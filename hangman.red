Red [
    Title: "The Hangman Game"
    Date: "21-Jul-2020"
    Author: Wally Silva
    File: %hangman.red
    Needs: View
    File: %hangman.red
    Tab: 4
]
; Game logic
text-color: hex-to-rgb #6495ED    
random/seed now/time
words: ["Red" "Rebol" "Python" "Java" "Ruby" "Swift" "Rust" "Lua" "GO" "C"]
; Function to randomly select a word from the list and 
; display a hint for how many letters the word has.
start: func [][
    secret: take random words  ; I use 'take instead of 'random/only because I want to remove the word from the list.
    display: copy []
    foreach letter secret [append display "_"]
    wrong-letters: copy []
    countdown: 10
    result: ""
]
; Function to evaluate the guess.
checker: func [][
    guess: copy guess-input/text
    either (find secret guess) <> none [
        repeat i length? secret [
                if guess = form secret/:i [
                    poke display i (uppercase secret/:i)
                    answer: true]
        ]
    ][
        append wrong-letters uppercase guess
        answer: false
    ]
; Inform player of game status.
status: either answer ["Good guess!"]["Wrong guess!"]
if (to-string display) = secret [result: "Congratulations, you won!"]
if (to-string display) <> secret and (countdown > 0)[
    countdown: countdown - 1
    if countdown = 0 [result: append "Sorry, you lost! ^/ The secret word was:  " uppercase secret]
]
]
; GUI design
view [
    title "The Hangman Game"
    size 310x450 backdrop #292929
    ;panel 310x450 #292929 [                                 ; Simulates the window face in live coding
    on-enter [
        do 'checker 
            guess-input/text: copy ""                        ; Clears field after a guess.
            display-secret/text: form display
            bad-guess/text: form wrong-letters
            feedback/text: status
            end/text: result
            chances/text: form countdown
    ]
    pad 0x10
    h3 290x35 #292929 bold center font [name: "Candara" color: do 'text-color] "The Hangman Game"
    style message: text #292929 bold font [name: "Candara" size: 12 color: do 'text-color] 
    at 20x80
    panel 270x370 #292929 [
    pad 10x10
    message "Secret word:"
    space 35x0
    display-secret: message font-size 15
    return
    pad 10x10
    message "Guess a letter:"
    space 25x0
    guess-input: field "" 25x25 #0a1526 bold center font-size 12 font-color #6495ED font-name "Candara"
    space 30x0
    checker-bt: text 35x25 #0a1526 bold center font [name: "Candara" size: 15 color: do 'text-color] "OK" 
        on-down [face/color: do 'text-color face/font/color: hex-to-rgb #0a1526]
        on-up [
            face/font/color: do 'text-color 
            face/color: hex-to-rgb #0a1526
            do 'checker
            guess-input/text: copy ""                        ; Clears field after a guess.
            display-secret/text: form display
            bad-guess/text: form wrong-letters
            feedback/text: status
            end/text: result
            chances/text: form countdown
        ]
    space 0x10
    return
    pad 10x0
    message "Wrong letters:"
    space 20x0
    bad-guess: message 90x40 wrap
    return
    pad 25x0
    feedback: message center wrap 
        "Press Play to start. ^/ Guess a letter and press OK."
    return
    pad 25x0
    end: message 200x40 center middle wrap
    return
    pad 85x20
    chances-txt: message 65x20
    at 160x230
    chances: text #292929 bold font [name: "Candara" size: 15 color: do 'text-color] 
    at 100x280
    play-bt: text 70x30 #0a1526 bold center font [name: "Candara" size: 15 color: do 'text-color] "Play" 
        on-down [face/color: do 'text-color face/font/color: hex-to-rgb #0a1526]
        on-up [
            face/font/color: do 'text-color
            face/color: hex-to-rgb #0a1526
            do 'start
            display-secret/text: form display
            bad-guess/text: form wrong-letters
            chances-txt/text: "Chances: "
            chances/text: form countdown
            set-focus guess-input
        ; Set replay
            play-bt/text: "Replay"
            feedback/text: ""
            end/text: ""
        ]
; Canvas    
    origin 0x0
    base 270x370 glass 
        draw [
            line-width 5 pen black box 2x2 267x340 10        ; panel border
            line-width 5 pen black box 203x54 243x84 10     ; "OK" button border
            line-width 5 pen black box 98x278 172x310 10    ; "Play" button border
        ]    
    ]
]