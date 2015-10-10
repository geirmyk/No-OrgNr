#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::EOL; Test::EOL->import(); 1; } ) {
        plan skip_all => 'Test::EOL required for this test';
    }
}

all_perl_files_ok( { trailing_whitespace => 1 } );
