#!/usr/bin/perl

################################################################################
#
# Name:		sum.pl
# Description:	A simple script to provide the numeric sum of text read in via
#		STDIN or an input file which matches a number.
# Author:	Eddie N. (en@sector572.com)
# Version:	v0.1.0
#
################################################################################

use strict;
use Getopt::Std;

sub usage($);

our($opt_i, $opt_h, $opt_v);
getopts('i:hv');

if($opt_h && ($opt_i || $opt_v))
{
	usage(1);
}
elsif($opt_h && !$opt_i && !$opt_v)
{
	usage(0);
}

my $fileName = $opt_i;
my $verbose = $opt_v;
my $fileHandle;

if(length($fileName) > 0)
{
	if(!open($fileHandle, "< $fileName"))
	{
		print STDERR "Unable to open file $fileName.\n";
		exit(1);
	}
}
else
{
	$fileHandle = *STDIN;
}

if($fileHandle && tell($fileHandle) != -1)
{
	my $total = 0;

	while(<$fileHandle>)
	{
		chomp;

		if($_ =~ m/^(-)?[\d]*(\.[\d]+)?$/)
		{
			$total += $_;
		}
		else
		{
			if($verbose)
			{
				print STDERR "Ignoring: $_\n";
			}
		}
	}

	print "$total\n";

	close($fileHandle);
}

# Subroutines

sub usage($)
{
	my $exitStatus = shift;

	print STDERR <<endl;
Usage:
	cat <file> | $0
	$0 -i <file>

Options:
	-i Input file
	-v Verbose
endl

	exit($exitStatus);
}
