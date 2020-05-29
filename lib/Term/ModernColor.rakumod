use v6;

unit module Term::ModernColor;

our constant $CSI = "\e[";
our constant $SGR = "m";

our constant $RGB-COLOR = "2";
our constant $INDEXED-COLOR = "5";

enum AnsiSgrCode is export(:raw) (
    Reset => 0,
    Bold => 1, Faint => 2, Italic => 3, Underline => 4,
    BlinkSlow => 5, BlinkFast => 6, Reverse => 7, Conceal => 8, CrossOut => 9,
    FontDefault => 10, FontAlt1 => 11, FontAlt2 => 12, FontAlt3 => 13,
    FontAlt4 => 14, FontAlt5 => 15, FontAlt6 => 16,
    FontAlt7 => 17, FontAlt8 => 18, FontAlt9 => 19, FontFraktur => 20,
    DoubleUnderline => 21,
    UnBold => 22, UnItalic => 23, UnUnderline => 24,
    UnBlink => 25, UnReverse => 27, UnConceal => 28, UnCrossOut => 29,
    FgBlack => 30, FgRed => 31, FgGreen => 32, FgYellow => 33, FgBlue => 34,
    FgMagenta => 35, FgCyan => 36, FgWhite => 37,
    FgSet => 38, FgDefault => 39,
    BgBlack => 40, BgRed => 41, BgGreen => 42, BgYellow => 43, BgBlue => 44,
    BgMagenta => 45, BgCyan => 46, BgWhite => 47,
    BgSet => 48, BgDefault => 49,
);

our sub ansi-code(@params, $final --> Str:D) is export(:raw) {
    "{$CSI}@params.join()$final"
}

our sub ansi-sgr-code(AnsiSgrCode:D $code, *@params --> Str:D) is export(:raw) {
    ansi-code([$code.value, |@params.map({ ";$_" })], $SGR)
}

enum Color256 is export(:colors) <
    Black Maroon Green Olive  Navy Purple  Teal Silver
    Gray  Red    Lime  Yellow Blue Fuschia Aqua White
    Gray0 RoyalBlue NavyBlue DukeBlue MediumBlue Zaffre
    PakistanGreen TropicalRainforest BlueSapphire HonoluluBlue TrueBlue DodgerBlue
    Ao SpanishViridian DarkCyan CeladonBlue StarCommandBlue Azure
    IndiaGreen GOGreen PersianGreen TiffanyBlue RobinEggBlue Capri
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

our constant ansi-reset-code is export(:raw) = ansi-sgr-code(Reset);

subset ColorIndex of Int where 0 <= * < 256;

our proto fg-color-code(|) is export(:raw) { * }
multi fg-color-code(Color256:D $color --> Str:D) {
    ansi-sgr-code(FgSet, $INDEXED-COLOR, $color.value);
}
multi fg-color-code(ColorIndex:D $color --> Str:D) {
    ansi-sgr-code(FgSet, $INDEXED-COLOR, $color);
}

our constant fg-default-code is export(:raw) = ansi-sgr-code(FgDefault);

our proto bg-color-code(|) is export(:raw) { * }
multi bg-color-code(Color256() $color --> Str:D) {
    ansi-sgr-code(BgSet, $INDEXED-COLOR, $color.value.fmt("%03d"));
}
multi bg-color-code(ColorIndex:D $color --> Str:D) {
    ansi-sgr-code(BgSet, $INDEXED-COLOR, $color);
}

our constant bg-default-code is export(:raw) = ansi-sgr-code(BgDefault);

subset ColorElement of Int where 0 <= * < 256;

multi fg-color-code(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b --> Str:D) {
    ansi-sgr-code(FgSet, $RGB-COLOR, $r, $g, $b);
}

multi bg-color-code(ColorElement:D $r, ColorElement:D $g, ColorElement:D $b --> Str:D) {
    ansi-sgr-code(BgSet, $RGB-COLOR, $r, $g, $b);
}

our sub _generate-exports($key) {
    % = gather {
        for Color256.enums.keys -> $color-name {
            my $color = Color256::{$color-name}.subst(/(\w) (<[A..Z]>)/, { "$0-$1" }, :g).lc;

            if $key eq 'named' | 'fg' | 'fg-named' {
                take "&fg-$color" => sub ($x?) { fg-color-code($color) ~ ($x//'') ~ fg-default-code }
            }

            if $key eq 'named' | 'bg' | 'bg-named' {
                take "&bg-$color" => sub ($x?) { bg-color-code($color) ~ ($x//'') ~ fg-default-code }
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
