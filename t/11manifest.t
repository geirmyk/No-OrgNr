#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::DistManifest; Test::DistManifest->import(); 1; } ) {
        plan skip_all => 'Test::DistManifest required for this test';
    }
    else {
        plan tests => 5;
    }
}

BEGIN {
    use_ok('No::OrgNr');
}

manifest_ok('MANIFEST', 'MANIFEST.SKIP');
