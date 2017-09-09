NB.%dbj.ijs - dbj is a database management system (DBMS) developed in J language.
NB.+
NB.+dbj.ijs (this file) is the main script, which provides the DBMS engine.
NB.+dbjgui.ijs realizes the optional GUI
NB.+
NB.+In J environment (window or console), dbj can be loaded with:
NB.+
NB.+load 'data/dbj' (if installed as addon)
NB.+-or-
NB.+load '~user/projects/dbj/dbj.ijs' (if installed as project)
NB.+
NB.+Then, a database can be opened with the command:
NB.+
NB.+dbj <'dbname' NB.+(graphic interface) 
NB.+dbj  'dbname' NB.+(command line interface)
NB.+
NB.+Refer to script comments and help page, or run the dbj labs for more information.
NB.+
NB.+MAIN DEFINITIONS
NB.+
NB.+dbj object methods (for opened databases):
NB.+
NB.+    closek    ''     - close a database, releasing resources
NB.+sel k         obj    - return an object as dbj dynaset from the active database
NB.+    krd       obj    - read a file (table or query of the active database) returning a dbj dynaset
NB.+ins ksave     obj    - save a dbj dynaset as table or a command string as query in the active database (text file)
NB.+ins ksavej    obj    - save a dbj dynaset as table or a command string as query in the active database (encrypted)
NB.+dyn kupdate   obj    - append records of a dbj dynaset to a table in the active database (text file)
NB.+    kdel      obj    - delete an object (query or table) from the active database
NB.+    kreset    obj    - unload an object or all objects from cache for the active database
NB.+    kinfo     sel    - return a dbj dynaset with info about the objects in the active database
NB.+('db2';'f2')iconv f1 - convert a linked field of a dbj dynaset in the active database
NB.+    tk        obj    - return as text the content of the source file defining an object in the active database
NB.+obj ka               - adverb which calls the k verb for a given object in the active database
NB.+
NB.+public dbj verbs:
NB.+
NB.+sep dbj       dir    - open a database being dir (a string) the database name (a directory under user/dbj/)
NB.+    dbjdestroy''     - destroy all existing instances of dbj class
NB.+    dbjlab    ''     - start the dbj studio lab
NB.+dir ke        obj    - return an object as dbj dynaset from an existing database
NB.+    kl        ''     - generate a dynaset with the list of existing databases and associated objects
NB.+    kn        ''     - list of locatives of dbj instances with associated info
NB.+
NB.+other dbj class methods:
NB.+
NB.+att dbjtohtml dyn    - convert a dbj dynaset in an html table with given attributes
NB.+att dbjtohref dyn    - convert a dbj dynaset in an html table with given attributes, preserving html tags
NB.+sep kget      file   - read a text or encrypted file (table or query) returning a dbj dynaset
NB.+sel kgetxls   file   - read an excel file (previously saved with writexls) returning a dbj dynaset
NB.+sep ktable    str    - transform a single string (normally the content of a dbj file) in a dbj table
NB.+dyn writek    file   - write a dbj dynaset to a dbj file using the default separator
NB.+dyn appendk   file   - append rows of a dbj dynaset to an existing dbj file using the default separator
NB.+dyn writexls  file   - write a dbj dynaset to an Excel file (tables/tara addon is required)
NB.+sep printk    dyn    - format a dbj dynaset as string using a field separator (default '|')
NB.+sep rowk      dyn    - format the body of a dbj dynaset as string using a field separator (default '|')
NB.+sel kfind     file   - find records in a dbj table (text file), mapping the file instead of loading it
NB.+sel ksearch   file   - full text search of a string in a dbj table (text file), mapping the file 
NB.+    namesk    dyn    - cleaned version of the field names of a dbj dynaset (without field types)
NB.+    typesk    dyn    - cleaned version of the field types of a dbj dynaset (without field names)
NB.+    typek     dyn    - cleaned version of the field types of a dbj dynaset (string-int-float-complex-boxed only)
NB.+    bfi       itb    - transform a table in boxed from inverted format
NB.+    ifb       btb    - transform a table in inverted from boxed format
NB.+    bfk       dyn    - transform a table in boxed from dbj format
NB.+    kfb       btb    - transform a table in dbj from boxed format
NB.+sel kyesrow   dyn    - select by numeric indexes rows (records) of a dbj dynaset
NB.+sel kyescol   dyn    - select by numeric indexes columns (fields) of a dbj dynaset
NB.+sel knotrow   dyn    - unselect by numeric indexes rows (records) of a dbj dynaset
NB.+sel knotcol   dyn    - unselect by numeric indexes columns (fields) of a dbj dynaset
NB.+sel kfirst    dyn    - select first x records of a dbj dynaset
NB.+sel klast     dyn    - select last x records of a dbj dynaset
NB.+sel kselrow   dyn    - select a group of consecutive records of a dbj dynaset
NB.+sel kdelrow   dyn    - delete by keys the rows (records) of a dbj dynaset
NB.+sel kdelcol   dyn    - delete by names the columns (fields) of a dbj dynaset
NB.+sel icol      dyn    - select columns (fields) from a dbj dynaset, without table head
NB.+sel kcol      dyn    - select columns (fields) from a dbj dynaset, with first column and table head always included
NB.+sel krename   dyn    - rename field(s) of a dbj dynaset
NB.+sel ifield    dyn    - select by name the unboxed content of a column (field) of a dbj dynaset
NB.+sel kfield    dyn    - select by names the fields of a dbj dynaset;
NB.+sel irow      dyn    - select rows (records) from a dbj dynaset
NB.+sel krow      dyn    - select rows (records) from a dbj dynaset, with first row (table head) always included
NB.+rec kaddrow   dyn    - add or update rows (records) in a dbj dynaset
NB.+ins kaddcol   dyn    - add or update columns (fields) in a dbj dynaset
NB.+ins kboxcol   dyn    - add or update boxed columns (fields) in a dbj dynaset
NB.+'f' kaddkey   dyn    - add a new numeric key column to a dbj dynaset
NB.+sel khead     dyn    - return the first row (head) of selected column(s) (field(s))
NB.+(k;f) cell    dyn    - return a single unboxed element from a dbj dynaset
NB.+      ibody   dyn    - return the body of a dbj dynaset, without the head
NB.+      headk   dyn    - return the head of a dbj dynaset, without the body
NB.+ins kfilter   dyn    - filter records of a dbj dynaset with a given condition
NB.+str klocate   dyn    - locate records of a dbj dynaset containing a given string or value
NB.+sel kazsort   dyn    - sort (ascending) records of a dbj dynaset
NB.+sel kzasort   dyn    - sort (descending) records of a dbj dynaset
NB.+('op';'f2') kgroup (dy1;'f1') - group content of some field(s) and perform operation on other field(s)
NB.+sel krnd      dyn    - return random records from a dbj dynaset
NB.+sel ktrans    dyn    - transpose a dbj dynaset
NB.+sel ktoint    dyn    - convert to integer the fields of a dbj dynaset
NB.+sel ktofloat  dyn    - convert to float the fields of a dbj dynaset
NB.+sel ktocomplex dyn   - convert to complex the fields of a dbj dynaset
NB.+sel ktostring dyn    - convert to string the fields of a dbj dynaset
NB.+sel ktorstring dyn   - convert to right-justified string the fields of a dbj dynaset
NB.+sel ktoboxed  dyn    - convert to boxed the fields of a dbj dynaset
NB.+sel kunbox    dyn    - convert to strings all boxed fields of a dbj dynaset
NB.+'f' kdirtree  dir    - generate a dbj dynaset with all filenames contained in a directory tree
NB.+'f' kdirpath  dir    - generate a dbj dynaset with all subdirs contained in a directory tree
NB.+'f' kdir      dir    - generate a dbj dynaset with files contained in a directory
NB.+'f' kfolder   dir    - generate a dbj dynaset with files and dirs contained in a directory
NB.+'f' kdu       dir    - generate a dbj dynaset with data about all subdirs of a directory tree
NB.+'f' kfile     file   - generate a dbj dynaset with the content of a text file (multi-records output)
NB.+'f' kcontent  file   - generate a dbj dynaset with the content of a text file (one-cell output)
NB.+'f' kwww      url    - generate a dbj dynaset with the content of a web file
NB.+'f' khttp     url    - generate a dbj dynaset with the content of a http response
NB.+sep kwget     url    - generate a dbj dynaset with the content of a web file holding a dbj table
NB.+'f' kstring   string - generate a dbj dynaset with the content of a string or a boxed list of strings
NB.+'f' kboxed    string - generate a dbj dynaset with the content of a string or a boxed list of strings
NB.+'f' kint      vector - generate a dbj dynaset with the content of a vector of integers
NB.+'f' kfloat    vector - generate a dbj dynaset with the content of a vector of floats
NB.+'f' kcomplex  vector - generate a dbj dynaset with the content of a vector of complexes
NB.+'f' kday (startday;length;step) - generate a dbj dynaset with sequential dates
NB.+'f' kjbox     dyn    - generate a dbj dynaset with the boxed representation of the given dynaset
NB.+'f' kdbj      dyn    - generate a dbj dynaset with the dbj representation of the given dynaset
NB.+'f' khtml     dyn    - generate a dbj dynaset with the html representation of the given dynaset
NB.+'f' khref     dyn    - generate a dbj dynaset with the html representation of the given dynaset, preserving tags
NB.+sep kself     dyn    - generate a dbj dynaset with the string representation of the given dynaset
NB.+'f' kj        arg    - generate a dbj dynaset with the string representations of any J noun
NB.+sep kcat      dyn    - collapse a dbj dynaset in a single column
NB.+dy2 klr       dy1    - (lr means left-right) put db1 dynaset to the right of db2 dynaset
NB.+dy2 kud       dy1    - (ud means up-down) put db1 dynaset under db2 dynaset
NB.+dy2 kmerge    dy1    - merge the contents of two dbj dynasets, if keys and/or fields are compatible
NB.+dy2 kmixkey   dy1    - mix keys of two dbj dynasets
NB.+dy2 kmixall   dy1    - mix all fields of two dbj dynasets
NB.+(dy2;'f2')  kmix   (dy1;'f1') - mix selected fields of two dbj dynasets
NB.+sel plotk     dyn    - select columns (fields) from a dbj dynaset and plot them
NB.+sel kplot     dyn    - select columns (fields) from a dbj dynaset, plot them and return number of points
NB.+sel tbk       dyn    - display a dbj dynaset in a QTableWidget (verb deined in dbjgui.ijs)
NB.+'f' kascii    ''     - generate a dbj dynaset, containing 95 printable ASCII characters (from 32 to 126)
NB.+rec kdefine   head   - define a new table, with a given table head and optional records
NB.+'c' kconf     string - parse the content of a simple configuration file
NB.+'c' kini      string - parse the content of a structured configuration file
NB.+    kgrid     dim    - generate a template of dbj dynaset with dim dimension (dim is records,fields)
NB.+'f' krgb      array  - generate a dbj dynaset from an integer array holding a bitmapped image, and display it
NB.+'f' kbmp      file   - generate a dbj dynaset from a file holding a bmp image, and display it
NB.+'f' kimg      file   - generate a dbj dynaset from a file holding a gig-png-jpg image, and display it
NB.+'f' kview     file   - display a file holding an image, returning a dbj dynaset with image dimensions
NB.+'f' kviewmat  array  - generate a dbj dynaset from a numeric array, and display it with viewmat
NB.+'f' ksurface  array  - generate a dbj dynaset from a numeric array, and display it as surface plot
NB.+'f' karray    array  - generate a dbj dynaset from a numeric array
NB.+sel ks        string - evaluate a string to get a dbj dynaset, and return a slice of records

coclass 'dbj'

NB.=====================================================================
NB.*DBE n integer indicating environment and loaded scripts
NB.+this definition includes initialization and require statements
DBE=: 3 : 0 ''
1!:44 :: ] jpath '~user' NB. set working directory
9!:1<.100x1**:{:6!:0''   NB. set new RNG seed
9!:7 '+++++++++|-'
9!:11 ] 10               NB. better print precision
NB.+9!:41 ] 0
IFENGINE_z_=: (jpath'~user')-:jpath'~install/user'
require 'socket task '
try. require 'jfiles' catch. assert. 'required addon: data/jfiles' end.
try. require 'jmf' catch. assert. 'required addon: data/jmf' end.
try. require 'numeric pack general/misc/font' catch. assert. 'required addon: general/misc' end.
try. require 'trig' catch. assert. 'required addon: math/misc' end.
if. fexist jpath'~addons/data/dbj/manifest.ijs' do.
  DBV=: jpath '~addons/data/dbj'
  require 'data/dbj/manifest'
  y=. 1 NB. dbj installed as addon
else.
  DBV=: jpath '~user/projects/dbj'
  require '~user/projects/dbj/manifest.ijs'
  y=. 0 NB. dbj installed as project
end.
if. -.IFENGINE do.
  try. require 'graphics/plot graphics/viewmat' catch. assert. 'required addons: arc/zlib, graphics/plot, graphics/bmp, graphics/png, graphics/color, graphics/afm, graphics/viewmat, graphics/gl2' end.
  try. require 'web/gethttp' catch. smoutput 'optional addon: web/gethttp' end.
  try. require 'labs/labs/lab' catch. smoutput 'optional addon: labs/labs' end.
  if. IFJHS do.
    coinsert 'jhs'
    try. require 'ide/jhs/jfilesrc convert/json' catch. assert. 'required addons: ide/jhs, convert/json' end.
    plotdef 'show';'dbjplot';800 600
    y=. y+4 NB. jhs environment
  elseif. IFQT do.
    coinsert 'jgl2'
    try. require 'print' catch. assert. 'required addons: graphics/print' end.
    try. require 'tables/tara' catch. smoutput 'optional addon: tables/tara' end.
    try. require 'graphics/jpeg' catch. smoutput 'optional addon: graphics/jpeg' end.
    y=. y+8 NB. jqt environment
  elseif. do.
    y=. y+2 NB. console environment
  end.
  if. 2|y do. load 'data/dbj/dbjgui' else. load '~user/projects/dbj/dbjgui.ijs' end.
  y
end.
)

NB.=====================================================================
NB. noun definitions for the dbj class
NB.=====================================================================

NB.=====================================================================
NB.*DBA n boxed array containing variables defined in manifest.ijs
DBA=: ('CAPTION';'DESCRIPTION';'LABCATEGORY';'VERSION';'RELEASE';'PLATFORMS';'FILES'),.CAPTION;DESCRIPTION;LABCATEGORY;VERSION;RELEASE;PLATFORMS;FILES

NB.=====================================================================
NB.*DBB n locative of the active database (boxed integer)
DBB=: <''

NB.=====================================================================
NB.*DBN n name of active database
DBN=: ''

NB.=====================================================================
NB.*DBF n name of database folder
DBF=: ''

NB.=====================================================================
NB.*DBD n boxed array containing the name, the first row and the size of each file 
DBD=: 0$,:'';'';''

NB.=====================================================================
NB.*DBS n field separator used in the database
DBS=: '|'

NB.=====================================================================
NB.*DBQ n boxed list used to trace queries
DBQ=: ,a:

NB.=====================================================================
NB.*DBR n boxed array used to trace queries
DBR=: ''

NB.=====================================================================
NB.*DBM n name of database keyfile
DBM=: ''

NB.=====================================================================
NB.*DBC n set to 1 to use cache (default), set to 0 to avoid cache
DBC=: 1

NB.=====================================================================
NB.*DBL n list of existing databases
DBL=: 0$a:

