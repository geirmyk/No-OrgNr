#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Pod::Coverage; Test::Pod::Coverage->import(); 1; } ) {
        plan skip_all => 'Test::Pod::Coverage required for this test';
    }
}

all_pod_coverage_ok();
