??    O      ?  k         ?  ?   ?  ,   ?  5   ?  N     7   f  \   ?  _   ?  `   [	  u   ?	  b   2
  V   ?
  ?   ?
  %   |     ?     ?  5   ?  B   	     L  w   i     ?     ?          1  $   I     n     ?     ?     ?     ?  #   ?     ?               .     @     R  H   _     ?     ?  !   ?               -     @  #   ^     ?     ?  $   ?     ?        #     2   >     q      ?     ?     ?  *   ?  *        9     Y     i  #   w  #   ?  &   ?     ?     ?  ,        A     Z  -   o     ?     ?     ?     ?     ?     ?          '  A  B  ?   ?  0   u  ;   ?  U   ?  =   8  Z   v  c   ?  `   5  ?   ?  ^     Z   v  ?   ?      j     ?     ?  @   ?  N        V  ?   p     ?          :     X  $   r     ?     ?     ?     ?  #   ?  !        4     P     W     r     ?     ?  M   ?     ?       <   2     o     ?     ?  !   ?     ?       "     )   A  )   k      ?  +   ?  &   ?     	   .      &   M      t   1   ?   /   ?   %   ?      !     +!  -   ?!  -   m!  /   ?!     ?!  #   ?!  6   "     <"     Z"  9   u"     ?"     ?"     ?"     ?"     #     ##     ?#  "   [#                     '              L       4                           6   /       5           7   N   H   *   <            0                 @         1       %   2   
          &   (       ;   -          !                    B          $             +   =       3   D   K           E      .   8   	       ,   F   O   A      )   C   >   M   J      9      :       G   "   I       #       ?            
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
   -l N, --line-length=N
                 specify the desired line-wrap length for the `l' command
   -n, --quiet, --silent
                 suppress automatic printing of pattern space
   -u, --unbuffered
                 load minimal amounts of data from the input files and flush
                 the output buffers more often
 %s: -e expression #%lu, char %lu: %s
 %s: can't read %s: %s
 %s: file %s line %lu: %s
 %s: warning: failed to get security context of %s: %s %s: warning: failed to set default file creation context to %s: %s : doesn't want any addresses GNU sed home page: <http://www.gnu.org/software/sed/>.
General help using GNU software: <http://www.gnu.org/gethelp/>.
 Invalid back reference Invalid character class name Invalid collation character Invalid content of \{\} Invalid preceding regular expression Invalid range end Invalid regular expression Memory exhausted No match No previous regular expression Premature end of regular expression Regular expression too big Success Trailing backslash Unmatched ( or \( Unmatched ) or \) Unmatched \{ Usage: %s [OPTION]... {script-only-if-no-other-script} [input-file]...

 `e' command not supported `}' doesn't want any addresses can't find label for jump to `%s' cannot remove %s: %s cannot rename %s: %s cannot stat %s: %s command only uses one address comments don't accept any addresses couldn't attach to %s: %s couldn't edit %s: is a terminal couldn't edit %s: not a regular file couldn't follow symlink %s: %s couldn't open file %s: %s couldn't open temporary file %s: %s delimiter character is not a single-byte character error in subprocess expected \ after `a', `c' or `i' expected newer version of sed extra characters after command invalid reference \%d on `s' command's RHS invalid usage of +N or ~N as first address invalid usage of line address 0 missing command multiple `!'s multiple `g' options to `s' command multiple `p' options to `s' command multiple number options to `s' command no input files no previous regular expression number option to `s' command may not be zero option `e' not supported read error on %s: %s strings for `y' command are different lengths unexpected `,' unexpected `}' unknown command: `%c' unknown option to `s' unmatched `{' unterminated `s' command unterminated `y' command unterminated address regex Project-Id-Version: sed 4.2.1
Report-Msgid-Bugs-To: bug-gnu-utils@gnu.org
POT-Creation-Date: 2017-02-03 17:17-0800
PO-Revision-Date: 2012-07-04 18:15+0200
Last-Translator: Tomislav Krznar <tomislav.krznar@gmail.com>
Language-Team: Croatian <lokalizacija@linux.hr>
Language: hr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2)
X-Generator: TransDict server
 
Ako nisu navedene opcije -e, --expression, -f ili --file, sed skripta će
interpretirati prvi argument koji nije opcija. Svi preostali argumenti
su imena ulaznih datoteka; ako nisu navedene ulazne datoteke, čita se sa
standardnog ulaza.

       --help     prikaži ovu pomoć i izađi
       --version  ispiši informacije o inačici i izađi
   --follow-symlinks
                 slijedi simboličke veze dok je obrada u tijeku
   --posix
                 onemogućuje sva GNU proširenja.
   -R, --regexp-perl
                 koristi Perl 5 sintaksu regularnih izraza u skripti.
   -b, --binary
                 otvori datoteke u binarnom načinu (CR+LF se posebno ne obrađuje)
   -e script, --expression=script
                 dodaj skriptu naredbama koje će se izvršiti
   -f datoteka-skripte, --file=datoteka-skripte
                 dodaj sadržaj datoteke skripte naredbama koje će se izvršiti
   -l N, --line-length=N
                 navodi željeno prelamanje redaka za naredbu „l”
   -n, --quiet, --silent
                 izostavi automatsko ispisivanje prostora uzoraka
   -u, --unbuffered
                 učitava minimalne količine podataka iz ulaznih datoteka i
                 češće prazni izlazne međuspremnike
 %s: -e izraz #%lu, znak %lu: %s
 %s: ne mogu čitati %s: %s
 %s: datoteka %s redak %lu: %s
 %s: upozorenje: nisam uspio dohvatiti sigurnosni kontekst %s: %s %s: upozorenje: nisam uspio postaviti zadani kontekst izrade datoteka u %s: %s : ne želi nikakve adrese GNU sed početna stranica: <http://www.gnu.org/software/sed/>.
Općenita pomoć za korištenje GNU softvera: <http://www.gnu.org/gethelp/>.
 Neispravna povratna referenca Neispravno ime razreda znakova Neispravan znak razvrstavanja Neispravan sadržaj \{\} Neispravan prethodni regularni izraz Neispravan kraj raspona Neispravan regularni izraz Memorija iscrpljena Nema poklapanja Nedostaje prethodni regularni izraz Preuranjen kraj regularnog izraza Regularni izraz je prevelik Uspjeh Obrnuta kosa crta na kraju Neuparena ( ili \( Neuparena ) ili \) Neuparena \{ Uporaba: %s [OPCIJA]... {skripta-samo-ako-nema-drugih} [ulazna-datoteka]...

 naredba „e” nije podržana „}” ne želi nikakve adrese ne mogu pronaći oznaku na koju bi trebalo skočiti „%s” ne mogu ukloniti %s: %s ne mogu preimenovati %s: %s ne mogu izvršiti stat %s: %s naredba koristi samo jednu adresu komentari ne prihvaćaju adrese ne mogu povezati na %s: %s ne mogu urediti %s: to je terminal ne mogu urediti %s: nije obična datoteka ne mogu slijediti simboličku vezu %s: %s ne mogu otvoriti datoteku %s: %s ne mogu otvoriti privremenu datoteku %s: %s znak razdvajanja nije jednobajtni znak greška u potprocesu očekujem \ nakon „a”, „c” ili „i” očekujem noviju inačicu programa sed višak znakova nakon naredbe neispravna referenca \%d na RHS-u naredbe „s” neispravno korištenje +N ili ~N za prvu adresu neispravno korištenje adrese retka 0 nedostaje naredba višestruki „!” višestruke opcije „g” za naredbu „s” višestruke opcije „p” za naredbu „s” višestruke brojčane opcije za naredbu „s” nema ulaznih datoteka nedostaje prethodni regularni izraz brojčana opcija za naredbu „s” ne smije biti nula opcija „e” nije podržana greška čitanja na %s: %s znakovni nizovi za naredbu „y” su različitih duljina neočekivani „,” neočekivana „}” nepoznata naredba: „%c” nepoznata opcija za „s” neuparena „{” nezavršena naredba „s” nezavršena naredba „y” nezavršeni regularni izraz adrese 