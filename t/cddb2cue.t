use Test::More tests => 2;

use File::Spec;

-d "t" && chdir "t";
my $exec = File::Spec->catfile("../blib/script","cddb2cue");

require "differ.pl";
ok(1);

my @dels = qw(x2.cue);

unlink(@dels);
system($exec, "x2.cddb");

ok(!differ("x2.cue", "x2.cue.ref"));

unlink(@dels);



