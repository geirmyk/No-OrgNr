#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More;

BEGIN {
    if ( !eval { require Test::Pod; Test::Pod->import(); 1; } ) {
        plan skip_all => 'Test::Pod required for this test';
    }
}

all_pod_files_ok();

done_testing;
