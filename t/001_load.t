# -*- perl -*-

use strict;
use warnings;

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 9;

BEGIN { use_ok( 'URI::ParseSearchString::More' ); }

my $more = URI::ParseSearchString::More->new ();
isa_ok ($more, 'URI::ParseSearchString::More');

my $google = "http://www.google.com.do/search?q=give your visitors a message depending on ip&client=firefox-a&aq=t&oe=utf-8&rls=org.mozilla:es-ES:official&ie=utf-8";

my $terms = $more->se_term( $google );

cmp_ok ( $terms, "eq", "give your visitors a message depending on ip", "returned terms: $terms");

my $name = $more->se_name( $google );
ok( $name, "got name: $name");

my $host = $more->se_host( $google );
ok( $host, "got host: $host");

require_ok( 'Test::WWW::Mechanize' );
my $mech = Test::WWW::Mechanize->new();

my $query = "testing";
$mech->get_ok("http://aolsearch.aol.com/aol/search?invocationType=topsearchbox.webhome&query=$query", "got search page from AOL");

ok( $mech->title(), "got a title from AOL: " . $mech->title() );
my $search_term = $more->_apply_regex(
    string  => $mech->title(),
    regex   => 'aol',
);

cmp_ok( $search_term, 'eq', $query, "aol returns correct search term" );
