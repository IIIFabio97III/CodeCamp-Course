#!/bin/bash

PSQL="psql -t --username=freecodecamp --dbname=salon -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

SERVICE_IDS=()

MAIN_MENU() {
  if [[ -n $1 ]]
  then
  echo -e "\n$1"
  fi

  while IFS='|' read -r ID S_NAME
  do
    if [[ $ID != 'service_id' ]]
    then
      ID=$(echo $ID | tr -d ' ')
      S_NAME=$(echo $S_NAME | tr -d ' ')
      SERVICE_IDS+=($ID)
      echo "$ID) $S_NAME"
    fi
  done < <($PSQL "SELECT service_id, name FROM services" | grep -Po '[0-9]+[^0-9]+')

  read SERVICE_ID_SELECTED

  #VALID=false
  for X in "${SERVICE_IDS[@]}"
  do
    if [[ $SERVICE_ID_SELECTED == $X ]]
    then
      VALID=true
      break
    fi
  done

  if [[ $VALID != true ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
    SERVICE_NAME=$(echo $SERVICE_NAME | tr -d ' ')
  fi
}

CUSTOMER_CHECK() {
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$1'")

  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    INSERT_NAME=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$1')")
  fi

  CUSTOMER_NAME=$(echo $CUSTOMER_NAME | tr -d ' ')
  CUSTOMER_ID=$($PSQL "SELECT customer_id From customers WHERE phone='$1'")
}

MAIN_MENU

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_CHECK $CUSTOMER_PHONE

echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
read SERVICE_TIME

APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
