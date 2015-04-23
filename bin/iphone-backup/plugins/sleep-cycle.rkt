#lang racket

(require db
         ios-backup
         ios-backup/apps
         json
         racket/date)

(provide run)

(define (run backup root-path)
  (with-backup backup
    (cond
      [(not (find-app "GoodMorning"))
       (void)]
      [else
       (make-directory* (build-path root-path "apps" "SleepCycle" "raw"))
       
       (define db-filename
         (for/first ([file (in-list (app-files (find-app "GoodMorning")))]
                     #:when (regexp-match #px"eventlog.sqlite$" (file-name file)))
           (file-path file)))
       
       (define db (sqlite3-connect #:database db-filename))
       
       (define (timestamp->date ts [offset 0])
         (when (sql-null? offset) (set! offset 0))
         (parameterize ([date-display-format 'iso-8601])
           (date->string (seconds->date (- (+ ts (date->seconds (date 0 0 0 1 1 2001 0 0 #f 0))) offset)) #t)))
       
       (with-output-to-file (build-path root-path "apps" "SleepCycle" "SleepCycle.json")
         #:exists 'replace
         (thunk
          (display
           (jsexpr->string
            (for/list ([(gps-lat gps-lon city state country raw-start raw-end gmt-offset quality)
                        (in-query db "
SELECT
  ZGPSLAT, ZGPSLONG,
  ZGPSCITY, ZGPSREGION, ZGPSCOUNTRY,
  ZSESSIONSTART, ZSESSIONEND, ZSECONDSFROMGMT,
  ZSTATSLEEPQUALITY
FROM ZSLEEPSESSION ORDER BY ZSESSIONSTART ASC")])
              
              (let* ([result (hash 'start (timestamp->date raw-start gmt-offset) 
                                   'end (timestamp->date raw-end gmt-offset)
                                   'quality quality)]
                     [result (if (not (sql-null? gps-lat))
                                 (hash-set result 'location (hash 'gps (list gps-lat gps-lon)))
                                 result)]
                     [result (if (not (ormap sql-null? (list city state country)))
                                 (hash-update result 'location (λ (lhash) (hash-set lhash 'name (string-join (list city state country) ", "))) (hash))
                                 result)])
                result))))))

       (for ([(session-id raw-start gmt-offset) (in-query db "SELECT Z_PK, ZSESSIONSTART, ZSECONDSFROMGMT FROM ZSLEEPSESSION ORDER BY Z_PK ASC")])
         (define path 
           (build-path root-path "apps" "SleepCycle" "raw"
                       (~a (~a session-id #:width 4 #:pad-string "0" #:align 'right)
                           "-"
                           (substring (timestamp->date raw-start gmt-offset) 0 10)
                           ".tab")))
         
         (with-output-to-file path
           #:exists 'replace
           (thunk
            (for ([(raw-time intensity) (in-query db (format "
SELECT ZTIME, ZINTENSITY
FROM ZSLEEPEVENT 
WHERE ZSLEEPSESSION = ~a
ORDER BY ZTIME ASC" session-id))])
              (printf "~a\t~a\n" (- raw-time raw-start) intensity)))))])))