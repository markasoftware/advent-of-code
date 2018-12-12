use v5.20;
# use strict;
use warnings;

my %found_letters = ();
my %deps = ();
my %completion_times = ();
my $current_time = -1;
my $available_workers = 5;

while (chomp(my $line = <>)) {
  my @letters = $line =~ /\b[A-Z]\b/g;
  $deps{$letters[1]} = [] unless exists $deps{$letters[1]};
  $found_letters{$letters[0]} = 1;
  $found_letters{$letters[1]} = 1;
  push(@{$deps{$letters[1]}}, $letters[0]);
}

sub pop_dependency {
  my $dep = shift;
  delete $deps{$dep};
  delete $found_letters{$dep};
  for my $dep_arr (values %deps) {
    @{$dep_arr} = grep {$_ ne $dep} @{$dep_arr};
  }
}

sub get_duration {
  # +61 because A - ord(A) is 0
  ord(shift) - ord('A') + 61;
}

while (my @dep_keys = keys %found_letters) {
  my @printables = ();

  $current_time++;
  for (sort keys %completion_times) {
    if ($completion_times{$_} == $current_time) {
      pop_dependency $_;
      $available_workers++;
    }
  }

  for my $dep_key (sort @dep_keys) {
    unless (exists $deps{$dep_key} and @{$deps{$dep_key}} > 0 or $available_workers == 0 or exists $completion_times{$dep_key}) {
      $completion_times{$dep_key} = $current_time + get_duration($dep_key);
      $available_workers--;
    }
  }
}
print $current_time;
