use v5.20;
use warnings;
use List::Util qw/min max sum/;

my $line_1 = <>;
chomp($line_1);
<>;
my @sta = split / /,$line_1;
my $st = '.' x 10000 . $sta[2] . '.' x 10000;

my %repls = ();

sub summy {

my @splitted = split//, $st;
my $t = 0;
for(0..scalar(@splitted)-1) {
  $t += $_-10000 if $splitted[$_] eq '#';
}
say $t;
}

while(my $line = <>) {
  my @parts = $line =~ /[.#]+/g;
  $repls{$parts[0]} = $parts[1];
}

for(1..50000000000) {
  my @newst = split//,$st;
  for my $start_index (-50..scalar(@newst)-3) {
    my $repl = $repls{substr($st, $start_index - 2, 5)} // '.';
    if ($repl eq '#') {
      $newst[$start_index] = '#';
    } else {
      $newst[$start_index] = '.';
    }
  }
  $st = join '', @newst;
  if( $_ % 1 == 0) {
  say $_;
    summy;
  }
}
