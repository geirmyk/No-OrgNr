#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Pod::LinkCheck; Test::Pod::LinkCheck->import(); 1; } ) {
        plan skip_all => 'Test::Pod::LinkCheck required for this test';
    }
}

Test::Pod::LinkCheck->new->all_pod_ok;
