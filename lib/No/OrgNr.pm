package No::OrgNr;

use utf8;
use 5.014;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use Net::DNS;
use Net::Whois::Norid;
use Net::Whois::Raw;

$Net::Whois::Raw::CHECK_FAIL = 1;
$Net::Whois::Raw::OMIT_MSG   = 1;

use version; our $VERSION = qv('0.8.4');

use parent qw/Exporter/;
our @EXPORT_OK = qw/all domain2orgnr orgnr_ok orgnr2domains/;
our %EXPORT_TAGS = ( 'all' => [qw/domain2orgnr orgnr_ok orgnr2domains/] );

sub domain2orgnr {
    my $domain = shift;

    return if not $domain;
    return if $domain !~ / [.] no \z /x;

    my $obj = Net::Whois::Norid->new($domain);

    return $obj->{id_number};
}

sub orgnr2domains {
    my $orgnr = shift;
    return () if not orgnr_ok($orgnr);
    $orgnr =~ s/\s//g;    # The lookup method below requires a 9-digit number

    my $obj = Net::Whois::Norid->new($orgnr);
    return () if not exists $obj->{norid_handle};

    my @domains;

  HANDLE:
    for my $nh ( split / \n /x, $obj->{norid_handle} ) {
        my $nhobj = Net::Whois::Norid->new($nh);
        next HANDLE if not exists $nhobj->{domains};

        for my $domain ( split / /, $nhobj->{domains} ) {
            push @domains, $domain;
        }
    }

    return ( sort @domains );
}

sub orgnr_ok {
    my $orgnr = shift;
    return 0 if not defined $orgnr;

    $orgnr =~ s/\s//g;

    # Valid numbers start on 8 or 9
    return 0 if $orgnr !~ /\A [89] \d{8} \z/ax;

    my @digits = split //, $orgnr;
    my $weights = [ 3, 2, 7, 6, 5, 4, 3, 2 ];
    my $sum = 0;
    for my $w ( 0 .. $#{$weights} ) {
        $sum += $digits[$w] * $weights->[$w];
    }

    my $rem = $sum % 11;
    my $control_digit = ( $rem == 0 ? 0 : 11 - $rem );

    # Invalid number if control digit is 10
    return 0 if $rem == 1;

    return 0 if $control_digit ne $digits[8];

    my $ret = $digits[0] . $digits[1] . $digits[2] . ' ';
    $ret .= $digits[3] . $digits[4] . $digits[5] . ' ';
    $ret .= $digits[6] . $digits[7] . $digits[8];

    return $ret;
}

1;

__END__

=encoding utf8

=for html
<a href="https://travis-ci.org/geirmyk/No-OrgNr">
<img alt="Build Status" src="https://travis-ci.org/geirmyk/No-OrgNr.svg?branch=master" /></a>
<a href="https://badge.fury.io/pl/No-OrgNr">
<img alt="CPAN version" src="https://badge.fury.io/pl/No-OrgNr.svg" /></a>

=head1 NAME

No::OrgNr - Utility functions for Norwegian organizations' ID numbers

=head1 VERSION

This document describes No::OrgNr version 0.8.4

=head1 SYNOPSIS

    use No::OrgNr qw/domain2orgnr orgnr2domains orgnr_ok/;
    # or
    use No::OrgNr qw/:all/;

    my $owner   = domain2orgnr('google.no'); # Returns "988588261", as seen by Whois
    my $test    = orgnr_ok('988588261');     # Returns "988 588 261"
    my @domains = orgnr2domains(ORG_NR);     # Returns a list of domain names owned by ORG_NR

=head1 DESCRIPTION

Organizations in Norway have a 9-digit number for identification. Valid numbers start with 8 or
9. No information about the given organization can be derived from the number.

This module contains utility functions for handling these numbers. Domain names owned by Norwegian
organizations can also be listed, given their organization number.

The Norwegian term for organization number is "organisasjonsnummer". See
L<https://no.wikipedia.org/wiki/Organisasjonsnummer> for a description (Norwegian text only).

Organizations in other countries also have ID numbers. See
L<https://en.wikipedia.org/wiki/VAT_identification_number>.

=head1 SUBROUTINES/METHODS

Nothing is exported by default. See L</"SYNOPSIS"> above.

=head2 domain2orgnr(DOMAIN_NAME)

The function returns the organization number for the owner of C<DOMAIN_NAME>. Only Norwegian domain
names (*.no) are supported. If no organization number can be found, the undefined value is returned.

=head2 orgnr2domains(ORG_NR)

The function returns a sorted list of domain names (if any) owned by
organization number C<ORG_NR>. If C<ORG_NR> is missing or invalid, or the
organization does not own a domain name, an empty list is returned.

=head2 orgnr_ok(ORG_NR)

The function returns false if C<ORG_NR> is invalid. Otherwise, it returns the number in standard
form, e.g., "987 654 321", which of course is a true value. A valid number is not necessarily used
by any real organization.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION

None.

=head1 DEPENDENCIES

This module requires Perl 5.14 or later, due to the "/a" regular expression modifier.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

The modules L<No::KontoNr|https://metacpan.org/pod/No::KontoNr> and
L<No::PersonNr|https://metacpan.org/pod/No::PersonNr>, written by another CPAN author, may be of
interest for validation purposes. The documentation for these modules is in Norwegian only.

=head1 BUGS

Please report bugs using L<GitHub|https://github.com/geirmyk/No-OrgNr/issues>.

=head1 SUPPORT

Documentation for this module is available using the following command:

    perldoc No::OrgNr

The following sites may be useful:

=over 4

=item *

AnnoCPAN: L<http://annocpan.org/dist/No-OrgNr>

=item *

MetaCPAN: L<https://metacpan.org/pod/No::OrgNr>

=item *

CPAN Dependencies: L<http://deps.cpantesters.org/?module=No%3A%3AOrgNr>

=item *

CPAN Ratings: L<http://cpanratings.perl.org/dist/No::OrgNr>

=item *

CPAN Search: L<http://search.cpan.org/perldoc?No::OrgNr>

=item *

CPAN Testers Matrix: L<http://matrix.cpantesters.org/?dist=No-OrgNr>

=item *

CPAN Testers Reports: L<http://www.cpantesters.org/distro/N/No-OrgNr.html>

=item *

CPANTS (CPAN Testing Service): L<http://cpants.cpanauthors.org/dist/No-OrgNr>

=back

=head1 AUTHOR

Geir Myklebust C<< <geirmy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

No::OrgNr is Copyright (C) 2015, 2016, Geir Myklebust.

This module is free software; you can redistribute it and/or modify it under the
same terms as Perl 5.14.0. For details, see L<GNU General Public
License|https://metacpan.org/pod/perlgpl> and L<Perl Artistic
License|https://metacpan.org/pod/perlartistic>.

This program is distributed in the hope that it will be useful, but it is
provided "as is" and without any express or implied warranties.
