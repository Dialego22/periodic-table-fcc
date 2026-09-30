PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1  ]]
then
  echo -e "Please provide an element as an argument."
  exit
fi

RESULT_ELEMENT=$($PSQL "SELECT atomic_number, symbol, name, t.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements e INNER JOIN properties p USING(atomic_number) INNER JOIN types t USING(type_id) WHERE atomic_number::TEXT='$1' OR symbol = '$1' OR name = '$1';")

if [[ -n $RESULT_ELEMENT ]]
then
  echo "$RESULT_ELEMENT" | while IFS='|' read NUMBER SYMBOL NAME TYPE MASS MELTING BOILING
  do
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  done
else
  echo "I could not find that element in the database."
fi
