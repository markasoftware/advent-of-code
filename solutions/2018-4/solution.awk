BEGIN {
#   RS
  FPAT = "#?[0-9]+"
  guard=99999999
}
/#[0-9]+/{
  guard=$6
}
/wake/{
  minute=$5
  for(i=fell_asleep[guard];i<minute;i++) {
    asleep_minutes[guard][i]++
  }
  sleep_time[guard] += (minute - fell_asleep[guard])
}
/falls/ {
  minute=$5
  fell_asleep[guard] = minute
}
END {
  max_sleep_time=0
  max_sleep_guard=999999999
  for(guard in sleep_time) {
    if (sleep_time[guard] > max_sleep_time) {
      max_sleep_guard = guard
      max_sleep_time = sleep_time[guard]
    }
  }
  max_minute=9999999
  max_minute_val=0
  for(minute in asleep_minutes[max_sleep_guard]) {
    if (asleep_minutes[max_sleep_guard][minute] > max_minute_val) {
      max_minute= minute
      max_minute_val=asleep_minutes[max_sleep_guard][minute]
    }
  }
  print max_sleep_guard
  print max_minute
}
