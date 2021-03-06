??    O      ?  k         ?  ?   ?  ,   ?  5   ?  N     7   f  \   ?  _   ?  `   [	  u   ?	  b   2
  V   ?
  ?   ?
  %   |     ?     ?  5   ?  B   	     L  w   i     ?     ?          1  $   I     n     ?     ?     ?     ?  #   ?     ?               .     @     R  H   _     ?     ?  !   ?               -     @  #   ^     ?     ?  $   ?     ?        #     2   >     q      ?     ?     ?  *   ?  *        9     Y     i  #   w  #   ?  &   ?     ?     ?  ,        A     Z  -   o     ?     ?     ?     ?     ?     ?          '  ?  B  :    .   P  B     [   ?  C     {   b  y   ?  h   X  ?   ?  ~   [  `   ?  ?   ;  *        1     N  ?   m  Y   ?       ?   &  !   ?  &   ?  #   ?       '   4     \     u     ?     ?  $   ?  (   ?  #        '     .     J     ]     p  P   ~      ?      ?  4        F     b  5     %   ?  -   ?     	   &   '   /   N   .   ~   #   ?   ,   ?   ;   ?      :!  )   Q!  -   {!  %   ?!  ;   ?!  0   "  *   <"     g"     v"  )   ?"  )   ?"  0   ?"     #  $   &#  9   K#  "   ?#     ?#  :   ?#     ?#     
$     $     1$     N$     ]$     t$  -   ?$                     '              L       4                           6   /       5           7   N   H   *   <            0                 @         1       %   2   
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
PO-Revision-Date: 2011-08-24 12:28-0500
Last-Translator: Cristian Othón Martínez Vera <cfuga@cfuga.mx>
Language-Team: Spanish <es@li.org>
Language: es
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8-bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=2; plural=(n != 1);
 
Si no se proporciona una opción -e, --expression, -f, ó --file option,
entonces se toma el primer argumento que no sea opción como el guión sed
a interpretar.  Todos los argumentos restantes son nombres de ficheros
de entrada; si no se especifican ficheros de entrada, entonces se lee
la entrada estándard.

       --help     muestra esta ayuda y termina
       --version  muestra la información de la versión y termina
   --follow-symlinks
                 sigue los enlaces simbólicos al procesar en el lugar
   --posix
                 desactiva todas las extensiones de GNU.
   -R, --regexp-perl
                 utiliza la sintaxis de expresiones regulares de Perl 5
                 en el guión.
   -b, --binary
                 abre ficheros en modo binario (los RC+FLs no se procesan
                 especialmente)
   -e guión, --expression=guión
                 agrega el guión a la lista de órdenes para ejecutar
   -f fichero-guión, --file=fichero-guión
                 agrega el contenido del fichero guión a la lista de órdenes
                 para ejecutar
   -l N, --line-length=N
                 especifica la longitud de corte de línea deseado para
                 la orden `l'
   -n, --quiet, --silent
                 suprime la muestra automática del espacio de patrones
   -u, --unbuffered
                 carga cantidades mínimas de datos de los ficheros de entrada
                 y vacía los almacenamientos temporales de salida con más
                 frecuencia
 %s: -e expresión #%lu, carácter %lu: %s
 %s: no se puede leer %s: %s
 %s: fichero %s línea %lu: %s
 %s: aviso: falló al obtener el contexto de seguridad de %s: %s %s: aviso: falló al establecer el contexto de creación de fichero por omisión a %s: %s : no acepta ninguna dirección Página web de sed de GNU: <http://www.gnu.org/software/sed/>.
Ayuda general para usar software GNU: <http://www.gnu.org/gethelp/>.
 Referencia hacia atrás inválida Carácter de nombre de clase inválido Carácter de ordenamiento inválido Contenido inválido de \{\} Expresión regular precedente inválida Final de rango inválido Expresion regular inválida Memoria agotada No hay coincidencia No hay una expresión regular previa Final prematuro de la expresión regular Expresión regular demasiado grande Éxito Diagonal invertida al final ( ó \( sin pareja ) ó \) sin pareja \{ sin pareja Uso: %s [OPCIÓN]... {guión-sólo-si-no-hay-otro-guión} [fichero-entrada]...

 no hay soporte para la orden `e' `}' no acepta ninguna dirección no se puede encontrar la etiqueta para saltar a `%s' no se puede eliminar %s: %s no se puede renombrar %s: %s no se puede obtener la información de stat de %s: %s la orden solamente usa una dirección los comentarios no aceptan ninguna dirección no se puede conectar a %s: %s no se puede editar %s: es una terminal no se puede editar %s: no es un fichero regular no se puede seguir el enlace simbólico %s: %s no se puede abrir el fichero %s: %s no se puede abrir el fichero temporal %s: %s el carácter delimitador no es un carácter de un solo byte error en el subproceso se esperaba \ después de `a', `c' ó `i' se esperaba una versión más reciente de sed caracteres extra después de la orden referencia \%d inválida en el lado derecho de la orden `s' uso inválido de +N o ~N como primera dirección uso inválido de la dirección de línea 0 orden faltante `!'s múltiples múltiples opciones `g' para la orden `s' múltiples opciones `p' para la orden `s' múltiples opciones numéricas para la orden `s' no hay ficheros de entrada no hay una expresión regular previa una opción numérica para la orden `s' no puede ser cero no hay soporte para la opción `e' error al leer de %s: %s las cadenas para la orden `y' son de longitudes diferentes `,' inesperada `}' inesperado orden desconocida: `%c' opción desconocida para `s' `{' sin pareja orden `s' sin terminar orden `y' sin terminar dirección de expresión regular sin terminar 