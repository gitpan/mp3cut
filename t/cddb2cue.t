use Test::More tests => 2;

-d "t" && chdir "t";

require "differ.pl";
ok(1);

my @dels = qw(x2.cue);

unlink(@dels);
system("../blib/script/cddb2cue x2.cddb");

ok(!differ("x2.cue", "x2.cue.ref"));

unlink(@dels);



