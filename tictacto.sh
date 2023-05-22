# tic-tac-toe.sh
#!/usr/bin/bash

player_name_1="PLAYER 1"
player_name_2="PLAYER 2"

player_1="X"
player_2="O"

turn=1
game_on=true

moves=( 1 2 3 4 5 6 7 8 9 )

welcome_message() {
  echo "========================"
  echo "====== Tic-Tac-Toe ====="
  echo "========================"
}

check_name() {
  echo "Do you want to change the default name for Player 1 (X) and Player 2 (O)?"
  select yn in "Yes" "No"; do
    case $yn in
        Yes ) player_name; break;;
        No ) break;;
    esac
done

}

player_name() {
  echo "PLAYER 1: Please Input Name"
  read player_name_1
    
  echo "PLAYER 2: Please Input Name"
  read player_name_2

}

print_board () {
  clear
  echo " ${moves[0]} | ${moves[1]} | ${moves[2]} "
  echo "-----------"
  echo " ${moves[3]} | ${moves[4]} | ${moves[5]} "
  echo "-----------"
  echo " ${moves[6]} | ${moves[7]} | ${moves[8]} "
  echo ""
  echo ""
}

player_pick(){
  if [[ $(($turn % 2)) == 0 ]]
  then
    play=$player_2
    echo -n "$player_name_2: pick a square: "
  else
    echo -n "$player_name_1: pick a square: "
    play=$player_1
  fi

  read square
  space=${moves[($square -1)]} 

  if [[ ! $square =~ ^-?[0-9]+$ ]] || [[ ! $space =~ ^[0-9]+$  ]]
  then 
    echo "Not a valid square."
    player_pick
  else
    moves[($square -1)]=$play
    ((turn=turn+1))
  fi
  space=${moves[($square-1)]} 
}

check_match() {
  if  [[ ${moves[$1]} == ${moves[$2]} ]]&& \
      [[ ${moves[$2]} == ${moves[$3]} ]]; then
    game_on=false
  fi
  if [ $game_on == false ]; then
    if [ ${moves[$1]} == 'x' ];then
      echo "$player_name_2: wins!"
      return 
    else
      echo "$player_name_1: wins!"
      return 
    fi
  fi
}

check_winner(){
  if [ $game_on == false ]; then return; fi
  check_match 0 1 2
  if [ $game_on == false ]; then return; fi
  check_match 3 4 5
  if [ $game_on == false ]; then return; fi
  check_match 6 7 8
  if [ $game_on == false ]; then return; fi
  check_match 0 4 8
  if [ $game_on == false ]; then return; fi
  check_match 2 4 6
  if [ $game_on == false ]; then return; fi
  check_match 0 3 6
  if [ $game_on == false ]; then return; fi
  check_match 1 4 7
  if [ $game_on == false ]; then return; fi
  check_match 2 5 8
  if [ $game_on == false ]; then return; fi
  

  if [ $turn -gt 9 ]; then 
    echo "A Draw!"
    exit
  fi
}

welcome_message
check_name
print_board
while $game_on
do
  player_pick
  print_board
  check_winner
done
