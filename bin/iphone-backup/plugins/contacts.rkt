#lang rackjure

(provide run)

(require ios-backup
         ios-backup/contacts
         "../jsexpr.rkt")

(define (run backup path)
  (define filename (build-path path "contacts.json"))
  
  (with-backup backup
    (merge-jsexprseq-to-file
     (λ (c1 c2) (string<? (c1 'name) (c2 'name)))
     (λ (c1 c2) (equal? (c1 'name) (c2 'name)))
     (λ (c1 c2) 
       (hash 'name (c1 'name)
             'identifiers (sort (unique (c1 'identifiers)
                                        (c2 'identifiers))
                                string<?)))
     filename
     (for/list ([c (in-list (list-contacts))])
       (match-define (contact name identifiers) c)
       (hash 'name name
             'identifiers (sort identifiers string<?))))))
