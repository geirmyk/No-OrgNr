#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    if ( !eval { require Net::Ping; Net::Ping->import; 1; } ) {
        plan skip_all => 'Net::Ping required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr2domains/ );
}

is( (), orgnr2domains('abc'), 'Testing invalid orgnr' );
is( (), orgnr2domains(undef), 'Testing undefined orgnr' );
is( (), orgnr2domains(''),    'Testing empty orgnr' );
is( (), orgnr2domains(' '),   'Testing orgnr equal to a space' );

if ( Net::Ping->new->ping('whois.norid.no') ) {

    # Checking known organization numbers
    my @domains = orgnr2domains('971035854');
    my $d       = 'uio.no';
    my $num     = grep { $_ eq $d } @domains;
    is( $num, 1, "Testing domain name $d" );

    @domains = orgnr2domains('988588261');
    $d       = 'google.no';
    $num     = grep { $_ eq $d } @domains;
    is( $num, 1, "Testing domain name $d" );
}

done_testing;
