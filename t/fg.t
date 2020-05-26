use v6;

use Test;
use Term::ModernColor :fg;

is fg-black("one"),         "\e[38;5;000mone",       "black okay";
is fg-maroon("two"),        "\e[38;5;001mtwo",       "maroon okay";
is fg-green("three"),       "\e[38;5;002mthree",     "green okay";
is fg-olive("four"),        "\e[38;5;003mfour",      "olive okay";
is fg-navy("five"),         "\e[38;5;004mfive",      "navy okay";
is fg-purple("six"),        "\e[38;5;005msix",       "purple okay";
is fg-teal("seven"),        "\e[38;5;006mseven",     "teal okay";
is fg-silver("eight"),      "\e[38;5;007meight",     "silver okay";
is fg-gray("nine"),         "\e[38;5;008mnine",      "gray okay";
is fg-red("ten"),           "\e[38;5;009mten",       "red okay";
is fg-lime("eleven"),       "\e[38;5;010meleven",    "lime okay";
is fg-yellow("twelve"),     "\e[38;5;011mtwelve",    "yellow okay";
is fg-blue("thirteen"),     "\e[38;5;012mthirteen",  "blue okay";
is fg-fuschia("fourteen"),  "\e[38;5;013mfourteen",  "fushia okay";
is fg-aqua("fifteen"),      "\e[38;5;014mfifteen",   "aqua okay";
is fg-white("sixteen"),     "\e[38;5;015msixteen",   "white okay";

is fg-black ~ "one",         "\e[38;5;000mone",       "black okay";
is fg-maroon ~ "two",        "\e[38;5;001mtwo",       "maroon okay";
is fg-green ~ "three",       "\e[38;5;002mthree",     "green okay";
is fg-olive ~ "four",        "\e[38;5;003mfour",      "olive okay";
is fg-navy ~ "five",         "\e[38;5;004mfive",      "navy okay";
is fg-purple ~ "six",        "\e[38;5;005msix",       "purple okay";
is fg-teal ~ "seven",        "\e[38;5;006mseven",     "teal okay";
is fg-silver ~ "eight",      "\e[38;5;007meight",     "silver okay";
is fg-gray ~ "nine",         "\e[38;5;008mnine",      "gray okay";
is fg-red ~ "ten",           "\e[38;5;009mten",       "red okay";
is fg-lime ~ "eleven",       "\e[38;5;010meleven",    "lime okay";
is fg-yellow ~ "twelve",     "\e[38;5;011mtwelve",    "yellow okay";
is fg-blue ~ "thirteen",     "\e[38;5;012mthirteen",  "blue okay";
is fg-fuschia ~ "fourteen",  "\e[38;5;013mfourteen",  "fushia okay";
is fg-aqua ~ "fifteen",      "\e[38;5;014mfifteen",   "aqua okay";
is fg-white ~ "sixteen",     "\e[38;5;015msixteen",   "white okay";

done-testing;
