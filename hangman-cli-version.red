Red [
    Title: "The Hangman Game"
    Date: "08-Aug-2020"
    Author: Wally Silva
    Needs: View
    File: %hangman-cli-version.red
    Tab: 4
]
;#include %red-source\environment\console\CLI\input.red     ;Required for compiling
do [
chances: 0
random/seed now/time
words: ["Red" "Rebol" "Python" "Java" "Ruby" "Swift" "Rust" "Lua" "GO" "C"]
; Function to randomly select a word from the list and 
; display a hint for how many letters the word has.
secret: take random words  ; I use 'take instead of 'random/only because I want to remove the word from the list.
display: copy []
foreach letter secret [append display "_"]
wrong-letters: copy []
reveal: reduce ["The secret word was:" uppercase secret]
; Function to check if guessed letter is correct or not.
checker: func [][
    guess: uppercase ask "Please, guess a letter: "
    while [(length? guess) <> 1] [
    guess: uppercase ask "Please, guess just one letter: "
    ]
; Check if word contains the guessed letter and display the current status of the game.
    either answer: find secret guess [
        repeat i length? secret [
            if guess = form secret/:i [
                poke display i (uppercase secret/:i)
			]
        ]
    ][
        append wrong-letters uppercase guess
    ]
    ; Inform player of game status.
    either answer [
        print ["Good guess!"]
    ][
        print ["Wrong guess!"]
    ]
    print ["Misses:" wrong-letters]
    if (to-string display) = secret [
        print [lf "Congratulations, you won!" lf lf reveal] 
    ]
    if (to-string display) <> secret and (chances = 10) [
        print [lf "Sorry, you lost!" lf lf reveal]
    ]
]
chances: 0
while [(to-string display) <> secret and (chances < 10) ][
    print [lf "Secret word:" display] 
    print ["You have" 10 - chances "chances left"]
    chances: chances + 1
    checker
]
ask ""  ; Added this like to keep the console open after the game is over.
]
