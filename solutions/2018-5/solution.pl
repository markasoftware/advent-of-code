use v5.20;
use warnings;

chomp(my $polymer_str = <>);
my @polymer = split(//, <>);

my $last_length = -1
for my $first_letter (a..z) {
  my @n_polymer = grep { $_ ne uc $first_letter and $_ ne lc $first_letter} @polymer;
  my $last_letter;
  until ($last_length == @new_polymer) {
    for (@n_polymer) {
      if $_ eq $last_letter;
    }
  }
}
