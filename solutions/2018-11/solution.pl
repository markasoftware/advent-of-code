use v5.20;
use warnings;
use List::Util qw/min max sum/;

my $serial = 5153;

sub get_value {
  my ($x, $y) = @_;
  my $rack = $x + 10;
  my $full = ($rack * $y + $serial) * $rack;
  my $hundreds_plus = int($full / 100);
  my $hundreds_only = $hundreds_plus % 10;
  return $hundreds_only - 5;
}


my $max_val = 0;
my $max_y = 0;
my $max_x = 0;
my $max_size=0;
for my $y (1..301 - $square_sz) {
  for my $x (1..301 - $square_sz) {
    my @vals = ();
    for my $ly ($y..$y+$square_sz-1) {
      for my $lx ($x..$x+$square_sz-1) {
        push @vals, get_value($lx,$ly);
      }
    }
      my $sum = sum @vals;
      if ($sum > $max_val) {
        $max_val = $sum;
        $max_y = $y;
        $max_x = $x;
        $max_size = $square_sz;
      }
  }
}
}

say $max_x;
say $max_y;
say $max_size;
