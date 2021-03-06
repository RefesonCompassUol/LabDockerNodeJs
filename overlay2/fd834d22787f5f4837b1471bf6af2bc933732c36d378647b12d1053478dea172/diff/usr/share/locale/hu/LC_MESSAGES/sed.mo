??    V      ?     |      x  ?   y  ,   t  5   ?  N   ?  7   &	  \   ^	  _   ?	  `   
  u   |
  i   ?
  b   \  V   ?  ?     D   ?  %   ?          (  5   B  B   x     ?  w   ?     P     g     ?     ?  $   ?     ?     ?     
          #     4     =     \  #   j     ?     ?     ?     ?     ?     ?     ?  H   ?     G     a  !   ?     ?     ?     ?     ?  #   ?     !     ;  $   [     ?     ?  #   ?  2   ?           $     E     c     ?  *   ?  *   ?     ?            #   )  #   M  &   q     ?     ?  ,   ?     ?       -   !     O     ^     m     ?     ?     ?     ?     ?  ?  ?    ?  2   ?  ;     [   [  @   ?     ?  ?   x  w   	  ?   ?  ?     f   ?  [   $  ?   ?  K   !  )   m     ?     ?  J   ?  g          ?   ?      %  #   F  (   j  !   ?  .   ?     ?  #         %      2      >      S   %   b      ?   &   ?      ?      ?      ?      ?      	!     !!     9!  _   J!  "   ?!     ?!  .   ?!     "     8"     U"  %   q"  !   ?"      ?"  &   ?"  1   #  1   3#  #   e#  0   ?#  /   ?#     ?#  4    $  '   5$      ]$     ~$  ;   ?$  6   ?$  *   %     -%     ?%  5   M%  5   ?%  3   ?%     ?%  #   &  4   ,&  $   a&     ?&  4   ?&     ?&     ?&     ?&     '     9'     O'     l'     ?'        T   =          	   1          H      7      D   (                 L       
   /   F   M           ?   G       '   <                     @      5   R      .   C                 B                     9                  :       "          !   K   4               N   0               -       U             A   *             P                      S   8       )       V   I   2          &   #          J   %   6   ;           Q   $   +   ,       E   >      3          O          
If no -e, --expression, -f, or --file option is given, then the first
non-option argument is taken as the sed script to interpret.  All
remaining arguments are names of input files; if no input files are
specified, then the standard input is read.

       --help     display this help and exit
       --version  output version information and exit
   --follow-symlinks
                 follow symlinks when processing in place
   --posix
                 disable all GNU extensions.
   -R, --regexp-perl
                 use Perl 5's regular expressions syntax in the script.
   -b, --binary
                 open files in binary mode (CR+LFs are not processed specially)
   -e script, --expression=script
                 add the script to the commands to be executed
   -f script-file, --file=script-file
                 add the contents of script-file to the commands to be executed
   -i[SUFFIX], --in-place[=SUFFIX]
                 edit files in place (makes backup if SUFFIX supplied)
   -l N, --line-length=N
                 specify the desired line-wrap length for the `l' command
   -n, --quiet, --silent
                 suppress automatic printing of pattern space
   -u, --unbuffered
                 load minimal amounts of data from the input files and flush
                 the output buffers more often
   -z, --null-data
                 separate lines by NUL characters
 %s: -e expression #%lu, char %lu: %s
 %s: can't read %s: %s
 %s: file %s line %lu: %s
 %s: warning: failed to get security context of %s: %s %s: warning: failed to set default file creation context to %s: %s : doesn't want any addresses GNU sed home page: <http://www.gnu.org/software/sed/>.
General help using GNU software: <http://www.gnu.org/gethelp/>.
 Invalid back reference Invalid character class name Invalid collation character Invalid content of \{\} Invalid preceding regular expression Invalid range end Invalid regular expression Jay Fenlason Ken Pizzini Memory exhausted No match No previous regular expression Paolo Bonzini Premature end of regular expression Regular expression too big Success Tom Lord Trailing backslash Unmatched ( or \( Unmatched ) or \) Unmatched \{ Usage: %s [OPTION]... {script-only-if-no-other-script} [input-file]...

 `e' command not supported `}' doesn't want any addresses can't find label for jump to `%s' cannot remove %s: %s cannot rename %s: %s cannot stat %s: %s command only uses one address comments don't accept any addresses couldn't attach to %s: %s couldn't edit %s: is a terminal couldn't edit %s: not a regular file couldn't follow symlink %s: %s couldn't open file %s: %s couldn't open temporary file %s: %s delimiter character is not a single-byte character error in subprocess expected \ after `a', `c' or `i' expected newer version of sed extra characters after command incomplete command invalid reference \%d on `s' command's RHS invalid usage of +N or ~N as first address invalid usage of line address 0 missing command multiple `!'s multiple `g' options to `s' command multiple `p' options to `s' command multiple number options to `s' command no input files no previous regular expression number option to `s' command may not be zero option `e' not supported read error on %s: %s strings for `y' command are different lengths unexpected `,' unexpected `}' unknown command: `%c' unknown option to `s' unmatched `{' unterminated `s' command unterminated `y' command unterminated address regex Project-Id-Version: sed 4.2.2
