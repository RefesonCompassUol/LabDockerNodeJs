??    V      ?     |      x  ?   y  ,   t  5   ?  N   ?  7   &	  \   ^	  _   ?	  `   
  u   |
  i   ?
  b   \  V   ?  ?     D   ?  %   ?          (  5   B  B   x     ?  w   ?     P     g     ?     ?  $   ?     ?     ?     
          #     4     =     \  #   j     ?     ?     ?     ?     ?     ?     ?  H   ?     G     a  !   ?     ?     ?     ?     ?  #   ?     !     ;  $   [     ?     ?  #   ?  2   ?           $     E     c     ?  *   ?  *   ?     ?            #   )  #   M  &   q     ?     ?  ,   ?     ?       -   !     O     ^     m     ?     ?     ?     ?     ?  ?  ?  .  ?  '     :   )  `   d  ?   ?  b     m   h  g   ?  ?   >  ?   ?  u   T  e   ?  ?   0  D   ?  *        ?     \  E   {  _   ?     !  ?   :  $   ?  '   ?  #   
     .  '   J     r     ?     ?     ?     ?     ?  (   ?        #      "   =      `      g      p      ?      ?      ?   L   ?   !   !     6!  1   Q!     ?!     ?!     ?!  "   ?!  $   ?!  (   "  (   D"  2   m"  0   ?"  $   ?"  -   ?"  :   $#     _#  (   r#  +   ?#  (   ?#     ?#  9   $  2   B$  (   u$     ?$     ?$  /   ?$  /   ?$  6   &%     ]%  (   z%  @   ?%  !   ?%     &  >    &     _&     n&     }&     ?&     ?&     ?&     ?&  +   '        T   =          	   1          H      7      D   (                 L       
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
PO-Revision-Date: 2016-08-07 17:31+0200
Last-Translator: Francisco Javier Tsao Santín <tsao@members.fsf.org>
Language-Team: Galician <proxecto@trasno.net>
Language: gl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=2; plural=n!=1;
 
Se non se indican as opcións -e, --expression, -f ou --file, entón o primeiro
argumento que non é unha opción tómase como o script sed para interpretar. Tódolos
argumentos restantes son nomes de ficheiros de entrada; se non se especifican
ficheiros de entrada, entón se le a entrada standard.

      --help     amosa esta axuda e sae
      --version  amosa-la información da versión e saír
   --follow-symlinks
                 segue ligazóns simbólicas cando se procesan no seu sitio
   --posix
                 desactiva tódalas extensións GNU.
   -R, --regexp-perl
                 usa-la sintaxe de expresións regulares de Perl 5 no script.
   -b, --binary
                 ficheiros abertos en modo binario (non se procesan de xeito especial CR+LFs)
 -e script, --expression=script
                  engade script ás instruccións que serán executadas
   -f ficheiro-de-script, --file=ficheiro-de-script
                 engade o contido do ficheiro do script ás instruccións que serán executadas
   -i[SUFIXO], --in-place[=SUFIXO]
                 edita ficheiros no seu sitio (fai copia de seguridade se se indica un SUFIXO)
   -l N, --line-length=N
                 especifica a lonxitude de axuste da liña desexado para a instrucción `l' 
   -n, --quiet, --silent
                 suprime a visualización automática do espacio de patróns
   -u, --unbuffered 
                 carga cantidades mínimas de datos dos ficheiros de entrada
                 e baleira os buffers de saída máis decote
   -z, --null-data
                 separa liñas por caracteres NUL
 %s: -e expresión #%lu, carácter %lu: %s
 %s: non se puido ler %s: %s
 %s: ficheiro %s liña %lu: %s
 %s: advertencia: fallou ó adoita-lo contexto de seguridade de %s: %s %s: advertencia: fallou ó establecer un contexto de creación de ficheiro por defecto a %s: %s : non acepta un enderezo Páxina principal de GNU sed: <http://www.gnu.org/software/sed/>.
Axuda xeral usando software GNU: <http://www.gnu.org/gethelp/>.
 Referencia cara a atrás non válida Nome de clase de caracteres non válido Carácter de ordeamento non válido Contido de \{\} non válido Expresión regular anterior non válida Fin de rango non válida Expresión regular non válida Jay Fenlason Ken Pizzini Memoria esgotada Non se atopou Non hai unha expresión regular anterior Paolo Bonzini Fin prematura da expresión regular Expresión regular grande de máis Éxito Tom Lord Barra invertida á fin de liña ( ou \( sen parella ) ou \) sen parella \{ sen parella Uso: %s [OPCIÓN]... {script-só-sen-outro-script} [ficheiro-de-entrada]...
 o comando `e' non está soportado `}' non acepta un enderezo non se puido atopa-la etiqueta para saltar a `%s' non se puido borrar %s: %s non se puido renomear %s: %s non se puido ler %s: %s a instrucción só usa un enderezo os comentarios non aceptan enderezos non se puido adxuntar elemento en %s: %s non se puido editar %s: é unha terminal non se puido editar %s: non é un ficheiro regular non se puido segui-la ligazón simbólica %s: %s non se puido abri-lo ficheiro %s: %s non se puido abri-lo ficheiro temporal %s: %s o carácter delimitador non é un carácter de byte simple erro no subproceso esperábase \ despois de `a', `c' ou `i' se esperaba unha versión de sed máis nova caracteres extra despois da instrucción instrucción incompleta referencia \%d non válida no lado dereito do comando `s' non se pode usar +N ou ~N como primeira dirección uso non válido da dirección de liña 0 falta unha instrucción múltiples `!'s múltiples opcións `g' para a instrucción `s' múltiples opcións `p' para a instrucción `s' múltiples opcións numéricas para a instrucción `s' non hai ficheiros de entrada non hai unha expresión regular anterior unha opción numérica para a instrucción `s' non pode ser cero a opción `e' non está soportada erro de lectura en %s: %s as cadeas para a instrucción `y' teñen lonxitudes diferentes `,' inesperada `}' inesperado instrucción descoñecida:`%c' opción de `s' descoñecida `{' sen parella instrucción `s' non rematada instrucción `y' non rematada expresión regular de enderezo non rematada 