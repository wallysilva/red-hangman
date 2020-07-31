Red [
    Title: "The Hangman Game"
    Date: "21-Jul-2020"
    Author: Wally Silva
    Needs: View
    File: %hangman-cli-version.red
    Tab: 4
]
#include %red-source\environment\console\CLI\input.red
do [
chances: 0
random/seed now/time
words: ["Red" "Rebol" "Python" "Java" "Ruby" "Swift" "Rust" "Lua" "GO" "C"]
; Function to randomly select a word from the list and 
; display a hint for how many letters the word has.
play: func [][
    secret: take random words  ; I use 'take instead of 'random/only because I want to remove the word from the list.
    display: copy []
    foreach letter secret [append display "_"]
    print [lf "Secret word:" display lf]
    wrong-letters: copy []

]
; Function to check if guessed letter is correct or not.
checker: func [][
    guess: uppercase ask "Please, guess a letter: "
    while [(length? guess) <> 1] [
    guess: uppercase ask "Please, guess a letter: " lf
    ]
; Check if word contains the guessed letter and display the current status of the game.
    either (find secret guess) <> none [
        repeat i length? secret [
                if guess = form secret/:i [
                    poke display i (uppercase secret/:i)
                    result: true]
        ]][
        append wrong-letters uppercase guess
        result: false
    ]
    ; Inform player of game status.
    either result [
        print [lf "Good guess!"]][
        print [lf "Wrong guess!"]
    ]
    print [lf "Wrong letters:" wrong-letters]
    if (to-string display) = secret [print [lf "Congratulations, you won!"]]
    either chances < 9 [
        print [lf "Secret word:" display lf] ][
        print [lf "The secret word was:" uppercase secret lf]
    ]
]
play
chances: 0
while [(to-string display) <> secret and (chances < 10) ][
    print ["You have" 10 - chances "chances left" lf]
    checker
    chances: chances + 1
    if chances = 10 [ print "Sorry, you lost!" lf]
]
ask ""  ; Added this like to keep the console open after the game is over.
]