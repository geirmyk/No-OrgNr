#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Pod::No404s; Test::Pod::No404s->import(); 1; } ) {
        plan skip_all => 'Test::Pod::No404s required for this test';
    }
}

all_pod_files_ok();
