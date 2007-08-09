# -*- perl -*-

use strict;
use warnings;

use Test::More qw( no_plan );
use Data::Dumper;

use lib '../lib';

BEGIN { use_ok( 'URI::ParseSearchString::More' ); }

my $more = URI::ParseSearchString::More->new ();

 use Config::General;
 my $conf = new Config::General(
    -ConfigFile => "t/urls.cfg", 
    -BackslashEscape => 1,
);
 my %config = $conf->getall;
 
 foreach my $test ( @{$config{'urls'}}) {
     next unless $test->{'terms'};
     
     my $terms = $more->parse_search_string( $test->{'url'} );
     cmp_ok ( $terms, 'eq', $test->{'terms'}, "got $terms");
     cmp_ok( $more->blame(), 'eq', 'URI::ParseSearchString::More', "parsed by More" );

 }
 