#!/usr/bin/perl

use utf8;
use 5.016;
use warnings;
use Test::More;

BEGIN {
    if ( !$ENV{RELEASE_TESTING} ) {
        plan skip_all => 'Author tests not required for installation';
    }
    elsif ( !eval { require Test::Spelling; Test::Spelling->import(); 1; } ) {
        plan skip_all => 'Test::Spelling required for this test';
    }
    elsif ( !eval { require Text::Hunspell; Text::Hunspell->import(); 1; } ) {
        plan skip_all => 'Text::Hunspell required for this test';
    }
    elsif ( !defined has_working_spellchecker() ) {
        plan skip_all => 'Required spellchecker (aspell) not found';
    }
}

set_spell_cmd('hunspell -d en_US -l');
add_stopwords(<DATA>);
all_pod_files_spelling_ok();

__DATA__
AnnoCPAN
CPANTS
Geir
MetaCPAN
Myklebust
foretaksnummer
juridisk
nummer
organisasjonsnummer
