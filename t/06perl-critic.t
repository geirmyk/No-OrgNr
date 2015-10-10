#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use File::Spec::Functions qw/catfile/;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Perl::Critic; 1; } ) {
        plan skip_all => 'Test::Perl::Critic required for this test';
    }
}

Test::Perl::Critic->import( -profile => catfile( 't', 'conf', 'perlcriticrc' ) );

all_critic_ok();
