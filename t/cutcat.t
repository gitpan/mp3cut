use Test::More tests => 6;
use File::Spec;

-d "t" && chdir "t";

# Get platform-independent file names.
my $cut = File::Spec->catfile("../blib/script", "mp3cut");
my $cat = File::Spec->catfile("../blib/script", "mp3cat");

require_ok("differ.pl");

my @dels = qw(01_x01.mp3 02_x02.mp3 03_x03.mp3 x2.mp3);

unlink(@dels);
system("perl $cut --silent x1.cue");

is(-s "01_x01.mp3", 15742, "x01 size");
is(-s "02_x02.mp3", 16302, "x02 size");
is(-s "03_x03.mp3", 15884, "x03 size");

system("perl $cat --silent 01_x01.mp3 02_x02.mp3 03_x03.mp3 > x2.mp3");

is(-s "x2.mp3", 47928, "x2 size");
ok(!differ("x1.mp3", "x2.mp3"));

unlink(@dels);



