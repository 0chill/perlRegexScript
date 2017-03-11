#!/usr/bin/perl

use strict;
use warnings;

sub regexForGoodEmails() {
	#This function reads the file known_good.txt
	#it makes sure that it has less than 255 characters
	#it does some basic regex to see that the emails
	#go through it
	#it also adds 1 if an email on the file doesn't work
        my $valid_bad = 0;

        my $filename = 'known_good.txt';
        open(my $fh, '<:encoding(UTF-8)', $filename )
                or die "Could not open file ' $filename '$!";

        while (my $row = <$fh>) {
                chomp $row;
                if ( length( $row ) <= 255 )
                        {
                        if ( $row =~ /^([\w+\.]){1,}@(\w+\.){1,}\w+$/i) 
                                {
                                #print "$row\n";

                                } else {
                                                print "'$row' Did not work\n";
                                                $valid_bad += 1;
                                        }
                        }
        }
	return($valid_bad);
}


sub regexForBadEmails() {
	#This function reads the file known_bad.txt
	#it makes sure that it has less than 255 characters
	#it does some basic regex to see that the emails
	#won't go through
	#it also adds 1 if a bad email goes through
        my $valid_bad = 0;

        my $filename = 'known_bad.txt';
        open(my $fh, '<:encoding(UTF-8)', $filename )
                or die "Could not open file ' $filename '$!";

        while (my $row = <$fh>) {
                chomp $row;
		if ( length( $row ) <= 255 )
			{
			if ( $row =~ /^([\w+\.]){1,}@(\w+\.){1,}\w+$/i)
				{
                        	print "$row\n";
				$valid_bad += 1;

                		} else {
                			}
			} else {
					print "'$row' has more than 254 characters, it was dropped.\n";
				}
        }
	return($valid_bad);
}


my $good_valid_bad = 0;
my $bad_valid_bad = 0;

$good_valid_bad = regexForGoodEmails();
$bad_valid_bad = regexForBadEmails();

print "Good emails passed: '$good_valid_bad'\n";
print "Bad emails passed: '$bad_valid_bad'\n";
