package Catalyst::Plugin::Log::Colorful;

use strict;
use Term::ANSIColor;
use Data::Dumper;
use vars qw($TEXT $BACKGROUND);

our $VERSION = 0.02;

sub setup {
    my $c = shift;
    $TEXT = $c->config->{log_colorful}{text} || 'red' ;
    $BACKGROUND = $c->config->{log_colorful}{background};
    $c = $c->NEXT::setup(@_);
    return $c;
}

sub Catalyst::Log::color {
    my ( $s ,$var, $color , $bg_color ) = @_;

    # is not debug mdoe.
    return unless $s->is_debug;

    $color      = $color    || $Catalyst::Plugin::Log::Colorful::TEXT ; 
    $bg_color   = $bg_color || $Catalyst::Plugin::Log::Colorful::BACKGROUND ;

    if ( ref $var eq 'ARRAY' or ref $var eq 'HASH') {
        $var = Dumper( $var );
    }
    
    if ( $bg_color ) {
        $color .= " on_$bg_color";
    }

    $s->debug( color(  $color ) . $var .color('reset'));
}

1;

=head1 NAME

Catalyst::Plugin::Log::Colorful - Catalyst Plugin for Colorful Log

=head1 SYNOPSYS

 use Catalyst qw/-Debug ConfigLoader Log::Colorful/;
 
 __PACKAGE__->config( 
    name => 'MyApp' ,
    log_colorful => {
        text        => 'blue',
        background  => 'green',
    }
 );

In your controller.

 $c->log->color('hello');
 $c->log->color('hello blue' , 'blue');
 $c->log->color('hello red on white' , 'red' , 'white');
 $c->log->color( $hash_ref );
 $c->log->color( $array_ref );

=head1 DESCRIPTION

This plugin injects a color() method into the L<Catalyst::Log> namespace.

Sometimes when I am monitoring 'tail -f error_log' or './script/my_server.pl'
during develop phase , I could not find log message because of a lot of
logs. This plugin may help to find it out.  This plugin is using L<Term::ANSIColor> . 

Of course when you open log file with vi or some editor , the color wont
change and also you will see additional log such as '[31;47moraora[0m'.

=head1 METHOD

=head2 color

 $c->log->color($var, 'text color' , 'background color');

this color method wrap up log->debug() . text color and background color is optional.

=head2 setup

=head1 SEE ALSO

L<Catalyst::Log>
L<Term::ANSIColor>

=head1 AUTHOR

Tomohiro Teranishi <tomohiro.teranishi@gmail.com>

=cut
