#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

GET_ID() {
  GET_ID_RESULT=$($PSQL "SELECT team_id FROM teams WHERE name='$1'")
  if [[ -z $GET_ID_RESULT ]]
  then
    GET_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$1') RETURNING team_id" | grep -Eo '^[0-9]+')
  fi
  echo $GET_ID_RESULT
}

while IFS=, read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS
do
  #Remove title line
  if [[ $YEAR != 'year' ]]
  then
    #Function -> Get ID | Check if empty -> Add team | Return team_id
    W_ID=$(GET_ID "$WINNER")
    O_ID=$(GET_ID "$OPPONENT")

    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES($YEAR, $W_ID, $O_ID, $W_GOALS, $O_GOALS, '$ROUND')")
  fi
done < games.csv
