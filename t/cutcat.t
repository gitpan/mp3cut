use Test::More tests => 6;

-d "t" && chdir "t";

require "differ.pl";
ok(1);

my @dels = qw(01_x01.mp3 02_x02.mp3 03_x03.mp3 x2.mp3);

unlink(@dels);
system("../blib/script/mp3cut --silent x1.cue");

is(-s "01_x01.mp3", 15742, "x01 size");
is(-s "02_x02.mp3", 16302, "x02 size");
is(-s "03_x03.mp3", 15884, "x03 size");

system("../blib/script/mp3cat --silent 01_x01.mp3 02_x02.mp3 03_x03.mp3 > x2.mp3");

is(-s "x2.mp3", 47928, "x2 size");
ok(!differ("x1.mp3", "x2.mp3"));

unlink(@dels);



