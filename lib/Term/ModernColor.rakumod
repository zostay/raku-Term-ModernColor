use v6;

unit module Term::ModernColor;

enum NamedColors is export(:codes) <
    Black Maroon Green Olive  Navy Purple  Teal Silver
    Gray  Red    Lime  Yellow Blue Fuschia Aqua White
>;

our proto fgcolor(|) is export(:codes) { * }
multi fgcolor(NamedColors:D $color --> Str:D) {
    return "" with $*DISABLE-COLOR;
    sprintf "\e[38;5;%03dm", $color.value;
}

our proto bgcolor(|) is export(:codes) { * }
multi bgcolor(NamedColors:D $color --> Str:D) {
    return "" with $*DISABLE-COLOR;
    sprintf "\e[48;5;%03dm", $color.value;
}

our sub reset-color(--> Str:D) is export(:codes) { "\e[0m" }
our sub done-coloring(--> Str:D) is export(:done) { reset-color() }

our sub _generate-exports($key) {
    % = gather {
        for NamedColors.enums.keys -> $color-name {
            my $color = NamedColors::{$color-name};

            if $key eq 'named' | 'plain' | 'plain-named' {
                take "&$color.lc()"    => sub ($x?) { fgcolor($color) ~ ($x//'') }
            }

            if $key eq 'named' | 'fg' | 'fg-named' {
                take "&fg-$color.lc()" => sub ($x?) { fgcolor($color) ~ ($x//'') }
            }

            if $key eq 'named' | 'bg' | 'bg-named' {
                take "&bg-$color.lc()" => sub ($x?) { bgcolor($color) ~ ($x//'') }
            }
        }
    }
}

my @pkg-keys = <named plain plain-named fg fg-named bg bg-named>;
for @pkg-keys -> $pkg-key {
    my $p = EXPORT::{$pkg-key} = package { }
    for _generate-exports($pkg-key).kv -> $name, $sub {
        $p.WHO.{$name} = $sub;
    }
}
