#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;
use Net::Ping;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping::External; Net::Ping::External->import; 1; } ) {
        plan skip_all => 'Net::Ping::External required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr2domains/ );
}

if ( Net::Ping->new('external')->ping('whois.norid.no') ) {

    # Checking known organization numbers
    my @domains = orgnr2domains('971035854');
    my $d       = 'uio.no';
    my $num     = grep { $_ eq $d } @domains;
    is( $num, 1, "Testing domain name $d" );

    @domains = orgnr2domains('988588261');
    $d       = 'google.no';
    $num     = grep { $_ eq $d } @domains;
    is( $num, 1, "Testing domain name $d" );

    # Checking invalid organization numbers
    is( (), orgnr2domains('abc'), 'Testing domain name (3)' );
    is( (), orgnr2domains(''),    'Testing domain name (4)' );
    is( (), orgnr2domains(' '),   'Testing domain name (5)' );
    is( (), orgnr2domains(undef), 'Testing domain name (6)' );

    # Checking orgnr which does not own a domain name
    is( (), orgnr2domains('994 039 113'), 'Orgnr does not own a domain name' );
}

done_testing;
