BEGIN{
#   FS
#   RS
}
{
  t += $0
  if (a[t]) {
    print t
    exit
  }
  a[t] = 1
  if (NR == FNR) {
    NR = 1
  }
}
