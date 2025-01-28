#!/bin/bash

num=6
while [[ $num -le 10 ]]  
do 
  echo "The value of variable num is $num" >> file2.txt
  num=$((num + 1))
done
