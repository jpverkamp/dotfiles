#!/usr/bin/env racket
#lang rackjure

(require ios-backup
         racket/runtime-path)

(define-runtime-path plugin-directory "plugins")

(for ([each-backup (in-list (list-backups))])
  (define start (current-seconds))
  
  (match-define (backup name hash date phone path) each-backup)
  (define output-path (build-path (current-directory) name))
  (make-directory* output-path)
  
  (printf "Backing up ~a to ~a\n" name output-path)
  (for ([plugin-file (in-directory plugin-directory)]
        #:when (regexp-match #px".rkt$" plugin-file))
    
    (define-values (folder filename dir?) (split-path plugin-file))
    (printf "\t~a: " filename)
    
    (define plugin (dynamic-require plugin-file 'run))
    (with-handlers ([exn? (λ (exn) (printf "failed\n~a\n" (exn-message exn)))])
      (plugin hash output-path)
      (printf "done\n")))
  
  (printf "Finished ~a in ~a seconds\n" name (- (current-seconds) start))
  (newline))
        


