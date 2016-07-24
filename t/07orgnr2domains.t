#!/usr/bin/env perl

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::Ping;
use Test::More;

BEGIN {
    use_ok( 'No::OrgNr', qw/orgnr2domains/ );
}

my @empty;
is( orgnr2domains('abc'), @empty, 'Testing invalid organization number' );
is( orgnr2domains(undef), @empty, 'Testing undefined organization number' );
is( orgnr2domains(''),    @empty, 'Testing empty organization number' );
is( orgnr2domains(' '),   @empty, 'Testing organization number equal to a space' );

if ( Net::Ping->new->ping('whois.norid.no') ) {

    # Testing known organization numbers
    my @domains = orgnr2domains('971035854');
    my $domain  = 'uio.no';
    my $num     = grep { $_ eq $domain } @domains;
    is( $num, 1, "Testing domain name $domain" );

    @domains = orgnr2domains('988588261');
    $domain  = 'google.no';
    $num     = grep { $_ eq $domain } @domains;
    is( $num, 1, "Testing domain name $domain" );

    # Testing organization number which does not own a domain name
    is( orgnr2domains('994039113'), @empty, 'Organization number does not own a domain name' );
}

done_testing;
