??    O      ?  k         ?  ?   ?  ,   ?  5   ?  N     7   f  \   ?  _   ?  `   [	  u   ?	  b   2
  V   ?
  ?   ?
  %   |     ?     ?  5   ?  B   	     L  w   i     ?     ?          1  $   I     n     ?     ?     ?     ?  #   ?     ?               .     @     R  H   _     ?     ?  !   ?               -     @  #   ^     ?     ?  $   ?     ?        #     2   >     q      ?     ?     ?  *   ?  *        9     Y     i  #   w  #   ?  &   ?     ?     ?  ,        A     Z  -   o     ?     ?     ?     ?     ?     ?          '  ?  B  ?     0     -   L  G   z  <   ?  ^   ?  Z   ^  ]   ?  o     [   ?  K   ?  j   /  '   ?     ?     ?  2   ?  >   -     l  {   ?                8     Q  !   n     ?     ?     ?     ?     ?          #     9     @     S     q     ?  T   ?     ?       /   -     ]     q     ?     ?     ?     ?  #   ?  )         D     e       $   ?     ?  2   ?          -  1   L  )   ~     ?     ?     ?  #   ?  #      "   '      J   !   ]   (         ?      ?      ?      ?      	!     !     7!     N!     b!     |!  !   ?!                     '              L       4                           6   /       5           7   N   H   *   <            0                 @         1       %   2   
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
PO-Revision-Date: 2013-02-12 23:37+0800
Last-Translator: Wei-Lun Chao <bluebat@member.fsf.org>
Language-Team: Chinese (traditional) <zh-l10n@linux.org.tw>
Language: zh_TW
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=1; plural=0;
 
如果未設定 -e, --expression, -f, 或 --file 選項，那麼第一個不是選項的
引數就會被當做 sed 的命令稿來解譯。所有剩下的引數則是輸入檔的名稱；
假如未指定輸入檔，就會從標準輸入來讀取。

       --help     顯示本輔助訊息並離開
       --version  輸出版本資訊並離開
   --follow-symlinks
                 就地處理時追隨符號連結
   --posix
                 停用所有 GNU 擴充功能。
   -R, --regexp-perl
                 在命令稿中使用 Perl 5 的正規表示式語法。
   -b, --binary
                 以二進位模式開啟檔案 (並未特殊處理 CR+LF)
   -e 命令稿, --expression=命令稿
                 加入命令稿做為執行的命令
   -f 命令稿檔案, --file=命令稿檔案
                 加入命令稿檔案內容做為執行的命令
   -l N, --line-length=N
                 指定使用「l」命令時想要的換列長度
   -n, --quiet, --silent
                 抑止樣版空間的自動顯示
   -u, --unbuffered
                 從輸入檔中讀取最少量的資料並更常清空輸出緩衝區
 %s: -e 表示式 #%lu，字元 %lu: %s
 %s: 無法讀取 %s: %s
 %s: 檔案 %s 列號: %lu: %s
 %s：警告：無法提取 %s：%s 的安全語境 %s：警告：無法設定 %s：%s 的預設檔案建立語境 : 不需要任何位址 GNU sed 首頁：<http://www.gnu.org/software/sed/>。
使用 GNU 軟體的一般說明：<http://www.gnu.org/gethelp/>。
 不正確的返回參考 不正確的字元等級名稱 不正確的核對字元 不正確的「\{\}」內容 不正確的前導正規表示式 不正確的範圍結束 不正確的正規表示式 記憶體耗盡 沒有符合者 沒有先前的正規表示式 正規表示式的過早結束 正規表示式太大 成功 末端有倒斜線 未匹配的「(」或「\」 未匹配的「)」或「\」 未匹配的「\{」 用法: %s [選項]... {若無其他命令稿則只能放命令稿} [輸入檔]...

 不支援命令「e」 「}」不需要任何位址 無法為目的是「%s」的跳移找到標籤 無法移除 %s: %s 無法更改名稱 %s: %s 無法取得狀態 %s：%s 命令只使用一個位址 備註不接受任何位址 無法附加到 %s：%s 無法編輯 %s: 是一個終端機 無法編輯 %s: 不是一個正常檔案 無法追隨符號連結 %s：%s 無法打開檔案 %s: %s 無法打開暫存檔案 %s: %s 分隔字元不是單一位元字元 錯誤發生於副行程中 預期在「a」、「c」或「i」之後出現 \ 預期使用新版的 sed 命令後含有多餘的字元 「s」命令的 RHS 上不正確的參考值 \%d 無法將 +N 或 ~N 作為第一個位址 非法使用位址第 0 列 遺漏命令 多個「!」 多個「s」命令的選項「g」 多個「s」命令的選項「p」 多個「s」命令的數值選項 沒有輸入檔案 不存在之前的正規表示式 「s」命令的數值選項不能為零 不支援選項「e」 讀取 %s 時出錯: %s y 命令的字串長度不同 未預期的「,」 未預期的「}」 未知的命令: 「%c」 「s」的未知選項 未匹配的「{」 未結束的「s」命令 未結束的「y」命令 未結束的位址正規表示式 