use v6;

unit module Term::ModernColor;

=begin pod

=head1 NAME

Term::ModernColor - Add color to your terminal, lots of color

=head1 SYNOPSIS

    {
        use Term::ModernColor :fg, :colors;
        say fg-color(ElectricPurple, :on(Citrine),
            "This is bright."
        );
    }

    {
        use Term::ModernColor :bg-named;
        say bg-jazzberry-jam("This is some hot pink.", :with(0xFF, 0x99, 0x99));
    }

=head1 DESCRIPTION

I don't know that Raku really needed another ANSI color library, but I wrote one anyway. It's named Modern because of reasons.

=head1 COLOR NAMES

The color names in this library follow no regular scheme but my own, though, my own scheme was based on trying to find well-known color names.

Assuming you don't use the ANSI OSC codes or some other mechanism to change the colors, your terminal probably uses the standard 256 color palette used by most terminals by default. This color scheme has 3 color bands.

=item * The first band is the original(ish) 16 ANSI colors, which are basically white, black, additive primaries, and additive secondaries at two intensity levels.

=item * The second band represents a 6 by 6 by 6 color cube that evenly covers the RGB spectrum. The 8 corners of the cube repeat the 8 colors already mentioned with a spectrum of colors in between.

=item * The third band fills the remaining 24 index slots with an even spread of gray values between white and black. This band is missing a full white and full black, though, so the color cube's white and black are used to cap the grayscale to give it 26 shades.

The ANSI colors are given what I consider to be traditional names:

    Black Maroon Green Olive  Navy Purple  Teal Silver
    Gray  Red    Lime  Yellow Blue Fuschia Aqua White

And the shades of gray are named C<Gray0> to C<Gray25>, which means that the color cube's white is C<Gray25> and the color cube's black is C<Gray0>. (And in the usual color palette, C<Gray25> is exactly the same as C<White> and C<Gray0> is exactly the same as C<Black> even though both are different indexes in the palette.)

The rest of the colors, however, have well-established, but unconventionally compiled names.

At first I was going to see if there is a standard list of names for xterm colors. It would appear that L<Jonas Jacek|https://jonasjacek.github.io/colors/> has attempted this, but with limited success. His color scheme attempts to map X11 color names onto the xterm names, but they match up and there are several duplicates.

I also discovered L<colornames.org|https://colornames.org>, which is kind of fun, but suffers from the same problem any other popularity contest: people game it to make it funny and absurd. I probably could have used it, but I found something I think is better.

Wikipedia maintains several lists of colors, which includes a combined list of the other colors lists. This is currently broken out into three pages: L<A-F|https://en.wikipedia.org/wiki/List_of_colors:_A%E2%80%93F>, L<G-M|https://en.wikipedia.org/wiki/List_of_colors:_G%E2%80%93M>, and L<N-Z|https://en.wikipedia.org/wiki/List_of_colors:_N%E2%80%93Z>. I took the pages from May 24, 2020 and used that list of colors to extract what I think to be a pretty reasonable list of names.

