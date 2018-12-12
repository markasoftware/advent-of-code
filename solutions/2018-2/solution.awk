BEGIN {
#   RS
  ta=0
  tb=0
}
{
  delete a
  split($0,x,"")
  for (i=0;i<length($0);i++) {
    a[x[i]]++
  }
  for(b in a) {
    if (a[b] == 2) {
      ta++
      break
    }
  }
  for (b in a) {
    if (a[b] == 3) {
      tb++
      break
    }
  }
}
END {
  print ta * tb
}
