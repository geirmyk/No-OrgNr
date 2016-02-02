#!/usr/bin/perl

use utf8;
use 5.014;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    add_to_cleanup      => [ 'No::OrgNr-*' ],
    module_name         => 'No::OrgNr',
    license             => 'perl',
    dist_author         => 'Geir Myklebust <geirmy@cpan.org>',
    dist_version_from   => 'lib/No/OrgNr.pm',
    configure_requires  => {
        'Module::Build' => 0
    },
    requires            => {
        'perl'              => 5.014,
        'Net::Whois::Norid' => 0
    },
    resources           => {
        license     => [ 'http://dev.perl.org/licenses/' ],
        homepage    => 'https://metacpan.org/pod/No::OrgNr',
        bugtracker  => {
            web    => 'https://github.com/geirmyk/No-OrgNr/issues',
            mailto => 'geirmy@cpan.org',
        },
        repository  => {
            url  => 'https://github.com/geirmyk/No-OrgNr.git',
            web  => 'https://github.com/geirmyk/No-OrgNr',
            type => 'git',
        }
    }
);

$builder->create_build_script();
