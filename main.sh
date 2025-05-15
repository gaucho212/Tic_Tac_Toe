#!/bin/bash

# Inicjalizacja planszy
board=( " " " " " " " " " " " " " " " " " " )

# Funkcja do wyświetlania planszy
display_board() {
    echo " ${board[0]} | ${board[1]} | ${board[2]} "
    echo "---+---+---"
    echo " ${board[3]} | ${board[4]} | ${board[5]} "
    echo "---+---+---"
    echo " ${board[6]} | ${board[7]} | ${board[8]} "
}

# Funkcja do sprawdzania wygranej
check_win() {
    # Poziome
    if [ "${board[0]}" == "$1" ] && [ "${board[1]}" == "$1" ] && [ "${board[2]}" == "$1" ]; then
        return 0
    elif [ "${board[3]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[5]}" == "$1" ]; then
        return 0
    elif [ "${board[6]}" == "$1" ] && [ "${board[7]}" == "$1" ] && [ "${board[8]}" == "$1" ]; then
        return 0
    # Pionowe
    elif [ "${board[0]}" == "$1" ] && [ "${board[3]}" == "$1" ] && [ "${board[6]}" == "$1" ]; then
        return 0
    elif [ "${board[1]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[7]}" == "$1" ]; then
        return 0
    elif [ "${board[2]}" == "$1" ] && [ "${board[5]}" == "$1" ] && [ "${board[8]}" == "$1" ]; then
        return 0
    # Przekątne
    elif [ "${board[0]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[8]}" == "$1" ]; then
        return 0
    elif [ "${board[2]}" == "$1" ] && [ "${board[4]}" == "$1" ] && [ "${board[6]}" == "$1" ]; then
        return 0
    else
        return 1
    fi
}



# Główna pętla gry
current_player="X"
while true; do
    display_board
    echo "Gracz $current_player, podaj numer pola (1-9):"
    read -r move

    # Sprawdzenie, czy input jest liczbą
    if ! echo "$move" | grep -q '^[0-9]$'; then
        echo "Błąd: Wprowadź pojedynczą cyfrę od 1 do 9."
        continue
    fi

    # Sprawdzenie, czy liczba jest w zakresie od 1 do 9
    if [ "$move" -lt 1 ] || [ "$move" -gt 9 ]; then
        echo "Błąd: Numer pola musi być od 1 do 9."
        continue
    fi

    # Konwersja numeru pola na indeks tablicy (0-8)
    index=$((move - 1))

    # Sprawdzenie, czy pole jest wolne
    if [ "${board[$index]}" != " " ]; then
        echo "Pole zajęte, spróbuj ponownie."
        continue
    fi

    # Ustawienie znaku gracza na planszy
    board[$index]=$current_player

    # Sprawdzenie wygranej
    if check_win "$current_player"; then
        display_board
        echo "Gracz $current_player wygrywa!"
        break
    fi

    # Sprawdzenie remisu
    if ! echo "${board[@]}" | grep -q " "; then
        display_board
        echo "Remis!"
        break
    fi

    # Zmiana gracza
    if [ "$current_player" == "X" ]; then
        current_player="O"
    else
        current_player="X"
    fi
done
