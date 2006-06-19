#!/usr/bin/perl

# Q&D cue file maker.
# Takes input a file with offsets (in seconds), one per line.
# Offsets can easily be determined with e.g. audacity.
# Minutes and fractions are allowed.

die("Usage: $0 [ -v ] mp3file [ secondsfile | secs1 secs2 ...]\n") unless @ARGV >= 2;
use strict;

my $verbose = $ARGV[0] eq "-v";
shift if $verbose;

print ("PERFORMER \"Unknown\"\n",
       "TITLE \"Unknown\"\n",
       "FILE \"", shift, "\" WAVE\n");

my $track = 0;

my @t = @ARGV == 1 ? <> : @ARGV;
my $prev = 0;
my $mprev;
foreach my $t ( 0, @t ) {
    my ($mm, $ss, $ms);
    $ms = $t;
    $ms = 60 * $1 + $2 if $t =~ /^(\d+):(\d+(?:\.\d+)?)/;
    my $l = $ms - $prev;
    $prev = $ms;
    $mm = int($ms / 60);
    $ss = int($ms) % 60;
    $ms = int(75*$ms) % 75; 
    if ( $verbose ) {
	printf STDERR ("%s, length = %02d:%02d\n",
		       $mprev,
		       int($l / 60), $l % 60) if $mprev;
	$mprev = sprintf("Track %02d @ %02d:%02d:%02d",
		       $track, $mm, $ss, $ms);
    }
    printf ("  TRACK %02d AUDIO\n", ++$track);
    print  ("    PERFORMER \"Unknown\"\n",
	    "    TITLE \"Unknown\"\n");
    printf ("    INDEX %02d %02d:%02d:%02d\n",
	    1, $mm, $ss, $ms);
}
if ( $verbose ) {
    printf STDERR ("%s\n", $mprev) if $mprev;
}
