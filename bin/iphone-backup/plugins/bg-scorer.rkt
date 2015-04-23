#lang racket

(require db
         ios-backup
         ios-backup/apps
         json
         "../jsexpr.rkt")

(provide run)

(define (run backup path)
  (with-backup backup
    (cond
      [(not (find-app "BgScorer"))
       (void)]
      [else
       (make-directory* (build-path path "apps"))
       
       (with-output-to-file (build-path path "apps" "BgScorer.json")
         #:exists 'replace
         (thunk
          (define db-filename
            (for/first ([file (in-list (app-files (find-app "BgScorer")))]
                        #:when (regexp-match #px"DbBgScorerCustom.sqlite3$" (file-name file)))
              (file-path file)))
          
          (define db (sqlite3-connect #:database db-filename))
          
          (define (sql:list-games) "
SELECT
  g.GID,
  g.TIMEUPDATE,
  gs.NAME,
  g.PLAYERS
FROM
  GAME g
  JOIN GAMESCORER gs USING (GSID)
ORDER BY g.TIMEUPDATE ASC
")
          
          (define (sql:list-players pids) 
            (format "SELECT p.PID, p.NAME FROM PLAYER p WHERE p.PID in (~a)" pids))
          
          (define (sql:get-scores gid pid) 
            (format "
SELECT
  sc.NAME,
  s.SCSCORE
FROM
  SCORE s
  JOIN SCORECATEGORY sc USING (SCID)
WHERE
  s.GID = ~a AND s.PID = ~a
" gid pid))
          
          (display
           (jsexpr->string
            (for/list ([(game-id date name player-ids) (in-query db (sql:list-games))])
              (hash 'name name
                    'date date
                    'scores
                    (for/hash ([(player-id player-name) (in-query db (sql:list-players player-ids))])
                      (values (string->symbol player-name)
                              (for/hash ([(category-name score) (in-query db (sql:get-scores game-id player-id))])
                                (values (string->symbol category-name) score))))))))))])))