# dbj
Database management system for J

1 - Introduction

dbj is a database management system (DBMS) developed in J language.

dbj does not try to re-implement the SQL syntax, but provides its own set of J verbs to generate, manage and process dynasets.

The system is composed by two main J scripts:

dbj.ijs which is the DBMS engine;
dbjgui.ijs which realizes the GUI-Graphical User Interface for J8 (WD and JHS).

The addon is available for Windows and Linux platforms.


2 - Opening a Database

In J environment (jqt, jhs or jconsole), dbj can be loaded with:

load 'data/dbj'

Then, an existing database can be opened with the following command:

dbj  'dbname' NB. for command line interface

or

dbj <'dbname' NB. to get the graphic interface

In jqt, if the database name is boxed, the WD GUI is loaded.
In jhs, click on created button, or browse http://127.0.0.1:65001/dbj?dbname to get the GUI.

The dbj verb creates a new instance of the dbj class, calling conew and create verbs. If dbname does not exist, it is created.

The result of dbj verb is the locative of the newly created database.
The name and the locative of the last opened database are also stored in DBN_dbj_ and DBB_dbj_, respectively.

If we want to open a database GUI directly from the shell command line, we can use the following commands (for Windows and Linux respectively, being jfolder the directory where J is installed):

c:\jfolder\bin\jqt.exe -js "load'data/dbj'" "dbj<'dbname'" (Windows)

/jfolder/bin/jqt -js "load'data/dbj'" "dbj<'dbname'" (Linux)


3 - Database Files

A dbj database is composed by a set of files stored in a directory under the directory jpath '~user/dbj/' (for example: '~user/dbj/dbname/').

dbj manages two basic types of objects: tables and queries; both types of objects are stored as plain text ASCII files in the same database directory; there is also the possibility to store the objects as encrypted files.

All file names, as well as field names (see below), should be valid J names, avoiding spaces, final underscore and double underscore (J locatives).

For each dbj database, a special character is defined as field separator; the default field separator is the character '|'. The optional left argument of the dbj verb is the field separator used in the dbj tables.


4 - Table Structure

A file containing a dbj table is composed by a table head (the first row), and a table body, with a row for each record.

The rows are separated by the LF character. Each row uses the field separator as fret. For example:

ID:i|VALUE
1|a
2|bb
3|ccc

The first row (head) of the table defines the field names; the first field on the left is the key field; in a dbj table the key field is always present and the correspondent column must hold unique values.

The colon (':' char) can be used in each field name to specify the field type; five types are allowed: 's' for string (default), 'i' for integer, 'f' for float, 'c' for complex, 'b' for boxed.

For the key field, auto-indexing with progressive integers is allowed using the following syntax (this table is equivalent to te previous one):

ID:1|VALUE
a
bb
ccc

The type, with the exception of the key field, can also hold additional information about the range of values that field should contain:

FIELDNAME:type[otherdynaset][somefield]

for example, if the field VALUE should contain only 'a' or 'bb' or 'ccc':

VALUE:s[kstring '_a_bb_ccc'][N]

This information is used by dbj GUI in order to help table editing by means of combo-boxes, and not to check data when the table is loaded; it is also used to implement relational links between tables.

The type can also hold instructions to calculate the content of the field, regardless of the data contained in the table body, using the syntax:

FIELDNAME:type(instructions)

for example, to fill automatcally the field VALUE:

VALUE:s(ID#"1(96+ID){a.)

The table body contains data: when the table is loaded, the dbj engine removes eventual inconsistencies, according with the following main rules:

- the key field must contain unique values; in case of duplicated values, the last one is the good one; the key field cannot contain empty strings;
- the same rule is applied to the field names in the first row;
- data are initially read as text, and then converted to numbers or boxes according with the field type;
- records having missed data are filled with default values ('' for string, 0 for numeric fields);
- some escape sequencies are recognized in string fields (see escape verb).


5 - Query Syntax

A file containing a dbj query is composed by one or more J sentences; in order to distinguish queries from tables, the first sentence of the query must always start with the ']' character (Same monad).

The content of the query is used by dbj engine to dinamically create a J verb, that should give as result a new dynaset. It is responsibility of the developer to check the consistency of the query result, and to avoid errors.

Refer to the comments of the kread verb to see how the query is executed.

The following examples shows two queries generating the same table of above:

]('1|a',LF,'2|bb',LF,'3|ccc') kdefine 'ID:i';'VALUE'
]'VALUE=.''a'';''bb'';''ccc''' kaddfield 'ID' kint >:i.3


