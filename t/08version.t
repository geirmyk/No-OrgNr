#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::ConsistentVersion; Test::ConsistentVersion->import(); 1; } ) {
        plan skip_all => 'Test::ConsistentVersion required for this test';
    }
}

Test::ConsistentVersion::check_consistent_versions();