Report-Msgid-Bugs-To: bug-gnu-utils@gnu.org
POT-Creation-Date: 2017-02-03 17:17-0800
PO-Revision-Date: 2016-06-19 13:19+0200
Last-Translator: Balazs Ur <urbalazs@gmail.com>
Language-Team: Hungarian <translation-team-hu@lists.sourceforge.net>
Language: hu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=1; plural=0;
X-Generator: Lokalize 1.5
 
Ha nincs megadva -e, --expression, -f vagy --file kapcsoló, akkor az első
nem-kapcsoló paramétert héjprogramnak tekintjük. Minden további paraméter
fájlnévnek számít. Ha nincs megadva bemeneti fájlnév, akkor a szabványos
bemenetről olvas.

       --help     kiírja ezt a súgót és kilép
       --version  kiírja a verzióinformációt és kilép
   --follow-symlinks
                 szimbolikus linkek követése helyben feldolgozáskor
   --posix
                 minden GNU kiterjesztés letiltása.
   -R --regexp-perl
                 Perl 5 reguláris kifejezés nyelvtanának használata a
                 parancsfájlban.
   -b, --binary
                 fájlok megnyitása bináris módban (a CR+LF karakterek nem
                 lesznek speciálisan feldolgozva)
   -e parancsfájl, --expression=parancsfájl
                 parancsfájl hozzáadása a végrehajtandó parancsokhoz
   -f parancsfájl, --file=parancsfájl
                 a megadott parancsfájl tartalmának hozzáadása a végrehajtandó
                 parancsokhoz
   -i[UTÓTAG], --in-place[=UTÓTAG]
                 fájlok szerkesztése helyben (biztonsági mentést készít, ha
                 az UTÓTAG meg van adva)
   -l N, --line-length=N
                 a kívánt sortörési hossz megadása az „l” parancshoz
   -n, --quiet, --silent
                 a minta tér automatikus kiírásának elnyomása
   -u, --unbuffered
                 minimális mennyiségű adat betöltése a bemeneti fájlokból és a
                 kimeneti pufferek gyakori ürítése
   -z, --null-data
                 sorok elválasztása NULL karakterekkel
 %s: -e kifejezés #%lu, karakter %lu: %s
 %s: %s nem olvasható: %s
 %s: %s fájl %lu sor: %s
 %s: figyelem: nem sikerült lekérni a(z) %s biztonsági környezetét: %s %s: figyelem: nem sikerült beállítani a(z) %s alapértelmezett fájl létrehozási környezetét: %s : nem igényel címzést GNU sed honlap: <http://www.gnu.org/software/sed/>.
Általános segítség a GNU szoftverek használatához: <http://www.gnu.org/gethelp/>.
 Érvénytelen vissza-hivatkozás Érvénytelen karakterosztály-név Érvénytelen összehasonlító karakter \{\}-nek érvénytelen a tartalma Érvénytelen megelőző reguláris kifejezés Érvénytelen tartományvég Érvénytelen reguláris kifejezés Jay Fenlason Ken Pizzini Elfogyott a memória Nincs találat Nincsen előző reguláris kifejezés Paolo Bonzini Reguláris kifejezés túl korai vége Túl nagy reguláris kifejezés Sikeres Tom Lord Lezáró fordított perjel Nincs párban ( vagy \( Nincs párban ) vagy \) Nincs párban \{ Használat: %s [OPCIÓ]... {parancsfájl-csak-ha-nincs-más-parancsfájl} [bemeneti fájl]…

 az „e” parancs nem támogatott „}” nem igényel címzést az ugráshoz („%s”) nem található címke %s nem távolítható el: %s nem lehet átnevezni: %s: %s nem lehet stat-olni: %s: %s a parancs csak egy címzést használ megjegyzésben nem lehet címzés nem lehet csatolni ehhez: %s: %s nem lehet szerkeszteni (%s): terminál nem lehet szerkeszteni (%s): nem szabályos fájl nem lehet követni a(z) %s szimbolikus linket: %s nem nyitható meg a(z) %s fájl: %s nem lehet megnyitni a(z) %s átmeneti fájlt: %s az elválasztó karakter nem egy bájtból áll hiba az alfolyamatban az „a”, „c” vagy „i” után \ szükséges a sed újabb verziójára van szükség extra karakterek a parancs után hiányos parancs érvénytelen hivatkozás (\%d) az „s” parancs RHS-ére a +N vagy ~N használata első címként érvénytelen a 0 sor címzés használata érvénytelen hiányzó parancs több „!” többszörös „g” kapcsoló az „s” parancshoz többszörös „p” kapcsoló az „s” parancshoz többszörös szám kapcsoló az „s” parancshoz nincsenek bemeneti fájlok nincs előző reguláris kifejezés az „s” parancs szám kapcsolója nem lehet nulla az „e” kapcsoló nem támogatott olvasási hiba ezen: %s: %s az „y” parancs szövegeinek hossza különböző váratlan „,” nincs párban „}” ismeretlen parancs: „%c” ismeretlen „s” kapcsoló nincs párban „{” befejezetlen „s” parancs befejezetlen „y” parancs befejezetlen regex cím 