6 - dbj Dynasets

When a dbj object is loaded from the correspondent ASCII file, either table or query, the dbj engine generates a dbj dynaset, which is always a 2-rows boxed table with a head row and a body row.

The head contains only boxed strings (the field names and types).

The body, which holds data, is an inverted table, as described in the J wiki at the page http://www.jsoftware.com/jwiki/Essays/Inverted_Table; the differences between the body of a dbj dynaset and the inverted table described in the J wiki are the following:

- numeric and boxed fields are always stored as rank 2 arrays, with N rows and 1 column, being N the number of records of the dbj dynaset;
- the first field, either string or numeric, must hold unique values, and empty string are not allowed.

The main disadvantage of inverted tables against boxed tables is that string fields having items of different length are filled of blanks, and this can lead, in some cases, to excessive memory occupation; in these cases boxed fields should be used instead of string. Boxed fields hold always strings, and should be avoided when are not really necessary, also because the table visualization is not clean as with string fields. Boxed fields can be added to an existing dbj dynaset with kboxcol, kboxfield or ktoboxed verbs.

The testk verb is available to check if a boxed array is a valid dbj dynaset.


7 - The k Method

The most important verb (see related comments for details) is the k method, which returns a database object, reading tables and/or executing queries:

k__DB 'myobj'

where DB is the locative of the database opened with the dbj verb.

Queries can refer to other database objects, generating nested (recursive) calls of the k verb.

When an object is loaded the first time, the k verb reads (by means of kread or kreadj verbs) the correspondent file, parse it, loads the table or executes the query, and returns a dbj dynaset; then this dynsaet is stored as a component of a keyfile (jpath '~temp/dbname.ijf') which is used as a cache; also information about relationships of the objects with other objects are stored as extra data in the keyfile.

When the object is called again, and no changes have occurred in files, the object is not loaded again, but it is quickly retrieved from the cache, with a significant reduction of execution times. The kreset verb (or the Database/Reset command in the GUI) is available for the cache cleaning.

Queries starting with double square bracket ']]' are not stored in cache and are executed every time the object is called.


8 - Other dbj Verbs

A large set of verbs are provided to operate and process dbj dynasets. Generally, verbs with name starting with 'k' give a valid dynaset as result; for example, krow selects records, kcol selects fields, kaddfield adds or modifies fields, kaddrow adds or modifies records, etc.

Some verbs with name starting with 'i' operate on fields of dynasets and are very useful in the left argument of kfilter and kaddfield verbs: for example icat concatenates fields, ieq compares fields, etc.

k, kinfo, ksave, ksavej, krd, kreset, kupdate, kdel, closek (and some other few verbs) are the methods of the dbj class, which work on an opened database, and must be used always with the correspondent locative. Other dbj methods can be used just with the '_dbj_' locative.

ke, kl, kn, dbj, dbjlab, dbjdestroy are the public verbs available in the 'z' locale.


9 - GUI Features

Two types of GUI are available: WD and JHS.

The dbj GUI allows an easy interaction with the dbj engine. In the WD GUI, two main controls are provided: a text area to edit queries, and a grid to display dynasets.

Working with the GUI, the speed is reduced due to the graphics management, but many additional features are available using the large set of controls (buttons, combo, etc.) and menu commands; for example:

- easy table editing inside the grid
- automatic conversion of linked fields with use of combo-boxes
- find and replace functions
- dynaset view in standard HTML browser
- dedicated commands for common operations (sort, insert records, etc.)
- database management (save as table, save as query, delete, etc.)
- auto-save table while editing
- optional event log
- macro execution (sequence of operations)
- macro autoexec (if file exists jpath '~user/dbj/dbname.ijm')
- open and save dynasets as Excel files
- print, help, font selection, zoom and other facilities

A similar set of controls are also available in JHS GUI.

To learn more, have a look to the dbj.ijt lab.
