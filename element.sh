#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

if [[ "$1" =~ ^[0-9]+$ ]]
then
  ELEMENT_INFO=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  IFS='|' read -r NAME SYMBOL TYPE MASS MELT BOIL <<< $ELEMENT_INFO

  echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
else
  ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$1' OR symbol='$1'")
  IFS='|' read -r NUMBER NAME SYMBOL TYPE MASS MELT BOIL <<< $ELEMENT_INFO

  if [[ -n $ELEMENT_INFO ]]
  then
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
  else
    echo "I could not find that element in the database."
  fi
fi
