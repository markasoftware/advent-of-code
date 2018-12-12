use v5.20;
use warnings;

my @all_entries = split(/ /, <>);
my @child_counter = ();
my $t = 0;

sub parse_child {
  my $child_count = shift @all_entries;
  my $metadata_count = shift @all_entries;

  for (1..$child_count) {
    parse_child();
  }
  for(1..$metadata_count) {
    $t += shift @all_entries;
  }
}

parse_child();
say scalar @all_entries;
say $t;
