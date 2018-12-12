use v5.12;

my @a = split(/ /, <>);
my $t = 0;
my %s = ();
while(1) {
for (@a) {
$t+=$_;
if ($s{$t}) {
print $t;
exit;
}
$s{$t} = 1;
}}
