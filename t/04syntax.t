#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Strict; Test::Strict->import(); 1; } ) {
        plan skip_all => 'Test::Strict required for this test';
    }
    else {
        plan tests => 58;
    }
}

BEGIN {
    use_ok('No::OrgNr');
}

use File::Spec;
use FindBin qw/$Bin/;

$Test::Strict::TEST_SYNTAX   = 1;
$Test::Strict::TEST_STRICT   = 1;
$Test::Strict::TEST_WARNINGS = 1;
$Test::Strict::TEST_SKIP     = [ File::Spec->catfile($Bin, '../Build') ];

all_perl_files_ok();
