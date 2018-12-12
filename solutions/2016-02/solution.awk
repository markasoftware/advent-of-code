BEGIN {
#   FS
#   RS
  a[0][0] = 1
  a[0][1] = 2
  a[0][2] = 3
  a[1][0] = 4
  a[1][1] = 5
  a[1][2] = 6
  a[2][0] = 7
  a[2][1] = 8
  a[2][2] = 9
  x=1
  y=1
}
{
  split($0, chars, "")
  for(i=0; i < length; i++) {
    if (chars[i]) == "U") {
      y = y == 0 ? 0 : y-1;
    }
    if (chars[i]) == "D") {
      y = y == 2 ? 2 : y+1;
    }
    if (chars[i]) == "L") {
      x = x == 0 ? 0 : x-1;
    }
    if (chars[i]) == "R") {
      x = x == 2 ? 2 : x+1;
    }
  }
  t=t a[x][y]
}
END {
  print t
}
