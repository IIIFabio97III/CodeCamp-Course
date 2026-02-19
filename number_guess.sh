#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

CHECK_USER=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

if [[ -z $CHECK_USER ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_NAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  USER_INFO=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'")
  IFS='|' read -r NAME GAMES BEST <<< "$USER_INFO"
  echo "Welcome back, $NAME! You have played $GAMES games, and your best game took $BEST guesses."
fi

NUMBER=$(( $RANDOM % 1000 + 1 ))
echo $NUMBER
N_GUESSES=1

echo "Guess the secret number between 1 and 1000:"
read NUMBER_GUESSED

while [[ $NUMBER_GUESSED != $NUMBER ]]
do
  if [[ ! $NUMBER_GUESSED =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    read NUMBER_GUESSED
  fi
  if (( $NUMBER_GUESSED < $NUMBER ))
  then
    echo "It's higher than that, guess again:"
    read NUMBER_GUESSED
    N_GUESSES=$(( N_GUESSES + 1 ))
  else
    echo "It's lower than that, guess again:"
    read NUMBER_GUESSED
    N_GUESSES=$(( N_GUESSES + 1 ))
  fi
done

if [[ -z $BEST || $N_GUESSES -lt $BEST ]]
then
  INSERT_MATCH=$($PSQL "UPDATE users SET games_played=games_played+1, best_game=$N_GUESSES")
else
  INSERT_MATCH=$($PSQL "UPDATE users SET games_played=games_played+1")
fi

echo "You guessed it in $N_GUESSES tries. The secret number was $NUMBER. Nice job!"
