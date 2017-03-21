#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; problem 1
(define (sequence low high stride)
  (if (<= low high)
      (cons low (sequence (+ low stride) high stride))
      null))

;; problem 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

;; problem 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

;; problem 4
(define (stream-for-n-steps s n)
  (if (<= n 0)
  null
  (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

 
;; problem 5
(define funny-number-stream
  (letrec ([neg-five (lambda (x) (if (= (remainder x 5) 0)
                                     (- 0 x)
                                     x))]
           [f (lambda (x) (cons (neg-five x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; problem 6
(define dan-then-dog
  (letrec ([dan? (lambda () (cons "dan.jpg" dog?))]
           [dog? (lambda () (cons "dog.jpg" dan?))])
    dan?))

;; problem 7
(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s)))
                   (stream-add-zero (cdr (s))))))

;; problem 8
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

;; problem 9
(define (vector-assoc v vec)
  (letrec ([vecLen (vector-length vec)]
           [helper (lambda (n)
                     (if (= n vecLen)
                         #f
                         (let* ([element (vector-ref vec n)])
                           (if (and (pair? element) (equal? (car element) v))
                               element
                               (helper (+ n 1))))))])
    (helper 0)))


;; problem 10
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [ptr 0]
           [fast-assoc (lambda (v i)
                         (if (= i n)
                             (let ([newVal (assoc v xs)])
                               (begin
                                 (vector-set! cache ptr newVal)
                                 (set! ptr (remainder (+ ptr 1) n))
                                 newVal))
                             (let ([entry (vector-ref cache i)])
                               (if (and (pair? entry) (equal? v (car entry)))
                                   entry
                                   (fast-assoc v (+ i 1))))))])
    (lambda (v) (fast-assoc v 0))))

;; challenge problem
;; note: an argument evaluated first before passing to function
(define-syntax while-less
  (syntax-rules (do)
    [(while-less exp1 do exp2)
     (letrec ([e1 exp1]
              [e2 (lambda () exp2)]
              [loop (lambda (x-thunk)
                      (let ([x (x-thunk)])
                        (if (>= x e1)
                            #t
                            (loop x-thunk))))])
       (loop e2))]))