NB.=====================================================================
NB.*DBP n string used by ks verb
DBP=: 'kstring'''''

NB.=====================================================================
NB.*DBO n two-elements list used by ks verb
DBO=: 0 100

NB.=====================================================================
NB.*DBW n dbj dynaset used by ks verb
DBW=: ,.(,'N');0 0$0

NB.=====================================================================
NB.*DBH n font for text areas
DBH=: FIXFONT_jgl2_"_ ::  ] 'Mono 10'

NB.=====================================================================
NB.*DBY n font for tables and grids
DBY=: PROFONT_jgl2_"_ ::  ] 'Sans 10'

NB.=====================================================================
NB.*DBG n events log
DBG=: 0

NB.=====================================================================
NB.*DBJ n set to 1 if jqt GUI is active, 0 if not
DBJ=: 0

NB.=====================================================================
NB.*DBZ n spare noun
DBZ=: ''

NB.=====================================================================
NB. dbj utilities
NB.=====================================================================

NB.=====================================================================
NB.*colwidth v size (number of characters) of each field of a dynaset
colwidth=: 3 : '([: <:@:}: 1&|. - ]) I.''+''E.{.": y'

NB.=====================================================================
NB.*colsize v size (number of pixels) to be assigned to each field on
NB.+screen, for best representation of data; y is colwidth
colsize=: 3 : '>(1280 > +/ 12*y){((12*y)<.90>.<.1280*(] % +/)y);12*y'

NB.=====================================================================
NB.*tobase64 v convert a string to base64 representation
tobase64=: 3 : 0
res=. ((a.{~ ,(a.i.'Aa') +/i.26),'0123456789+/') {~ #. _6 [\ , (8#2) #: a. i. y
res, (0 2 1 i. 3 | # y) # '='
)

NB.=====================================================================
NB.*frombase64 v convert a string from base64 representation
frombase64=: 3 : 0
pad=. _2 >. (y i. '=') - #y
pad }. a. {~ #. _8 [\ , (6#2) #: ((a.{~ ,(a.i.'Aa') +/i.26),'0123456789+/') i. y
)

NB.=====================================================================
NB.*bfi v transform a table in boxed from inverted format
bfi=: dtb&.>@:|:@:(<"_1&>)

NB.=====================================================================
NB.*ifb v transform a table in inverted from boxed format
ifb=: <@(,@>"1)@|:

NB.=====================================================================
NB.*bfk v transform a table in boxed from dbj format
bfk=: (1&{. , bfi@:(_1&{)) :. kfb

NB.=====================================================================
NB.*kfb v transform a table in dbj from boxed format
kfb=: (1&{. , ifb@:(1&}.)) :. bfk

NB.=====================================================================
NB.*ind v indexof dyad operating on rows of an inverted table
NB.+equivalent to i. dyad operating on normal lists
ind=: i.&>~@[ i.&|: i.&>

NB.=====================================================================
NB.*tostring v convert into a single string any J variable
NB.+see discussion http://jsoftware.2058.n7.nabble.com/flatten-data-to-a-string-td14868.html
tostring=: 3 : 0
r=. _1
y=. ,&LF"1 ": y
while. 2 < # $ y do.
  r=. <:r
  y=. (,&LF)@,"2 y
end.
r }. ,y
)

NB.=====================================================================
NB.*tochars v convert into a single string any J variable, preserving LF inside boxes
tochars=: [: tostring >@:ifb@:,.@:(<;._2)@:(,&LF)@:tostring L:0

NB.=====================================================================
NB.*toflat v convert into a single string any J variable removing boxing characters
toflat=: }:@:;@:(;L:1^:L.)@:(,&' '@:":L:0)

NB.=====================================================================
NB.*tofloat v convert into a single float number any J variable
tofloat=: (1&{.)@:;@:+.@:(0&".)@:toflat f.

NB.=====================================================================
NB.*tocomplex v convert into a single complex number any J variable
tocomplex=: (1&{.)@:;@:(0&".)@:toflat f.

NB.=====================================================================
NB.*toint v convert into a single integer number any J variable
toint=: <.@:tofloat f.

NB.=====================================================================
NB.*tobool v convert into a single boolean value any J noun
tobool=: 0&~:@:tofloat

NB.=====================================================================
NB.*isint v check if a string represents an integer value
isint=: (dltb -: ":@:toint)

NB.=====================================================================
NB.*isfloat v check if a string represents a float value
isfloat=: (dltb -: ":@:tofloat)

NB.=====================================================================
NB.*iscomplex v check if a string represents a complex value
iscomplex=: (dltb -: ":@:tocomplex)

NB.=====================================================================
NB.*frmt v try to unbox, then format as string with - sign for negative numbers
frmt=: ({.@(8!:2)`tostring@.((1 < #) +. 16 32 e.~ 3!:0))@:(> :: ])

NB.=====================================================================
NB.*ifrmt v format as strings all the non-string fields of an inverted table
ifrmt=: frmt"1^:(2 ~: 3!:0)&.>

NB.=====================================================================
NB.*prefix v prepend a string to each element of a boxed list
prefix=: 4 : '(<x) , each ": each y'

NB.=====================================================================
NB.*suffix v append a string to each element of a boxed list
suffix=: 4 : '(<x) ,~ each ": each y'

NB.=====================================================================
NB.*bcat v concatenate strings inside two boxed lists, or a string inside a boxed list
bcat=: 4 : '(": each boxopen x) , each ": each boxopen y'

NB.=====================================================================
NB.*bcatstr v concatenate all elements of a boxed list using a separator between strings
bcatstr=: (3 : 'bcat/ y') : (4 : '(-#x) }. each bcat/ x suffix y')

NB.=====================================================================
NB.*icat v concatenate as string the content of two fields of a dbj dynaset
NB.+operands can be also single strings instead of rank 2 arrays
icat=: 4 : 'dtb(dtb^:(1<#)":x),":y'"1

NB.=====================================================================
NB.*icatstr v concatenate all elements of a field using a separator between strings
icatstr=: (3 : 'icat/ dtb@:":"1 y') : (4 : '(#":x) }. icat/ (":x) ,"1 dtb@:":"1 y')

NB.=====================================================================
NB.*icount v count of non-zero elements in an array
icount=: 3 : '# (;y)-.0'

NB.=====================================================================
NB.*imean v arithmetic mean of non-zero elements in an array
imean=: 3 : '(+/ % #) (;y)-.0'

NB.=====================================================================
NB.*iss v number of occurrences of content of field x in content of field y
iss=: 4 : '#(dtb x)ss y'"1

NB.=====================================================================
NB.*issf v first occurrence of content of field x in content of field y
NB.+return _1 in case of no occurence
issf=: 4 : '0{((dtb x)ss y),_1'"1

NB.=====================================================================
NB.*issl v last occurrence of content of field x in content of field y
NB.+return _1 in case of no occurence
issl=: 4 : '_1{_1,(dtb x)ss y'"1

NB.=====================================================================
NB.*inum v format a numeric array as field of a dbj dynaset
NB  if numbers are complex, only the real part is taken
inum=: 3 : ',. (#,y) $ , y'

NB.=====================================================================
NB.*istr v format a string array as field of a dbj dynaset
istr=: 3 : ',:^:(2-#@$) y'

NB.=====================================================================
NB.*ifrm v format (if possible) a name as field (numeric or string) of a dbj dynaset
ifrm=: 3 : 'inum`istr@.(2=3!:0) (>@:,)^:L. y'

NB.=====================================================================
NB.*ibox v format (if possible) a name as field of a dbj dynaset, but strings are boxed
ibox=: 3 : 0
if. 32=3!:0 y do.
  if. 2=~.;3!:0 each y do.
    ,.,y
  else.
    inum >@:,y
  end.
elseif. 2=3!:0 y do.
  ,. <@:dtb"1 istr y
elseif. do.
  inum y
end.
)

NB.=====================================================================
NB.*isel v select the content of y=field1,:field2 using values of boolean vector x
NB.+works also with more than 2 fields and an integer vector as selector
isel=: 4 : 'dtb"1 (<"1 (,x),.i.#x) {y'

NB.=====================================================================
NB.*ieq v test where two fields (or a field and a string) have the same content
ieq=: 4 : '(dtb x)-:dtb y'"1

NB.=====================================================================
NB.*iazgrade v grade up an inverted table, returning an integer vector
iazgrade=: >@((] /: {~)&.>/)@(}: , /:&.>@{:)

NB.=====================================================================
NB.*izagrade v grade down an inverted table, returning an integer vector
izagrade=: >@((] \: {~)&.>/)@(}: , \:&.>@{:)

NB.=====================================================================
NB.*cverb c conditionally apply verbs to atoms of an array
NB.+usage: x u cverb v y
NB.+y is a generic array; x is a boolean array with the same shape of y;
NB.+u and v are monadic verbs; u or v are applied to each atom of y,
NB.+according with the value of corresponding atom of x;
NB.+example 0 1 0 1 0 1 *: cverb %: i.6
NB.+cverb=: 2 : '((u@])`(v@])@.[)"0' NB. my version
cverb=: 2 : '[@{"0 1 (u@]) ,"0 v@]'  NB. by Roger Hui

NB.=====================================================================
NB.*noss v used by sr to manage non-ovelapping substrings
NB.+equivalent to ss if no overlaps occurr
noss=: 4 : 0
s=. x I.@E. y
i=. s I. s+#x
(i.&_1 {. ]) (s,_1) {~ (i,_1) {~^:a: 0
)

NB.=====================================================================
NB.*sr v string replace by Roger Hui
NB.+usage: (oldsubstr;newsubstr) sr string
NB.+can work also with numeric or boxed lists
NB.+see discussion http://jsoftware.2058.n7.nabble.com/tacit-stringreplace-td19101.html
NB.+and http://www.jsoftware.com/jwiki/Essays/Substring_Replacement
NB.+my tacit version (less performant):
NB.+sr=: 13 : '(#>{:x)}. ; ({:x) , each (<:#>{.x)}. each ((>{.x)E.(>{.x),y)<;._1 (>{.x),y'
sr=: 4 : 0
'p q'=. x
j=. p noss y
if. ''-:j do. y return. end.
d=. p-&#q
l=. (j+(0>.-d)*i.#j)+/i.#q
select. *d
  case.  1 do. (0 (j+/(#q)+i.d)}1$~#y) # q l}y
  case.  0 do. q l}y
  case. _1 do. q l} (0 (d{."1 l)}1$~(#y)+(#j)*|d) #^:_1 y
end.
)

NB.=====================================================================
NB.*srr v replace multiple substrings inside a string
NB.+usage: (oldsubstr1;newsubstr1;oldsubstr2;newsubstr2...) srr string
NB.+tacit version (see http://www.jsoftware.com/jwiki/Essays/Do_While):
NB.+f=: 13 : '(2}.>{.y) ; (2{.>{.y) sr >{:y' 
NB.+p=: 13 : '1<#>{.y'
NB.+srr=: 13 : '>{: f^:p^:_ (,x);y'
srr=: 4 : 'for_n. _2 ,\ ,x do. y=. n sr y end.'

NB.=====================================================================
NB.*htmlreplace v replace special html characters in string
htmlreplace=: ('<';'&lt;') sr ('>';'&gt;') sr ('"';'&quot;') sr ('&';'&amp;') sr ]

NB.=====================================================================
NB.*tohtml v convert J data to html code with same display
tohtml=: '<pre>'&,@:(,&(LF,'</pre>'))@:htmlreplace@:tostring

NB.=====================================================================
NB.*urldecode v replace escaped sequences in url string
urldecode=: ('%09';TAB;'%0A';LF;'%0D';CR;'%20';' ';'%21';'!';'%22';'"';'%23';'#';'%24';'$';'%26';'&';'%27';'''';'%28';'(';'%29';')';'%2B';'+';'%2C';',';'%2F';'/';'%3A';':';'%3B';';';'%3C';'<';'%3D';'=';'%3E';'>';'%3F';'?';'%40';'@';'%5B';'[';'%5C';'\';'%5D';']';'%5E';'^';'%60';'`';'%7B';'{';'%7C';'|';'%7D';'}';'%7E';'~';'%25';'%')&srr

NB.=====================================================================
NB.*urlencode v put escaped sequences in url string
urlencode=: ('%';'%25';TAB;'%09';LF;'%0A';CR;'%0D';' ';'%20';'!';'%21';'"';'%22';'#';'%23';'$';'%24';'&';'%26';'''';'%27';'(';'%28';')';'%29';'+';'%2B';',';'%2C';'/';'%2F';':';'%3A';';';'%3B';'<';'%3C';'=';'%3D';'>';'%3E';'?';'%3F';'@';'%40';'[';'%5B';'\';'%5C';']';'%5D';'^';'%5E';'`';'%60';'{';'%7B';'|';'%7C';'}';'%7D';'~';'%7E')&srr

NB.=====================================================================
NB.*boxreplace v replace elements inside a boxed array, preserving shape
NB.+usage: (old1;new1;old2;new2...) boxreplace boxedarray
boxreplace=: 4 : 0
shp=. $ y                 NB. save shape of y
y=. ,y                    NB. transform y in boxed list
for_n.
  _2 ,\ ,x                NB. put old and new boxes in two columns
do.
  y=. ({:n) (I. y={.n)} y NB. amend boxed list (step)
end.
shp $ y                   NB. reshape y as original
)

