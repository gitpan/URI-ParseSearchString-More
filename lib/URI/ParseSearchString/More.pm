package URI::ParseSearchString::More;

use warnings;
use strict;

use base qw( URI::ParseSearchString );

our $VERSION = '0.01';

use Params::Validate qw( validate SCALAR );
use WWW::Mechanize::Cached;

my %search_regex = (
    aol => qr/AOL Search results for "(.*)"/,
);

sub se_term {

    my $self = shift;
    my $url = shift;
    
    # is this a funky AOL query?
    if ( $url =~ /search\?encquery=/ ) {
        my $mech = $self->get_mech();
        $mech->get( $url );

        my $search_term = $self->_apply_regex(
            string  => $mech->title(),
            regex   => 'aol',
        );
        
        return $search_term if $search_term;
    }

    return $self->SUPER::se_term( $url, @_ );

}

sub get_mech {
 
    my $self = shift;
    if ( !$self->{'mech'} ) {
   
        my $mech = WWW::Mechanize::Cached->new();
        $mech->agent("URI::ParseSearchString::More $VERSION");
        $self->{'mech'} = $mech;
   
    }

    return $self->{'mech'};

}

sub _apply_regex {

    my $self = shift;
    my %rules = ( 
        string => { type => SCALAR },
        regex  => { type => SCALAR },
    );
    
    my %args = validate( @_, \%rules );
     
    if ( $args{'string'} =~ $search_regex{$args{'regex'}} ) {
        return $1;
    }

    return;
}


#################### main pod documentation begin ###################


=head1 NAME

URI::ParseSearchString::More - Extract search strings from more referrers.

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

  use URI::ParseSearchString::More;
  my $more = URI::ParseSearchString::More;
  my $search_terms = $more->se_term( $search_engine_referring_url );


=head1 DESCRIPTION

This module is a subclass of L<URI::ParseSearchString>, so you can call any
methods on this object that you would call on a URI::ParseSearchString object. 
L<URI::ParseSearchString> is extended in the following way:

L<WWW::Mechanize> is used to extract search strings from some URLs which
contain session info rather than search params.  Currently this means AOL 
queries.  Support for other engines can be added as needed.


=head1 USAGE

  use URI::ParseSearchString::More;
  my $more = URI::ParseSearchString::More;
  my $search_terms = $more->se_term( $search_engine_referring_url );


=head1 EXTENDED URI::ParseSearchString METHODS

=head2 se_term

At this point, this is the only "extended" URI::ParseSearchString method.  If
the URL supplied looks to be an AOL search query with no search data in the 
URL, this method will attempt a WWW::Mechanize::Cached lookup of the URL and 
will try to extract the search terms from the page returned.  In all other 
cases the results of URI::ParseSearchString::se_term will be returned.

WWW::Mechanize::Cached is used to speed up your movement through large log 
files which may contain multiple similar URLs.

=head1 STRICTLY URI::ParseSearchString::More METHODS


=head2 get_mech

This gives you direct access to the L<WWW::Mechanize::Cached> object.  If you
know what you're doing, play around with it.  Caveat emptor.

  use URI::ParseSearchString::More;
  my $more = URI::ParseSearchString::More;

  my $mech = $more->get_mech();
  $mech->agent("My Agent Name");

  my $search_terms = $more->se_term( $search_engine_referring_url );
  
=head1 TO DO

Sometimes a good guess is all you need.  This module should make (hopefully)
intelligent guess when L<URI::ParseSearchString> comes up empty and there's no 
session info to be had.

Here is a list of some of the engines currently not covered by 
URI::ParseSearchString that may be added to this module:

  about.com
  search.msn.ca (as well as other permutations of search.msn)
  books.google.*
  images.google.*
  maps.google.*
  local.google.*
  search.hk.yahoo.com
  clusty.com
  www.excite.co.uk
  search.dmoz.org
  aolsearcht2.search.aol.com
  www.att.net
  www.overture.com
  www.adelphia.net/google/
  www.googlesyndicatedsearch.com

One interesting thing to note is that maps.google.* URLs have 2
important params: "q" and "near".   The same can be said for
local.google.*  I would think the results would be incomplete without
including the value of "near" in the search terms for these searches.

=head1 NOTES

Despite its low version number, this module actually works.  It is,
however, still very young and the interface is subject to some change.

=head1 BUGS

Please use the RT interface to report bugs:

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=URI-ParseSearchString-More>


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc URI::ParseSearchString::More

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/URI-ParseSearchString-More>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/URI-ParseSearchString-More>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=URI-ParseSearchString-More>

=item * Search CPAN

L<http://search.cpan.org/dist/URI-ParseSearchString>

=back

=head1 AUTHOR

    Olaf Alders
    CPAN ID: OALDERS
    WunderCounter.com
    olaf@wundersolutions.com
    http://www.wundercounter.com

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

#################### main pod documentation end ###################


1;
# The preceding line will help the module return a true value

