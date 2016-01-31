#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;
use Test::More tests => 7;

BEGIN {
    if ( !eval { require Net::Ping; 1; } ) {
        plan skip_all => 'Net::Ping required for this test';
    }
    elsif ( !eval { require Net::Ping::External; Net::Ping::External->import('ping'); 1; } ) {
        plan skip_all => 'Net::Ping::External required for this test';
    }
}

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr2domains/ );
}

if ( Net::Ping->new('external')->ping('whois.norid.no') ) {

    # Checking known organization numbers
    my @domains = orgnr2domains('971035854');
    my ($d) = grep { $_ eq 'uio.no' } @domains;
    is( $d, 'uio.no', 'Validating domain name (1)' );

    @domains = orgnr2domains('988588261');
    ($d) = grep { $_ eq 'google.no' } @domains;
    is( $d, 'google.no', 'Validating domain name (2)' );

    # Checking invalid organization numbers
    is( (), orgnr2domains('abc'), 'Validating domain name (3)' );
    is( (), orgnr2domains(''),    'Validating domain name (4)' );
    is( (), orgnr2domains(' '),   'Validating domain name (5)' );
    is( (), orgnr2domains(undef), 'Validating domain name (6)' );
}
