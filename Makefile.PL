use 5.006;
use strict;
use ExtUtils::MakeMaker;
use Config;

my @scripts = qw(mp3cut mp3cat cddb2cue);
my $usrbin = "/usr/bin";
my $installscript = $Config{installscript};

print STDERR <<EOD unless $installscript eq $usrbin;

WARNING: This Makefile will install user accessible scripts.
The location for these scripts is $installscript.
You may consider to pass INSTALLSCRIPT=$usrbin (or some other
convenient location) to "make install".

EOD

eval {
    require ID3Tools;
};
if ( $@ ) {
    print STDERR <<EOD;

NOTICE: The mp3cut program that comes with this package can provide
ID3 info tags for the MP3 files it generates if you install the
package ID3Tools (yet unreleased).

EOD
}

WriteMakefile(
    NAME		=> 'mp3cut',
    VERSION_FROM	=> 'script/mp3cut',
    PREREQ_PM		=> { 'Getopt::Long' => 2.33,
			     'Test::More' => 0.00,
			     'MPEG::Audio::Frame' => 0.03,
			     'CDDB::File' => 1.03,
			   },
   EXE_FILES		=> [ map { "script/$_" } @scripts ],
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'script/mp3cut', # retrieve abstract from module
       AUTHOR        => 'Johan Vromans <jv@cpan.org>') : ()),
);


