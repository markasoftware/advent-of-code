for letter in q
do
  grep -vi $letter < tmp/2018-5/input.folded > /tmp/input.folded
  for i in {1..500}
  do
    awk -f solutions/2018-5/solution.awk /tmp/input.folded > /tmp/input.folded.2
    mv /tmp/input.folded.2 /tmp/input.folded
  done
  echo $letter
  grep '[a-z]' /tmp/input.folded | wc -l
done
