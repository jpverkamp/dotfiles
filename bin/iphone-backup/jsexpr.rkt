#lang racket

(provide (all-defined-out))

(require json)

; Merge any number of jsexpr sequences
; Objects that are jsexpr-equal? will be merged with jsexpr-merge
; All other objects will be sorted with jsexpr<?
(define (merge-jsexprseq* jsexpr<? jsexpr-equal? jsexpr-merge . jss*)
  (let loop ([ls (sort (apply append (map sequence->list jss*)) jsexpr<?)])
    (match ls
      [(or (list) (list _)) ls]
      [(list* fst snd rest)
       (if (jsexpr-equal? fst snd)
           (loop (list* (jsexpr-merge fst snd) rest))
           (list* fst (loop (list* snd rest))))])))

; Read a sequence of jsexprs from a port (must be one per line)
(define (port->jsexprseq [in (current-input-port)])
  (for/list ([line (in-lines in)]
             #:when (and (not (eof-object? line))
                         (not (equal? line ""))))
    (string->jsexpr line)))

; Read a sequence of jsexprs from a file (must be one per line)
(define (file->jsexprseq filename)
  (if (file-exists? filename)
      (call-with-input-file filename port->jsexprseq)
      '()))

; Write a sequence of jsexprs to a port
(define (jsexprseq->port jss [out (current-output-port)])
  (for ([el jss])
    (displayln (jsexpr->string el))))

; Merge a jsexprseq list to a file
(define (merge-jsexprseq-to-file jsexpr<? jsexpr-equal? jsexpr-merge filename . jss*)
  
  (define merged-values
    (apply merge-jsexprseq* (list* jsexpr<? jsexpr-equal? jsexpr-merge (file->jsexprseq filename) jss*)))
  
  (with-output-to-file filename
    #:exists 'replace
    (thunk (jsexprseq->port merged-values))))

; Remove duplicates from a list, preserving order
(define (unique . ls*)
  (let loop ([ls (apply append ls*)])
    (match ls
      ['() '()]
      [(list-rest fst rst)
       (list* fst (remove* (list fst) rst))])))
