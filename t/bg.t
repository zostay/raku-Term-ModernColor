use v6;

use Test;
use Term::ModernColor :bg, :colors;

is bg-color(Black, "one"),         "\e[48;5;0mone\e[49m",       "black okay";
is bg-color(Maroon, "two"),        "\e[48;5;1mtwo\e[49m",       "maroon okay";
is bg-color(Green, "three"),       "\e[48;5;2mthree\e[49m",     "green okay";
is bg-color(Olive, "four"),        "\e[48;5;3mfour\e[49m",      "olive okay";
is bg-color(Navy, "five"),         "\e[48;5;4mfive\e[49m",      "navy okay";
is bg-color(Purple, "six"),        "\e[48;5;5msix\e[49m",       "purple okay";
is bg-color(Teal, "seven"),        "\e[48;5;6mseven\e[49m",     "teal okay";
is bg-color(Silver, "eight"),      "\e[48;5;7meight\e[49m",     "silver okay";
is bg-color(Gray, "nine"),         "\e[48;5;8mnine\e[49m",      "gray okay";
is bg-color(Red, "ten"),           "\e[48;5;9mten\e[49m",       "red okay";
is bg-color(Lime, "eleven"),       "\e[48;5;10meleven\e[49m",    "lime okay";
is bg-color(Yellow, "twelve"),     "\e[48;5;11mtwelve\e[49m",    "yellow okay";
is bg-color(Blue, "thirteen"),     "\e[48;5;12mthirteen\e[49m",  "blue okay";
is bg-color(Fuschia, "fourteen"),  "\e[48;5;13mfourteen\e[49m",  "fushia okay";
is bg-color(Aqua, "fifteen"),      "\e[48;5;14mfifteen\e[49m",   "aqua okay";
is bg-color(White, "sixteen"),     "\e[48;5;15msixteen\e[49m",   "white okay";

is bg-color(Phlox, "seventeen", :with(BlueJeans)), "\e[48;5;165m\e[38;5;75mseventeen\e[49;39m", "phlox on blue-jeans okay (actually, it's really not okay, never actually mix these two colors this way)";

done-testing;
