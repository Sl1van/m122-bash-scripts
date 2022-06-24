random_number=$((RANDOM%15+1))

echo "Guess a input between 1 and 15:"
read input

while [ $input -ne $random_number ]
do
  if [ $input -gt $random_number ]
  then
    echo "Your guess is higher than the number input"
  else
    echo "Your guess is lower than the number input"
  fi
  echo "Guess again:"
  read input
done
echo "You guessed the correct input"