I deleted all the duplicates and all the names I considered fixed. Then I took the RGB values for a typical color cube palette and compared it to the RGB values presented on Wikipedia for each color to measure color distance using a fairly unscientific method (comparing RGB values is not the best way to compare colors, but it's not a bad way for this purpose given how imprecise human color vision is). I then tried to pick the closest matches to the Wikipedia colors while also preserving uniqueness.

All of that was combined to come up with the list of colors you can read with L<#enum Colors256>. I think it works pretty well and ends up with a lot of interesting cultural references across the world.

You can also address all colors by numeric index instead of by name, if that suits your application better or if you just don't like my names. Or you can use a three part RGB value, assuming your terminal was updated sometime in the past decade or so.

=head1 CAVEATS

This library generally uses American spellings for colors and color words, which seem to have a higher concentration of dialect-specific spellings than other domains. If that bugs you, sorry not sorry. This is my dialect of English and this is my library. If you want to figure out how to work other dialect spellings in, feel free to offer a patch or fork it.

=head1 CONSTANTS

=head2 enum AnsiSgrCode

    enum AnsiSgrCode is export(:raw)

This enumeration defines a number of constants for use with ANSI CSI-SGR sequences. An ANSI CSI code is one that is prefixed with the Control Sequence Introducer, which is used to issue a number of different terminal commands for various actions. This library primarily supports the SGR subset,  Select Graphics Rendition sequences. These control the appearance of text and the background of that text as it is written.

The following SGR codes are defined:

    SgrReset
    SgrBold
    SgrFaint
    SgrItalic
    SgrUnderline
    SgrBlinkSlow
    SgrBlinkFast
    SgrReverse
    SgrConceal
    SgrCrossOut
    SgrFontDefault
    SgrFontAlt1
    SgrFontAlt2
    SgrFontAlt3
    SgrFontAlt4
    SgrFontAlt5
    SgrFontAlt6
    SgrFontAlt7
    SgrFontAlt8
    SgrFontAlt9
    SgrFontFraktur
    SgrUnderlineDouble
    SgrUnBold
    SgrUnItalic
    SgrUnUnderline
    SgrUnBlink
    SgrUnReverse
    SgrUnConceal
    SgrUnCrossOut
    SgrFgBlack
    SgrFgRed
    SgrFgGreen
    SgrFgYellow
    SgrFgBlue
    SgrFgMagenta
    SgrFgCyan
    SgrFgWhite
    SgrFgSet
    SgrFgDefault
    SgrBgBlack
    SgrBgRed
    SgrBgGreen
    SgrBgYellow
    SgrBgBlue
    SgrBgMagenta
    SgrBgCyan
    SgrBgWhite
    SgrBgSet
    SgrBgDefault

The ones primarily used with this library are:

=item * C<SgrReset> is used with the L<constant ansi-reset-code>.

=item * C<SgrFgSet> is used to set the foreground color.

=item * C<SgrFgDefault> is used to clear the foreground color.

=item * C<SgrBgSet> is used to set the background color.

=item * C<SgrBgDefault> is used to clear the background color.

=head2 enum Color256

    enum Color256 is export(:colors)

This exports the following color constants which can be used to set the color to an indexed color value:

    Black Maroon Green Olive  Navy Purple  Teal Silver
    Gray  Red    Lime  Yellow Blue Fuschia Aqua White
    Gray0 RoyalBlue NavyBlue DukeBlue MediumBlue Zaffre
    PakistanGreen TropicalRainforest BlueSapphire HonoluluBlue TrueBlue DodgerBlue
    Ao SpanishViridian DarkCyan CeladonBlue StarCommandBlue Azure
    IndiaGreen GoGreen PersianGreen TiffanyBlue RobinEggBlue Capri
    DarkPastelGreen Malachite CaribbeanGreen LightSeaGreen DarkTurquoise VividSkyBlue
    ElectricGreen Erin SpringGreen MediumSpringGreen TurquoiseBlue Cyan
    BloodRed TyrianPurple Indigo TrypanBlue HanPurple ElectricIndigo
    AntiqueBronze GraniteGray DarkBlueGray Liberty MajorelleBlue NeonBlue
    Avocado RussianGreen SteelTeal Glaucous UnitedNationsBlue CornflowerBlue
    KellyGreen ForestGreen ShinyShamrock GreenSheen CarolinaBlue BlueJeans
    Harlequin ParisGreen Emerald MediumAquamarine MediumTurquoise MayaBlue
    BrightGreen ScreaminGreen OceanGreen Verdigris Turquoise ItalianSkyBlue
    DarkRed Patriarch MardiGras DarkMagenta FrenchViolet ElectricViolet
    Brown DeepTaupe ChineseViolet FrenchLilac MediumPurple MediumSlateBlue
    Gold Shadow TaupeGray CoolGrey MiddleBluePurple Aero
    AppleGreen Asparagus DarkSeaGreen PewterBlue DarkSkyBlue FrenchSkyBlue
    SheenGreen Mantis LightGreen TurquoiseGreen MiddleBlueGreen LightSkyBlue
    LawnGreen SpringFrost MintGreen EtonBlue Aquamarine ElectricBlue
    Rufous JazzberryJam Flirt Byzantine DarkViolet ElectricPurple
    WindsorTan CopperPenny AntiqueFuchsia PearlyPurple MediumOrchid Amethyst
    DarkGoldenrod CafeAuLait EnglishLavender GlossyGrape Lavender AfricanViolet
    AcidGreen OliveGreen Sage SilverChalice MaximumBluePurple BabyBlueEyes
    BitterLemon JuneBud GrannySmithApple Celadon LightBlue UranianBlue
    SpringBud Inchworm KeyLime AshGray MagicMint Celeste
    RossoCorsa RubineRed MexicanPink HollywoodCerise PsychedelicPurple Phlox
    Tenne IndianRed Blush SkyMagenta Orchid Heliotrope
    HarvestGold RawSienna NewYorkPink MiddlePurple FrenchMauve BrightLilac
    Goldenrod EarthYellow Tumbleweed SilverPink PinkLavender Mauve
    Citrine ArylideYellow Flax DesertSand Timberwolf Periwinkle
    Chartreuse MaximumGreenYellow Mindaro TeaGreen Nyanza LightCyan
    CandyAppleRed WinterSky Rose FashionFuchsia HotMagenta Magenta
    SafetyOrange Bittersweet BrinkPink HotPink RosePink UltraPink
    DarkOrange Coral CongoPink TickleMePink PersianPink PinkFlamingo
    ChineseYellow Rajah MacaroniAndCheese Melon CottonCandy CarnationPink
    SchoolBusYellow NaplesYellow Jasmine LightOrange PalePink PinkLace
    LemonGlacier LaserLemon Canary Peach Cream Gray25
    Gray1 Gray2 Gray3 Gray4 Gray5 Gray6
    Gray7 Gray8 Gray9 Gray10 Gray11 Gray12
    Gray13 Gray14 Gray15 Gray16 Gray17 Gray18
    Gray19 Gray20 Gray21 Gray22 Gray23 Gray24

=head2 constant ansi-reset-code

    our constant ansi-reset-code is export(:raw)

This is set to the ANSI control sequence that will reset all text rendering attributes to normal. When using the tools exported via C<:fg>, C<:bg>, C<:fg-named>, and C<:bg-named>, this should not be necessary as reset is taken care of automatically.

=end pod

our constant $CSI = "\e[";
our constant $SGR = "m";

our constant $RGB-COLOR = "2";
our constant $INDEXED-COLOR = "5";

enum AnsiSgrCode is export(:raw) (
    SgrReset           => 0,
    SgrBold            => 1,
    SgrFaint           => 2,
    SgrItalic          => 3,
    SgrUnderline       => 4,
    SgrBlinkSlow       => 5,
    SgrBlinkFast       => 6,
    SgrReverse         => 7,
    SgrConceal         => 8,
    SgrCrossOut        => 9,
    SgrFontDefault     => 10,
    SgrFontAlt1        => 11,
    SgrFontAlt2        => 12,
    SgrFontAlt3        => 13,
    SgrFontAlt4        => 14,
    SgrFontAlt5        => 15,
    SgrFontAlt6        => 16,
    SgrFontAlt7        => 17,
    SgrFontAlt8        => 18,
    SgrFontAlt9        => 19,
    SgrFontFraktur     => 20,
    SgrUnderlineDouble => 21,
    SgrUnBold          => 22,
    SgrUnItalic        => 23,
    SgrUnUnderline     => 24,
    SgrUnBlink         => 25,
    SgrUnReverse       => 27,
    SgrUnConceal       => 28,
    SgrUnCrossOut      => 29,
    SgrFgBlack         => 30,
    SgrFgRed           => 31,
    SgrFgGreen         => 32,
    SgrFgYellow        => 33,
    SgrFgBlue          => 34,
    SgrFgMagenta       => 35,
    SgrFgCyan          => 36,
    SgrFgWhite         => 37,
    SgrFgSet           => 38,
    SgrFgDefault       => 39,
    SgrBgBlack         => 40,
    SgrBgRed           => 41,
    SgrBgGreen         => 42,
    SgrBgYellow        => 43,
    SgrBgBlue          => 44,
    SgrBgMagenta       => 45,
    SgrBgCyan          => 46,
    SgrBgWhite         => 47,
    SgrBgSet           => 48,
    SgrBgDefault       => 49,
);

enum Color256 is export(:colors) <
    Black Maroon Green Olive  Navy Purple  Teal Silver
    Gray  Red    Lime  Yellow Blue Fuschia Aqua White
    Gray0 RoyalBlue NavyBlue DukeBlue MediumBlue Zaffre
    PakistanGreen TropicalRainforest BlueSapphire HonoluluBlue TrueBlue DodgerBlue
    Ao SpanishViridian DarkCyan CeladonBlue StarCommandBlue Azure
    IndiaGreen GoGreen PersianGreen TiffanyBlue RobinEggBlue Capri
    DarkPastelGreen Malachite CaribbeanGreen LightSeaGreen DarkTurquoise VividSkyBlue
    ElectricGreen Erin SpringGreen MediumSpringGreen TurquoiseBlue Cyan
    BloodRed TyrianPurple Indigo TrypanBlue HanPurple ElectricIndigo
    AntiqueBronze GraniteGray DarkBlueGray Liberty MajorelleBlue NeonBlue
    Avocado RussianGreen SteelTeal Glaucous UnitedNationsBlue CornflowerBlue
    KellyGreen ForestGreen ShinyShamrock GreenSheen CarolinaBlue BlueJeans
    Harlequin ParisGreen Emerald MediumAquamarine MediumTurquoise MayaBlue
    BrightGreen ScreaminGreen OceanGreen Verdigris Turquoise ItalianSkyBlue
    DarkRed Patriarch MardiGras DarkMagenta FrenchViolet ElectricViolet
    Brown DeepTaupe ChineseViolet FrenchLilac MediumPurple MediumSlateBlue
    Gold Shadow TaupeGray CoolGrey MiddleBluePurple Aero
    AppleGreen Asparagus DarkSeaGreen PewterBlue DarkSkyBlue FrenchSkyBlue
    SheenGreen Mantis LightGreen TurquoiseGreen MiddleBlueGreen LightSkyBlue
    LawnGreen SpringFrost MintGreen EtonBlue Aquamarine ElectricBlue
    Rufous JazzberryJam Flirt Byzantine DarkViolet ElectricPurple
    WindsorTan CopperPenny AntiqueFuchsia PearlyPurple MediumOrchid Amethyst
    DarkGoldenrod CafeAuLait EnglishLavender GlossyGrape Lavender AfricanViolet
    AcidGreen OliveGreen Sage SilverChalice MaximumBluePurple BabyBlueEyes
    BitterLemon JuneBud GrannySmithApple Celadon LightBlue UranianBlue
    SpringBud Inchworm KeyLime AshGray MagicMint Celeste
    RossoCorsa RubineRed MexicanPink HollywoodCerise PsychedelicPurple Phlox
    Tenne IndianRed Blush SkyMagenta Orchid Heliotrope
    HarvestGold RawSienna NewYorkPink MiddlePurple FrenchMauve BrightLilac
    Goldenrod EarthYellow Tumbleweed SilverPink PinkLavender Mauve
    Citrine ArylideYellow Flax DesertSand Timberwolf Periwinkle
    Chartreuse MaximumGreenYellow Mindaro TeaGreen Nyanza LightCyan
    CandyAppleRed WinterSky Rose FashionFuchsia HotMagenta Magenta
    SafetyOrange Bittersweet BrinkPink HotPink RosePink UltraPink
    DarkOrange Coral CongoPink TickleMePink PersianPink PinkFlamingo
    ChineseYellow Rajah MacaroniAndCheese Melon CottonCandy CarnationPink
    SchoolBusYellow NaplesYellow Jasmine LightOrange PalePink PinkLace
    LemonGlacier LaserLemon Canary Peach Cream Gray25
    Gray1 Gray2 Gray3 Gray4 Gray5 Gray6
    Gray7 Gray8 Gray9 Gray10 Gray11 Gray12
    Gray13 Gray14 Gray15 Gray16 Gray17 Gray18
    Gray19 Gray20 Gray21 Gray22 Gray23 Gray24
>;

=begin pod

=head1 ROUTINES

=head2 sub ansi-csi-code

    our sub ansi-csi-code(@params, $final --> Str:D) is export(:raw)

This method outputs an ANSI code with a CSI (control sequence introducer) prefix, C<\e[>. For example, to perform cursor reset to return all graphics parameters back to normal, you can run:

    print ansi-csi-code(["0"], "m");

=end pod

our sub ansi-csi-code(@params, $final --> Str:D) is export(:raw) {
    "{$CSI}@params.join()$final"
}

=begin pod

=head2 sub ansi-sgr-code

    our sub ansi-sgr-code(AnsiSgrCode:D $code, *@params --> Str:D) is export(:raw)

This is a further specialization of L<#method ansi-csi-code>, which outputs an ANSI sequence with the SGR (select graphics rendition) suffix, C<m>.

For example, if you want to turn on slow blink for some text on your terminal. You might write:

    print ansi-sgr-code(SgrBlinkSlow),
          "Blinking Text",
          ansi-sgr-code(SgrUnBlink);

=end pod

our sub ansi-sgr-code(AnsiSgrCode:D $code, *@params --> Str:D) is export(:raw) {
    ansi-csi-code([$code.value, |@params.map({ ";$_" })], $SGR)
}

=begin pod

=head2 sub colors256

    sub colors256(:$ansi, :$cube, :$grays --> Seq)

If you would like to iterate through the available indexed colors for some reason, this routine provides a convenient means of getting at the colors enum in order. This is helpful because Raku enumerations are not any more ordered than any other map, even though there is an implied ordering in the language structure.

=item * With no flags, it returns all 256 color enumeration values as a sequence in ascending order.

=item * With the C<:ansi> flag, it returns the first 16 colors in ascending order.

=item * With the C<:cube> flag, it returns the middle 216 colors from the color cube band in ascending order.

=item * With the C<:grays> flag, it returns the full 26 color gray scale in ascending order.

=end pod

our proto colors256(|) is export(:colors) { * }
multi colors256(--> Seq) {
    Color256.enums.values.sort.map: { Color256($^color) }
}
multi colors256(:$ansi! --> Seq) {
    (Black..White).map: { Color256($^color) }
}
multi colors256(:$cube! --> Seq) {
    (Gray0..Gray25).map: { Color256($^color) }
}
multi colors256(:$grays! --> Seq) {
    (Gray0, Gray1..Gray24, Gray25).flat.map: { Color256($^color) }
}

our constant ansi-reset-code is export(:raw) = ansi-sgr-code(SgrReset);

=begin pod

=head2 sub fg-color-code

    our proto fg-color-code(|) is export(:raw)
    multi fg-color-code(Color256:D $color, :$on --> Str:D)
    multi fg-color-code(Int:D $color, :$on --> Str:D)
    multi fg-color-code(Int:D $r, Int:D $g, Int:D $b, :$on --> Str:D)

This is a low level function that outputs the ANSI control sequence for setting the color of the text that comes after it.

The version that takes a L<Color256#enum Color256> and the version that takes a single L<Int> set the color to the indexed palette color. One sets it to the named color from teh enumeration and the second is an integer between 0 and 255 (inclusive) that sets it using the numeric index.

The final version that takes three L<Int>s uses the values as the Truecolor RGB color value to give the following text.

All the changes above will affect the foreground color.

The named C<:$on> argument gives you the option of setting the background color at the same time as the foreground color. It may take exactly the same forms: a single L<Color256#enum Color256>, a single L<Int>, or three L<Int>s for the RGB color value.

All of them return a string containing the ANSI code or codes needed to perform the color change requested.

=head2 sub bg-color-code

    our proto bg-color-code(|) is export(:raw)
    multi bg-color-code(Color256:D $color, :$with --> Str:D)
    multi bg-color-code(Int:D $color, :$with --> Str:D)
    multi bg-color-code(Int:D $r, Int:D $g, Int:D $b, :$with --> Str:D)

This is a low level function that outputs the ANSI control sequence for setting the color of the background of text that comes after it.

You can use indexed colors by either passing a L<Color256#enum Color256> color constant or an integer between 0 and 255, inclusive.

The other version, with C<$r>, C<$g>, and C<$b> arguments allows you to set the color using an RGB value.

These changes are all for the background color of the textx.

You can change the foreground at the same time by passing the C<:$with> named argument. This can be set to a numeric index, a Color256, or a 3 element list to set the RGB color.


All versions return the ANSI code sequences requested as a string.

=end pod

subset ColorIndex of Int where 0 <= * < 256;

our proto fg-color-code(|) is export(:raw) { * }
multi fg-color-code(Color256:D $color, :$on --> Str:D) {
    ansi-sgr-code(SgrFgSet, $INDEXED-COLOR, $color.value)
    ~ do with $on { bg-color-code(|$on) } else { '' }
}
multi fg-color-code(ColorIndex:D $color, :$on --> Str:D) {
    ansi-sgr-code(SgrFgSet, $INDEXED-COLOR, $color)
    ~ do with $on { bg-color-code(|$on) } else { '' }
}

our sub fg-default-code(:$on) is export(:raw) {
    ansi-sgr-code(
        SgrFgDefault,
        |(do with $on { SgrBgDefault.value } else { () }),
    )
}

our proto bg-color-code(|) is export(:raw) { * }
multi bg-color-code(Color256() $color, :$with --> Str:D) {
    ansi-sgr-code(SgrBgSet, $INDEXED-COLOR, $color.value)
    ~ do with $with { fg-color-code(|$with) } else { '' }
}
multi bg-color-code(ColorIndex:D $color, :$with --> Str:D) {
    ansi-sgr-code(SgrBgSet, $INDEXED-COLOR, $color)
    ~ do with $with { fg-color-code(|$with) } else { '' }
}

our sub bg-default-code(:$with) is export(:raw) {
    ansi-sgr-code(
        SgrBgDefault,
        |(do with $with { SgrFgDefault.value } else { () }),
    )
}

subset ColorElement of Int where 0 <= * < 256;

multi fg-color-code(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b, :$on --> Str:D) {
    ansi-sgr-code(SgrFgSet, $RGB-COLOR, $r, $g, $b)
    ~ do with $on { bg-color-code(|$on) } else { '' }
}

multi bg-color-code(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b, :$with --> Str:D) {
    ansi-sgr-code(SgrBgSet, $RGB-COLOR, $r, $g, $b)
    ~ do with $with { fg-color-code(|$with) } else { '' }
}

=begin pod

=head2 sub fg-color

    our proto fg-color(|) is export(:fg)
    multi fg-color(Color256:D $color, *@text, :$on --> Str:D)
    multi fg-color(Int:D $color, *@text, :$on --> Str:D)
    multi fg-color(Int:D $r, Int:D $g, Int:D $b, *@text, :$on --> Str:D)

This, along with the L<bg-color subroutine#sub bg-color> make up the primary general purpose coloring tools provided by this library.

Each version of the function take a color, followed by zero or more objects to stringify, and then an optional named C<:$on> parameter for setting the background. The color can be specified by name using a L<Color256#enum Color256> constant or index number using a single L<Int>. The color can also be specified as three L<Int>s to set the color by RGB value.

The text providing will be stringified and concatenated using C<join>.

After the string, the foreground reset is set.

The C<:$on> value can be specified the same as the foreground color and is used to set the background color. If this parameter is passed, the background color reset will be passed.

This method returns the string for colorizing the given text.

=head2 sub bg-color

    our proto bg-color(|) is export(:fg)
    multi bg-color(Color256:D $color, *@text, :$with --> Str:D)
    multi bg-color(Int:D $color, *@text, :$with --> Str:D)
    multi bg-color(Int:D $r, Int:D $g, Int:D $b, *@text, :$with --> Str:D)

This function works exactly like the L<fg-color subroutine#sub fg-color>, but with the background and foreground functions reversed. The named argument for the foreground is C<:$with> rather than C<:$on>.

=end pod

our proto fg-color(|) is export(:fg) { * }
multi fg-color(Color256:D $color, *@_, :$on --> Str:D) {
    fg-color-code($color, :$on) ~ @_.join ~ fg-default-code(:$on)
}
multi fg-color(ColorIndex:D $color, *@_, :$on --> Str:D) {
    fg-color-code($color, :$on) ~ @_.join ~ fg-default-code(:$on)
}
multi fg-color(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b, *@_, :$on --> Str:D) {
    fg-color-code($r, $g, $b, :$on)
    ~ @_.join
    ~ fg-default-code(:$on)
}

our proto bg-color(|) is export(:bg) { * }
multi bg-color(Color256:D $color, *@_, :$with --> Str:D) {
    bg-color-code($color, :$with) ~ @_.join ~ bg-default-code(:$with)
}
multi bg-color(ColorIndex:D $color, *@_, :$with --> Str:D) {
    bg-color-code($color, :$with) ~ @_.join ~ bg-default-code(:$with)
}
multi bg-color(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b, *@_, :$with --> Str:D) {
    bg-color-code($r, $g, $b, :$with)
    ~ @_.join
    ~ bg-default-code(:$with)
}

=begin pod

=head2 sub fg-*-code

=head2 sub bg-*-code

This library can provide named versions of the L<fg-color-code subroutine#sub fg-color-code> and the L<bg-color-code subroutine#sub bg-color-code>, one for every color listed in the L<Color256 enumeration#enum Color256>.

The C<fg-*-code> methods will work just like C<fg-color-code>, but with the color argument omitted. Similarly, the C<bg-*-code> methods will work just like C<bg-color-code>, also with the color argument omitted.

The names of the functions will trade the C<TitleCase> names for C<kebab-case>. For example, the functions for C<JazzberryJam> are C<fg-jazzberry-jam-code> and C<bg-jazzberry-jam-code>.

The C<fg-*-code> functions are exported with the C<:fg-named-raw> tag and the C<bg-*-code> functions are exported wtih the C<:bg-named-raw tag>. Both sets of functions are exported via teh C<:named-raw> tag.

=head2 sub fg-*

=head2 sub bg-*

The high level coloring functions of this library can be provided as named functions. The C<fg-*> functions behave exactly like C<fg-color>, but without the color arguments. The C<bg-*> functions behave exactl like C<bg-color>, but without the color arguments.

The names of the functions will trade the C<TitleCase> names for C<kebab-case>. For example, the functions for C<GrannySmithApple> are C<fg-grany-smith-apple> and C<bg-granny-smith-apple>.

The C<fg-*> functions are exported with the C<:fg-named> tag and the C<bg-*> functions are exported with the C<:bg-named> tag. Both are exported with the C<:named> tag.

=end pod

our sub _generate-exports($key) {
    % = gather {
        for Color256.enums.keys -> $color-name is copy {
            my $color = Color256::{$color-name};
            $color-name .= subst(/(\w) (<[A..Z]>)/, { "$0-$1" }, :g).=lc;

            if $key eq 'named-raw' | 'fg-named-raw' {
                take "&fg-{$color-name}-code" => sub (:$on) { fg-color-code($color, :$on) }
            }

            if $key eq 'named-raw' | 'bg-named-raw' {
                take "&bg-{$color-name}-code" => sub (:$with) { bg-color-code($color, :$with) }
            }

            if $key eq 'named' | 'fg-named' {
                take "&fg-$color-name" => sub (*@_, :$on) { fg-color($color, |@_, :$on) }
            }

            if $key eq 'named' | 'bg-named' {
                take "&bg-$color-name" => sub (*@_, :$with) { bg-color($color, |@_, :$with) }
            }
        }
    }
}

my @pkg-keys = <named named-raw plain plain-named fg-named bg-named>;
for @pkg-keys -> $pkg-key {
    my $p = EXPORT::{$pkg-key} = package { }
    for _generate-exports($pkg-key).kv -> $name, $sub {
        $p.WHO.{$name} = $sub;
    }
}
