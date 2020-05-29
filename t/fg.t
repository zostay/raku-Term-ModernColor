use v6;

use Test;
use Term::ModernColor :fg-named, :colors;

is fg-black("one"),         "\e[38;5;0mone\e[39m",       "black okay";
is fg-maroon("two"),        "\e[38;5;1mtwo\e[39m",       "maroon okay";
is fg-green("three"),       "\e[38;5;2mthree\e[39m",     "green okay";
is fg-olive("four"),        "\e[38;5;3mfour\e[39m",      "olive okay";
is fg-navy("five"),         "\e[38;5;4mfive\e[39m",      "navy okay";
is fg-purple("six"),        "\e[38;5;5msix\e[39m",       "purple okay";
is fg-teal("seven"),        "\e[38;5;6mseven\e[39m",     "teal okay";
is fg-silver("eight"),      "\e[38;5;7meight\e[39m",     "silver okay";
is fg-gray("nine"),         "\e[38;5;8mnine\e[39m",      "gray okay";
is fg-red("ten"),           "\e[38;5;9mten\e[39m",       "red okay";
is fg-lime("eleven"),       "\e[38;5;10meleven\e[39m",    "lime okay";
is fg-yellow("twelve"),     "\e[38;5;11mtwelve\e[39m",    "yellow okay";
is fg-blue("thirteen"),     "\e[38;5;12mthirteen\e[39m",  "blue okay";
is fg-fuschia("fourteen"),  "\e[38;5;13mfourteen\e[39m",  "fushia okay";
is fg-aqua("fifteen"),      "\e[38;5;14mfifteen\e[39m",   "aqua okay";
is fg-white("sixteen"),     "\e[38;5;15msixteen\e[39m",   "white okay";

is fg-phlox("seventeen", :on(BlueJeans)), "\e[38;5;165m\e[48;5;75mseventeen\e[39;49m", "phlox on blue-jeans okay (actually, it's really not okay, never actually mix these two colors this way)";

done-testing;