NB.=====================================================================
NB.*prec v return x if y is an empty box
NB.+prec=: 4 : 'if. a:-:y do. x else. y end.'
NB.+prec=: ]`[@.(a:-:])
prec=: [^:(a:-:])

NB.=====================================================================
NB.*populate v fill empty elements of a boxed vector with content of previous atom
NB.+see discussion http://jsoftware.2058.n7.nabble.com/populating-a-list-of-boxed-strings-td14048.html
NB.+populate=: prec/\
populate=: (1}. a:&~:(#;.1@(1&,)@[ # a:,#) ])&.(a:&,)

NB.=====================================================================
NB.*iprec v return x if y is an empty (or blank) string
iprec=: [^:(''&-:@:(dtb@:]))

NB.=====================================================================
NB.*ipopulate v fill empty strings of a string array with content of previous item
NB.+ipopulate=: iprec/\
ipopulate=: >@:ifb@:populate@:bfi@:<

NB.=====================================================================
NB.*lookup v extract values from a two-columns boxed table
NB.+where first column holds keys and second column holds values
NB.+usage: mykey lookup boxedtable 
NB.+examples:
NB.+'key2' lookup ('key1';'key2'),.('value1';'value2') NB. returns a single unboxed value
NB.+('key2';'key1') lookup ('key1';'key2'),.('value1';'value2') NB. returns a list of boxed values
lookup=: 4 : ';^:(1=#)_1{"1(((,each {."1 y)i.boxopen&,x)-.#y){y'

NB.=====================================================================
NB.*lookset v set a value in a two-columns boxed table
NB.+where first column holds key and second column holds value
NB.+if key doesn't exist, it is added
NB.+usage: (mykey;newvalue) lookset boxedtable 
NB.+lookset=: 4 : 'x (({."1 y) i. {.x)} y' :: ]
lookset=: 4 : 0
z=. ({."1 y) i. {.x
if. z<#y do.
  x z} y
else.
  y,x
end.
)

NB.=====================================================================
NB.*unixtojtime v convert unixtime (seconds from 1/1/1970) to J timestamp (Y M A h m s)
unixtojtime=: 1 tsrep 5364662400000+1000*]

NB.=====================================================================
NB.*jtounixtime v convert J timestamp (Y M A h m s) to unixtime (seconds from 1/1/1970) 
jtounixtime=: 5364662400 -~ [: <. 1000 %~ tsrep

NB.=====================================================================
NB.*crono v convert number of seconds to string HH:MM:SS 
crono=: 3 : '(((": <. y%86400),''d '')&,)^:(y>86399) 8&{. 11&}. isotimestamp 1&tsrep 1000&* 86400|y'

NB.=====================================================================
NB.*dft v discrete fourier transform
NB.+form: dft vector
dft=: (3 : '+/ z * ^ (#z) %~ 0j_2p1 * */~ i.#z [ z=. ,y') :. ift

NB.=====================================================================
NB.*ift v inverse fourier transform
NB.+form: ift vector
ift=: (3 : '+/ (z%#z) * ^ (#z) %~ 0j2p1 * */~ i.#z [ z=. ,y') :. dft

NB.=====================================================================
NB.*pdi v poisson distribution (^-y)*(y^n) % !n
NB.+form: n pd y
pdi=: ^@-@] * ^~ % !@[

NB.=====================================================================
NB.*pdc v poisson distribution, cumulative
NB.+form: n pdc y
pdc=: ([: +/ ] pdi~ [: i. [: >: [)"0

NB.=====================================================================
NB.*intg a definite integral
NB.+example (1 % intg 2) -: (^.2)-(^.1)
intg=: 1 : '(u d. _1 @ ])-(u d. _1 @ [)'

NB.=====================================================================
NB.*drvt a first derivative
NB.+example (^. drvt 2) -: (%2)
drvt=: 1 : 'u d. 1'

NB.=====================================================================
NB.*encrypt v encrypt strings using simple Vigenere algorithm
NB.+see http://www.jsoftware.com/jwiki/Addons/convert/misc/vig
NB.+usage: encmessage=: key encrypt plainmessage
NB.+as monad, a default key is used (pseudo-random ascii sequence having the same length of y)
encrypt=: 3 : 0
((?.(#y)$256){a.) encrypt y
:
a. {~ 256 | ((#y) $ a. i.x) + a. i.y
)

NB.=====================================================================
NB.*decrypt v decrypt strings using simple Vigenere algorithm
NB.+see http://www.jsoftware.com/jwiki/Addons/convert/misc/vig
NB.+usage: plainmessage=: key decrypt encmessage
NB.+as monad, a default key is used (pseudo-random ascii sequence having the same length of y)
decrypt=: 3 : 0
((?.(#y)$256){a.) decrypt y
:
a. {~ 256 | (-(#y) $ a. i.x) + a. i.y
)

NB.=====================================================================
NB.*encryptfile v encrypt a file
NB.+y is a single filename (encryption in place) or plainfilename;encfilename
NB.+if y is twice boxed, a conversion to base64 is executed after encryption;
NB.+x is the encryption key;
NB.+as monad, a default key is used (pseudo-random ascii sequence having the same length of the file)
encryptfile=: 3 : 0
if. 2=L.y do.
   y=. ,>y
  ('(w)',LF,tobase64 encrypt fread {.y)fwrite {:y
else.
   y=. ,boxopen y
  (encrypt fread {.y)fwrite {:y
end.
:
if. 2=L.y do.
   y=. ,>y
  ('(w)',LF,tobase64 x encrypt fread {.y)fwrite {:y
else.
   y=. ,boxopen y
  (x encrypt fread {.y)fwrite {:y
end.
)

NB.=====================================================================
NB.*decryptfile v decrypt a file
NB.+y is a single filename (decryption in place) or encfilename;plainfilename
NB.+if y is twice boxed, a conversion from base64 is executed before decryption
NB.+x is the encryption key;
NB.+as monad, a default key is used (pseudo-random ascii sequence having the same length of the file)
decryptfile=: 3 : 0
if. 2=L.y do.
   y=. ,>y
  (decrypt frombase64 4}. fread {.y)fwrite {:y
else.
   y=. ,boxopen y
  (decrypt fread {.y)fwrite {:y
end.
:
if. 2=L.y do.
   y=. ,>y
  (x decrypt frombase64 4}. fread {.y)fwrite {:y
else.
   y=. ,boxopen y
  (x decrypt fread {.y)fwrite {:y
end.
)

NB.=====================================================================
NB.*readjpegcomment v read comment embedded in a jpeg file
readjpegcomment=: 3 : 0
y=. boxopen y
c=. a. i. 1!:11 y,<2 4
if. 255 254 -: 2{.c do.
  1!:11 y,<6,_3+(3{c)+256*2{c
else.
  ''
end.
)

NB.=====================================================================
NB.*writejpegcomment v write comment embedded in a jpeg file
writejpegcomment=: 4 : 0
y=. boxopen y
x=. tostring x
a=. 1!:1 y
if. 255 216 -: a. i. 2{.a do.
  c=. a. i. 2 3 4 5{a
  if. 255 254 -: 2{.c do.
    b=. 4+(3{c)+256*2{c
  else.
    b=. 2
  end.
  d=. 3+#x
  d=. (<.d%256),256|d
  (((255 216 255 254,d){a.),x,(0{a.),b}.a) 1!:2 y
  #x
else.
  _1
end.
)

NB.=====================================================================
NB.*writej v write a J variable to a J binary file
NB.+'(j)',LF is prefixed if the variable is boxed;
NB.+'(y)',LF is prefixed if the variable is a string;
NB.+'(x)',LF is prefixed if the variable is numeric
writej=: 4 : 0
if. 32 = 3!:0 x do.
  ('(j)',LF,3!:1 x) fwrite y
elseif. 2 = 3!:0 x do.
  ('(y)',LF,3!:1 x) fwrite y
elseif. do.
  ('(x)',LF,3!:1 x) fwrite y
end.
)

NB.=====================================================================
NB.*readj v read a J variable from J binary file
NB.+'(j)',LF or '(y)',LF or '(x)',LF prefixes are removed
readj=: 3 : '(3!:2) 4 }. fread y'

NB.=====================================================================
NB.*chopdb v cut records y of a dbj file using separator x as fret
NB.+deletes leading and trailing blanks from each row,
NB.+separates fields, and tranforms each field in a box;
NB.+as monad, the default separator '|' is used
chopdb=: (3 : 'DBS chopdb y') : (4 : '<;._2 (dltb y),x')

NB.=====================================================================
NB.*checkrow v check a boxed table against empty keys
checkrow=: 3 : 0
y=. (dltb each 0{"1 y) (<(i.#y);0) } y NB. removes trailing blanks from first column
n=. -. (<'') = 0{"1 y               NB. rows with a vaild (not empty) key
n # y                               NB. removes rows without a valid key
)

NB.=====================================================================
NB.*checkcol v check a boxed table against empty field names
checkcol=: 3 : 0
y=. (dltb each 0{y) 0}y             NB. removes trailing blanks from first row
n=. -. (<'') = 0{y                  NB. columns with a valid (not empty) field name
n #"1 y                             NB. removes invalid columns
)

NB.=====================================================================
NB.*escape v remove field separator and LF from a string
NB.+field separator, LF, CR, TAB, backslash are replaced 
NB.+with escape sequences \s, \n, \r, \t, \b;
NB.+as monad, the default separator '|' is used
escape=: (3 : '(DBS;''\s'')sr(TAB;''\t'')sr(CR;''\r'')sr(LF;''\n'')sr(''\'';''\b'')sr y') : (4 : '(x;''\s'')sr(TAB;''\t'')sr(CR;''\r'')sr(LF;''\n'')sr(''\'';''\b'')sr y')

NB.=====================================================================
NB.*unescape v restore field separator and LF in a string
NB.+escape sequences \s, \n, \r, \t, \b are replaced with
NB.+field separator, LF, CR, TAB, backslash;
NB.+as monad, the default separator '|' is used
unescape=: (3 : '(''\b'';''\'')sr(''\n'';LF)sr(''\r'';CR)sr(''\t'';TAB)sr(''\s'';DBS)sr y') : (4 : '(''\b'';''\'')sr(''\n'';LF)sr(''\r'';CR)sr(''\t'';TAB)sr(''\s'';x)sr y')

NB.=====================================================================
NB.*checksum v sum of all bytes of a file
NB.+return an hex string with |x nibbles (4 nibbles as monad)
NB.+if x is negative, perform a 16-bit sum
checksum=: 3 : 0
4 checksum y
:
if. 0<x do.
  x=. 1>.<.x
  (-x) {. (x#'0'),hfd +/ a. i. fread y
else.
  x=. 1>.<.|x
  (-x) {. (x#'0'),hfd +/ _2 (256&#.)\ a. i. fread y
end.
)

NB.=====================================================================
NB.*fread1 v read first line of a file
NB.+y is filename;
NB.+lines are assumed delimited by CR, LF, or CRLF;
NB.+the result is a string
fread1=: 3 : 0
y=. fboxname boxopen y
max=. 1!:4 :: _1: y
if. max -: _1 do. return. end.
blk=. 10000
blk=. blk<.max
dat=. 1!:11 y,<0,blk
cls=. <./dat i.CRLF
cls {. dat
)

NB.=====================================================================
NB.*freadl v read all lines of a file containing a given string
NB.+x is the string to be searched, or a boxed list of strings;
NB.+use (LF,key,sep) to search for a key;
NB.+y is the file path (must be a dbj table saved as text file);
NB.+the head row is always returned as first line;
NB.+you can use ktable to transform the result in a dbj dynaset
freadl=: 4 : 0
y=. fboxname boxopen y
max=. 1!:4 :: _1: y
if. max -: _1 do. return. end.
d=. ~. _1,(LF fss y),max
q=. 0
l=. 0$0
for_z. ,boxopen x do.
  l=. l,(>z) fss y
end.
ret=. (fread1 y),LF
for_n. /:~ ~. l do.
  m=. ([: >: [: {: ] #~ n >: ])d
  p=. ([: {. ] #~ n < ])d
  if. -.m e. q do.
    q=. q,m
    dat=. 1!:11 y,<m,p-m
    cls=. <./dat i.CRLF
    ret=. ret,(cls {. dat),LF
  else.
    ret
  end.
end.
)

NB.=====================================================================
NB.*now v return current date and time
now=: 6!:0

NB.=====================================================================
NB.*delay v delay execution for y seconds
delay=: 6!:3

NB.=====================================================================
NB.*pt v print J noun to stdout as string + LF
pt=: ''&[@stdout@(,&LF)@tostring

NB.=====================================================================
NB.*ph v print J noun to stdout as string + LF replacing html special chars
ph=: ''&[@stdout@(,&LF)@htmlreplace@tostring

NB.=====================================================================
NB.*htmlheader v print an html header to stdout
htmlheader=: 3 : 'stdout ''Content-Type: text/html'',CRLF,CRLF'

NB.=====================================================================
NB.*textheader v print a text header to stdout
textheader=: 3 : 'stdout ''Content-Type: text/plain'',CRLF,CRLF'

NB.=====================================================================
NB.*cgiparms v parse cgi parameters
cgiparms=: 3 : 0
q=. getenv'QUERY_STRING'
select. getenv 'REQUEST_METHOD'
case. 'GET' do.
  p=. q
case. 'POST' do.
  p=. stdin''
  if. 0 < # q do.
    p=. q,'&',p
  end.
case. do.
  p=. ''
end.
cgiparms1 p
)

NB.=====================================================================
NB.*cgiparms1 v parse cgi parameters (called from cgiparms)
cgiparms1=: 3 : 0
y=. <;._1 '&',' ' (I. y = '+') } y
ndx=. y i.&> '='
nms=. ndx {. each y
val=. (ndx+1) }. each y
cgiparms2 each nms,.val
)

NB.=====================================================================
NB.*cgiparms2 v parse cgi parameters (called from cgiparms1)
cgiparms2=: 3 : 0
if. -. '%' e. y do. y return. end.
y=. <;._1 '%00', y
a=. '0123456789abcdef0123456789ABCDEF'
p=. a. {~ 16 #. 16 | a i. 2 {.&> y
}. ; p ,each 2 }.each y
)

NB.=====================================================================
NB.*evalparms v store cgi parameters in CGI locale
evalparms=: 3 : 0
p=. (>:@(=&'''') # ]) each cgiparms''
p=. (<'H'),"1(1{."1 p),"1(<'_CGI_=:'''),"1( 1}."1 p),"1(<'''')
". ;"1 p
# p
)

NB.=====================================================================
NB.*cleanstring v clean a string leaving only printable ASCII chars (32 to 126)
NB.+other chars are removed, or replaced with string x in dyadic case;
NB.+if x is boxed, only non-ASCII chars (128 to 255) are removed/replaced;
NB.+string length is preserved if 1=#>x
cleanstring=: 3 : 0
'' cleanstring y
:
if. 32=3!:0 x do.
  (,(<"0(_128{.a.)),.x)srr 7 u: y
else.
  (,(<"0(32{.a.),_129{.a.),.<x)srr 7 u: y
end.
)

NB.=====================================================================
NB. verb definitions for the dbj class
NB.=====================================================================

NB.=====================================================================
NB.*dbj v open a database, calling conew + create verb
NB.+y is the database name (a string, which is a directory name);
NB.+x is an optional field separator (default '|');
NB.+return the locative of the newly created database
dbj=: 3 : 0
DBS dbj y
:
if. IFQT*.(1=L.y) do.
  if. DBJ_dbj_ do.
    assert. 'a jqt GUI istance already active'
  end.
end.
if. IFJHS do.
  if. (2=DBE_dbj_)+.(3=DBE_dbj_) do. NB. dbj already loaded in console or android, and then switched to jhs
    coinsert 'jhs'
    try. require 'ide/jhs/jfilesrc convert/json' catch. assert. 'required addons: ide/jhs, convert/json' end.
    plotdef 'show';'dbjplot';800 600
    DBE_dbj_=: 2+DBE_dbj_
  end.
  if. 1=L.y do.
    if. 'jijx'-:4{.URL_jhs_ do.
      jhtml'<input type="button" value="click here to open ''',(>y),'''" onclick="window.open(''dbj?',(>y),''');">'
      return.
    end.
  end.
end.
db=. conew 'dbj'
x create__db y
)

NB.=====================================================================
NB.*create v open a database, being y (a string) the database name
NB.+y must be the name of a subdirectory of the dbj directory
NB.+under the J user directory; if the directory does not exist,
NB.+try to create it;
NB.+if present, x (a single character) is the field separator;
NB.+as monad, the default separator '|' is used;
NB.+create verb must be invoked before to open objects with k verb,
NB.+or to save objects with ksave, ksavej, kupdate;
NB.+if J operates in a windowed environment, and y (the database name)
NB.+is boxed, then dbjgui gui is initialized;
NB.+this verb should not be used directly: use dbj verb to open a database
create=: 3 : 0
DBS create y
:
DBB=: coname''
9!:1<.100x1**:{:6!:0''   NB. set new RNG seed
9!:7 '+++++++++|-'
9!:11 ] 10               NB. better print precision
if. a:-:y do. y=. <'db1' elseif. ''-:y do. y=. 'db1' end.
if. (0=#dir jpath '~user/dbj/',>y)*._2<4!:0 boxopen y do.  NB. local database does not exist and has a valid j name
  try.
    1!:5 < jpath '~user/dbj/',>y         NB. try to create new database directory
    DBL_dbj_=: (}:&.> #~ PATHJSEP_j_ = [: > {:&.>) {."1 (2 1) dir jpath '~user/dbj/'
  catch.
  end.
end.
if. (0<#dir jpath '~user/dbj/',>y)*.(1-:#x) do. NB. local database exists and there is a valid separator
  DBS=: x
  DBN=: >y
  DBF=: jpath '~user/dbj/',DBN
  dbjdir=. 1 dir DBF
  if. 0 < # dbjdir do.                   NB. read first row of each file
    DBD=: /:~ (0 {"1 (2 0) dir DBF) ,. (<@fread1"0 dbjdir) ,. <"0 fsize dbjdir
  else.
    DBD=: 0$,:'';'';''
  end.
  DBM=: jpath '~temp/',DBN,'.ijf'
  DBQ=: ,a:
  DBR=: (0 {"1 DBD) ,. a:
  if. DBC *. 0 = # dir DBM do. keycreate DBM end.
  DBN_dbj_=: DBN
  DBB_dbj_=: DBB
  if. (1=L.y)*.DBE>3 do.
    dbjgui 'kinfo _1'
  end.
else.
  assert. 'Cannot open Database'
end.
)

NB.=====================================================================
NB.*destroy v close a database, releasing resources
destroy=: 3 : 0
assert. DBB=coname''
DBN_dbj_=: ''
DBB_dbj_=: <''
codestroy''
)

NB.=====================================================================
NB.*closek v close a database, releasing resource
NB.+this is an alias for the destroy method 
closek=: destroy

NB.=====================================================================
NB.*k v return a database object, being y (a string) the object name
NB.+if the object is yet loaded (i.e. cached), it is immediately returned;
NB.+if the object exists, it is loaded by mean of krd verb;
NB.+the object y is yet loaded if there is a component in the dbj keyfile;
NB.+the object y exists if there is an entry in the DBD array;
NB.+if y is an empty string, the list of database objects is returned;
NB.+if y is not an object name, it is considered a command to be executed;
NB.+if y is not a string, it is returned as dbj dynaset (if possible);
NB.+the k verb keeps traces of recursive calls by mean of global variables;
NB.+the optional left argument has the following effect on output:
NB.+'' ==> (k y) [ kreset y
NB.+non-empty string (rank 1) ==> x kfilter k y
NB.+array of strings (rank 2) ==> apply sequence of verbs to k y
NB.+boxed list of strings;<boxed list of strings ==> (>{:x) kgroup (k y);>{.x
NB.+<boxed list of strings ==> (>x) kaddcol k y
NB.+<<boxed list of strings ==> (>>x) kboxcol k y
NB.+boxed string (rank 0) ==> x kfield k y
NB.+boxed list of strings (rank 1) ==> x kcol k y
NB.+boxed list of keys (rank 2) ==> (,x) krow k y
NB.+list of integers (rank 1) ==> x kyescol k y
NB.+list of integers (rank 2) ==> (,x) kyesrow k y
NB.+0 ==> convert all linked fields (those having a field type like 'type[othertable][otherfield]')
NB.+1 ==> kazsort k y
NB.+_1 ==> kzasort k y
NB.+_ ==> '' ktrans k y
NB.+__ ==> 'bifc' kunbox k y
NB.+a: (empty box) ==> 0 tbk k y
NB.+<a: (boxed empty box) ==> 1 tbk k y
NB.+symbols ==> parametric query: `0, `1, ... , `9 are replaced in y with symbols passed in x
k=: 3 : 0
assert. DBB=coname''
try.
  if. (2>#$y) *. 2=3!:0 y do.                   NB. y parameter is a string
    if. ''-:y do. 
      kinfo _                                   NB. list of database objects
      return.
    end.
    sel=. 0{"1 DBD                              NB. boxed list of the objects in the database
    if. ((<,y) e. sel) *. ((;:y)-:,<,y) *. _2<4!:0<,y do. NB. the object exists in database and has a valid J name
      if. DBC do.                               NB. use of cache
        chk=. (<,y) e. keydir DBM               NB. check if object exists in cache
        if. chk do.
          lsq=. > keyreadx DBM;,y               NB. read extra data from cache
          old=. (0 { lsq), 1 {"1 > 4 { lsq      NB. cached size of required files
          lsq=. (<,y), 0 {"1 > 4 { lsq          NB. list of required files
          siz=. (<(sel i. lsq);2) { DBD         NB. actual sizes of required files
          chk=. chk *. siz -: old               NB. check if sizes of required files are not changed
        else.
          lsq=. ,<,y                            NB. only this file is required
        end.
        for_req.                                NB. trace query scanning stack of recursive calls
          1 }. DBQ
        do.
          if. req e. keydir DBM do.
            new=. 0 {"1 > 4 { > keyreadx DBM;req
          else.
            new=. >(<(sel i. req),1) { DBR
          end.
          new=. ~. new , lsq
          DBR=: (<new) (<(sel i. req),1) } DBR
        end.
      else.                                     NB. do not use cache
        chk=. 0
      end.
      if. chk do.                               NB. object is yet loaded and can be read from cache
        > keyread DBM;,y                        NB. object is returned reading it from cache
      else.                                     NB. object is not yet loaded and must be read from file
        if. DBC do. DBQ=: DBQ,<,y end.          NB. add query object to queries stack
        dat=. krd y                             NB. object is loaded from text file
        if. DBC do. DBQ=: _1}.DBQ end.          NB. drop query object from queries stack
        testk dat                               NB. check if the object is a valid dbj dynaset
        if. DBC *. -.']]'-:2{.y lookup 2{."1 DBD do. NB. cache is enabled and object is not a special query starting with ']]'
          (<dat) keywrite DBM;,y                NB. object is stored in keyfile
          lsq=. >(<(sel i. <,y),1) { DBR
          siz=. (<(sel i. lsq);2) { DBD
          (<(((<(sel i.<,y),2) { DBD),((1{$dat);(#>0{_1{dat); 7!:5 <'dat'),<lsq,.siz)) keywritex DBM;,y NB. size of file, number of fields, number of records, memory occupation and required files (with sizes) are stored as extra data
        end.
        dat                                     NB. object is returned
      end.
    else.                                       NB. a command is provided
      testk y=. ". y                            NB. try to execute the command
      y
    end.
  else.                                         NB. y parameter is not a string
    select. <3!:0 y                             NB. detect type
    case. 2;65536;131072 do.
      kstring ":y
    case. 32 do.
      if. 2=#$y do.
        try.
          testk y
          y                                     NB. the object is yet a dbj dynaset
        catch.
          kstring y
        end.
      else.
        if. 0=#$y do.
          ktable tostring>y                     NB. the object is a single box (rank=0) holding a string which defines a table
        else.
          kstring y
        end.
      end.
    case. 1;4 do.
      if. 2=#$y do.
        karray y
      else.
        kint y
      end.
    case. 16 do.
      if. 2=#$y do.
        karray y
      else.
        kcomplex y
      end.
    case. do.
      if. 2=#$y do.
        karray y
      else.
        kfloat y
      end.
    end.
  end.
catch.                                          NB. some error has occurred
  assert. 'Error executing query'
end.
:
if. x-:0 do.                                    NB. ex kconv verb
  y=. k y
  names=. namesk y
  hdr=. typesk y
  lnk=. I. 0 < _1 { |: (,: '][') ss '][' ,"1 > hdr
  lst=. 0{"1 DBD
  str=. 0$a:
  for_n.
    lnk
  do.
    typ=. > n { hdr
    sel=. '[' ss typ
    f1=. > n { names                            NB. field to be converted
    db2=. (_2 - -/ sel) {. (>: 0 {sel) }. typ   NB. linked table
    if. (<,db2) e. lst do.
      f2=. _1 }. (>: 1 {sel) }. typ             NB. linked field
      str=. str , < f1,'=. (''',db2,''';''',f2,''') iconv ',f1 NB. conversion
    else.
      str=. str , < f1,'=. ',f1                 NB. just remove link
    end.
  end.
  str kaddcol y
elseif. x-:1 do.
  kazsort k y
elseif. x-:_1 do.
  kzasort k y
elseif. x-:_ do.
  '' ktrans k y
elseif. x-:__ do.
  'bifc' kunbox k y
elseif. x-:'' do.
  (k y) [ kreset y
elseif. x-:a: do.
  ".'0 tbk k''',y,''''
elseif. x-:<a: do.
  ".'1 tbk k''',y,''''
elseif. (2-:3!:0 x) *. 1-:#$ x do.
  x kfilter k y
elseif. (2-:3!:0 x) *. 2-:#$ x do.
  ". ,&'k y' icatstr ('('&,)@:(,&')@:')@:dtb"1 x
elseif. (2-:L. x) *. 2-:# x do.
  (>{:x) kgroup (k y);>{.x
elseif. (2-:L. x) *. 1-:# x do.
  (>x) kaddcol k y
elseif. (3-:L. x) *. 1-:# x do.
  (>>x) kboxcol k y
elseif. (1-:L. x) *. 0-:#$ x do.
  x kfield k y
elseif. (1-:L. x) *. 1-:#$ x do.
  x kcol k y
elseif. (1-:L. x) *. 2-:#$ x do.
  (,x) krow k y
elseif. (4>:3!:0 x) *. 1-:#$ x do.
  x kyescol k y
elseif. (4>:3!:0 x) *. 2-:#$ x do.
  (,x) kyesrow k y
elseif. (65536=3!:0 x) *. (2>#$y) *. 2=3!:0 y do. NB. parametric query
  assert. DBB=coname''
  try.
    sel=. 0{"1 DBD
    if. ((<,y) e. sel) *. ((;:y)-:,<,y) *. _2<4!:0<,y do.
      dat=. x krd y
      testk dat
      dat
    else.
      testk y=. ". ((,.'`'&,@:": each i.10) ,. 10{.s:^:_1 x) srr y
      y
    end.
  catch.
    assert. 'Error executing query'
  end.
elseif. do.
  k y
end.
)



NB.=====================================================================
NB.*ka a adverb to get an object of active database
NB.+example 'objectname'ka
NB.+note that (k'objectname')-:('objectname'ka)
ka=: 1 : 'k m'

NB.=====================================================================
NB.*tk v return as text the content of the file defining an object
tk=: 3 : 0
assert. DBB=coname''
sel=. 0{"1 DBD                                   NB. boxed list of the objects in the database
if. ((<(sel i. <,y),1) { DBD) e. '(t)';'(q)' do. NB. encrypted file
  decrypt frombase64 4 }. fread DBF,'/',y        NB. reads and decrypts file y
else.                                            NB. text file
  freads DBF,'/',y
end.
)

NB.=====================================================================
NB.*krd v read a text file returning a dbj dynaset, eventually executing a dbj query
NB.+right argument must be the name of the object to read;
NB.+if the corresponding file contains a table, it is loaded;
NB.+if the sorresponding file contains a query, it is evaluated;
NB.+dyadic version is used only for parametric query (see k verb);
NB.+working also with encrypted files
krd=: 3 : 0
''krd y
:
assert. DBB=coname''
sel=. 0{"1 DBD                             NB. boxed list of the objects in the database
dbfile=. DBF,'/',y                         NB. pathname of the file
if. ((<(sel i. <,y),1) { DBD) e. '(t)';'(q)' do. NB. encrypted file
  y=. decrypt frombase64 4 }. fread dbfile NB. reads and decrypts file y
else.                                      NB. plain text file
  y=. freads dbfile                        NB. reads file (as text, converting CRLF to LF) in a single string
end.
if. -.''-:x do.                            NB. parametric query
  y=. ((,.'`'&,@:": each i.10) ,. 10{.s:^:_1 x) srr y
end.
if. ']' -: 0 { y do.                       NB. this is a query, because starts with ']'
  y=. 'kquery=. 3 : 0',LF,(1 }. ,&LF^:(LF~:{:) y),')' NB. dynamic definition of kquery verb
  0!:0 y                                   NB. the kquery verb is loaded as script
  kquery''                                 NB. the kquery verb is executed
else.                                      NB. this is a table
  DBS ktable y                             NB. transformation from string to dbj table
end.
)

NB.=====================================================================
NB.*ksave v save a dbj dynaset or a query string x as object y in a text file
NB.+y is the file name (a string) of the object to be saved
NB.+in the active database;
NB.+the DBD entry and the dbj keyfile are updated;
NB.+x must be a valid dbj dynaset or a valid query string
NB.+(']' is automatically prefixed to queries)
ksave=: 4 : 0
assert. DBB=coname''
sel=. 0{"1 DBD                                 NB. boxed list of the objects in the database
dbfile=. DBF,'/',y                             NB. pathname of the file to save
if. 2=#testk :: 0: x do.                       NB. save table
  for_n.
    I. (<'()') = ({.@}. , {:) each typesk x    NB. indexes of calculated fields
  do.
    x=. a:(<1,n)}x                             NB. erase calculated fields
  end.
  (DBS printk x) fwrite dbfile                 NB. the boxed array is converted into a string and saved in the text file
else.                                          NB. save query
  (']',tostring x) fwrite dbfile               NB. the query string is saved in the text file (with ']' prefix)
end.
DBD=: ((<,y) i. sel) # DBD                     NB. removes previous entry in DBD (if any)
DBD=: /:~ DBD,y;(,fread1 dbfile);fsize <dbfile NB. updates entry in DBD array (first row and size of file)
if. DBC do.
  DBR=: (0 {"1 DBD) ,. a:
  keydrop DBM;,y                               NB. erases object in the dbj keyfile
end.
kinfo y                                        NB. returns a table with info about saved object
)

NB.=====================================================================
NB.*ksavej v save a dbj dynaset or a query string x as object y in an encrypted file
NB.+y is the file name (a string) of the object to be saved in the active database;
NB.+tables are prefixed with ('(t)',LF) queries with ('(q)',LF);
NB.+the DBD entry and the dbj keyfile are updated;
NB.+x must be a valid dbj dynaset or a valid query string
ksavej=: 4 : 0
assert. DBB=coname''
sel=. 0{"1 DBD                                 NB. boxed list of the objects in the database
dbfile=. DBF,'/',y                             NB. pathname of the file to save
if. 2=#testk :: 0: x do.                       NB. save table
  for_n.
    I. (<'()') = ({.@}. , {:) each typesk x    NB. indexes of calculated fields
  do.
    x=. a:(<1,n)}x                             NB. erase calculated fields
  end.
  id=. '(t)'
  (id,LF,tobase64 encrypt DBS printk x) fwrite dbfile NB. the boxed array is converted into a string and saved in the encrypted file
else.                                          NB. save query
  id=. '(q)'
  (id,LF,tobase64 encrypt ']',tostring x) fwrite dbfile NB. the query string is saved in the encrypted file (with ']' prefix)
end.
DBD=: ((<,y) i. sel) # DBD                     NB. removes previous entry in DBD (if any)
DBD=: /:~ DBD,y;id;fsize <dbfile               NB. updates entry in DBD array (first row and size of file)
if. DBC do.
  DBR=: (0 {"1 DBD) ,. a:
  keydrop DBM;,y                               NB. erases object in the dbj keyfile
end.
kinfo y                                        NB. returns a table with info about saved object
)

NB.=====================================================================
NB.*kupdate v update an object y appending records of dbj dynaset x
NB.+similar to ksave, but the records of x are just appended to
NB.+the text file (so, be careful to append consistent records);
NB.+y is the file name (a string) of the object to be saved, and
NB.+must be an existing table, already saved in text format;
NB.+the DBD entry and the dbj keyfile are updated;
NB.+x must be a valid dbj dynaset
kupdate=: 4 : 0
assert. DBB=coname''
sel=. 0{"1 DBD                                 NB. boxed list of the objects in the database
if. ((<,y) e. sel) *. 2=#testk :: 0: x do.     NB. y is a table already existing in the database and x is a valid dynaset
  for_n.
    I. (<'()') = ({.@}. , {:) each typesk x    NB. indexes of calculated fields
  do.
    x=. a:(<1,n)}x                             NB. erase calculated fields
  end.
  if. (}:DBS printk krow x)-:(,y) lookup 2{."1 DBD do.  NB. x must have the same head of table y
    dbfile=. DBF,'/',y                         NB. pathname of the file to save
    (DBS rowk x) fappend dbfile                NB. the boxed array is converted into a string and appended to the text file
    DBD=: ((<,y) i. sel) # DBD                 NB. removes previous entry in DBD (if any)
    DBD=: /:~ DBD,y;(,fread1 dbfile);fsize <dbfile  NB. updates entry in DBD array (first row and size of file)
    if. DBC do.
      DBR=: (0 {"1 DBD) ,. a:
      keydrop DBM;,y                           NB. erases object in the dbj keyfile
    end.
    kinfo y                                    NB. returns a table with info about saved object
  else.
    assert. 'Updating of not consistent table not allowed'
  end.
else.
  assert. 'Updating of not exixting object not allowed'
end.
)

NB.=====================================================================
NB.*kdel v delete an object y of the active database
NB.+y is the file name (a string) of the object to be deleted
NB.+in the database actually active;
NB.+the DBD entry is removed
kdel=: 3 : 0
assert. DBB=coname''
sel=. 0{"1 DBD                                 NB. boxed list of the objects in the database
if. (<y) e. sel do.
  dbfile=. DBF,'/',y                           NB. pathname of the file to save
  1!:55 <dbfile                                NB. erases file
  DBD=: ((<,y) i. sel) # DBD                   NB. removes previous entry in DBD (if any)
  if. DBC do.
    DBR=: (0 {"1 DBD) ,. a:
    keydrop DBM;,y                             NB. erases object in the dbj keyfile
  end.
end.
kinfo y                                        NB. should return an empty table
)

NB.=====================================================================
NB.*kreset v unload objects from cache of the active database
NB.+erase the y object(s) in the dbj keyfile and update the DBD entry;
NB.+y is a string (the object to be unloaded) or a boxed list of strings;
NB.+if y=0 unload all tables;
NB.+if y=1 unload all queries;
NB.+if y=_ unload all objects;
NB.+as dyad, if x is not an empty string, the above objects are then reloaded;
NB.+if y-:'' re-create the dbj keyfile and update all the DBD boxed array
kreset=: 3 : 0
''kreset y
:
assert. DBB=coname''
if. ''-:y do.
  dbjdir=. 1 dir DBF                           NB. read again first row of each file
  if. 0 < # dbjdir do.                         NB. read first row of each file
    DBD=: /:~ (0 {"1 (2 0) dir DBF) ,. (<@fread1"0 dbjdir) ,. <"0 fsize dbjdir
  else.
    DBD=: 0$,:'';'';''
  end.
  if. DBC do.
    DBR=: (0 {"1 DBD) ,. a:
    keycreate DBM                              NB. erase dbj keyfile and create a new one
  end.
  kinfo''                                      NB. return updated info
else.
  sel=. 0{"1 DBD                               NB. boxed list of all objects in the database
  if. 0-:y do.
    y=. (-.;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # sel NB. boxed list of tables
  elseif. 1-:y do.
    y=. (;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # sel   NB. boxed list of queries
  elseif. _-:y do.
    y=. sel
  elseif. do.
    y=. (sel e. ,each boxopen y)#sel
  end.
  for_z. y do.
    dbfile=. DBF,'/',>z                        NB. pathname of the file
    DBD=: (z i. sel) # DBD                     NB. removes previous entry in DBD (if any)
    DBD=: /:~ DBD,(>z);(,fread1 dbfile);fsize <dbfile NB. updates entry in DBD array (first row and size of file)
    if. DBC do.
      DBR=: (0 {"1 DBD) ,. a:
      keydrop DBM;z                            NB. erases object in the dbj keyfile
    end.
  end.
  if. -.''-:x do.                              NB. reloads objects
    for_z. y do.
      k >z
    end.
  end.
  kinfo y                                      NB. returns a table with info about unloaded object
end.
)

NB.=====================================================================
NB.*iconv v convert a field of an inverded table in the active database
NB.+usage: ('db2';'f2') iconv f1
NB.+f1 is a the array of values (in field format) to be converted;
NB.+db2 and f2 are strings containing the name of the object and field
NB.+of the converted values; db2 can be also a boxed array (the object);
NB.+the array of converted values (in field format) is returned;
NB.+element without corrispondence are converted in '' (string) or 0 (number)
iconv=: 4 : 0
y=. ifrm y
f=. 1{x
x=. k >0{x
x=. f kcol x
x=. ((tostring y) kaddrow krow x) kud x
x=. (,&'' each _1{x) _1}x
>_1{ y irow x
)

NB.=====================================================================
NB.*infok v provide information about an object in the active database
NB.+the result is a boxed list with 4 elements: number of fields,
NB.+number of records, memory occupation, list of dependencies;
NB.+information is available only if object is loaded in memory (cached);
NB.+y must be a (boxed) string holding the object name
infok=: 3 : 0
y=. boxopen y
_1;_1;_1;''
if. DBC do.
  if. y e. keydir DBM do. 
    dat=. > keyreadx DBM;y
    (1 2 3 { dat),< ": ;:^:_1 ] 0 {"1 > 4 { dat
  end.
end.
)

NB.=====================================================================
NB.*kinfo v return a dbj dynaset with info about the objects in the active database
NB.+the output table has 8 fields: the object name, the first row of file, the size of file,
NB.+the type (0 for table, 1 for query), the number of fields, the number of records, 
NB.+the memory allocated for the object, the list of dependencies;
NB.+last 4 fields are (_1;_1;_1;'') if the object is not loaded in memory (cached);
NB.+if y-:'' all objects are listed;
NB.+if y-:0 only tables are listed;
NB.+if y-:1 only queries are listed;
NB.+if y-:_1 only main columns are selected;
NB.+if y-:_ only first column is selected;
NB.+if y-:__ the first column and the query call for each object is displayed;
NB.+in other cass, the object(s) selected by y is listed
kinfo=: 3 : 0
assert. DBB=coname''
dat=. kfb`kfbcheck@.(1=#) ('OBJECT';'FIRSTROW';'SIZE:i';'QUERY:i';'NFIELD:i';'NREC:i';'MEMORY:f';'DEPEND'),(DBD,.(']'&=@{. +. '(q)'&-:) each 1{"1 DBD) ,"1 infok"0 (0 {"1 DBD)
if. y-:'' do.
  dat
elseif. y-:_ do.
  kcol dat
elseif. y-:0 do.
  '-.QUERY' kfilter dat
elseif. y-:1 do.
  'QUERY' kfilter dat
elseif. y-:_1 do.
  ('OBJECT';'SIZE';'QUERY';'MEMORY') kcol dat
elseif. y-:__ do.
  ('CALL' kcol 'CALL=. ''k''&,@:quote@:dtb"1 OBJECT' kaddcol '-.QUERY' kfilter dat) kud 'CALL' kcol 'CALL=. (_1&}.^:(LF = _1&{))@:tk@:dtb"1 OBJECT' kaddcol 'QUERY' kfilter dat
elseif. do.
  y krow dat
end.
)

NB.=====================================================================
NB.*kaddcol v add column(s) (field(s) x) to a dbj dynaset (y)
NB.+x can be a string like 'NEWFIELD=. someverb EXISTINGFIELD',
NB.+or a boxed list of strings like this.
NB.+NEWFIELD can be defined as a numeric vector or a string matrix
NB.+or a boxed list, or a single number or a single string;
NB.+if NEWFIELD is an existing field name, that field is replaced (amended in place);
NB.+to delete a field, use kdelcol verb;
NB.+kaddcol cannot be used to add boxed fields (use kboxcol for this);
NB.+without left argument, an empty string field is added with a default name
kaddcol=: 3 : 0
new=. 'F' , (' ';'0') sr 3j0 ": >:<.>_1{/:~  toint each 1&}. each namesk y  NB. next free integer
(new,'=. ''''') kaddcol y
:
names=. namesk y                             NB. list of field names
sel=. _2<4!:0]names                          NB. fields with valid J names
(sel # names)=. sel # _1{y                   NB. evaluate each field as an array
x=. , (<@":) ` (":&.>) @. (0 < L.) x         NB. check that x is one or more boxed string
for_h.
  x
do.
  j=. ,>h
  if. 0=# '=.' ss j do. j=. j,'=.''''' end.
  new=. , dltb (1 {. '=.' ss j) {. j         NB. extract new field name
  if. _2<4!:0<new do.                        NB. new field name is a valid J name
    field=. ". dltb (2+1{. '=.' ss j) }. j   NB. evaluate new field
    field=. ifrm field                       NB. format as field of dbj dynaset
    select. <3!:0 field                      NB. detect field type
    case. 2 do.
      type=. ''
    case. 16 do.
      type=. ':c'
    case. 1;4 do.
      type=. ':i'
    case. do.
      type=. ':f'
    end.
    n=. #>0{_1{y                             NB. number of records
    (<new)=. n $ field                       NB. set to n the number of elements
    m=. names i. <new                        NB. check if new field is an existing field
    if. m<1{$y do.                           NB. NEWFIELD is an existing field
      y=. ((new,type);".new) (<(0 1);m)} y   NB. table is amended without add a column
    else.                                    NB. NEWFIELD is really new
      y=. y ,. (new,type);".new              NB. a new column is added on the right
    end.
    names=. namesk y                         NB. updated list of field names
    if. 0=m do.                              NB. NEWFIELD is the key field (check against duplicated keys)
      y=. kclnrow y
    else.
      y
    end.
  else.
    y
  end.
end.
)

NB.=====================================================================
NB.*kaddkey v add a new numeric key column to a dbj dynaset
NB.+x is an optional key field name (default 'N')
kaddkey=: 3 : 0
'N' kaddkey y
:
(x kint i.#>0{_1{y) klr y 
)

NB.=====================================================================
NB.*kboxcol v add boxed column(s) (field(s) x) to a dbj dynaset (y)
NB.+like kaddcol, but added fields are boxed (if they hold strings) 
NB.+without left argument, an empty boxed field is added with a default name
kboxcol=: 3 : 0
new=. 'F' , (' ';'0') sr 3j0 ": >:<.>_1{/:~  toint each 1&}. each namesk y  NB. next free integer
(new,'=. ''''') kboxcol y
:
names=. namesk y                             NB. list of field names
sel=. _2<4!:0]names                          NB. fields with valid J names
(sel # names)=. sel # _1{y                   NB. evaluate each field as an array
x=. , (<@":) ` (":&.>) @. (0 < L.) x         NB. check that x is one or more boxed string
for_h.
  x
do.
  j=. ,>h
  if. 0=# '=.' ss j do. j=. j,'=.''''' end.
  new=. , dltb (1 {. '=.' ss j) {. j         NB. extract new field name
  if. _2<4!:0<new do.                        NB. new field name is a valid J name
    field=. ". dltb (2+1{. '=.' ss j) }. j   NB. evaluate new field
    field=. ibox field                       NB. format as field of dbj dynaset (but strings are boxed)
    select. <3!:0 field                      NB. detect field type
    case. 32 do.
      type=. ':b'
    case. 1;4 do.
      type=. ':i'
    case. 16 do.
      type=. ':c'
    case. do.
      type=. ':f'
    end.
    n=. #>0{_1{y                             NB. number of records
    (<new)=. n $ field                       NB. set to n the number of elements
    m=. names i. <new                        NB. check if new field is an existing field
    if. m<1{$y do.                           NB. NEWFIELD is an existing field
      y=. ((<new,type),<".new) (<(0 1);m)} y NB. table is amended without add a column
    else.                                    NB. NEWFIELD is really new
      y=. y ,. (<,new,type),<".new           NB. a new column is added on the right
    end.
    names=. namesk y                         NB. updated list of field names
    if. 0=m do.                              NB. NEWFIELD is the key field (check against duplicated keys)
      y=. kclnrow y
    else.
      y
    end.
  else.
    y
  end.
end.
)

NB.=====================================================================
NB.*kfbcheck v transform a table in dbj from boxed format, and check field types
NB.+each atom of input table must be a boxed string;
NB.+output table is checked against empty keys/field names,
NB.+but not checked against duplicated keys/field names (see kcln)
kfbcheck=: 3 : 0
y=. checkrow@:checkcol y            NB. check against empty field names and keys
h=. 1{.y                            NB. table head (first row)
s=. typesk h
h=. krename ,: (namesk h) bcat ':' bcat s  NB. cleaned head
r=. namesk h
t=. typek h
y=. 1}.y                            NB. table body (all except first row)
m=. #y                              NB. number of records
for_n.                              NB. converts strings into boxed strings if key field type is 'boxed'
  boxs=. I. t e.<'boxed'
do.
  y=. (< each n{"1 y) (<(i.#y);n)}y
end.
y=. ifb y                           NB. transform table body in inverted table
for_n.                              NB. converts strings into boxed strings if key field type is 'boxed'
  boxs
do.
  if. 0=m do.
    y=. (<0 1$<'') n}y
  end.
end.
for_n.                              NB. converts strings into complexes if field type is 'complex'
  cmps=. I. t e.<'complex'
do.
  if. 0=m do.
    y=. (<0 1$0j1) n}y
  else.
    y=. (tocomplex"1 each n{y) n}y
  end.
end.
  
for_n.                              NB. converts strings into floats if field type is 'float'
  flts=. I. t e.<'float'
do.
  if. 0=m do.
    y=. (<0 1$0.1) n}y
  else.
    y=. (tofloat"1 each n{y) n}y
  end.
end.
for_n.                              NB. converts strings into integers if field type is 'int'
  ints=. I. t e.<'int'
do.
  if. 0=m do.
    y=. (<0 1$2) n}y
  else.
    y=. (toint"1 each n{y) n}y
  end.
end.
for_n.                              NB. converts to strings if field type is 'string' 
  strs=. I. t e.<'string'
do.
  if. 0=m do.
    y=. (<0 0$'a') n}y
NB.+ else.
NB.+   y=. (tostring"1 each n{y) n}y   NB. not required because we already have just strings
  end.
end.
y=. h,y
for_n.                              NB. evaluates calculated fields
  calc=. I. (<'()') = ({.@}. , {:) each s  NB. indexes of calculated fields
do.
  y=. ". (quote(>n{r),'=. ',}.>n{s),' kaddcol y'
  y=. ". (quote >n{r),' kto',(>n{t),' y'
  y=. ((<0,n){h) (<0,n)}y
end.
)

NB.=====================================================================
NB.*ktable v transform a single string in a dbj table
NB.+the string is normally the content of a dbj file holding a table in text format;
NB.+as dyad, left argument (a single character) is used as separator;
NB.+as monad, the default separator '|' is used
ktable=: 3 : 0
DBS ktable y
:
flag=. 0 < # '\' ss y                    NB. checks if unescape could be necessary 
z=. (] {.~ LF i.~ ]) y                   NB. first row
z=. (] {.~ x i.~ ]) z,x                  NB. first field
w=. (] }.~ [: >: ':' i.~ ]) z            NB. first type definition
auto=. isint w                           NB. auto-index
if. auto do.
  z=. (] {.~ ':' i.~ ]) z                NB. key field name
  w=. 0{toint w                          NB. first key value
  y=. (LF;LF,x)sr y                      NB. make room for keys
end.
y=. x&chopdb ;._2 y,LF                   NB. separates rows with LF and cuts each record calling chopdb
if. auto do.
  y=. ((<z,':i') , ": each <"0 ,. w+i.<:#y) ,"1 }."1 y
end.
if. flag do. y=. x&unescape each y end.  NB. restores CR-LF-TAB and separators from escape sequences
kcln kfbcheck y                          NB. transformation from boxed to dbj format and final checks
)

NB.=====================================================================
NB.*kget v read a text file returning a dbj dynaset, eventually executing a dbj query
NB.+right argument must be the pathname of the file to read;
NB.+if the file contains a table, it is loaded;
NB.+if the file contains a query (i.e. starts with ']'), it is evaluated,
NB.+provided that it does not contain dbj class methods (like k verb);
NB.+as dyad, left argument (a single character) is used as separator;
NB.+as monad, the default separator '|' is used
kget=: 3 : 0
DBS kget y
:
z=. fread1 y                             NB. reads first line of file to identify type
if. ('(t)'-:3{.z)+.('(q)'-:3{.z) do.     NB. this is an encrypted file
  y=. decrypt frombase64 4 }. fread y    NB. reads and decrypts file y
else.
  y=. freads y                           NB. reads file y (as text, converting CRLF to LF) in a single string
end.
if. ']' -: 0 { y do.                     NB. this is a plain query, because starts with ']'
  y=. freads y                           NB. reads file y (as text, converting CRLF to LF) in a single string
  y=. 'kquery=. 3 : 0',LF,(1 }. ,&LF^:(LF~:{:) y),')' NB. dynamic definition of kquery verb
  0!:0 y                                 NB. the kquery verb is loaded as script
  kquery''                               NB. the kquery verb is executed
else.                                    NB. this is a plain table
  y=. freads y                           NB. reads file y (as text, converting CRLF to LF) in a single string
  x ktable y                             NB. transformation from string to dbj table
end.
)

NB.=====================================================================
NB.*kgetxls v read an Excel file returning a dbj dynaset
NB.+right argument must be the pathname of the file to read;
NB.+works with files previously written with writexls verb;
NB.+as monad, the first sheet of the worksheet is loaded;
NB.+as dyad, left parameter is a string holding the name of sheet to be loaded;
NB.+the tables/tara addon is required
kgetxls=: 3 : 0
kcln kfbcheck ": each readexcel y
:
n=. (readxlsheetnames y)i.<x
kcln kfbcheck ": each n readexcel y
)

NB.=====================================================================
NB.*writek v write a dbj dynaset to a dbj file
NB.+the default separator '|' is used;
NB.+to use a different separator sep the command is:
NB.+(sep printk db) fwrite file
writek=: 4 : 0
(printk x) fwrite y
)

NB.=====================================================================
NB.*appendk v append rows of a dbj dynaset to an existing dbj file
NB.+the default separator '|' is used;
NB.+no check is performed about consistence of appended rows with
NB.+the existing file;
NB.+to use a different separator sep the command is:
NB.+(sep rowk db) fappend file
appendk=: 4 : 0
(rowk x) fappend y
)

NB.=====================================================================
NB.*printk v output a dbj dynaset as single string in the "file" format
NB.+formats each field as string without LF, adds separator x to each field,
NB.+adds LF to each row, tranforms the boxed array in a single string, 
NB.+as monad, the default separator '|' is used
printk=: 3 : 0
DBS printk y
:
y=. ,@:> each bfk y
if. 1 e. ,> (x,CR,LF,TAB,'\')&e.  each }.y do.
  ; (<@(,&LF)@}:@;)"1 (,&x)@:((x&escape)@:frmt) each y
else.
  ; (<@(,&LF)@}:@;)"1 (,&x)@:frmt each y
end.
)

NB.=====================================================================
NB.*rowk v output body of a dbj dynaset as single string in the "file" format
NB.+like printk, but the first row (table head) is suppressed;
NB.+to output just a selection of rows use the command:
NB.+sep rowk sel krow db
NB.+as monad, the default separator '|' is used
rowk=: 3 : 0
DBS rowk y
:
(] }.~ [: >: LF i.~ ]) x printk y
)

NB.=====================================================================
NB.*writexls v write a dbj dynaset to an Excel file
NB.+y is the name of the xls file to be written;
NB.+x is the dbj dynaset or ('sheet name';<dbj dynaset);
NB.+default sheet name is 'Sheet1';
NB.+complex and boxed fields are written as strings;
NB.+the tables/tara addon is required
writexls=: 4 : 0
if. (,2)-:$x do.
  'n x'=. x
else.
  n=. 'Sheet1'
end.
x=. (0{x) , 0&{^:(1 = #) each bfi _1{ 'bc' kunbox x
(n;<x) writexlsheets y
)

NB.=====================================================================
NB.*kfind v find records in a dbj file, mapping the file instead of loading it
NB.+x are the keys to search and must be a single string, where the last character is used 
NB.+as fret and it is also the field separator, or a string array or a boxed list of keys;
NB.+if the field separator is not indicated in x, the default separator '|' is used;
NB.+y is the file path (must be a dbj table saved as text file);
NB.+as monad, just the head with an empty body is returned
kfind=: 3 : 0
a: kfind y
:
sep=. DBS
if. 0=L.x do.
  if. 1<#@$ x do.
    x=. <@:dtb@:tostring"1 istr x
  else.
    if. 2=3!:0 x do.
      sep=. {:x
      x=. <;._2 ": x
    else.
      x=. tostring each ,x
    end.
  end.
else.
  x=. tostring each ,x
end.
JCHAR map_jmf_ 'f_dbj_';y                 NB. map file to noun f
try.
  y=. CR-.~((] {.~ LF i.~ ])f_dbj_),LF    NB. first row of file
  for_n. x do.
    p=. >: {: (LF,(>n),sep) I.@:E. f_dbj_ NB. find last key position
    if. p>1 do.
      p=. CR-.~p(}. {.~ LF i.~ }.)f_dbj_  NB. extract record from key to LF
      y=. y,p,LF
    end.
  end.
catch.
end.
unmap_jmf_ 'f_dbj_'
sep ktable y
)

NB.=====================================================================
NB.*ksearch v full text search of a string in a dbj file, mapping the file instead of loading it
NB.+x is the string to be searched, or a boxed pair (separator;stringtosearch);
NB.+y is the file path (must be a dbj table saved as text file);
NB.+if the field separator is not indicated in x, the default separator '|' is used;
ksearch=: 4 : 0
if. 0=L.x do.
  sep=. DBS
else.
  sep=. >{.,x
  x=. ":>{:,x
end.
JCHAR map_jmf_ 'f_dbj_';y                 NB. map file to noun f
try.
  y=. CR-.~((] {.~ LF i.~ ])f_dbj_),LF    NB. first row of file
  x=. (#y) (< # ]) x I.@:E. f_dbj_        NB. indexes of occurences of string (excluding first row)
  for_n. x do.
    p=. CR-.~n(([: >: LF i:~ {.) }. ] {.~ [ + LF i.~ }.)f_dbj_ NB. extract record from previous LF to next LF
    y=. y,p,LF
  end.
catch.
end.
unmap_jmf_ 'f_dbj_'
sep ktable y
)

NB.=====================================================================
NB.*namesk v cleaned version of the field names of a dbj dynaset (without field types)
namesk=: 3 : '(([: {. '':'' ss '':'' ,~ ]) {. '':'' ,~ ]) each 0{y'

NB.=====================================================================
NB.*typesk v cleaned version of the field types of a dbj dynaset (without field names)
NB.+the following operations are performed on the first row:
NB.+- remove field names and the ':' char
NB.+- add a leading 's' char where type is undefined
NB.+- change to 's' the first char where first char is not 's','b','i','f' or 'c'
NB.+- keep only the first char 's','b','i','f' or 'c' of the first word
NB.+- remove any additional information for the type of the key field
typesk=: 3 : '(0}~ [: 1&{.&.> 0 { ]) ([: (([: {. [: > [: {. ;:) , ] }.~ [: # [: > [: {. ;:) [: (''s''&(0}))^:([: -. (''s'';''b'';''i'';''f'';''c'') e.~ [: < {.) [: (''s''&,)^:(0=#) [: _1&}. ([: >: [: {. '':'' ss '':'' ,~ ]) }. '':'' ,~ ]) each 0{y'

NB.=====================================================================
NB.*typek v field types of a dbj dynaset (string-int-float-complex-boxed only)
typek=: 3 : '((''s'';''string'')&sr)@:((''b'';''boxed'')&sr)@:((''c'';''complex'')&sr)@:((''f'';''float'')&sr)@:((''i'';''int'')&sr)@:(1&{.) each typesk y'

NB.=====================================================================
NB.*ibody v return the body of a dbj dynaset, without the head
NB.+the result is an inverted table
ibody=: _1&{

NB.=====================================================================
NB.*headk v return the head of a dbj dynaset, without the body
headk=: 0&{

NB.=====================================================================
NB.*iyesrow v select by numeric indexes rows (records) of a dbj dynaset
NB.+x is an integer or a vector of integers;
NB.+only the table body is returned; duplicated rows are allowed
iyesrow=: 4 : 'dtb"1 each (<,x){ each _1{y'

NB.=====================================================================
NB.*iyescol v select by numeric indexes columns (fields) of a dbj dynaset
NB.+x is an integer or a vector of integers;
NB.+only the table body is returned; duplicated columns are allowed
iyescol=: 4 : '(,x){_1{y'

NB.=====================================================================
NB.*kyesrow v select by numeric indexes rows (records) of a dbj dynaset
NB.+x is an integer or a vector of integers;
NB.+the output is checked against duplicated rows
kyesrow=: 4 : '(1{.y) , dtb"1 each (<~.&.|.,x){ each _1{y'

NB.=====================================================================
NB.*kyescol v select by numeric indexes columns (fields) of a dbj dynaset
NB.+x is an integer or a vector of integers;
NB.+the first column (key field) is always preserved;
NB.+the output is checked against duplicated columns
kyescol=: 4 : '(~.&.|.0,x-.0){"1 y'

NB.=====================================================================
NB.*knotrow v unselect by numeric indexes rows (records) of a dbj dynaset
NB.+x is an integer or a vector of integers
knotrow=: 4 : '(1{.y) , dtb"1 each (<(i.#>0{_1{y)-.,x){ each _1{y'

NB.=====================================================================
NB.*knotcol v unselect by numeric indexes columns (fields) of a dbj dynaset
NB.+x is an integer or a vector of integers;
NB.+the first column (key field) is always preserved
knotcol=: 4 : '((i.1{$y)-.x-.0){"1 y'

NB.=====================================================================
NB.*kfirst v select first x records (default 100) of a dbj dynaset
kfirst=: 100&$: : (4 : '(i.x<.#>0{_1{y)kyesrow y')

NB.=====================================================================
NB.*klast v select last x records (default 100) of a dbj dynaset
klast=: 100&$: : (4 : '(|.->:i.x<.#>0{_1{y)kyesrow y')

NB.=====================================================================
NB.*kselrow v select consecutive records of a dbj dynaset
NB.+x must be an integer or a list of two integers;
NB.+0{x is the index of the starting record;
NB.+1{x is the number of records (default 100);
NB.+negative and infinite values are allowed for elements of x
NB.+(here, infinite means the number of records of the dynaset)
kselrow=: 3 : 0
0 100 kselrow y
:
z=. #>0{_1{y
if. 1=#x do.
  x=. x,100
end.
if. _=0{x do.
  x=. z 0}x
elseif. 0>0{x do.
  x=. (z+0{x)0}x
end.
if. _=1{x do.
  x=. z 1}x
elseif. 0>1{x do.
  x=. (+/x),-1{x
end. 
(I.(i.z)e.(0{x)+i.1{x) kyesrow y
)

NB.=====================================================================
NB.*indrow v return indexes of keys of a dbj dynaset
NB.+x is a boxed list of keys, or a numeric vector, or a string matrix
indrow=: 4 : ',((,each)`(<@:dtb"1)@.(2=3!:0)x) i.~ <@:dtb"1 >@(0&{)@(_1&{) y'

NB.=====================================================================
NB.*indcol v return indexes of field names of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix
indcol=: 4 : ',((,each)`(<@:dtb"1)@.(2=3!:0)x) i.~ namesk y'

NB.=====================================================================
NB.*kclnrow v select unique and non-empty values in first column 
NB.+(last value is the good one)
kclnrow=: 3 : '(1{.y) , (<@(~:&.|. *. 0 < #@dtb"1)@>@{. # each ]) _1{y'

NB.=====================================================================
NB.*kclncol v select unique values in first row
NB.+(last value is the good one)
kclncol=: 3 : '(~:&.|. namesk y) #"1 y'

NB.=====================================================================
NB.*kcln v apply kclncol and kclnrow to clean a dbj dynaset
kcln=: (3 : 'kclnrow kclncol y') : [:

NB.=====================================================================
NB.*irow v select by keys the rows (records) of a dbj dynaset
NB.+x is a boxed list of keys, or a numeric vector, or a string matrix;
NB.+non-existing keys are ignored;
NB.+as monad, return an empty record;
NB.+only the table body is returned
irow=: (3 : '(0$0) iyesrow y') : (4 : '(n-.m) iyesrow y [ n=. x indrow y [ m=. #>0{_1{y')

NB.=====================================================================
NB.*icol v select by names the columns (fields) of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+non-existing field names are ignored;
NB.+as monad, return just the key column;
NB.+only the table body is returned
icol=: (3 : '0 iyescol y') : (4 : '(n-.m) iyescol y [ n=. x indcol y [ m=. 1{$y')

NB.=====================================================================
NB.*ifield v select by name the unboxed content of a column (field) of a dbj dynaset
NB.+x is a boxed field name, or a string;
NB.+non-existing field names are ignored;
NB.+as monad, return the content of the key column
ifield=: (3 : '0&{@:> 0 iyescol y') : (4 : '0&{@:> x icol y')

NB.=====================================================================
NB.*krow v select by keys the records of a dbj dynaset
NB.+x is a boxed list of keys, or a numeric vector, or a string matrix;
NB.+non-existing keys are ignored;
NB.+the output is checked against duplicated rows;
NB.+as monad, return the table head with 0 records
krow=: (3 : '(0$0) kyesrow y') : (4 : '(n-.m) kyesrow y [ n=. x indrow y [ m=. #>0{_1{y')

NB.=====================================================================
NB.*kcol v select by names the fields of a dbj dynaset, preserving key field;
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+the first column (key field) is always preserved;
NB.+non-existing field names are ignored;
NB.+as monad, return the table with just the key column
kcol=: (3 : '1{."1 y') : (4 : '(n-.m) kyescol y [ n=. x indcol y [ m=. 1{$y')

NB.=====================================================================
NB.*kfield v select by names the fields of a dbj dynaset;
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+the resulting table can have less records, if the key column is changed;
NB.+non-existing field names can cause errors
kfield=: 4 : 'kclnrow n {"1 y [ n=. (x indcol y)-.m [ m=. 1{$y'

NB.=====================================================================
NB.*khead v return the first row (head of table y) of selected column(s) (field x)
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+non-existing field names can cause errors;
NB.+as monad returns the head of key field
khead=: (3 : 'krow kcol y') : (4 : 'krow x kfield y')

NB.=====================================================================
NB.*kdelrow v delete by keys the rows (records) of a dbj dynaset
NB.+x is a boxed list of keys, or a numeric vector, or a string matrix;
kdelrow=: 4 : '(x indrow y) knotrow y'

NB.=====================================================================
NB.*kdelcol v delete by names the columns (fields) of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+the first column (key field) is always preserved;
kdelcol=: 4 : '(x indcol y) knotcol y'

NB.=====================================================================
NB.*ks v evaluate a string to get a dbj dynaset, and return a slice of records
NB.+useful in the GUI to browse dynasets with many records;
NB.+y must be a string whose execution gives a dbj dynaset;
NB.+if y is an empty string, it is assumed to be the same of last ks call,
NB.+and it is not executed again; string and dynaset are stored in DBP and DBW;
NB.+x must be an integer or a list of two integers, like in kselrow verb;
NB.+positive/negative values of 1{x select forward/backward browsing;
NB.+in monadic case, or if x is an empty string, the next (or previous) slice of
NB.+the dynaset is returned; slice start and size are stored in DBO (default 0 100);
NB.+examples:
NB.+ks 'kint i.1000' NB. records from 0 to 99 (first slice of size 100)
NB.+ks ''            NB. records from 100 to 99 (next slice of size 100)
NB.+_ _50 ks ''      NB. records from 950 to 999 (last slice of size 50)
NB.+ks ''            NB. records from 900 to 949 (previous slice of size 50)
NB.+0 _ ks ''        NB. records from 0 to 999 (all records)
ks=: 3 : 0
'' ks y
:
if. ''-:y do.
  z=. {.testk DBW
  if. ''-:x do.
    DBO=: (+/DBO)0}DBO
  end.
else.
  DBP=: y
  z=. {.testk DBW=: ".DBP
  if. ''-:x do.
    DBO=: 0 100
  end.
end.
if. -.''-:x do.
  if. 1=#x do.
    x=. x,100
  end.
  if. _=0{x do.
    x=. z 0}x
  elseif. 0>0{x do.
    x=. (z+0{x)0}x
  end.
  if. _=1{x do.
    x=. z 1}x
  elseif. 0>1{x do.
    x=. (+/x)0}x
  end.
  DBO=: x
end.
(I.(i.z)e.(0{DBO)+i.|1{DBO) kyesrow DBW
)

NB.=====================================================================
NB.*kaddrow v add row(s) (record(s) x) to a dbj dynaset (y)
NB.+x must be a string with '|' as field separator and LF as record separator,
NB.+or a boxed list representing a single record,
NB.+or a boxed array representing several records; 
NB.+if a new record has an existing key, the corresponding record is updated;
NB.+to delete a record, use kdelrow verb;
NB.+without left argument, an empty record is added with a default key
kaddrow=: 3 : 0
h=. 1{.y
if. ('int'-:>0{typek h)+.('float'-:>0{typek h)+.('complex'-:>0{typek h) do.
  if. 0<#>0{_1{y do.
    new=. ,":>:<.>./{.@:+."0>0{_1{y  NB. next free integer
  else.
    new=. ,'0'
  end.
else.
  if. 0<#>0{_1{y do.
    new=. 'K',(' ';'0') sr 5j0 ": >:<.>./ toint@(1&}.)"1 >0{_1{y  NB. next free integer
  else.
    new=. 'K00000'
  end.
end.
dat=. ,&'' each h, chopdb new
dat=. kfbcheck dat
kclnrow h,(_1{y),each _1{dat
:
if. 32 = 3!:0 x do.
  x=. ": each x
else.
  x=. chopdb ;._2 (": x),LF
end.
h=. 1{.y
dat=. ,&'' each h,x
dat=. kfbcheck dat
if. 0<#>0{_1{dat do.
  kclnrow h,(_1{y),each _1{dat
else.
  y
end.
)

NB.=====================================================================
NB.*kfilter v apply a filter (condition x) to a dbj dynaset (y)
NB.+the filter must be a string like '(''value'') ieq FIELD1', or 'FIELD1 > 100',
NB.+or 'FIELD1 ieq FIELD2': the result must be a boolean vector
kfilter=: 4 : 0
if. 0<#>0{_1{y do.
  names=. namesk y               NB. list of field names
  sel=. _2<4!:0]names            NB. fields with valid J names
  (sel # names)=. sel # _1{y     NB. evaluate each field as an array
  n=. ,".":x
  (I.n) kyesrow y
else.
  y                              NB. no records
end.
)

NB.=====================================================================
NB.*klocate v search a value (x) anywhere in a dbj dynaset (y)
NB.+if x is boxed, all cells holding any of the boxed values are searched;
NB.+if x is an unboxed string, a full text search is perfomed for that string;
NB.+all matching records are returned
klocate=: 4 : 0
if. 1=L.x do.
  n=. (#>0{_1{y) $ 0
  for_j. ,x do.
    n=. n +. +./ > (>j)&ieq each _1{y
  end.
else.
  n=. +./ > (tostring x)&iss@:(tostring"1) each _1{y
end.
(I.n) kyesrow y
)

NB.=====================================================================
NB.*krename v rename column(s) (as specified in x) of a dbj dynaset (y)
NB.+x must be a string with form 'oldname1|newname1|oldname2|newname2...'
NB.+or a boxed list ('oldname1';'newname1';'oldname2';'newname2'...);
NB.+the operation is performed only if there are not duplicated field names;
NB.+as monad, convert field names in valid J names (substituting invalid characters)
krename=: 3 : 0
sub=. (<"0]35 2$' Z!A"B#C$D%E&F''G(H)I*J+K,L-M.N/O:P;Q<R=S>T?U@V[a\b]c^d`f{g|h}i~j',CR,'n',LF,'l',TAB,'m'),('__';'ee')
new=. (('k'&,)^:('0123456789' e.~ {.))@:(sub&srr)@:((,&'W')^:('_'=_1&{)) each namesk y
new=.  (<"1(;(_2=[:4!:0<)each new),.i.#new){new,:'X'&,@:":each i.#new
((namesk y) ,. new) krename y
:
if. 32 = 3!:0 x do.                          NB. boxed
  sel=. , each ,x
elseif. 2 = 3!:0 x do.                       NB. string
  sel=. <;._2 x,'|'
end.
sel=. dltb each sel
if. (0<#,sel)*.(0=2|#,sel)*.-. _2 e. 4!:0 {:|: _2 ,\ sel do. NB. selection exists and has even number of elements with valid J names
  sel=. ~. sel boxreplace namesk y
  if. (#sel)=#namesk y do.                   NB. no loss of columns
    sel=. sel bcat (':s';'') boxreplace ':' bcat typesk y
    y=. sel,1}.y
  end.
end.
y
)

NB.=====================================================================
NB.*klr v (lr means left-right) put y table to the right of x table
NB.+it works only if x and y have same number of records;
NB.+the resulting boxed array is then cleaned according with
NB.+new keys and field names (with the rule 'last value is the good one')
klr=: 4 : 0
if. (#>0{_1{x)-:#>0{_1{y do.
  kcln x ,"1 y
else.
  x
end.
)

NB.=====================================================================
NB.*kud v (ud means up-down) put y table under x table
NB.+it works only if x and y have same number and types of fields;
NB.+the resulting table has the same fields of x,
NB.+and it is cleaned according with key values
kud=: 4 : 0
if. (typek x) -: typek y do.
  kclnrow (1{.x),(_1{x),each _1{y
else.
  x
end.
)

NB.=====================================================================
NB.*kdefine v define a new table, with a given table head
NB.+right argument is a boxed list of field names (with optional
NB.+type indication, being string the default type) or a string
NB.+where field names are separated by the default separator |;
NB.+left argument is optional and contain records to fill the body;
NB.+it can be a string with '|' as field separator and LF as record separator,
NB.+or a boxed list representing a single record,
NB.+or a boxed array representing several records
kdefine=: 3 : 0
if. 2=3!:0 y do.
  y=. <;._2 y,'|'
else.
  y=. ": each y
end.
kclncol kfbcheck ,:y
:
x kaddrow kdefine y
)

NB.=====================================================================
NB.*kgrid v generate a template of dbj dynaset with dim dimension (dim is records,fields)
NB.+maximum dimensions are 1000 rows x 1000 columns
NB.+example kgrid 20 100
kgrid=: 3 : 0
y=. ,1>.1000<.toint"0 y
kaddcol^:(<:_1{y) kaddrow^:(0{y) kdefine 'F000'
)

NB.=====================================================================
NB.*kazsort v sort up a dbj dynaset, using assigned fields
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+without left argument, the table is sorted with the key column
kazsort=: (3 : '(iazgrade _1{ kcol y) kyesrow y') : (4 : '(iazgrade ((,each)`(<@:dtb"1)@.(2=3!:0)x) icol y) kyesrow y')

NB.=====================================================================
NB.*kzasort v sort down a dbj dynaset, using assigned fields
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+without left argument, the table is sorted with the key column
kzasort=: (3 : '(izagrade _1{ kcol y) kyesrow y') : (4 : '(izagrade ((,each)`(<@:dtb"1)@.(2=3!:0)x) icol y) kyesrow y')

NB.=====================================================================
NB.*cell v return the unboxed content of a single element of a dbj dynaset
NB.+left argument must have the form (key;field);
NB.+as monad return the unboxed content of the last cell
cell=: 3 : 0
,_1{.>_1{_1{y
:
h=. 0{x
f=. 1{x
,_1{.>_1{. f icol h krow y
)

NB.=====================================================================
NB.*kgroup v group content of fields f1,f2,etc. and perform operation
NB.+op1 on field new1, op2 on field new2, etc.;
NB.+usage: ('op1';'new1';'op2';'new2';...) kgroup (db;'f1';'f2';...)
NB.+'new1' has the form 'old1_something', where old1 is the existing field
NB.+on which to perform operation op1 ('_something' is optional);
NB.+'op1' is a string that is the linear representation of a monadic verb,
NB.+which operates on the list selected by 'old1';
NB.+for example if 'op' is '+/' content of field 'old' (numeric) is summarized,
NB.+if 'op' is '#' content is counted, if 'op' is '+/ % #' the result is the
NB.+arithmetic mean of content, if 'op' is 'icatstr' content is 
NB.+concatenated as string, if 'op' is '''-''&icatstr' content is 
NB.+concatenated with - as separator, etc.;
NB.+if the grouping is made on more fields, a new key field is added
NB.+(with name 'KEYGROUP' and type 'string');
NB.+kgroup does not work on boxed fields (they are converted to strings);
NB.+without left argument makes just the grouping of fields f1,f2,etc.
kgroup=: 3 : 0
f=. ,each 1}.y
y=. kunbox >0{y
h=. f
f=. f icol y
if. (#h)~:#f do.
  assert. 'table cannot be grouped'
end.
i=. <@ind~ f
y=. i {. /. &.> f
if. 1<#f do.
  s=. < (,&')')@:('('&,)@:(')('&icatstr)"_1 >bfi ": each y
  y=. s,y
  h=. 'KEYGROUP';h
end.
s=. ''
for_j. 3!:0 each y do.
  select. j
  case. 2 do.
    s=. s,<''
  case. 1;4 do.
    s=. s,<':i'
  case. 16 do.
    s=. s,<':c'
  case. do.
    s=. s,<':f'
  end.
end.
(h bcat s),:y
:
dat=. kgroup y
z=. namesk dat
f=. ,each 1}.y
y=. >0{y
x=. ,each ,x
x=. ((<.-:#x),2)$x                   NB. arrange x in 2 columns
z=. z , 1{"1 x                       NB. final list of output fields
x=. x \: 0{"1 x                      NB. sort x by required operations
ops=. 0{"1 (0{"1 x) , /. 0{"1 x      NB. list of different operations
x=. (0{"1 x) , /. 1{"1 x             NB. correspondent lists of fields
f=. f icol y
i=. <@ind~ f
for_n. i.#ops do.
  ". 'op=. ',>n{ops                  NB. required operation
  h=. (n{x)-.a:                      NB. fields to be operated
  g=. (] {.~ '_' i:~ ]) each h       NB. original names of fields
  w=. g icol y
  if. (#g)~:#w do.
    assert. 'table cannot be grouped'
  end.
  w=. ifrm each i op /. &.> w        NB. this makes the big job
  s=. ''
  for_j. 3!:0 each w do.
    select. j
    case. 2 do.
      s=. s,<''
    case. 1;4 do.
      s=. s,<':i'
    case. 16 do.
      s=. s,<':c'
    case. do.
      s=. s,<':f'
    end.
  end.
  w=. (g bcat s),:w
  dat=. dat ,"1 (,g,.h) krename w
end.
z kcol dat
)

NB.=====================================================================
NB.*boxtohtml v convert a boxed table y in html table with attributes x
NB.+all fields are left-justified,
NB.+linfeeds and spaces are html-escaped, and the nowrap attribute is set;
NB.+first row is used as table header, including field type info
boxtohtml=: 3 : 0
'' boxtohtml y
:
h=. 1{.y
hh=. ('<th nowrap>'&,)@:(,&'</th>')@:htmlreplace each {.h
hh=. ((<'<tr>')&,)@:(,&(<'</tr>',LF)) hh
y=. ('<td nowrap>'&,)@:(,&'</td>')@:((LF;'<br>')&sr)@:((' ';'&nbsp;')&sr)@:htmlreplace@:frmt each 1}.y
y=. ((<'<tr>')&,)@:(,&(<'</tr>',LF))"1 y
y=. ((('<table',((' '&,)^:(0<#) x),'>');'')&,)@:(,&(('</table>',LF);'')) hh,y
;y
)

NB.=====================================================================
NB.*boxtohref v convert a boxed table y in html table with attributes x, preserving tags
NB.+numbers are right-justified according to field type,
NB.+linked fields are center-justified,
NB.+and html special chars are not escaped (this preserves html tags);
NB.+empty elements of tables are replaced with &nbsp;
NB.+first row is used as table header, but field type info is suppressed;
NB.+field names are used as class names for <th> and <td> tags
boxtohref=: 3 : 0
'' boxtohref y
:
h=. 1{.y
t=. typek h
num=. (I.t e.<'int'),(I.t e.<'float'),I.t e.<'complex'
lnk=. I. 0 < _1 { |: (,: '][') ss '][' ,"1 > typesk h
nn=. htmlreplace each namesk h
hh=. ,&'</th>' each (('<th class="'&,)@:(,&'">') each nn),each nn
hh=. ((<'<tr>')&,)@:(,&(<'</tr>',LF)) hh
y=. frmt each 1}.y
for_n. i.#nn do.
  y=. ((('<td class="',(>n{nn),'">')&,)@:(,&'</td>') each n {"1 y) (<(i.#y);n) } y
end.
for_n. num-.lnk do.
  y=. (('<td ';'<td align="right" ')&sr each n {"1 y) (<(i.#y);n) } y
end.
for_n. lnk do.
  y=. (('<td ';'<td align="center" ')&sr each n {"1 y) (<(i.#y);n) } y
end.
y=. ((<'<tr>')&,)@:(,&(<'</tr>',LF))"1 y
y=. ((('<table',((' '&,)^:(0<#) x),'>');'')&,)@:(,&(('</table>',LF);'')) hh,y
('<td></td>';'<td>&nbsp;</td>') sr ;y
)

NB.=====================================================================
NB.*dbjtohtml v convert a dbj dynaset y in html table with attributes x
NB.+numbers are right-justified according to field type,
NB.+linfeeds and spaces are html-escaped, and the nowrap attribute is set;
NB.+first row is used as table header, including field type info
dbjtohtml=: (3 : 'boxtohtml bfk y') : (4 : 'x boxtohtml bfk y')

NB.=====================================================================
NB.*dbjtohref v convert a dbj dynaset y in html table with attributes x, preserving tags
NB.+numbers are right-justified according to field type,
NB.+and html special chars are not escaped (this preserves html tags);
NB.+empty elements of tables are replaced with &nbsp;
NB.+first row is used as table header, but field type info is suppressed
dbjtohref=: (3 : 'boxtohref bfk y') : (4 : 'x boxtohref bfk y')

NB.=====================================================================
NB.*kself v generate a dbj dynaset with the string representation of the dbj dynaset itself
NB.+y must be a dbj dynaset;
NB.+the output table has 1 field (name 'N') and 1 record;
NB.+as dyad, left argument (a single character) is used as separator;
NB.+use monadic cell verb to extract the string representation;
NB.+as monad, the default separator '|' is used
kself=: 3 : 0
DBS kself y
:
,.(<,'N'),<,: x printk y
)

NB.=====================================================================
NB.*kjbox v generate a dbj dynaset with the boxed representation of the dbj dynaset itself
NB.+y must be a dbj dynaset;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field and 1 record
kjbox=: 3 : 0
'N' kjbox y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
,.(<x),<,: tostring justnum bfk y
)

NB.=====================================================================
NB.*kdbj v generate a dbj dynaset with the dbj representation of the dbj dynaset itself
NB.+y must be a dbj dynaset;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field and 1 record
kdbj=: 3 : 0
'N' kdbj y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
,.(<x),<,: tostring y
)

NB.=====================================================================
NB.*kj v generate a dbj dynaset with the string representations of the argument
NB.+y can be any J noun or sentence;
NB.+x is an optional prefix for key field names (default 'N');
NB.+the output table has 2 fields;
NB.+the first field contains the linear representation of y;
NB.+the second field contains the "tostring" representation of y;
NB.+if y is a boxed list, the output table has a record for each (unboxed) element
NB.+of the list, otherwise the output table has just 1 record;
kj=: 3 : 0
'N' kj y
:
if. (1=#$ y) *. (32=3!:0 y) do.
  yy=. 'y',each ": each i. #y
  (yy)=. y
  ((<"1 ] 5!:5 yy) ,. tostring each y) kdefine (x,'0');x,'1'
else.
  ((5!:5 <'y');tostring y) kdefine (x,'0');x,'1'
end.
)

NB.=====================================================================
NB.*khtml v generate a dbj dynaset with the html representation of the dbj dynaset itself
NB.+the dbjtohtml verb is used for the conversion;
NB.+y must be a dbj dynaset;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field and 1 record
khtml=: 3 : 0
'N' khtml y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
,.(<x),<,: dbjtohtml y
)

NB.=====================================================================
NB.*khref v generate a dbj dynaset with the html representation of the dbj dynaset itself
NB.+the dbjtohref verb is used for the conversion;
NB.+y must be a dbj dynaset;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field and 1 record
khref=: 3 : 0
'N' khref y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
,.(<x),<,: dbjtohref y
)

NB.=====================================================================
NB.*kcat v collapse a dbj dynaset in a single column
NB.+the unique resulting field has type string;
NB.+key field name is taken from input table;
NB.+kcat does not work on boxed fields (they are converted to strings);
NB.+left argument is used as separator;
NB.+as monad, the default separator '|' is used
kcat=: 3 : 0
DBS kcat y
:
kclnrow ,.(0{namesk y),ifb x&bcatstr"1 bfi _1{kunbox y
)

NB.=====================================================================
NB.*krnd v return random records from a dbj dynaset
NB.+as dyad, x (a positive integer) records of y are returned;
NB.+as monad, a random permutation of all records is returned;
krnd=: (3 : '(#>0{_1{ y) krnd y') : (4 : '(((1>.toint x)<.z) ? z)kyesrow y [ z=. #>0{_1{y')

NB.=====================================================================
NB.*ktrans v transpose a dbj dynaset swapping rows and columns
NB.+all field types of new table will be string by default;
NB.+as dyad, field of new table are checked for their proper type
NB.+(regardless of x value)
ktrans=: 3 : 0
typ=. 0{typek y
y=. |: (namesk y),": each 1}. bfk kunbox y
kcln kfbcheck y
:
y=. ktrans y
if. 0<#>0{_1{y do.
  for_m.
    >:i.<:1{$y
  do.
    f=. (m{0{y) ifield y
    if. -. 0 e. isint"1 f do.
      y=. ((<(>m{0{y),':i'),<,.0&"."1 f) (<(0 1);m)} y
    elseif. -. 0 e. isfloat"1 f do.
      y=. ((<(>m{0{y),':f'),<,.0&"."1 f) (<(0 1);m)} y
    elseif. -. 0 e. iscomplex"1 f do.
      y=. ((<(>m{0{y),':c'),<,.0&"."1 f) (<(0 1);m)} y
    end.
    y
  end.
end.
)

NB.=====================================================================
NB.*kstring v generate a dbj dynaset with the content of a string or boxed strings
NB.+y must be a single string, where the first character is used as fret,
NB.+or a string array or a boxed list of strings;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field of type string
kstring=: 3 : 0
'N' kstring y
:
if. 0=L.y do.
  if. 1<#@$ y do.
    y=. <@:dtb@:tostring"1 istr y
  else.
    y=. <;._1 ": y
  end.
else.
  y=. tostring each ,y
end.
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
kclnrow kfbcheck ,. x;y
)

NB.=====================================================================
NB.*kboxed v generate a dbj dynaset with the content of a string or boxed strings
NB.+y must be a single string, where the first character is used as fret,
NB.+or a string array or a boxed list of strings;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field of type boxed
kboxed=: 3 : 0
'N' kboxed y
:
if. 0=L.y do.
  if. 1<#@$ y do.
    y=. <@:dtb@:tostring"1 istr y
  else.
    y=. <;._1 ": y
  end.
else.
  y=. tostring each ,y
end.
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
kclnrow kfbcheck ,. x;y
)

NB.=====================================================================
NB.*kint v generate a dbj dynaset with the content of a vector of integers
NB.+y must be a vector of integers, or an integer atom;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 1 field of type int
kint=: 3 : 0
'N' kint y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
kclnrow ,.(x,':i'); ,. toint"0 ;y
)

NB.=====================================================================
NB.*kfloat v generate a dbj dynaset with the content of a vector of floats
NB.+y must be a vector of floats; x is an optional key field name (default 'N');
NB.+the output table has 1 field of type float
kfloat=: 3 : 0
'N' kfloat y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
kclnrow ,.(x,':f'); ,. tofloat"0 ;y
)

NB.=====================================================================
NB.*kcomplex v generate a dbj dynaset with the content of a vector of complexes
NB.+y must be a vector of complexes; x is an optional key field name (default 'N');
NB.+the output table has 1 field of type complex
kcomplex=: 3 : 0
'N' kcomplex y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
kclnrow ,.(x,':c'); ,. tocomplex"0 ;y
)

NB.=====================================================================
NB.*ktoint v convert to integer the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all string fields (except key) are converted
ktoint=: 3 : 0
strs=. I.(typek y)e.<'string'
((strs-.0){namesk y) ktoint y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.(1{$y),I.(typek y)e.<'int'
do.
  f=. (m{namesk y) ifield y
  y=. ((<(>m{namesk y),':i'),< ,. toint"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*ktofloat v convert to float the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all string fields (except key) are converted
ktofloat=: 3 : 0
strs=. I.(typek y)e.<'string'
((strs-.0){namesk y) ktofloat y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.(1{$y),I.(typek y)e.<'float'
do.
  f=. (m{namesk y) ifield y
  y=. ((<(>m{namesk y),':f'),< ,. tofloat"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*ktocomplex v convert to complex the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all string fields (except key) are converted
ktocomplex=: 3 : 0
strs=. I.(typek y)e.<'string'
((strs-.0){namesk y) ktocomplex y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.(1{$y),I.(typek y)e.<'complex'
do.
  f=. (m{namesk y) ifield y
  y=. ((<(>m{namesk y),':c'),< ,. tocomplex"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*ktostring v convert to string the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all numeric fields (except key) are converted
ktostring=: 3 : 0
t=. typek y
cmps=. I.t e.<'complex'
flts=. I.t e.<'float'
ints=. I.t e.<'int'
(((ints,flts,cmps)-.0){namesk y) ktostring y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.(1{$y),I.(typek y)e.<'string'
do.
  f=. (m{namesk y) ifield y
  y=. ((m{namesk y),< ,. frmt"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*ktorstring v convert to right-justified string the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all numeric fields (except key) are converted
ktorstring=: 3 : 0
t=. typek y
cmps=. I.t e.<'complex'
flts=. I.t e.<'float'
ints=. I.t e.<'int'
(((ints,flts,cmps)-.0){namesk y) ktorstring y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.1{$y
do.
  f=. (m{namesk y) ifield y
  y=. ((m{namesk y),< rjust ,. frmt"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*ktoboxed v convert to boxed the fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix;
NB.+if x is an empty string, all fields are converted;
NB.+as monad, all string fields (except key) are converted
ktoboxed=: 3 : 0
strs=. I.(typek y)e.<'string'
((strs-.0){namesk y) ktoboxed y
:
if. ''-:x do. x=. namesk y end.
for_m.
  l=. (x indcol y)-.(1{$y),I.(typek y)e.<'boxed'
do.
  f=. (m{namesk y) ifield y
  y=. ((<(>m{namesk y),':b'),< ,. <@:dtb@:tostring"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*kunbox v convert to strings all the boxed fields of a dbj dynaset
NB.+as dyad, x is a string containing one or more characters 'bifc'
NB.+to control which types of fields must be converted to string
kunbox=: 3 : 0
'b' kunbox y
:
boxs=. 0$0
if. 'b' e. x do. boxs=. boxs,I.(typek y)e.<'boxed' end.
if. 'i' e. x do. boxs=. boxs,I.(typek y)e.<'int' end.
if. 'f' e. x do. boxs=. boxs,I.(typek y)e.<'float' end.
if. 'c' e. x do. boxs=. boxs,I.(typek y)e.<'complex' end.
x=. boxs{namesk y
for_m.
  l=. (x indcol y)-.1{$y
do.
  f=. (m{namesk y) ifield y
  y=. ((m{namesk y),< ,. frmt"1 f) (<(0 1);m)} y
end.
if. 0 e. l do. kclnrow y else. y end.
)

NB.=====================================================================
NB.*justnum v print a boxed table with numeric fields right-justified
NB.+the output is not a valid dynaset
justnum=: 3 : 0
h=. 1{.y
for_n.
  I.((typek h)e.<'complex')+((typek h)e.<'float')+(typek h)e.<'int'
do.
  y=. (<"1 rjust > ": each n {"1 y) (<(i.#y);n) } y
end.
y
)

NB.=====================================================================
NB.*kdirtree v generate a dbj dynaset with all filenames contained in a directory tree
NB.+y must be a directory path specifier; directories are explored recursively;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 6 fields
kdirtree=: 3 : 0
'N' kdirtree y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'datetime';'size:i';'level:i';'parent';'name'
if. ('/'~:{.y)*.('\'~:{.y)*.(':'~:{:2{.y) do. y=. '.',PATHJSEP_j_,y end.
b=. dirtree y
b=. ((19&{.)&isotimestamp each 1 {"1 b) (<(i.#b);1) } b
b=. b ,. +/@(e.&PATHJSEP_j_) each 0 {"1 b
b=. b ,. (i:&PATHJSEP_j_ {. ]) each 0 {"1 b
b=. b ,. (>:@:(i:&PATHJSEP_j_) }. ]) each 0 {"1 b
h,ifb b
)

NB.=====================================================================
NB.*kdirpath v generate a dbj dynaset with all subdirss contained in a directory tree
NB.+y must be a directory path specifier; directories are explored recursively;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 4 fields
kdirpath=: 3 : 0
'N' kdirpath y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'level:i';'parent';'name'
if. ('/'~:{.y)*.('\'~:{.y)*.(':'~:{:2{.y) do. y=. '.',PATHJSEP_j_,y end.
b=. ,. dirpath y
b=. b ,. +/@(e.&PATHJSEP_j_) each 0 {"1 b
b=. b ,. (i:&PATHJSEP_j_ {. ]) each 0 {"1 b
b=. b ,. (>:@:(i:&PATHJSEP_j_) }. ]) each 0 {"1 b
h,ifb b
)

NB.=====================================================================
NB.*kdir v generate a dbj dynaset with files contained in a directory
NB.+y must be a directory path specifier; x is an optional key field name (default 'N');
NB.+the output table has 6 fields
kdir=: 3 : 0
'N' kdir y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'datetime';'size:i';'perms';'attr';'pathname'
b=. (5 {."1 (2 0 dir y)) ,. 1 0 dir y
if. 0 < # b do.
  b=. ((19&{.)@isotimestamp each 1 {"1 b) (<(i.#b);1) } b
else.
  b=. 0$0
end.
h,ifb b
)

NB.=====================================================================
NB.*kfolder v generate a dbj dynaset with files and dirs contained in a directory
NB.+y must be a directory path specifier; x is an optional key field name (default 'N');
NB.+the output table has 6 fields, but if y is boxed 2 additional fields are present,
NB.+with information about disk usage (number of files and space in bytes of each subdir)
kfolder=: 3 : 0
'N' kfolder y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
if. L.y do.
  y=. >y
  l=. 1 1 dir y
  h=. ,:x;'datetime';'size:i';'perms';'attr';'pathname';'files:i';'bytes:i'
  b=. (5 {."1 (2 1 dir y)) ,. l ,. > <"0 each dirused each l
else.
  h=. ,:x;'datetime';'size:i';'perms';'attr';'pathname'
  b=. (5 {."1 (2 1 dir y)) ,. 1 1 dir y
end.
if. 0 < # b do.
  b=. ((19&{.)@isotimestamp each 1 {"1 b) (<(i.#b);1) } b
else.
  b=. 0$0
end.
h,ifb b
)

NB.=====================================================================
NB.*kdu v generate a dbj dynaset with data about all subdirs of a directory tree
NB.+y must be a directory path specifier; x is an optional key field name (default 'N');
NB.+directories are explored recursively; the output table has 6 fields
kdu=: 3 : 0
'N' kdu y
:
if. 2=ftype y do.
  y=. (-PATHJSEP_j_={:y)}.y NB. remove trailing dir separator, if any
else.
  y=. 1!:43''              NB. current directory
end.
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'subdirs:i';'files:i';'bytes:i';'firstdate';'lastdate'
b=. dud boxopen y
if. 0 < # b do.
  b=. ((19&{.)@isotimestamp :: ('0000-00-00 00:00:00'"_) each 4 5{"1 b) (<(i.#b);4 5) } b
else.
  b=. 0$0
end.
h,ifb b
)

NB.=====================================================================
NB.*dud v recursive dir display
NB.+form: current_path dud list_of_dirs
dud=: 3 : 0
'' dud y
:
r=. 0 6$''                                  NB. Initial result
for_d. y do.
  cd=. x,>d
  d=. fdir cd,PATHJSEP_j_,'*'                NB. Get a dir
  q=. ,>(<'d')e.&.> 4{"1 d                  NB. 0 = file, 1 = dir
  subdirs=. q#d
  d=. (-.q)#d
  fsiz=. +/>2{"1 d
  d=. >1{"1 d
  if. 0=#d do. dates=. '';'' else. dates=. (1&tsrep <./ tsrep d);1&tsrep >./ tsrep d end.
  dirs=. (cd,PATHJSEP_j_) dud 0{"1 subdirs   NB. Recurse
  r=. r,(cd;(+/q);(+/-.q);fsiz;dates),dirs  NB. Save dir, #subdirs, #files, du, firstdate, lastdate
end.
r
)

NB.=====================================================================
NB.*kfile v generate a dbj dynaset with the content of a text file (multi-records output)
NB.+y must be a file specifier; x is an optional key field name (default 'N');
NB.+the output table has 2 fields of type int and string
kfile=: 3 : 0
'N' kfile y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:(x,':i');'text'
b=. 'm' fread y
b=. (,.i.#b);b
h,b
)

NB.=====================================================================
NB.*kcontent v generate a dbj dynaset with the content of a text file (one-cell output)
NB.+y must be a file specifier; x is an optional key field name (default 'N');
NB.+the output table has 1 field of type  string;
NB.+the file content can be retrieved again from the dynaset with the cell verb
kcontent=: 3 : 0
'N' kcontent y
:
h=. <, ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
b=. <,: fread y
h,:b
)

NB.=====================================================================
NB.*kwww v generate a dbj dynaset with the content of a web file
NB.+y must be a url in the form 'www.somenet.xx/path/filename'
NB.+or a boxed list 'www.somenet.xx/path/filename';port (port default:80)
NB.+or an url in the form 'http://www.somenet.xx/path/filename';
NB.+in the last case (i.e. when the url includes the web protocol 'http://' or 'https://' or 'ftp://')
NB.+the web/gethttp addon is used to retrieve the web content (i.e. external wget or curl commands);
NB.+x is an optional key field name (default 'N');
NB.+the output table has 2 fields of type int and string;
NB.+this is the web counterpart of the kfile verb;
NB.+the web file is saved in jpath '~temp/webfile' allowing
NB.+further elaboration (for example, when the content is an image)
kwww=: 3 : 0
'N' kwww y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:(x,':i');'text'
tempfile=. jpath '~temp/webfile'
if. 1=$'://'ss y do.
  filecontent=. gethttp y
else.
  filecontent=. getweb y
  filecontent=. >_1{_1{filecontent NB. extract the body of http message
end.
filecontent fwrite tempfile 
b=. 'm' fread tempfile
b=. (,.i.#b);b
h,b
)

NB.=====================================================================
NB.*khttp v generate a dbj dynaset with the content of a HTTP message
NB.+y must be a url in the form 'www.somenet.xx/path/filename'
NB.+or a boxed list 'www.somenet.xx/path/filename';port (port default:80)
NB.+or an url in the form 'http://www.somenet.xx/path/filename';
NB.+in the last case (i.e. when the url includes the web protocol 'http://' or 'https://' or 'ftp://')
NB.+the web/gethttp addon is used to retrieve the web content (i.e. external wget or curl commands);
NB.+x is an optional key field name (default 'N');
NB.+this is almost the web counterpart of the kcontent verb;
NB.+the output table has 2 fields of type string, holding names and
NB.+values returned by the parsehttp verb
khttp=: 3 : 0
'N' khttp y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'text'
if. 1=$'://'ss y do.
  b=. (,:'HTTPbody');(,:gethttp y)
else.
  filecontent=. getweb y
  b=. ifb filecontent NB. convert content from boxed to inverted table
end.
h,b
)

NB.=====================================================================
NB.*kwget v read a web file returning a dbj dynaset, eventually executing a dbj query
NB.+y must be an url in the form 'www.somenet.xx/path/tablename'
NB.+or a boxed list 'www.somenet.xx/path/tablename';port (port default:80)
NB.+or an url in the form 'http://www.somenet.xx/path/tablename';
NB.+in the last case (i.e. when the url includes the web protocol 'http://' or 'https://' or 'ftp://')
NB.+the web/gethttp addon is used to retrieve the web content (i.e. external wget or curl commands);
NB.+this is the web counterpart of the kget verb;
NB.+as dyad, left argument (a single character) is used as separator;
NB.+as monad, the default separator '|' is used
kwget=: 3 : 0
DBS kwget y
:
if. 1=$'://'ss y do.
  filecontent=. (CRLF;LF) sr gethttp y
else.
  filecontent=. getweb y
  filecontent=. (CRLF;LF) sr >_1{_1{filecontent               NB. extract the body of http message
end.
if. ('(t)'-:3{.filecontent)+.('(q)'-:3{.filecontent) do.      NB. this is an encrypted file
  filecontent=. decrypt frombase64 4 }. filecontent           NB. reads and decrypts file content
end.
if. ']' -: 0 { filecontent do.                                NB. this is a query, because starts with ']'
  filecontent=. 'kquery=. 3 : 0',LF,(1 }. ,&LF^:(LF~:{:) filecontent),')' NB. dynamic definition of kquery verb
  0!:0 filecontent                                            NB. the kquery verb is loaded as script
  kquery''                                                    NB. the kquery verb is executed
else.                                                         NB. this is a table
  x ktable filecontent                                        NB. transformation from string to dbj table
end.
)

NB.=====================================================================
NB.*ask v ask an url to a running dbj jhs server
NB.+optional left argument defaults to localhost server
NB.+result is always a string
NB.+example 1: ask ']<"0 i.10 10'
NB.+example 2: ask 'dbj/'
NB.+example 3: '192.168.0.1:8080' ask '~system/config/version.txt'
ask=: 3 : 0
cell khttp ('127.0.0.1/',y);65001
:
x=. ':' cut x
cell khttp ((>{.x),'/',y);0".>{:x
)

NB.=====================================================================
NB.*getweb v get a file from an url using sockets
NB.+see verbs kwww, khttp, kwget
getweb=: 3 : 0
('url';'port')=. 2{.(boxopen y),<80
hostname=. (] {.~ '/' i.~ ]) url
filepath=. (] }.~ '/' i.~ ]) url
if. '/]'-:2{.filepath do. filepath=. '/',urlencode }.filepath end. NB. just in case of a j sentence form a jhs dbj server
sk=. 0 pick sdcheck_jsocket_ sdsocket_jsocket_ ''             NB. open socket
hostaddr=. sdcheck_jsocket_ sdgethostbyname_jsocket_ hostname NB. find host by name
sdcheck_jsocket_ sdconnect_jsocket_ sk;hostaddr,<port         NB. connect to host at port (default 80 http)
sdcheck_jsocket_ ('GET ',filepath,' HTTP/1.0',CRLF,'Host: ',hostname,CRLF,CRLF) sdsend_jsocket_ sk,0 NB. use HTTP/1.0 to avoid encodings
filecontent=. ''
whilst. 0<#r do. NB. read from socket until there are available data
  filecontent=. filecontent,r=. ;sdcheck_jsocket_ sdrecv_jsocket_ sk,10000,0
end.
sdcheck_jsocket_ sdclose_jsocket_ sk                          NB. close socket
1 parsehttp filecontent                                       NB. return http message (headers and content) as boxed table
)

NB.=====================================================================
NB.*states v utility for building sequential machines
NB.+st.op means next state is st, with opcode op
NB.+rows are states, columns are character classes
NB.+see http://www.jsoftware.com/jwiki/JWebServer/HttpParser
states=: 3 : 0
0 10 #: <. 10 * > -.&a: <@".;._2] 0 : 0
)

NB.=====================================================================
NB.*splitWord n sequential machine to split words in first row of HTTP message
splitWord=: 0;(states'');a.e.' ',CRLF,TAB
NB.+other space     #
    1.1   0     NB. 0 whitespace
    1     0.3   NB. 1 other
)

NB.=====================================================================
NB.*splitHttp n sequential machine to split whole HTTP message 
splitHttp=: 0;(states'');CRLF i.a.
NB.+CR   LF   other    #
    0    0    1.1  NB. 0 initial state
    2.2  2.2  1    NB. 1 first line (HTTPctrl)
    3    4    2    NB. 2 headers    (HTTPhead)
    0.6  4    0.6  NB. 3 CR
    5    6    2    NB. 4 LF
    0.6  6    0.6  NB. 5 CR after blank line
    7.2  7.2  7.2  NB. 6 LF after blank line
    7    7    7    NB. 7 body       (HTTPbody)
)

NB.=====================================================================
NB.*splitHead n sequential machine to split HEADER of HTTP message 
splitHead=: (0;(states'');(-2&<)a.i.~CRLF,TAB,' ')
NB.+CR   LF   space other    #
    0    0    0.6   1.1  NB. 0 initial state
    2    3    1     1    NB. 1 header
    0.6  3    0.6   0.6  NB. 2 CR
    0.5  0.5  1     4.4  NB. 3 LF
    5    6    4     4    NB. 4 alt header
    0.6  6    0.6   0.6  NB. 5 alt CR
    0.5  0.5  4     1.4  NB. 6 alt LF
)

NB.=====================================================================
NB.*splitNV n sequential machine to split name-values in each row of HEADER of HTTP message 
splitNV=: (0;(states'');(2*a.=':')+a.e.' ',CRLF,TAB)&;:
NB.+other space :        #
    1.1   0.6   0.6  NB. 0 initial state
    1     0.6   2.3  NB. 1 name
    3.1   2     3.1  NB. 2 skipping whitespace after name
    3     2.5   3    NB. 3 value
)

NB.=====================================================================
NB.*parsehttp v parse HTTP message using sequential machines
NB.+y is the whole HTTP message
NB.+x is 0 to parse a HTTP request (default), 1 to parse a HTTP response
NB.+return value is a two-columns matrix olding names and values
NB.+example parsehttp 'GET /jserver/jtest.htm HTTP/1.1',CRLF,'Host: localhost:1200',CRLF,'Content-Type: text/plain',CRLF,'Content-Length: 12',CRLF,CRLF,'Hello World!'
parsehttp=: 3 : 0
0 parsehttp y
:
'HTTPctrl HTTPhead HTTPbody'=. 3{.splitHttp ;: y
'names values'=. <"1|:splitNV &> splitHead ;: HTTPhead
if. x do.
  'HTTPversion HTTPcode HTTPmsg'=. ((2 {. ]) , [: ' '&bcatstr 2 }. ])splitWord ;: HTTPctrl
(  'HTTPversion';HTTPversion),('HTTPcode';HTTPcode),('HTTPmsg';HTTPmsg),(names,.values),'HTTPbody';HTTPbody
else.
  'HTTPmethod HTTPuri HTTPversion'=. 3{.splitWord ;: HTTPctrl
  ('HTTPmethod';HTTPmethod),('HTTPuri';HTTPuri),('HTTPversion';HTTPversion),(names,.values),'HTTPbody';HTTPbody
end.
)

NB.=====================================================================
NB.*kday v generate a dbj dynaset with sequential dates
NB.+y must be a boxed list in the form (startday;length;step);
NB.+for example (1960 12 24;14;1) to list 14 days starting from
NB.+24 December 1960, with steps of 1 day;
NB.+x is an optional key field name (default 'N');
NB.+the output table has 4 fields
kday=: 3 : 0
'N' kday y
:
start=. >0{y
lengt=. >1{y
stept=. >2{y
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
h=. ,:x;'year:i';'month:i';'day:i'
b=. todate (stept * i.lengt) + todayno start
b=. (": each 1 todate todayno b),.<"0 b
kclnrow kfb checkrow h,b
)

NB.=====================================================================
NB.*plotk v select column(s) (field(s) x) from a dbj dynaset (y), and plot them
NB.+similar to icol verb, but also display a plot of selected columns;
NB.+all selected columns must have numeric values;
NB.+if there are more than one column, the values of the first column are used for x axis;
NB.+as monad, plots just the key column
plotk=: 3 : 0
y=. icol y
plot ,>y
y
:
y=. x icol y
select. #y
case. 1 do.
  plot ,>y
case. 2 do.
  plot (,>0{y);(,>1{y)
case. ;/1+i.#y do.
  plot (,>0{y);(>,each 1}.y)
end.
y
)

NB.=====================================================================
NB.*kplot v select column(s) (field(s) x) from a dbj dynaset (y), and plot them
NB.+like plotk, but returns a valid dbj dynaset with a single field 'N' and a single
NB.+record (the number of plotted points)
kplot=: 3 : 0
,.'N:i'; ,. #>0{_1{ plotk y
:
,.'N:i'; ,. #>0{_1{ x plotk y
)

NB.=====================================================================
NB.*kascii v generate a dbj dynaset, containing 95 printable ASCII characters (from 32 to 126)
NB.+y is the field name of the ASCII column (default 'A');
NB.+x is an optional key field name (default 'N');
NB.+the output table has 2 fields
kascii=: 3 : 0
'N' kascii y
:
x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
if. 0 = # ,":y do. asc=. ,'A' else. asc=. ,":y end.
(asc,'=. ,.(32}.127{.a.)') kaddcol x kint 32 + i.95
)

NB.=====================================================================
NB.*kmerge v merge the contents of two dbj dynasets of active database
NB.+merging is possible only if the set of field names are identical,
NB.+or the set of keys are identical, or key fields are of same type
kmerge=: 4 : 0
if. (krow x) -: (krow y) do. NB. same fields (similar to kud, but with AZ sorting)
  kazsort kclnrow (1{.x),(_1{x),each _1{y
elseif. ((1{kcol x) -: 1{kcol y) *. -.(0{headk x) e. 1}.headk y do. NB. same keys (similar to klr, but keys of x are always preserved, and key field of y is removed)
  kclncol x ,"1 (1}."1 y)
elseif. ((0{typek x) -: 0{typek y) *. -.(0{headk x) e. 1}.headk y do. NB. same type of keys (only common keys of x and y are kept)
  r=. (ifield x) krow y
  l=. (ifield y) krow x
  kclncol ((ifield r) krow l) ,"1 (1}."1 r)
elseif. do.
  assert. 'Tables cannot be merged'
end.
)

NB.=====================================================================
NB.*kmixkey v mix keys of two dbj dynasets
NB.+the resulting table has three fields: a new key field (name 'KEYMIX', type 'string')
NB.+containing all possible combinations of the two original key fields,
NB.+and the two corresponding original key fields; only if necessary, the name 
NB.+of the last field is changed to differentiate it from the other one (appending '_1');
NB.+kmixkey does not work on boxed fields (they are converted to strings);
NB.+usage: db2 kmixkey db1
kmixkey=: 4 : 0
x=. kunbox x
y=. kunbox y
newkey=. ,.'KEYMIX'; ;"1 >,{ (<"1'('icat(>0{_1{x)icat')');<<"1'('icat(>0{_1{y)icat')'
mixkey=. namesk (khead x) ,"1 (khead y)
if. ((<0 0) { mixkey)-:((<0 1) { mixkey) do. mixkey=. ('_1'&suffix (<0 1) { mixkey) (<0 1)} mixkey end.
mixkey=. (1{.mixkey), ifb >,{ (<"1(>0{_1{x));<<"1(>0{_1{y)
newkey ,"1 mixkey
)

NB.=====================================================================
NB.*kmix v mix selected fields of two dbj dynasets
NB.+the resulting table has a new key field (name 'KEYMIX', type 'string')
NB.+containing all possible combinations of the two original key fields;
NB.+the other fields are those selected, all with the name changed
NB.+(appending '_0' and '_1' repectively for left and right arguments);
NB.+kmix does not work on boxed fields (they are converted to strings);
NB.+usage: (db2;'f21';'f22';...) kmix (db1;'f11';'f12';...)
kmix=: 4 : 0
fx=. 1}.x
x=. kunbox >0{x
fy=. 1}.y
y=. kunbox >0{y
newkey=. ,.'KEYMIX'; ;"1 >,{ (<"1'('icat(>0{_1{x)icat')');<<"1'('icat(>0{_1{y)icat')'
mixkey=. >,{ (<"1(>0{_1{x));<<"1(>0{_1{y)
mixhdx=. fx kcol krow x
mixhdx=. (('_0'&suffix namesk mixhdx) bcat (':s';'') boxreplace ':' bcat typesk mixhdx) 0}mixhdx
mixhdy=. fy kcol krow y
mixhdy=. (('_1'&suffix namesk mixhdy) bcat (':s';'') boxreplace ':' bcat typesk mixhdy) 0}mixhdy
mixfld=. (1{. mixhdx ,"1 mixhdy) , ((0{"1 mixkey) irow fx kcol x) ,"1 (1{"1 mixkey) irow fy kcol y
(('_0'&suffix fx),('_1'&suffix fy)) kcol newkey ,"1 mixfld
)

NB.=====================================================================
NB.*kmixall v mix all fields of two dbj dynasets
NB.+the resulting table has a new key field (name 'KEYMIX', type 'string')
NB.+containing all possible combinations of the two original key fields;
NB.+the other fields are all the fields of the two tables, with the name changed
NB.+(appending '_0' and '_1' repectively for left and right arguments);
NB.+kmixall does not work on boxed fields (they are converted to strings);
NB.+usage: db2 kmixall db1
kmixall=: 4 : 0
x=. kunbox x
y=. kunbox y
newkey=. ,.'KEYMIX'; ;"1 >,{ (<"1'('icat(>0{_1{x)icat')');<<"1'('icat(>0{_1{y)icat')'
mixkey=. >,{ (<"1(>0{_1{x));<<"1(>0{_1{y)
mixhdx=. krow x
mixhdx=. (('_0'&suffix namesk mixhdx) bcat (':s';'') boxreplace ':' bcat typesk mixhdx) 0}mixhdx
mixhdy=. krow y
mixhdy=. (('_1'&suffix namesk mixhdy) bcat (':s';'') boxreplace ':' bcat typesk mixhdy) 0}mixhdy
mixfld=. (1{. mixhdx ,"1 mixhdy) , ((0{"1 mixkey) irow x) ,"1 (1{"1 mixkey) irow y
newkey ,"1 mixfld
)

NB.=====================================================================
NB.*kconf v parse the content of a simple configuration file
NB.+returns a two-fields dbj dynaset, where first column 'N' holds variable
NB.+names and second column 'value' holds corresponding string values;
NB.+in the input string, lines starting with x (comment, default is #) and lines
NB.+not containing = are ignored; other lines are used to fill the table;
NB.+example kconf freads jpath '~addons/data/dbj/examples/dbjhs.conf'
kconf=: 3 : 0
'#' kconf y
:
h=. ,:(,'N');'value'
b=. <;._2 y,LF                         NB. from string to vector of boxed strings
b=. ((<,x)~:1&{. each b)#b             NB. remove lines starting with comment char
b=. (;(0&<)@(1&{.)@('='&ss) each b)#b  NB. remove lines not containing '='
c=. ;(1&{.)@('='&ss) each b            NB. position of the '=' char in each line
b=. dltb each (c {. each b),.(>:c) }. each b
kclnrow kfb checkrow h,b
)

NB.=====================================================================
NB.*kini v parse the content of a structured configuration file
NB.+returns a two-fields dbj dynaset, where first column 'N' holds variable
NB.+names and second column 'value' holds corresponding string values;
NB.+similar to kconf, but here variables can be grouped with lines
NB.+like '[group]' (this string is prefixed to each variable name);
NB.+example kini freads jpath '~addons/data/dbj/examples/dbj.desktop'
kini=: 3 : 0
'#' kini y
:
h=. ,:(,'N');'value'
b=. <;._2 y,LF
b=. ((<,x)~:1&{. each b)#b
b=. (;(((0&<)@(1&{.)@('='&ss))+.((1&=)@(1&{.)@('['&ss)@(' '&,))*.((1&=)@(1&{.)@(']'&ss)@(' '&,)@|.)) each b)#b
c=. ;(1&{.)@('='&ss) each b
b=. (c>0) # (populate (<"1 (c>0),.i.#b) {b,:a:), each (<"1 (c=0),.i.#b) {b,:a:
c=. ;(1&{.)@('='&ss) each b
b=. dltb each (c {. each b),.(>:c) }. each b
kclnrow kfb checkrow h,b
)

NB.=====================================================================
NB.*dbjdestroy v destroy all instances of dbj class (close all databases)
NB.+return the number of destroyed instances
dbjdestroy=: 3 : 0
dat=: >{.{: 'creator ieq ''dbj''' kfilter kn''
cnt=. 0
for_n. dat do.
  m=. <dtb n
  cnt=. cnt+destroy__m''
end.
)

NB.=====================================================================
NB.*ke v return an object from an existing database
NB.+x is the name of the existing database;
NB.+y is the argument of the k verb which is called for the external database;
NB.+the new instance of the database is closed at the end;
NB.+as monad, or if database x does not exist,
NB.+ke works like k, using the last opened database
ke=: 3 : 0
if. 0<#DBN_dbj_ do.
  b=. DBB_dbj_
  k__b y
else.
  'db1' ke y
end.
:
if. (<x)e.DBL_dbj_ do.
  n=. DBN_dbj_
  if. 0<#n do.
    r=. DBB_dbj_
  end.
  b=. dbj x
  d=. k__b y
  closek__b''
  if. 0<#n do.
    cocurrent r
    DBN_dbj_=: n
    DBB_dbj_=: r
  end.
  d
else.
  if. 0<#DBN_dbj_ do.
    b=. DBB_dbj_
    x k__b y
  else.
    'db1' ke y
  end.
end.
)

NB.=====================================================================
NB.*kl v list of existing databases with their objects
NB.+the output table has 4 fields
kl=: 3 : 0
dat=. ('DB=. dtb"1 (,.>:parent i:"1 PATHJSEP_j_)}."1 parent';'OBJECTS=. dtb"1 (,.>:N i:"1 PATHJSEP_j_)}."1 N') kaddcol kdirtree jpath'~user/dbj'
('size';'SIZE') krename kazsort 'dbj' kdelrow ('#';'N';'+/';'size';''',''&icatstr';'OBJECTS') kgroup dat;'DB'
)

NB.=====================================================================
NB.*kn v list of locatives of dbj instances with associated info
NB.+resulting dynaset has 5 string fields: id,creator,path,refs,dbname
kn=: 3 : 0
dat=. 'creator ieq''dbj'''kfilter kfb 1&|."1 costate''
'dbname=. ".''DBN_''icat id icat ''_'''kaddcol dat
)

NB.=====================================================================
NB.*krgb v generate a dbj dynaset from an array holding a bitmapped image, and display it
NB.+y must be an integer matrix with the bitmapped image (rank 2);
NB.+x is an optional key field name (default 'N');
NB.+the key field is automatically generated for the resulting dynaset
krgb=: 3 : 0
'N' krgb y
:
if. (2=#$y) *. (3!:0 y) e. 1 4 do.
  viewrgb y
  z=. #":<:{:$y
  x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
  h=. ':i' suffix (,x);x&([ , (' ';'0') sr z ": ]) each i.{:$y
  h,:ifb<"0(,.i.#y),.y
else.
  x kint 0$0
end.
)

NB.=====================================================================
NB.*kbmp v generate a dbj dynaset from a file holding a bmp image, and display it
NB.+y must be the file name of the bmp image;
NB.+x is an optional key field name (default 'N');
NB.+the key field is automatically generated for the resulting dynaset
kbmp=: krgb@:readbmp

NB.=====================================================================
NB.*kimg v generate a dbj dynaset from a file holding a jpg or png image, and display it
NB.+y must be the file name of the image;
NB.+x is an optional key field name (default 'N');
NB.+the key field is automatically generated for the resulting dynaset
kimg=: krgb@:readimg_jqtide_

NB.=====================================================================
NB.*kview v display a file holding an image, returning a dbj dynaset with image dimensions
NB.+y must be the file name of the image
kview=: >@{.@((<;._1 ' x:i y:i')&(kdefine~)@(<"0@|.@$) ; ([: viewrgb ]))@readimg_jqtide_

NB.=====================================================================
NB.*kviewmat v generate a dbj dynaset from a numeric array, and display it with viewmat
NB.+y must be a numeric array suitable as right argument for viewmat (rank 1 or 2);
NB.+x is an optional key field name (default 'N'), or a color palette, for example (". COLOR16);
NB.+the key field is automatically generated for the resulting dynaset
kviewmat=: 3 : 0
'N' kviewmat y
:
select. <3!:0 y
case. 2;32;65536;131072 do.
  y=. ''
case. 16 do.
  type=. 'c'
case. 1;4 do.
  type=. 'i'
case. do.
  type=. 'f'
end.
if. 1=#$y do.
  y=. ,.y
end.
if. 2=#$y do.
  if. 2=3!:0 x do.
    viewmat_jviewmat_ y
    x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
  else.
    x viewmat_jviewmat_ y
    x=. 'N'
  end.
  z=. #":<:{:$y
  h=. (x,':i');(':',type) suffix x&([ , (' ';'0') sr z ": ]) each i.{:$y
  h,:ifb<"0(,.i.#y),.y
else.
  x kint 0$0
end.
)

NB.=====================================================================
NB.*ksurface v generate a dbj dynaset from a numeric array, and display it as surface plot
NB.+y must be a numeric matrix suitable as right argument for plot verb (rank 2);
NB.+x is an optional key field name (default 'N'), or a plot command/option
NB.+(if it contains the character ';') allowing to display other types of plots;
NB.+example 1: ksurface sin */~ 0.1*i:25
NB.+example 2: 'type line;grids 0 0;frame 0;labels 0 0;tics 0 0' ksurface (-@*: ,. *:) i:100
NB.+example 3: 'type pie;title mypie' ksurface ,.i.10
NB.+the key field is automatically generated for the resulting dynaset
ksurface=: 3 : 0
'N' ksurface y
:
select. <3!:0 y
case. 2;16;32;65536;131072 do.
  y=. ''
case. 1;4 do.
  type=. 'i'
case. do.
  type=. 'f'
end.
if. 2=#$y do.
  if. ';'e.,x do.
    x plot |:y
    x=. 'N'
  else.
    'type surface' plot |:y
    x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
  end.
  z=. #":<:{:$y
  h=. (x,':i');(':',type) suffix x&([ , (' ';'0') sr z ": ]) each i.{:$y
  h,:ifb<"0(,.i.#y),.y
else.
  x kint 0$0
end.
)

NB.=====================================================================
NB.*karray v generate a dbj dynaset from a numeric array 
NB.+y must be a numeric matrix or a numeric list (rank 1 or 2);
NB.+x is an optional key field name (default 'N');
NB.+a key field is automatically generated for the resulting dynaset
karray=: 3 : 0
'N' karray y
:
select. <3!:0 y
case. 2;32;65536;131072 do.
  y=. ''
case. 16 do.
  type=. 'c'
case. 1;4 do.
  type=. 'i'
case. do.
  type=. 'f'
end.
if. 1=#$y do.
  y=. ,.y
end.
if. (2=#$y)*.-.0={:$y do.
  z=. #":<:{:$y
  x=. , ":`('N'"_)@.(_2 = [: 4!:0 :: _2: [: < ":) x
  h=. (x,':i');(':',type) suffix x&([ , (' ';'0') sr z ": ]) each i.{:$y
  h,:ifb<"0(,.i.#y),.y
else.
  x kint 0$0
end.
)

NB.=====================================================================
NB.*bf v box each element of given fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix
bf=: 4 : '(,.@:(<@:dtb"1) each x icol y) (<_1;x indcol y)}y' :. fb

NB.=====================================================================
NB.*fb v unbox each element of given fields of a dbj dynaset
NB.+x is a boxed list of field names, or a string, or a string matrix
fb=: 4 : '(>@:,^:L. each x icol y) (<_1;x indcol y)}y' :. bf

NB.=====================================================================
NB.*dimi v number of records,number of fields of an inverted table
dimi=: #@>@{. , #

NB.=====================================================================
NB.*dimk v number of records,number of fields of a dbj dynaset
dimk=: dimi@:{:

NB.=====================================================================
NB.*testk v test if argument is a dbj dynaset
NB.+assertion failure if argument is not a dbj dynaset;
NB.+if it is, return number of records, number of fields
testk=: 3 : 0
assert. 32=3!:0 y                             NB. boxed array
assert. 2=#$y                                 NB. rank 2 array
assert. 2=#y                                  NB. 2 rows (1 for head, 1 for data)
assert. 2=3!:0 >1{.y                          NB. first row contains boxed strings
assert. 1=#~.#&>_1{y                          NB. same # items (records) in each field (with at least one field)
n=. #>0{_1{y                                  NB. number of records
m=. 1{$y                                      NB. number of fields
t=. typek y                                   NB. field types
r=. namesk y                                  NB. field names
assert. m=+/2=#@$&>_1{y                       NB. rank 2 array in each field
cmps=. I. t e.<'complex'
flts=. I. t e.<'float'
ints=. I. t e.<'int'
strs=. I. t e.<'string'
boxs=. I. t e.<'boxed'
assert. (i.m)-:/:~cmps,flts,ints,strs,boxs    NB. each field has a valid type assigned
assert. m=+/ 0<;# each 0{y                    NB. each field has a name assigned
assert. -. _2 e. 4!:0 r                       NB. each field has a valid J name
assert. -. 0 e. ~: r                          NB. no duplicated field names
if. 0<n do.
  if. 0<#ints do. assert. (#ints)=+/1&{@$&>ints iyescol y end.                  NB. all integer fields have shape n,1
  if. 0<#flts do. assert. (#flts)=+/1&{@$&>flts iyescol y end.                  NB. all float fields have shape n,1
  if. 0<#boxs do. assert. (#boxs)=+/1&{@$&>boxs iyescol y end.                  NB. all boxed fields have shape n,1
  if. 0<#strs do. assert. (,2) e.~ ~.; 3!:0 each strs iyescol y end.            NB. all string fields really contain strings
  if. 0<#ints do. assert. 1 4 64 e.~ ~.; 3!:0 each ints iyescol y end.          NB. all integer fields really contain integers
  if. 0<#flts do. assert. 1 4 8 64 128 e.~ ~.; 3!:0 each flts iyescol y end.    NB. all float fields really contain floats
  if. 0<#cmps do. assert. 1 4 8 16 64 128 e.~ ~.; 3!:0 each cmps iyescol y end. NB. all complex fields really contain complexes
  if. 0<#boxs do. assert. (,32) e.~ ~.; 3!:0 each boxs iyescol y end.           NB. all boxed fields really contain boxes
  if. 0<#boxs do. assert. (,2) e.~ ~.; 3!:0 each ;boxs iyescol y end.           NB. all boxed fields have one boxing level and hold strings
  if. 'string'-:>0{t do. assert. -. 0 e. , #@:dtb"1 >0{_1{y end.                NB. key field does not contain empty strings
  assert. -. 0 e. ~: >0{_1{y                                                    NB. no duplicated key values
end.
n,m
)

NB.=====================================================================
NB.*dbjlab v start the dbj studio lab
dbjlab=: 3 : 0
try.
  lab_jlab_ jpath '~addons/data/dbj/dbj.ijt'
catch.
  lab_jlab_ jpath '~user/projects/dbj/dbj.ijt'
end.
)

NB.=====================================================================
NB. public interface to dbj class
NB.=====================================================================

coclass 'dbj'

dbj_z_=: dbj_dbj_
dbjdestroy_z_=: dbjdestroy_dbj_
dbjlab_z_=: dbjlab_dbj_
ke_z_=: ke_dbj_
kl_z_=: kl_dbj_
kn_z_=: kn_dbj_

NB. modified dirtree verb, to show also hidden files and dirs
0!:0 'dirtree_dbj_=: ',('(''h'' ~: 1{"1 att) *. ';'') sr 5!:5 <'dirtree'

NB.=====================================================================
NB. initialization statements
NB.=====================================================================

3 : 0 ''
if. 0=#dir jpath '~user/dbj' do.     NB. dbj user directory does not exist
  1!:5 <jpath '~user/dbj'            NB. try to create new dbj directory
end.
if. 0=#dir jpath '~user/dbj/db1' do.
  1!:5 <jpath '~user/dbj/db1'        NB. try to create new db1 directory as the first database
end.
DBL=: (}:&.> #~ PATHJSEP_j_ = [: > {:&.>) {."1 (2 1) dir jpath '~user/dbj/'
if. IFQT do.
  smoutput 'dbj ',VERSION,' qt environment on ',UNAME,' platform'
elseif. IFJHS do.
  conf=. kconf fread DBV,'/examples/dbjhs.conf'
  HDBJ_jfilesrc_=: toint ('HDBJ';'value') cell conf
  JCMD_jfilesrc_=: toint ('JCMD';'value') cell conf
  DIRS_jfilesrc_=: toint ('DIRS';'value') cell conf
  PHPCGI_jfilesrc_=: ('PHPCGI';'value') cell conf
  if. 0<#PHPCGI_jfilesrc_ do. PHPCGI_jfilesrc_=: >(fexist PHPCGI_jfilesrc_){'';PHPCGI_jfilesrc_ end.
  smoutput 'dbj ',VERSION,' jhs environment on ',UNAME,' platform'
elseif. -.IFENGINE do.
  smoutput 'dbj ',VERSION,' console environment on ',UNAME,' platform'
elseif. do.
  0 0$0
end.
)
