{
  register = $1
  inc_or_dec = $2
  inc_by = $3
  compare_op = $5
  operator = $6
  compare_num = $7
  if ( \
    operator == ">" && reg[compare_op] > compare_num || \
    operator == ">=" && reg[compare_op] >= compare_num || \
    operator == "<" && reg[compare_op] < compare_num || \
    operator == "<=" && reg[compare_op] <= compare_num || \
    operator == "==" && reg[compare_op] == compare_num || \
    operator == "!=" && reg[compare_op] != compare_num \
  ) {
    reg[register] += ((inc_or_dec == "inc" ? 1 : -1) * inc_by)
    if (reg[register] > max_val) {
      max_val = reg[register]
    }
  }
}
END {
  print max_val
}
