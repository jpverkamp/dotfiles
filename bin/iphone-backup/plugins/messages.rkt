#lang rackjure

(require ios-backup
         ios-backup/contacts
         ios-backup/messages
         json
         openssl/sha1
         racket/date
         "../jsexpr.rkt")

(provide run)

(define (run backup root-path)
  (make-directory* (build-path root-path "messages"))
  
  (with-backup backup
    ; Get file hashes for all attachments already saved to avoid re-copying them
    (displayln "\n\t\tCreating attachment cache")
    (define hash-cache
      (for/hash ([path (in-directory (build-path root-path "messages"))]
                 #:when (and (file-exists? path)
                             (regexp-match #px"attachments" path)))
        (values (call-with-input-file path sha1) path)))
    
    ; Save a single attachment (skip if the source file is gone or if it's already been copied)
    (define (save-attachment names message-date att)
      (match-define (attachment name path) att)
      (cond
        [(not (file-exists? path))
         (~a "missing-" name)]
        [(hash-ref hash-cache (call-with-input-file path sha1) #f)
         => path->string]
        [else
         (define cmd (~a "identify -verbose \"" path "\""))
         (define exif-data
           (with-output-to-string
            (thunk
             (system cmd))))
         
         (define (exif-field name)
           (let ([match (regexp-match (pregexp (~a "\n\\s*" name ": (.*?)\n")) exif-data)])
             (and match (cadr match))))
         
         (define (fix-date str)
           (let* ([str (regexp-replace* #px"[-:]" str "")]
                  [str (regexp-replace* #px"[T ]" str "-")]
                  [str (regexp-replace* #px"-[\\d:]{4,5}$" str "")])
             str))
         
         (define date-strings
           (sort 
            (map fix-date
                 (filter identity
                         (list 
                          (parameterize ([date-display-format 'iso-8601])
                            (date->string message-date #t))
                          (exif-field "date:create")
                          (exif-field "exif:DateTimeOriginal")
                          (exif-field "exif:DateTime"))))
            string<?))
         
         (make-directory* (build-path root-path "messages" names "attachments"))
         (define filename (regexp-replace* #px"\\s+" (~a (first date-strings) "-" (attachment-name att)) ""))
         (define output-path (build-path root-path "messages" names "attachments" filename))
         
         (with-handlers ([exn? (λ (exn)
                                 (printf "\t\tfailed to copy:\n\t\t\t~a (exists? ~a) to\n\t\t\t~a (exists? ~a)\n"
                                         (attachment-path att)
                                         (file-exists? (attachment-path att))
                                         output-path
                                         (file-exists? output-path)))])
           
           (copy-file (attachment-path att) output-path #t))
         
         filename]
        
        ))
    
    (displayln "\t\tSaving messages")
    (parameterize ([date-display-format 'iso-8601])
      (for* ([chat (in-list (list-chats))])
        
        (define names 
          (let ([names (string-join 
                        (sort
                         (for/list ([c (in-list (chat-contacts chat))] #:when c)
                           (regexp-replace* "[^A-Za-z -]" (contact-name c) ""))
                         string<?)
                        ", ")])
            (if (equal? names "") "_other_" names)))
        
        (let loop ([m* (chat-messages chat)] [buffer '()] [old-month #f])
          
          (define (output-buffer)
            (when (not (null? buffer))
              (make-directory* (build-path root-path "messages" names))
              (define filename (build-path root-path "messages" names (~a old-month ".json")))
              
              (merge-jsexprseq-to-file
               (λ (c1 c2) (string<? (c1 'date) (c2 'date)))
               (λ (c1 c2) (and (equal? (c1 'date) (c2 'date))
                               (equal? (c1 'text) (c2 'text))
                               (equal? (c1 'sender) (c2 'sender))))
               (λ (c1 c2) c1)
               filename
               (reverse buffer))))
          
          (match m*
            ; End of list, output last buffer
            [(list)
             (output-buffer)]
            ; New items in the same month, buffer them
            [(list-rest (message date service sender subject text attachments) m*)
             (define new-month (substring (date->string date) 0 7))
             (define message-jsexpr
               (hash 'date (date->string date #t)
                     'service service
                     'sender sender
                     'subject subject
                     'text text
                     'attachments (map (curry save-attachment names date) attachments) ; TODO: fix this
                     ))
             
             (cond
               [(equal? old-month new-month)
                (loop m* (list* message-jsexpr buffer) new-month)]
               [else
                (output-buffer)
                (loop m* (list message-jsexpr) new-month)])]))))))