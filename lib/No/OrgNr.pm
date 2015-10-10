package No::OrgNr;

use utf8;
use 5.016;
use warnings;
use open qw/:encoding(UTF-8) :std/;

use parent qw/Exporter/;
our @EXPORT_OK = qw/orgnr_ok/;

use version; our $VERSION = qv('0.1.0');

sub orgnr_ok {
    my $orgnr = shift;

    return 0 if not defined $orgnr;
    return 0 if $orgnr =~ /\A\s*\z/;

    $orgnr =~ s/\s//msg;
    return 0 if $orgnr =~ /\D/a;

    return 0 if $orgnr =~ /\A[0-7]/;

    my @digits = split //, $orgnr;
    my $weights = [ 3, 2, 7, 6, 5, 4, 3, 2 ];
    my $sum = 0;
    foreach (0..7) {
        $sum += $digits[$_] * $weights->[$_];
    }

    my $rem = $sum % 11;
    return 0 if $rem == 1;

    my $control_digit;
    $rem == 0 ? $control_digit = 0 : $control_digit = 11 - $rem;
    return 0 if $control_digit ne $digits[8];

    return join ' ', join('', @digits[0..2]), join('', @digits[3..5]), join('', @digits[6..8]);
}

1;

__END__

=encoding utf8

=head1 NAME

No::OrgNr - Validate ID numbers for Norwegian organizations

=head1 VERSION

This document describes No::OrgNr version 0.1.0


=head1 SYNOPSIS

    use No::OrgNr qw/orgnr_ok/;
    my $test_orgnr = orgnr_ok('988588261');
    print $test_orgnr if $test_orgnr;    # Prints "988 588 261"

=head1 DESCRIPTION

Organizations in Norway have a 9-digit number for identification. This module can be used to
validate these numbers.

Valid numbers always start with 8 or 9. The module checks if the number is valid. Whether a given
number is actually used by an organization is not checked. No information about the given
organization can be derived from the number.

The Norwegian term for organization number is "organisasjonsnummer" or "juridisk nummer"; the
previous name was "foretaksnummer". See L<https://no.wikipedia.org/wiki/Organisasjonsnummer> for a
description (Norwegian text only).

Organizations in other countries also have ID numbers. See
L<https://en.wikipedia.org/wiki/VAT_identification_number>.

=head1 SUBROUTINES/METHODS

=head2 orgnr_ok

The function returns false if the number is invalid. Otherwise, it returns the number in standard
form, e.g., "987 654 321", which of course is a true value.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

None.

=head1 DEPENDENCIES

This module requires Perl 5.16 or later.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

The modules L<No::KontoNr|https://metacpan.org/pod/No::KontoNr> and
L<No::PersonNr|https://metacpan.org/pod/No::PersonNr> may be of interest for validation
purposes. The documentation for these modules is in Norwegian only.

=head1 BUGS

None reported.

=head1 SUPPORT

Documentation for this module is available using the perldoc command:

    perldoc No::OrgNr

=head1 AUTHOR

Geir Myklebust C<< <geirmy@gmail.com> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Geir Myklebust C<< <geirmy@gmail.com> >>.

This module is free software; you can redistribute it and/or modify it under the same terms as Perl
itself. See L<Perl Artistic License|perlartistic>.
