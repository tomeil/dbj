NB.%dbjgui.ijs - jhs and jqt dbj interface

NB.=====================================================================
NB. MAIN
NB.=====================================================================

NB.=====================================================================
NB.*dbjgui v start GUI (jhs or jqt) when argument of dbj verb is boxed
dbjgui=: 3 : 0
if. IFJHS do.
  dbh y
else.
  if. IFQT do.
    dbk y
  else.
    DBB
  end.
end.
)

NB.=====================================================================
NB. HTML utilities
NB.=====================================================================

NB.=====================================================================
NB.*myhtml v build html page
myhtml=: 3 : 0
'' myhtml y
:
(('<h1>dbj';'<h1><img src="data:image/png;base64,',(tobase64 fread DBV,'/images/dbj.png'),'" alt="dbj" width="128" height="128" align="center" />&nbsp;') sr ('dbj html output';x)&sr^:(0<#x) MYHTML),y,'</body>',LF,'</html>',LF
)

NB.=====================================================================
NB.*myhref v build href page
myhref=: 3 : 0
'' myhref y
:
(('<h1>dbj';'<h1><img src="data:image/png;base64,',(tobase64 fread DBV,'/images/dbj.png'),'" alt="dbj" width="128" height="128" align="center" />&nbsp;') sr ('dbj href output';x)&sr^:(0<#x) MYHREF),y,'</body>',LF,'</html>',LF
)

NB.=====================================================================
NB.*MYHTML n base code for html page
MYHTML=: 0 : 0
<html>
<head>
<title>dbj html output</title>
<style type="text/css">
a:link {color:white}
a:visited {color:aqua}
a:hover {color:lime}
h1 {font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:16pt}
pre,tt {font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt}
th {color:#fff;background:#666;font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt;border:outset thin gray;padding:2px}
td {color:#fff;background:#222;font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt;border:outset thin gray;padding:2px}
body {padding:8px;color:#ff8;background:#600;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt}
</style>
</head>
<body>
<h1>dbj html output</h1>
)

NB.=====================================================================
NB.*MYHREF n base code for href page
MYHREF=: 0 : 0
<html>
<head>
<title>dbj href output</title>
<style type="text/css">
a:link {color:white}
a:visited {color:aqua}
a:hover {color:lime}
h1 {font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:16pt}
pre,tt {font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt}
th {color:#fff;background:#666;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt;border:outset thin gray;padding:2px}
td {color:#fff;background:#222;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt;border:outset thin gray;padding:2px}
body {padding:8px;color:#ff8;background:#040;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt}
</style>
</head>
<body>
<h1>dbj href output</h1>
)

NB.=====================================================================
NB. jhs page
NB.=====================================================================

NB.=====================================================================
NB.*jev_get v call dbj verb when browser get a dbj URL
NB.+to test browse http://127.0.0.1:65001/dbj?db1
NB.+
NB.+page opening sequence: browser request -->
NB.+jev_get --> dbj --> create --> dbjgui --> dbh --> 
NB.+jhr --> htmlresponse --> putdata --> ssend -->
NB.+sdsend_jsocket_ --> browser 
NB.+
NB.+event handling sequence: event on html object -->
NB.+javascript ev_object_event() --> javascript jdoayax() -->
NB.+j ev_object_event --> j jhrajax --> javascript
NB.+ev_object_event_ajax(ts)
jev_get=: 3 : 0          
dat=. _9}.5}.gethv'GET' NB. es: _9}.5}.'/dbj?db1 HTTP/1.1'
dbj<dat
)

NB.=====================================================================
NB.*dbh v start creation of jhs GUI upon request of dbjgui verb
dbh=: 3 : 0
qry=. y
res=. ".y
inf=. '* ',":(#>0{_1{res ),1{$res
DBI=: res
res=. showres'Show as text table'
JMWIDTH=: >./;#each DBL
dblist=. tostring ifield 'N=. ''y=. y,''''dbj?'' icat N icat ''''''jhml'''''' icat N icat '''''''',LF' kaddcol kstring DBL-.<DBN
dblist=. 'kdblist=. 3 : 0',LF,dblist,LF,')'
0!:0 dblist
dblist=. kdblist''
('dbj: ',DBN)jhr'DBLIST QRY INF RES';dblist;qry;inf;res
)

NB.=====================================================================
NB.*HBS n html body of jhs GUI
HBS=: 0 : 0
>(2|DBE_dbj_){'<link rel="SHORTCUT ICON" href="/~user/projects/dbj/images/dbj.ico" />';'<link rel="SHORTCUT ICON" href="/~addons/data/dbj/images/dbj.ico" />'
jhma''
'linkmenu'jhmg'link';1;14
'dbresetmenu'jhmab'reset database'
'/~user/dbj/" " target="_blank'jhml'dbj directory'
>(2|DBE_dbj_){('/~user/projects/dbj/help/dbjwiki.htm" target="_blank'jhml'dbj help page');('/~addons/data/dbj/help/dbjwiki.htm" target="_blank'jhml'dbj help page')
'/~temp/plot.html" target="_blank'jhml'dbj plot output'
'/~temp/viewmat.bmp" target="_blank'jhml'dbj bmp output'
'jfile" target="_blank'jhml'jfile'
'jijx" target="_blank'jhml'jijx'
'dbexitmenu'jhmab'exit'
'openmenu'jhmg'open';1;JMWIDTH
'<DBLIST>'
'objectmenu'jhmg'object';1;10
'execmenu'jhmab'exec'
'gotomenu'jhmab'goto'
'editmenu'jhmab'edit'
'unloadmenu'jhmab'unload'
'deletemenu'jhmab'delete'
'savetablemenu'jhmab'savetable'
'savequerymenu'jhmab'savequery'
'resetmenu'jhmab'reset'
jhmz''
>(2|DBE_dbj_){(jhh1'<img src="/~user/projects/dbj/images/dbj.png" alt="dbj" width="128" height="128" align="center" />&nbsp;',DBN);(jhh1'<img src="/~addons/data/dbj/images/dbj.png" alt="dbj" width="128" height="128" align="center" />&nbsp;',DBN)
'Tables: '
('onchange="return jev(event)"';'onchange="return jev(event)" onfocus="return jev(event)"')sr'tablelist'jhselect ((-.;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD);1;0
'&nbsp;&nbsp;'
'Queries: '
('onchange="return jev(event)"';'onchange="return jev(event)" onfocus="return jev(event)"')sr'querylist'jhselect ((;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD);1;0
'&nbsp;&nbsp;'
'Selected Object: '
'object'jhtext '';24
'&nbsp;&nbsp;'
'gotobutton'jhb'Goto Object'
'&nbsp;&nbsp;'
'savetablebutton'jhb'Save Table'
'&nbsp;&nbsp;'
'savequerybutton'jhb'Save Query'
'&nbsp;&nbsp;'
'cryptsave'jhcheckbox'Crypt Save';0
jhbr,jhbr
('wrap="off" ';'')sr'qry'jhtextarea'<QRY>';5;120
jhbr,jhbr
'execbutton'jhb'Exec Query'
'&nbsp;&nbsp;'
'resetbutton'jhb'Reset Text'
jhbr,jhbr
'showselect'jhselect('Show as text table';'Show as html table';'Show as formatted text';'Edit as text area';'Edit as text table');5;0
'inf'jhspan jhh1'<INF>'
'res'jhdiv'<RES>'
'<p><i>',('datetime'jhspan 19{. isotimestamp 6!:0''),'</i><br>dbj ',VERSION_dbj_,'</p>'
smoutput (19{.isotimestamp 6!:0''),' dbj-jhs open database: ',DBN,' [',(":>DBB),']'
)

NB.=====================================================================
NB.*CSS n stylesheet of jhs GUI
CSS=: 0 : 0
a:link {color:green}
h1 {font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:16pt}
pre,tt {font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt}
textarea {font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt}
th {color:#fff;background:#666;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt;border:outset thin gray;padding:2px}
td {color:#fff;background:#222;font-family:"Courier New","Nimbus Mono L","DejaVu Sans Mono","Liberation Mono",FreeMono,monospace;font-size:10pt;border:outset thin gray;padding:2px}
body {padding:8px;color:#ff8;background:#008;font-family:Arial,"Nimbus Sans L","DejaVu Sans","Liberation Sans",Freesans,sans-serif;font-size:10pt}
)

NB.=====================================================================
NB.*JS n javascript code of jhs GUI
JS=: 0 : 0 NB. javascript
function ev_body_unload(y){
  disablecontrols(true);
  jdoajax([],"");
}
function ev_body_unload_ajax(ts){
  return true;
}
function disablecontrols(y){
  jbyid("tablelist").disabled=y;
  jbyid("querylist").disabled=y;
  jbyid("object").disabled=y;
  jbyid("gotobutton").disabled=y;
  jbyid("savetablebutton").disabled=y;
  jbyid("savequerybutton").disabled=y;
  jbyid("cryptsave").disabled=y;
  jbyid("qry").disabled=y;
  jbyid("execbutton").disabled=y;
  jbyid("resetbutton").disabled=y;
  jbyid("showselect").disabled=y;
}
function ev_gotobutton_click(){
  disablecontrols(true);
  if (findSelect(jbyid("tablelist"),jbyid("object").value)===false && findSelect(jbyid("querylist"),jbyid("object").value)===false){
    alert("selection is not valid");
    disablecontrols(false);
  }
  else
    jdoajax(["object","showselect"],"");
}
function ev_gotobutton_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("qry").value=ts[1];
    jbyid("inf").innerHTML=ts[2];
    jbyid("res").innerHTML=ts[3];
    jbyid("datetime").innerHTML=ts[4];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_savetablebutton_click(){
  disablecontrols(true);
  if (0==jbyid("object").value.length){
    alert("selection is empty");
    disablecontrols(false);
  }
  else
    if (jbyid("txt"))
      jdoajax(["object","showselect","txt"],jbyid("cryptsave").checked.toString());
    else
      if (jbyid("dec"))
        jdoajax(["object","showselect"],jbyid("cryptsave").checked.toString()+"|"+jbyid("dec").innerHTML);
      else
        jdoajax(["object","showselect"],jbyid("cryptsave").checked.toString());
}
function ev_savetablebutton_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("inf").innerHTML=ts[1];
    if (jbyid("txt"))
      jbyid("txt").value=ts[2];
    else
      if (jbyid("dec"))
        jbyid("dec").innerHTML=ts[2];
    jbyid("datetime").innerHTML=ts[3];
    if (findSelect(jbyid("tablelist"),jbyid("object").value)===false){
      jbyid("tablelist").options[jbyid("tablelist").options.length]=new Option(jbyid("object").value,jbyid("object").value);
      sortSelect(jbyid("tablelist"));
    }
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_savequerybutton_click(){
  disablecontrols(true);
  if (0==jbyid("object").value.length){
    alert("selection is empty");
    disablecontrols(false);
  }
  else
    jdoajax(["object","qry"],jbyid("cryptsave").checked.toString());
}
function ev_savequerybutton_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("datetime").innerHTML=ts[1];
    if (findSelect(jbyid("querylist"),jbyid("object").value)===false){
      jbyid("querylist").options[jbyid("querylist").options.length]=new Option(jbyid("object").value,jbyid("object").value);
      sortSelect(jbyid("querylist"));
    }
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_execbutton_click(){
  disablecontrols(true);
  jdoajax(["qry","showselect"],"");
}
function ev_execbutton_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("inf").innerHTML=ts[1];
    jbyid("res").innerHTML=ts[2];
    jbyid("datetime").innerHTML=ts[3];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_resetbutton_click(){
  jbyid("object").value="";
  jbyid("qry").value="";
}
function ev_dbresetmenu_click(){
  disablecontrols(true);
  jdoajax([],"");
}
function ev_dbresetmenu_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("datetime").innerHTML=ts[1];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_dbexitmenu_click(){
  disablecontrols(true);
  jdoajax([],"");
}
function ev_dbexitmenu_click_ajax(ts){
  window.close();
}
function ev_gotomenu_click(){ev_gotobutton_click();}
function ev_gotomenu_click_ajax(ts){ev_gotobutton_click_ajax(ts);}
function ev_execmenu_click(){ev_execbutton_click();}
function ev_execmenu_click_ajax(ts){ev_execbutton_click_ajax(ts);}
function ev_savetablemenu_click(){ev_savetablebutton_click();}
function ev_savetablemenu_click_ajax(ts){ev_savetablebutton_click_ajax(ts);}
function ev_savequerymenu_click(){ev_savequerybutton_click();}
function ev_savequerymenu_click_ajax(ts){ev_savequerybutton_click_ajax(ts);}
function ev_resetmenu_click(){ev_resetbutton_click();}
function ev_editmenu_click(){
  disablecontrols(true);
  if (findSelect(jbyid("tablelist"),jbyid("object").value)===false && findSelect(jbyid("querylist"),jbyid("object").value)===false){
    alert("selection is not valid");
    disablecontrols(false);
  }
  else
    jdoajax(["object"],"");
}
function ev_editmenu_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("qry").value=ts[1];
    jbyid("datetime").innerHTML=ts[2];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_unloadmenu_click(){
  disablecontrols(true);
  if (findSelect(jbyid("tablelist"),jbyid("object").value)===false && findSelect(jbyid("querylist"),jbyid("object").value)===false){
    alert("selection is not valid");
    disablecontrols(false);
  }
  else
    jdoajax(["object"],"");
}
function ev_unloadmenu_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("datetime").innerHTML=ts[1];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_deletemenu_click(){
  disablecontrols(true);
  if (findSelect(jbyid("tablelist"),jbyid("object").value)===false && findSelect(jbyid("querylist"),jbyid("object").value)===false){
    alert("selection is not valid");
    disablecontrols(false);
  }
  else
    jdoajax(["object"],"");
}
function ev_deletemenu_click_ajax(ts){
  if ('ok'==ts[0]){
    jbyid("datetime").innerHTML=ts[1];
    jbyid("inf").innerHTML=jbyid("inf").innerHTML.replace(jbyid("object").value,"*");
    if (findSelect(jbyid("querylist"),jbyid("object").value)!==false)
      jbyid("querylist").remove(findSelect(jbyid("querylist"),jbyid("object").value));
    else
      jbyid("tablelist").remove(findSelect(jbyid("tablelist"),jbyid("object").value));
      jbyid("object").value="";
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function ev_tablelist_focus(){
  jbyid("object").value=jbyid("tablelist").value;
}
function ev_querylist_focus(){
  jbyid("object").value=jbyid("querylist").value;
}
function ev_tablelist_change(){
  jbyid("object").value=jbyid("tablelist").value;
}
function ev_querylist_change(){
  jbyid("object").value=jbyid("querylist").value;
}
function ev_showselect_change(){
  disablecontrols(true);
  if (jbyid("txt"))
    jdoajax(["showselect","txt"],"textarea");
  else
    if (jbyid("dec"))
      jdoajax(["showselect"],jbyid("dec").innerHTML);
    else
      jdoajax(["showselect"],"");
}
function ev_showselect_change_ajax(ts){
  if ('ok'==ts[0]){
    if (0<ts[1].length)
      jbyid("inf").innerHTML=ts[1];
    jbyid("res").innerHTML=ts[2];
    jbyid("datetime").innerHTML=ts[3];
  }
  else
    alert(ts[0]);
  disablecontrols(false);
}
function sortSelect(selElem){
  var i,op,tmpAry=new Array();
  for (i=0;i<selElem.options.length;i++){
    tmpAry[i]=new Array();
    tmpAry[i][0]=selElem.options[i].text;
    tmpAry[i][1]=selElem.options[i].value;
   }
   tmpAry.sort();
   while (selElem.options.length>0)
     selElem.options[0]=null;
   for (i=0;i<tmpAry.length;i++){
     op=new Option(tmpAry[i][0],tmpAry[i][1]);
     selElem.options[i]=op;
   }
   return;
}
function findSelect(selElem,optVal){
  for(var i=0;i<selElem.options.length;i++)
    if(selElem.options[i].value==optVal)
      return i;
  return false;
}
)

NB.=====================================================================
NB.*ev_body_unload v close database when jhs GUI is unloaded from browser
ev_body_unload=: 3 : 0
smoutput (19{.isotimestamp 6!:0''),' dbj-jhs close database: ',DBN,' [',(":>DBB),']'
closek''
jhrajax''
0 0$0
)

NB.=====================================================================
NB.*ev_gotobutton_click v manage goto button on jhs page
ev_gotobutton_click=: 3 : 0
try.
  sel=. getv'object'
  qry=. sel lookup 2{."1 DBD
  if. ']' = {. qry do.
    qry=. _1 }. 1 }. freads DBF,PATHJSEP_j_,sel
  elseif. '(q)' -: qry do.
    qry=. 1 }. decrypt frombase64 4 }. fread DBF,PATHJSEP_j_,sel
  elseif. 1 do.
    qry=. 'k ''',sel,''''
  end.
  res=. k sel
  inf=. jhh1 sel,' ',":(#>0{_1{res ),1{$res
  DBI=: res
  res=. showres''
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,qry,JASEP,inf,JASEP,res,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_execbutton_click v manage exec button on jhs page
ev_execbutton_click=: 3 : 0
try.
  qry=. getv'qry'
  res=. 'kquery=. 3 : 0',LF,qry,LF,')'
  0!:0 res
  res=. kquery''
  if. -.2=#testk :: 0: res do.
    res=. 'execqueryoutput'kstring<tostring res
  end.
  qry=. ;:qry
  if. (2=#qry)*.((<,'k')={.qry)*.(}.@}: each {:qry)e.0&{"1 DBD do.
    inf=. (}.}:>1{qry)
  else.
    inf=. '*'
  end.
  inf=. jhh1 inf,' ',":(#>0{_1{res ),1{$res
  DBI=: res
  res=. showres''
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,inf,JASEP,res,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_savetablebutton_click v manage savetable button on jhs page
ev_savetablebutton_click=: 3 : 0
try.
  sel=. getv'object'
  shs=. getv'showselect'
  res=. getv'jdata'
  bin=. 't'={.res
  if. 'Edit as text area'-:shs do.
    res=. getv'txt'
    res=. DBS ktable res
    DBI=: res
    res=. cell DBS kself DBI
  elseif. 'Edit as text table'-:shs do.
    res=. html2dbj res
    res=. DBS ktable res
    DBI=: res
    res=. dbj2html DBI
  elseif. 1 do.
    res=. ''
  end.
  if. bin do.
    DBI ksavej sel
  else.
    DBI ksave sel
  end.
  inf=. jhh1 sel,' ',":(#>0{_1{DBI ),1{$DBI
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,inf,JASEP,res,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_savequerybutton_click v manage savequery button on jhs page
ev_savequerybutton_click=: 3 : 0
try.
  sel=. getv'object'
  qry=. getv'qry'
  bin=. 't'={.getv'jdata'
  if. bin do.
    qry ksavej sel
  else.
    qry ksave sel
  end.
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

ev_gotomenu_click=: ev_gotobutton_click
ev_execmenu_click=: ev_execbutton_click
ev_savetablemenu_click=: ev_savetablebutton_click
ev_savequerymenu_click=: ev_savequerybutton_click

NB.=====================================================================
NB.*ev_editmenu_click v manage edit menu option on jhs page
ev_editmenu_click=: 3 : 0
try.
  sel=. getv'object'
  qry=. sel lookup 2{."1 DBD
  if. ']' = {. qry do.
    qry=. _1 }. 1 }. freads DBF,PATHJSEP_j_,sel
  elseif. '(q)' -: qry do.
    qry=. 1 }. decrypt frombase64 4 }. fread DBF,PATHJSEP_j_,sel
  elseif. 1 do.
    qry=. 'k ''',sel,''''
  end.
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,qry,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_unloadmenu_click v manage unload menu option on jhs page
ev_unloadmenu_click=: 3 : 0
try.
  sel=. getv'object'
  kreset sel
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_deletemenu_click v manage delete menu option on jhs page
ev_deletemenu_click=: 3 : 0
try.
  sel=. getv'object'
  kdel sel
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_dbresetmenu_click v manage dbreset menu option on jhs page
ev_dbresetmenu_click=: 3 : 0
try.
  kreset''
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*ev_dbexitmenu_click v manage dbexit menu option on jhs page (close database)
ev_dbexitmenu_click=: 3 : 0
smoutput (19{.isotimestamp 6!:0''),' dbj-jhs close database: ',DBN,' [',(":>DBB),']'
closek''
jhrajax''
0 0$0
)

NB.=====================================================================
NB.*ev_showselect_change v manage change of dynaset representation on jhs page
ev_showselect_change=: 3 : 0
try.
  inf=. ''
  if. 'textarea'-:getv'jdata' do.
    res=. getv'txt'
    res=. DBS ktable res
    inf=. jhh1 '* ',":(#>0{_1{res ),1{$res
    DBI=: res
  elseif. 0<#getv'jdata' do.
    res=. getv'jdata'
    res=. html2dbj res
    res=. DBS ktable res
    inf=. jhh1 '* ',":(#>0{_1{res ),1{$res
    DBI=: res
  end.
  res=. showres''
  datetime=. 19{. isotimestamp 6!:0''
  status=. 'ok'
  jhrajax status,JASEP,inf,JASEP,res,JASEP,datetime
catch.
  status=. 13!:12''
  jhrajax status
end.
0 0$0
)

NB.=====================================================================
NB.*html2dbj v convert html table to dbj table
html2dbj=: 3 : 0
('&amp;';'&')sr('&lt;';'<')sr('&gt;';'>')sr('&nbsp;';' ')sr('<br>';'\n')sr('<td>';'')sr('<th>';'')sr('</td>';DBS)sr('</th>';DBS)sr(DBS;'\s')sr('<tr>';'')sr('</td></tr>';LF)sr('</th></tr>';LF)sr('<br></td>';'</td>')sr('</table>';'')sr('</tbody>';'')sr(2&{@:('<'&ss) }. ])y
)

NB.=====================================================================
NB.*dbj2html v convert dbj dynaset to html table
dbj2html=: 3 : 0
box2html bfk y
)

NB.=====================================================================
NB.*box2html v convert boxed table to html table
box2html=: 3 : 0
h=. 1{.y
t=. typek h
hh=. ('<th>'&,)@:(,&'</th>')@:htmlreplace each {.h
hh=. ((<'<tr>')&,)@:(,&(<'</tr>')) hh
y=. ('<td>'&,)@:(,&'</td>')@:((LF;'<br>')&sr)@:((' ';'&nbsp;')&sr)@:htmlreplace@:frmt each 1}.y
y=. ((<'<tr>')&,)@:(,&(<'</tr>'))"1 y
y=. (('<table>';'')&,)@:(,&(('</table>',LF);'')) hh,y
;y
)

NB.=====================================================================
NB.*showres v show selected representation of dbj dynaset on jhs page
showres=: 3 : 0
if. 0=#y do.
  y=. getv'showselect'
end.
select. <y
case. 'Show as text table' do.
  dbjtohtml DBI
case. 'Show as html table' do.
  dbjtohref 0&k DBI
case. 'Show as formatted text' do.
  '<pre>',(htmlreplace tostring DBI),'</pre>'
case. 'Edit as text area' do.
  res=. cell DBS kself DBI
  'txt'jhtextarea res;40;120
case. 'Edit as text table' do.
  ('dec'jhec dbj2html DBI)jhfix'background:#088;padding:8px'
end.
)

NB.=====================================================================
NB. modification of some jhs verbs to serve other file types
NB.=====================================================================

NB.=====================================================================
NB.*input_jhs_ v originally defined in jhs/core.ijs
input_jhs_=: 3 : 0
logjhs 'prompt'
logapp 'jhs input prompt: ',":#y
try.
if. _1~:SKSERVER do. try. ".'urlresponse_',URL,'_ y' catch. end. end. NB. jijx
if. _1~:SKSERVER do. jbad'' end.
getdata'' NB. get and parse http request
if. 1=NVDEBUG do. smoutput seebox NV end. NB. HNV,NV
if. (-.(<URL)e.boxopen OKURL)*.(0~:#PASS)*.(1~:+/cookie E. gethv'Cookie:')*.-.LHOK*.PEER-:LOCALHOST
                       do. r=. 'jev_get_jlogin_ 0'
elseif. 1=RAW          do. r=. 'jev_post_raw_',URL,'_'''''
NB. start my code for .php scripts with post data
elseif. ('post'-:METHOD)*.'.php'-:_4{.URL
                       do. r=. 'jev_get_jfilesrc_ URL_jhs_'
NB. end my code
elseif. 'post'-:METHOD do. r=. getv'jdo'
elseif. '.'e.URL       do. r=. 'jev_get_jfilesrc_ URL_jhs_'
NB. start my code for display of dbj objects
elseif. 1-:#'dbj/'ss URL
                       do. r=. 'jev_get_jfilesrc_ URL_jhs_'
NB. end my code
NB. start my code for display result of j sentences
elseif. ']'-:{.URL     do. r=. 'jev_get_jfilesrc_ URL_jhs_'
NB. end my code
NB. start my code for display of directory content
elseif. '/'-:{:URL     do. r=. 'jev_get_jfilesrc_ URL_jhs_'
NB. end my code
elseif. 1              do. r=. 'jev_get_',URL,'_'''''
end.
logjhs'sentence'
logapp 'jhs sentence: ',r
if. JZWSPU8-:3{.r do. r=. 3}.r end. NB. empty prompt kludge
r NB. J sentence to run
catch.
 logappx 'input error'
 exit'' NB. 2!:55[11 crashes
end.
)

NB.=====================================================================
NB.*gsrcheadphp_jhs_ n modified version of gsrchead defined in jhs/utilh.ijs
gsrcheadphp_jhs_=: toCRLF 0 : 0
HTTP/1.1 200 OK
Server: JHS
Last-Modified: Mon, 01 Mar 2010 00:23:24 GMT
Accept-Ranges: bytes
Content-Length: <LENGTH>
Keep-Alive: timeout=15, max=100
Connection: Keep-Alive
<HEADER>

)

NB.=====================================================================
NB.*gsrcphp_jhs_ v modified version of gsrcf defined in jhs/utilh.ijs
gsrcphp_jhs_=: 4 : 0
htmlresponse y,~gsrcheadphp rplc '<HEADER>';x;'<LENGTH>';":#y
)

NB.=====================================================================
NB.*jev_get_jfilesrc_ v originally defined in jhs/jfilesrc.ijs
jev_get_jfilesrc_=: 3 : 0
if. y-:'favicon.ico' do. favicon 0 return. end.
y=. jpath(5*'~root/'-:6{.y)}.y
try.
  if. (0<#PHPCGI)*.'.php'-:_4{.y do.
    NB. global NV holds all get and post data
    t=. 'PHP_SELF=http://',(gethv_jhs_'Host:'),'/',URL_jhs_,;('&'&,each {."1 NV_jhs_),.'='&,each {:"1 NV_jhs_
    d=. spawn_jtask_ '"',PHPCGI,'" "',y,'" "',t,'"' NB. run PHP executable, which parses requested file + get data
    p=. ({.CRLF ss d){.d                            NB. first row provided by PHPCGI
    d=. (2+{.CRLF ss d)}.d                          NB. PHP output, without first row provided by PHPCGI
    t=. ({.(CRLF,CRLF) ss d){.d                     NB. complete http header provided by PHPCGI
    d=. (4+{.(CRLF,CRLF) ss d)}.d                   NB. PHP output, without http header provided by PHPCGI
    smoutput (19{.isotimestamp 6!:0''),' dbj-jhs get file: ',y,' (',(":#d),' bytes, ',p,')'
    t gsrcphp d return.
  elseif. JCMD*.']'-:{.y do.
    try.
      d=. tostring_dbj_ ". urldecode_dbj_ y
    catch.
      d=. 13!:12''
    end.
    t=. 'text/plain'
  elseif. DIRS*.'/'-:{:y do.
    if. 1<#'/'ss y do.
      t=. '<a href="../">Parent Directory</a>' kdefine_dbj_ 'name';'datetime';'size:i'
    else.
      t=. kdefine_dbj_ 'name';'datetime';'size:i'
    end.
    d=. ('Directory Content of ',y)myhref_dbj_ (dbjtohref_dbj_ t kud_dbj_ ('name';'datetime';'size') kfield_dbj_ 'name=. (''\'';''/'') sr"1 ''<a href="'' icat N icat ''">'' icat N icat ''</a>''' kaddcol_dbj_ kfolder_dbj_ y),'<p><i>',(19{. isotimestamp 6!:0''),'</i><br />dbj ',VERSION_dbj_,'</p>'
    t=. 'text/html'
  elseif. HDBJ do.
    if. -.'.'e.y do.
      t=. 'text/plain'
    elseif. (#mimetypes) > i=. ({:"1 mimetypes) i. <@tolower@}.(}.~ i:&'.') y do.
      t=. i{:: {."1 mimetypes
    elseif. do. 
      t=. ''
    end.
    d=. 1!:1<y
  elseif. do. NB. original behaviour in jhs/jfilesrc.ijs
    d=. fread y
    if. ('.htm'-:_4{.y)+.'.html'-:_5{.y do. htmlresponse d,~fsrchead rplc '<TYPE>';'text/html' return. end.
    if. (#mimetypes) > i=. ({:"1 mimetypes) i. <@tolower@}.(}.~ i:&'.') y do.
      t=. i{:: {."1 mimetypes
    else. smoutput 'will not get file ',y return. end.
    t gsrcf d return.
  end. 
catch.
  d=. 'jhs request error',CRLF,CRLF,(tostring_dbj_ HNV_jhs_,NV_jhs_),CRLF,CRLF,13!:12''
  t=. 'text/plain'
end.
smoutput (19{.isotimestamp 6!:0''),' dbj-jhs get file: ',y,' (',(":#d),' bytes, Content-Type: ',t,')'
t gsrcf d
)

NB.=====================================================================
NB. jqt window
NB.=====================================================================

NB.=====================================================================
NB. dbk window controls (upper side of jqt GUI)
NB.=====================================================================

NB.=====================================================================
NB.*dbk v start creation of jqt GUI upon request of dbjgui verb
dbk=: 3 : 0
DBJ_dbj_=: 1           NB. jqt GUI is active (one instance only is allowed)
DBX=: ''               NB. macro record
DBU=: 0                NB. counter for undo operation
DBK=: ''               NB. last executed command
DBT=: 6!:1''           NB. events time meter
TBK=: ".y
TBN=: '*'
TBF=: 'ffddbb'
TBG=: '000080'
TBO=: 2
tbk_init y;'0';'0';'0';'1';'1' NB. 0=queryedit;1=cryptsave;2=autosave;3=objectlist_select;4=listtable;5=listquery
tbk_build''
mem=. 0j1 ": (7!:0'') % 16b100000
tim=. 0j3 ": 0
wd 'set sbar setlabel object "Object: ',TBN,' ',(":$TBB),'"'
wd 'set sbar setlabel memory "Used Memory: ',mem,' MB"'
wd 'set sbar setlabel exetim "Execution Time: ',tim,' s"'
wd 'set sbar setlabel status "Ready [open]"'
wd 'ide hide'
wd 'timer 500' NB. set timer for macro autoexec and other stuff
)

NB.=====================================================================
NB.*sys_timer v manage macro autoplay after jqt gui is started
sys_timer=: 3 : 0
if. IFQT do.
  wd 'timer 0'
  cocurrent DBB_dbj_
  if. DBN-:('''';'')sr>{:;:>{:ARGV do. 
    smoutput '   dbj <''',DBN,''''
  end.
  9!:7 '+++++++++|-'
  if. fexist jpath '~user/dbj/',DBN,'.ijo' do.
    playmacro jpath '~user/dbj/',DBN,'.ijo'
  end.
end.
smoutput DBB
)

NB.=====================================================================
NB.*savegrid v save dynaset content for undo operations
savegrid=: 3 : 0
if. 2>TBO do. return. end.
(3!:1 TBK) fwrite jpath '~temp/',DBN,'-',(":DBU),'.bak'
DBU=: >:DBU
wd 'set undo enable 1'
wd 'set tools enable undo 1'
)

NB.=====================================================================
NB.*tablegrid v manage dynaset changes for autosave option
tablegrid=: 3 : 0
if. TBX=0 do. savegrid'' end.
if. (2=TBO) *. 0=4!:0<'TBZ' do.
  if. '1'='autosave' lookup TBZ do.
    sel=. 'objectlist' lookup TBZ
    if. (<sel)e.(-.;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD do.
      cryptsave=. 'cryptsave' lookup TBZ
      if. (''-:y)+.('1'=cryptsave) do.
        TBX=: 1
        tbk_clean''
        if. '0'=cryptsave do.
          TBK ksave sel
        else.
          TBK ksavej sel
        end.
        TBN=: sel
        tbk_update,'0'
        return.
      else.
        obj=. tbk_revert y
        if. (1={.testk obj)*.(tostring >0{_1{y)-:tostring 1{.>0{_1{obj do.
          obj kupdate sel
          TBN=: sel
          TBX=: 1
          return.
        end.
      end.
    end.    
  end.
end.
TBN=: '*'
TBX=: 1
:
if. TBX=0 do. savegrid'' end.
TBN=: '*'
TBX=: 1
)

NB.=====================================================================
NB.*updategrid v update grid content
NB.+if x is an empty string, just clean table
NB.+otherwise dynaset x is loaded in grid
updategrid=: 3 : 0
''updategrid y
:
wd 'psel tbk'
if. L.y do.
  y=. '' NB. used only to skip savegrid for undo button
else.
  savegrid''
end.
if. 0=#x do.
  tbk_clean''
else.
  TBK=: x
end.
if. 0=#y do.
  TBN=: '*'
else.
  TBN=: y
end.
TBZ=: wd'qd'
sel=. 't1_select' lookup TBZ
tbk_update sel
)

NB.=====================================================================
NB.*tbk_exit_button v close tbk window, and exit jqt GUI
tbk_exit_button=: tbk_close

NB.=====================================================================
NB.*tbk_open_button v close database and open a new one
tbk_open_button=: 3 : 0
TBZ=: wd 'qd'
event_start'open';sel=. 'dblist' lookup TBZ
dbnsave=. DBN
if. 0 < # sel do.
  tbk_close 'reopen'
  try.                   NB. opens selected database
    smoutput '   dbj <''',sel,''''
    dbj_dbj_ <sel
  catch.                 NB. re-opens previous database
    smoutput '   dbj <''',dbnsave,''''
    dbj_dbj_ <dbnsave
  end.
else.
  wdinfo'dbj error in tbk_open_button';13!:12''
end.
NB. event_stop'open'
)

NB.=====================================================================
NB.*tbk_reset_button v clean cache of database
tbk_reset_button=: 3 : 0
event_start,<'reset'
kreset''
event_stop'reset'
)

NB.=====================================================================
NB.*tbk_exportxls_button v save whole database as excel file
tbk_exportxls_button=: 3 : 0
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb save "" "',(jpath '~user'),'" "Excel file (*.xls)"'
end.
event_start'exportxls';mb
try.
  if. 0<#mb do.
    dat=. bfi icol kinfo 0
    dat=. ('Queries';<kinfo __) , dat ,. ".@:('k'''&,)@:(,&'''') each dat
    dat=. ({."1 dat) ,. (0&{ , [: 0&{^:(1 = #)&.> [: bfi [: _1&{ 'bc' kunbox ]) each {:"1 dat
    dat writexlsheets mb
  end.
catch.
  wdinfo'dbj error in tbk_exportxls_button';13!:12''
end.
event_stop'exportxls'
)

NB.=====================================================================
NB.*tbk_exec_button v exec query in queryedit textarea and display results in grid
tbk_exec_button=: 3 : 0
TBZ=: wd 'qd'
event_start'exec';qry=. 'queryedit' lookup TBZ
try.
  res=. 'kquery=. 3 : 0',LF,qry,LF,')'
  0!:0 res
  res=. kquery''
  testk res
  qry=. ;:qry
  if. (2=#qry)*.((<,'k')=0{qry)*.(<}.}:>1{qry)e.0&{"1 DBD do.
    res updategrid }.}:>1{qry
  else.  
    res updategrid''
  end.
catch.
  wdinfo'dbj error in tbk_exec_button';13!:12''
end.
if. 0=#y do. event_stop'exec' end.
)

NB.=====================================================================
NB.*tbk_test_button v exec query in queryedit textarea and display results in a separate window
tbk_test_button=: 3 : 0
TBZ=: wd 'qd'
event_start'test';qry=. 'queryedit' lookup TBZ
try.
  res=.'kquery=. 3 : 0',LF,qry,LF,')'
  0!:0 res
  res=. kquery''
  wd 'textview *',DEL,'dbj command result for database ',DBN,DEL,qry,DEL,tostring res
catch.
  wdinfo'dbj error in tbk_test_button';13!:12''
end.
event_stop'test'
)

NB.=====================================================================
NB.*tbk_browsehtml_button v display grid content in default browser escaping html tags
tbk_browsehtml_button=: 3 : 0
TBZ=: wd 'qd'
event_start'browsehtml';qry=. 'queryedit' lookup TBZ
updategrid''
(('dbj ',DBN)myhtml'<h2><tt>',(htmlreplace qry),'</tt></h2>',LF,dbjtohtml TBK) fwrite jpath '~temp/dbjout.htm'
browse_j_ file2url jpath '~temp/dbjout.htm'
event_stop'browsehtml'
)

NB.=====================================================================
NB.*tbk_browsehref_button v display grid content in default browser preserving html tags
tbk_browsehref_button=: 3 : 0
TBZ=: wd 'qd'
event_start'browsehref';qry=. 'queryedit' lookup TBZ
updategrid''
(('dbj ',DBN)myhref'<h2><tt>',(htmlreplace qry),'</tt></h2>',LF,dbjtohref 0&k TBK) fwrite jpath '~temp/dbjout.htm'
browse_j_ file2url jpath '~temp/dbjout.htm'
event_stop'browsehref'
)

NB.=====================================================================
NB.*tbk_template_button v display a template dynaset 
tbk_template_button=: 3 : 0
event_start,<'template'
qry=.'(<"0,.i.10) kdefine ''ID:i'';''VALUE'''
wd 'set queryedit text *',qry
try.
  res=. ". qry
  res updategrid''
catch.
  wdinfo'dbj error in tbk_template_button';13!:12''
end.
event_stop'template'
)

NB.=====================================================================
NB.*tbk_kverblist_select v add in queryedit the selected verb 
tbk_kverblist_select=: 3 : 0
TBZ=: wd 'qd'
clip=. 'kverblist' lookup TBZ
qry=. 'queryedit' lookup TBZ
sel=. 'queryedit_select' lookup TBZ
sel=. 0".sel
wd 'set queryedit text *',(({.sel){.qry),clip,({:sel)}.qry
wd 'set queryedit select ',":2$({.sel)+$clip
)

NB.=====================================================================
NB.*tbk_trykverb_button v menu option add in queryedit the selected verb 
tbk_trykverb_button=: tbk_kverblist_select

NB.=====================================================================
NB.*tbk_tryobject_button v add in queryedit the selected object 
tbk_tryobject_button=: 3 : 0
TBZ=: wd 'qd'
clip=. 'objectlist' lookup TBZ
qry=. 'queryedit' lookup TBZ
sel=. 'queryedit_select' lookup TBZ
sel=. 0".sel
clip=. 'k''',clip,''''
wd 'set queryedit text *',(({.sel){.qry),clip,({:sel)}.qry
wd 'set queryedit select ',":2$({.sel)+$clip
)

NB.=====================================================================
NB.*tbk_clear_button v clear queryedit text content 
tbk_clear_button=: 3 : 0
event_start,<'clear'
wd 'set queryedit text *'
event_stop'clear'
)

NB.=====================================================================
NB.*tbk_textfont_button v set font used in all textareas 
tbk_textfont_button=: 3 : 0
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb font ',DBH
end.
event_start'textfont';mb
if. 0<#mb do.
  wd 'set queryedit font ',mb
  wd 'set xb font ',mb
  wd 'set pb font ',mb
  wd 'set ub font ',mb
  DBH=: mb
end.
event_stop'textfont'
)

NB.=====================================================================
NB.*tbk_listtable_button v enable/disable listing of tables in objectlist combo 
tbk_listtable_button=: 3 : 0
TBZ=: wd 'qd'
event_start'listtable';'listtable' lookup TBZ
objectcheck''
event_stop'listtable'
)

NB.=====================================================================
NB.*tbk_listquery_button v enable/disable listing of queries in objectlist combo 
tbk_listquery_button=: 3 : 0
TBZ=: wd 'qd'
event_start'listquery';'listquery' lookup TBZ
objectcheck''
event_stop'listquery'
)

NB.=====================================================================
NB.*objectcheck v update list of tables and/or queries shown in objectlist combo
objectcheck=: 3 : 0
sel=. 'objectlist' lookup TBZ
tq=. ('listtable' lookup TBZ),('listquery' lookup TBZ)
if. tq-:'00' do.
  dat=. ''
elseif. tq-:'10' do.
  dat=. (-.;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD
elseif. tq-:'01' do.
  dat=. (;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD
elseif. tq-:'11' do.
  dat=. 0&{"1 DBD
end.
if. 0 < # dat do.
  wd 'set objectlist items ', ; ,&LF each dat
  setsel=. dat i.<sel
  if. setsel=#dat do.
    wd 'set objectlist select 0'
  else.
    wd 'set objectlist select ',":setsel
  end.
else.
  wd 'set objectlist items *'
end.
wd 'set objectlist focus'
)

NB.=====================================================================
NB.*tbk_goto_button v open the object selected in objectlist and display results in grid
tbk_goto_button=: 3 : 0
TBZ=: wd 'qd'
event_start'goto';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    qry=. sel lookup 2{."1 DBD
    if. ']' -: 0 { ,qry do.
      qry=._1 }. 1 }. freads DBF,PATHJSEP_j_,sel
    elseif. '(q)' -: qry do.
      qry=. 1 }. decrypt frombase64 4 }. fread DBF,PATHJSEP_j_,sel
    elseif. 1 do.
      qry=. 'k ''',sel,''''
    end.
    wd 'set queryedit text *',qry
    res=. k sel
    res updategrid sel
  catch.
    wdinfo'dbj error in tbk_goto_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_goto_button';'Selection is empty'
end.
event_stop'goto'
)

NB.=====================================================================
NB.*tbk_edit_button v edit in queryedit the object selected in objectlist without loading results in grid
tbk_edit_button=: 3 : 0
TBZ=: wd 'qd'
event_start'edit';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    qry=. sel lookup 2{."1 DBD
    if. ']' -: 0 { ,qry do.
      qry=. _1 }. 1 }. freads DBF,PATHJSEP_j_,sel
    elseif. '(q)' -: qry do.
      qry=. 1 }. decrypt frombase64 4 }. fread DBF,PATHJSEP_j_,sel
    elseif. 1 do.
      qry=. 'k ''',sel,''''
    end.
    wd 'set queryedit text *',qry
  catch.
    wdinfo'dbj error in tbk_edit_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_edit_button';'Selection is empty'
end.
event_stop'edit'
)

NB.=====================================================================
NB.*tbk_view_button v load the source file of the object selected in objectlist and display content in a separate window
tbk_view_button=: 3 : 0
TBZ=: wd 'qd'
event_start'view';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    qry=. sel lookup 2{."1 DBD
    sel=. DBF,PATHJSEP_j_,sel
    if. '(t)' -: qry do.
      wd 'textview *',DEL,sel,DEL,'dbj crypt table',DEL,decrypt frombase64 4 }. fread sel
    elseif. '(q)' -: qry do.
      wd 'textview *',DEL,sel,DEL,'dbj crypt query',DEL,decrypt frombase64 4 }. fread sel
    elseif. ']' -: 0 { ,qry do.
      wd 'textview *',DEL,sel,DEL,'dbj ascii query',DEL,fread sel
    elseif. do.
      wd 'textview *',DEL,sel,DEL,'dbj ascii table',DEL,fread sel
    end.
  catch.
    wdinfo'dbj error in tbk_view_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_view_button';'Selection is empty'
end.
event_stop'view'
)

NB.=====================================================================
NB.*tbk_savetable_button v save grid content as table with the name selected in objectlist
tbk_savetable_button=: 3 : 0
TBZ=: wd 'qd'
event_start'savetable';sel=. 'objectlist' lookup TBZ
cryptsave=. 'cryptsave' lookup TBZ
if. 0 < # sel do.
  try.
    if. fexist DBF,PATHJSEP_j_,sel do.
      yn=. ''
      if. (<sel) e. (;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD do.
        yn=. ' (WARNING: you are replacing a query with a table!)'
      end.
      yn=. 2 3 wdquery'dbj confirmation';'Are you sure to replace this file?',yn
    else.
      yn=. 2
    end.
    if. 2-:yn do.
      updategrid sel
      if. '0'=cryptsave do.
        TBK ksave sel
      else.
        TBK ksavej sel
      end.
      objectcheck''
    end.
  catch.
    wdinfo'dbj error in tbk_savetable_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_savetable_button';'Selection is empty'
end.
event_stop'savetable'
)

NB.=====================================================================
NB.*tbk_savequery_button v save queryedit content as query with the name selected in objectlist
tbk_savequery_button=: 3 : 0
TBZ=: wd 'qd'
event_start'savequery';(sel=. 'objectlist' lookup TBZ);obj=. 'queryedit' lookup TBZ
cryptsave=. 'cryptsave' lookup TBZ
if. (0 < # sel) *. (0 < # obj) do.
  try.
    if. fexist DBF,PATHJSEP_j_,sel do.
      yn=. ''
      if. (<sel) e. (-.;(']'&=@{. +. '(q)'&-:) each 1&{"1 DBD) # 0&{"1 DBD do.
        yn=. ' (WARNING: you are replacing a table with a query!)'
      end.
      yn=. 2 3 wdquery'dbj confirmation';'Are you sure to replace this file?',yn
    else.
      yn=. 2
    end.
    if. 2-:yn do.
      if. '0'=cryptsave do.
        obj ksave sel
      else.
        obj ksavej sel
      end.
      objectcheck''
    end.
  catch.
    wdinfo'dbj error in tbk_savequery_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_savequery_button';'Selection is empty'
end.
event_stop'savequery'
)

NB.=====================================================================
NB.*tbk_cryptsave_button v enable/disable cryptsave option
tbk_cryptsave_button=: 3 : 0
TBZ=: wd 'qd'
event_start'cryptsave';cryptsave=. 'cryptsave' lookup TBZ
wd 'set objectlist focus'
event_stop'cryptsave'
)

NB.=====================================================================
NB.*tbk_autosave_button v enable/disable autosave option
tbk_autosave_button=: 3 : 0
TBZ=: wd 'qd'
event_start'autosave';autosave=. 'autosave' lookup TBZ
wd 'set objectlist focus'
event_stop'autosave'
)

NB.=====================================================================
NB.*tbk_reload_button v like goto, but before unload object from cache
tbk_reload_button=: 3 : 0
TBZ=: wd 'qd'
event_start'reload';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    kreset sel
    qry=. sel lookup 2{."1 DBD
    if. ']' -: 0 { ,qry do.
      qry=. _1 }. 1 }. freads DBF,PATHJSEP_j_,sel
    elseif. '(q)' -: qry do.
      qry=. 1 }. decrypt frombase64 4 }. fread DBF,PATHJSEP_j_,sel
    elseif. 1 do.
      qry=. 'k ''',sel,''''
    end.
    wd 'set queryedit text *',qry
    res=. k sel
    res updategrid sel
  catch.
    wdinfo'dbj error in tbk_reload_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_reload_button';'Selection is empty'
end.
event_stop'reload'
)

NB.=====================================================================
NB.*tbk_unload_button v unload selected object from cache
tbk_unload_button=: 3 : 0
TBZ=: wd 'qd'
event_start'unload';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    kreset sel
  catch.
    wdinfo'dbj error in tbk_unload_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_unload_button';'Selection is empty'
end.
event_stop'unload'
)

NB.=====================================================================
NB.*tbk_delete_button v delete selected object from database (be careful!)
tbk_delete_button=: 3 : 0
TBZ=: wd 'qd'
event_start'delete';sel=. 'objectlist' lookup TBZ
if. 0 < # sel do.
  try.
    if. 2-:2 3 wdquery'dbj confirmation';'Are you sure to delete this file?' do.
      kdel sel
      objectcheck''
    end.
  catch.
    wdinfo'dbj error in tbk_delete_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_delete_button';'Selection is empty'
end.
event_stop'delete'
)

NB.=====================================================================
NB.*tbk_undo_button v reload in grid previous dynaset
tbk_undo_button=: 3 : 0
TBZ=: wd 'qd'
event_start,<'undo'
if. DBU>0 do.
  DBU=: <:DBU
  res=. 3!:2 fread jpath '~temp/',DBN,'-',(":DBU),'.bak'
  res updategrid a:
  ferase jpath '~temp/',DBN,'-',(":DBU),'.bak'
end.
if. DBU=0 do.
  wd 'set undo enable 0'
  wd 'set tools enable undo 0'
end.
event_stop'undo'
)

NB.=====================================================================
NB.*tbk_dbjhelp_button v show in default browser the dbj wiki page
tbk_dbjhelp_button=: 3 : 0
event_start,<'dbjhelp'
browse_j_ file2url DBV,'/help/dbjwiki.htm'
event_stop'dbjhelp'
)

NB.=====================================================================
NB.*tbk_jhelp_button v show in default browser the main j help page
tbk_jhelp_button=: 3 : 0
event_start,<'jhelp'
browse_j_ file2url jpath '~addons/docs/help/index.htm'
event_stop'jhelp'
)

NB.=====================================================================
NB.*tbk_maindoc_button v show in a separate window the main dbj.ijs script
tbk_maindoc_button=: 3 : 0
event_start,<'maindoc'
sel=. DBV,'/dbj.ijs'
wd 'textview *',DEL,sel,DEL,DEL,fread sel
event_stop'maindoc'
)

NB.=====================================================================
NB.*tbk_guidoc_button v show in a separate window the dbjgui.ijs script (this script)
tbk_guidoc_button=: 3 : 0
event_start,<'guidoc'
sel=. DBV,'/dbjgui.ijs'
wd 'textview *',DEL,sel,DEL,DEL,fread sel
event_stop'guidoc'
)

NB.=====================================================================
NB.*tbk_about_button v show information about dbj
tbk_about_button=: 3 : 0
event_start,<'about'
wdinfo ('dbj information';'dbj ',('VERSION'lookup DBA),LF,LF,('CAPTION'lookup DBA),LF,LF,'by Lorenzo Tomei')
if. IFUNIX do. wd 'msgs' end.
'dbj logo' viewbmp DBV,'/images/dbj.bmp'
event_stop'about'
)

NB.=====================================================================
NB.*event_start v manage start of command execution (stausbar, macro, event log)
event_start=: 3 : 0
wd 'set toolgrid enable 0'
wd 'set toolfindcell enable 0'
wd 'set findcell enable 0'
wd 'set toolrplcell enable 0'
wd 'set rplcell enable 0'
wd 'set toolfindtext enable 0'
wd 'set findtext enable 0'
wd 'set toolrpltext enable 0'
wd 'set rpltext enable 0'
wd 'set toolfile enable 0'
wd 'set fileedit enable 0'
wd 'set toolurl enable 0'
wd 'set urledit enable 0'
if. 2>TBO do.
  if. 1=TBO do.
    wd 'set t0 enable 0'
  end.
  wd 'msgs'
  return.
end.
wd 'set tooldb enable 0'
wd 'set tools enable 0'
wd 'set toolgo enable 0'
wd 'set toolobj enable 0'
wd 'set toolqry enable 0'
wd 'set dblist enable 0'
wd 'set cryptsave enable 0'
wd 'set autosave enable 0'
wd 'set eventlog enable 0'
wd 'set toggleide enable 0'
wd 'set objectlist enable 0'
wd 'set listtable enable 0'
wd 'set listquery enable 0'
wd 'set kverblist enable 0'
wd 'set queryedit enable 0'
wd 'set sbar setlabel object ""'
wd 'set sbar setlabel memory ""'
wd 'set sbar setlabel exetim ""'
wd 'set sbar setlabel status "Running... [',(>{.y),']"'
wd 'msgs'
DBT=: 6!:1''
if. 0<DBG_dbj_ do.
  if. 1=DBG_dbj_ do.
    ('c=. 0 0$''''',LF) fappend jpath '~temp/dbk.log'
  end.
  c=. DBG_dbj_;(isotimestamp now'');y
  ('c=. c,',(5!:5 <'c'),LF) fappend jpath '~temp/dbk.log'
  DBG_dbj_=: >:DBG_dbj_
end.
if. 0<#DBX do.
  c=: (<. 1000*DBT);y
  ('c=. c,',(5!:5 <'c'),LF) fappend DBX
end.
)

NB.=====================================================================
NB.*event_stop v manage end of command execution (stausbar)
event_stop=: 3 : 0
wd 'psel tbk'
wd 'set toolgrid enable 1'
wd 'set toolfindcell enable 1'
wd 'set findcell enable 1'
wd 'set toolrplcell enable 1'
wd 'set rplcell enable 1'
wd 'set toolfindtext enable 1'
wd 'set findtext enable 1'
wd 'set toolrpltext enable 1'
wd 'set rpltext enable 1'
wd 'set toolfile enable 1'
wd 'set fileedit enable 1'
wd 'set toolurl enable 1'
wd 'set urledit enable 1'
if. 2>TBO do.
   if. 1=TBO do.
    wd 'set t0 enable 1'
  end.
  return.
end.
wd 'set tooldb enable 1'
wd 'set tools enable 1'
wd 'set toolgo enable 1'
wd 'set toolobj enable 1'
wd 'set toolqry enable 1'
wd 'set dblist enable 1'
wd 'set cryptsave enable 1'
wd 'set autosave enable 1'
wd 'set eventlog enable 1'
wd 'set toggleide enable 1'
wd 'set objectlist enable 1'
wd 'set listtable enable 1'
wd 'set listquery enable 1'
wd 'set kverblist enable 1'
wd 'set queryedit enable 1'
mem=. 0j1 ": (7!:0'') % 16b100000
tim=. 0j3 ": (6!:1'')-DBT
sel=. 0 ". 't1_select' lookup TBZ
wd 'set sbar setlabel object "Object: ',TBN,' ',(":>(sel>0){($TBB);dimk TBK),'"'
wd 'set sbar setlabel memory "Used Memory: ',mem,' MB"'
wd 'set sbar setlabel exetim "Execution Time: ',tim,' s"'
wd 'set sbar setlabel status "Ready [',y,']"'
DBK=: y
)

NB.=====================================================================
NB.*tbk_eventlog_button v enable/disable eventlog option
tbk_eventlog_button=: 3 : 0
if. DBG_dbj_=0 do. DBG_dbj_=: 1 else. DBG_dbj_=: 0 end.
wd 'set eventlog ',":DBG_dbj_
)

NB.=====================================================================
NB.*tbk_toggleide_button v enable/disable ide visibility
tbk_toggleide_button=: 3 : 0
wd 'ide ',(0".toggleide) pick 'hide';'show'
)

NB.=====================================================================
NB.*tbk_startrecord_button v start macro recording on a dbj macro file
tbk_startrecord_button=: 3 : 0
DBX=: wd 'mb save "" "',(jpath '~user/dbj'),'" "dbj-macro (*.ijo)"'
('c=. 0 0$''''',LF) fwrite DBX
if. fexist DBX do.
  wd 'set startrecord enable 0'
  wd 'set tools enable startrecord 0'
  wd 'set stoprecord enable 1'
  wd 'set tools enable stoprecord 1'
  wd 'set startplay enable 0'
  wd 'set tools enable startplay 0'
else.
  DBX=: ''
end.
)

NB.=====================================================================
NB.*tbk_stoprecord_button v stop macro recording
tbk_stoprecord_button=: 3 : 0
DBX=: ''
wd 'set startrecord enable 1'
wd 'set tools enable startrecord 1'
wd 'set stoprecord enable 0'
wd 'set tools enable stoprecord 0'
wd 'set startplay enable 1'
wd 'set tools enable startplay 1'
)

NB.=====================================================================
NB.*tbk_startplay_button v start macro playing from a dbj macro file
tbk_startplay_button=: 3 : 0
mb=. }:wd 'mb open "" "',(jpath '~user/dbj'),'" "dbj-macro (*.ijo)"'
if. 0<#mb do.
  playmacro mb
end.
)

NB.=====================================================================
NB.*playmacro v manage macro playing (automatic execution of a sequence of commands)
playmacro=: 3 : 0
y=. freads y
if. #y do.
  y=. 'macro=. 3 : 0',LF,y,LF,')'
  0!:0 y
  try.
    wd 'psel tbk'
    y=. macro''
    for_n. y do.
      cmd=. >1{n
      if. 2<#n do. par=. >2{n end.
      if. 3<#n do. rap=. >3{n end.
      if. 4<#n do. arp=. >4{n end.
      arg=. ''
      select. cmd
      case. 'open' do.
        TBZ=: ('dblist';par) lookset TBZ
      case. 'exec';'test';'browsehtml';'browsehref' do.
        wd 'set queryedit text *',par
      case. 'goto';'edit';'view';'savetable';'reload';'unload';'delete' do.
        TBZ=: ('objectlist';par) lookset TBZ
        objectcheck''
      case. 'savequery' do.
        TBZ=: ('objectlist';par) lookset TBZ
        wd 'set queryedit text *',rap
        objectcheck''
      case. 'listtable';'listquery';'cryptsave';'autosave' do.
        TBZ=: (cmd;par) lookset TBZ
        wd 'set ',cmd,' ',par
      case. 'exportxls';'openxls';'savexls';'textfont';'gridfont';'gridbackcolor';'gridtextcolor' do.
        arg=. par
      case. 'insertrec';'appendcopy';'deleterec';'removefield';'azsort';'zasort' do.
        'TBR TBC'=: 0".par
      case. 'findnextcell';'findprevcell' do.
        'TBR TBC'=: 0".par
        wd 'set findcell text *',rap
      case. 'replacecell' do.
        'TBR TBC'=: 0".par
        wd 'set findcell text *',rap
        wd 'set rplcell text *',arp
      case. 'findnexttext';'findprevtext' do.
        wd 'set xb select ',par
        wd 'set findtext text *',rap
      case. 'replacetext' do.
        wd 'set xb select ',par
        wd 'set findtext text *',rap
        wd 'set rpltext text *',arp
      case. 'openfile' do.
        wd 'set fileedit text *',par
      case. 'openurl' do.
        wd 'set urledit text *',par
      case. 'cg' do. NB. change the content of a grid cell
        'TBR TBC'=: 0".par
        tbk_tb_change <rap
      case. 't1' do. NB. change tab selection
        tbk_t1_select par
      end.
      if. -.(<cmd)e.'cg';'t1' do.
        ".'tbk_',cmd,'_button arg'
      end.
    end.
  catch.
    wdinfo'dbj error in playmacro';13!:12''
  end.
end.
''
)

NB.=====================================================================
NB. tbk window controls (tab holding dynaset representations)
NB.=====================================================================

NB.=====================================================================
NB.*tbk v display a dbj dynaset in a QTableWidget (editable grid)
NB.+a toolbar is available to manage grid content
NB.+several tabs allow to view the dynaset also as text and html
NB.+the dynaset content can be viewed in Grid,Text,ASCII,HTML,HREF,isigrid format
NB.+isigrid view is not yet fully working
NB.+only the Grid and Text format are editable
NB.+Grid, Text and HTML show the dynaset in source format
NB.+when the widget is closed, TBK holds the edited table
tbk=: 3 : 0
0 tbk y
:
if. DBJ_dbj_ do. 
  assert. 'a jqt GUI istance is already active'
end.
TBK=: y
TBN=: '*'
TBF=: 'ffddbb'
TBG=: '000080'
TBO=: x NB. 0=tab only; 1=other controls; 2=tab only dialog style (no close button)
z=. ''
if. 1=TBO do.
  z=. (('_',(;coname''),'_');'') sr }.{.13!:18'' NB. function argument taken from stack
  z=. dltb (3 + {. 'tbk' ss z)}.z
  z=. z;":#DBD NB. query;selected object (none)
end.
if. IFQT do.
  tbk_init z
  tbk_build''
elseif. IFJHS do.
  if. 1=TBO do.
    jhtml 'id="tbk" border="1"' dbjtohref 0&k :: ] TBK
  else.
    jhtml '<pre>',(htmlreplace DBS printk TBK),'</pre>'
  end.
end.
0 0$0
)

NB.=====================================================================
NB.*tbk_init v initialize tbk window content
tbk_init=: 3 : 0
try.
  wd 'psel tbk'
  (": wd 'qform') fwrite jpath '~temp/tbk.tmp'
  wd 'pclose'
catch.
end.
wd 'pc tbk'
wd 'fontdef ',DBY
wd 'picon ',DBV,'/images/dbj.png'
wd 'bin v'
if. 1=TBO do.
  wd 'splitv 0 1 40 400'
  wd 'cc t0 tab'
  wd 'set t0 stylesheet *color:#000000;background-color:#',TBF
  wd 'tabnew Query'
  wd 'bin h'
  wd 'bin v'
  wd 'cc eb button;cn "Exec"'
  wd 'set eb stylesheet *color:#000000;background-color:#dddddd'
  wd 'bin s'
  wd 'cc ob combobox'
  wd 'set ob stylesheet *color:#000000;background-color:#dddddd'
  wd 'set ob items ',;,&LF each 0{"1 DBD
  wd 'set ob select ',>1{y
  wd 'bin z'
  wd 'cc qb editm'
  wd 'set qb stylesheet *color:#000000;background-color:#ffffff'
  wd 'set qb font ',DBH
  wd 'set qb text *',>0{y
  wd 'bin z'
  wd 'tabend'
  wd 'splitsep'
elseif. 2=TBO do.
  wd 'pn "dbj: ',DBN,'";'
  wd 'menupop "Database"'
  wd 'menu open "&Open DB" "Ctrl+Shift+O"'
  wd 'menu reset "&Reset" "Ctrl+Shift+R"'
  wd 'menusep'
  wd 'menu exportxls "Export xls..." ""'
  wd 'menusep'
  wd 'menu exit "E&xit" "Ctrl+Shift+X"'
  wd 'menupopz'
  wd 'menupop "Object"'
  wd 'menu undo "&Undo" "Ctrl+Shift+U";set undo enable 0'
  wd 'menusep'
  wd 'menu exec "Exec &Query" "Ctrl+Shift+Q"'
  wd 'menu test "&Test Query" "Ctrl+Shift+T"'
  wd 'menu goto "&Goto Object" "Ctrl+Shift+G"'
  wd 'menu edit "&Edit Object" "Ctrl+Shift+E"'
  wd 'menu view "Vie&w Source File" "Ctrl+Shift+W"'
  wd 'menusep'
  wd 'menu savetable "Save Ta&ble" "Ctrl+Shift+B"'
  wd 'menu savequery "Save Quer&y" "Ctrl+Shift+Y"'
  wd 'menusep'
  wd 'menu reload "Reload Object" ""'
  wd 'menu unload "Unload Object" ""'
  wd 'menu delete "Delete Object" ""'
  wd 'menusep'
  wd 'menu tryobject "Try k Object" ""'
  wd 'menu trykverb "Try k Verb" ""'
  wd 'menu template "Template" ""'
  wd 'menu clear "C&lear Text" "Ctrl+Shift+L"'
  wd 'menupopz'
  wd 'menupop "Grid"'
  wd 'menu cleantable "Clea&n Table" "Ctrl+Shift+N"'
  wd 'menusep'
  wd 'menu insertrec "&Insert Record" "Ctrl+Shift+I"'
  wd 'menu appendcopy "&Copy-Append Record" "Ctrl+Shift+C"'
  wd 'menu deleterec "&Delete Record" "Ctrl+Shift+D"'
  wd 'menu removefield "Remove Field" ""'
  wd 'menusep'
  wd 'menu azsort "&AZ Sort" "Ctrl+Shift+A"'
  wd 'menu zasort "&ZA Sort" "Ctrl+Shift+Z"'
  wd 'menusep'
  wd 'menu printtable "Print Table..." ""'
  wd 'menu openxls "Open xls..." ""'
  wd 'menu savexls "Save xls..." ""'
  wd 'menusep'
  wd 'menu colwidth "Column Width" ""'
  wd 'menu rowwidth "Row Width" ""'
  wd 'menu zoomin "Zoom In" ""'
  wd 'menu zoomout "Zoom Out" ""'
  wd 'menusep'
  wd 'menu gridfont "Grid Fonts..." ""'
  wd 'menu gridbackcolor "Grid Back Color..." ""'
  wd 'menu gridtextcolor "Grid Text Color..." ""'
  wd 'menupopz'
  wd 'menupop "Tools"'
  wd 'menu findnextcell "&Find Next Cell" "Ctrl+Shift+F"'
  wd 'menu findprevcell "Find &Prev Cell" "Ctrl+Shift+P"'
  wd 'menu replacecell "Replace in Cell" ""'
  wd 'menusep'
  wd 'menu findnexttext "&Find Next Text" ""'
  wd 'menu findprevtext "Find &Prev Text" ""'
  wd 'menu replacetext "Replace in Selection" ""'
  wd 'menusep'
  wd 'menu browsehtml "Browse HT&ML" "Ctrl+Shift+M"'
  wd 'menu browsehref "Browse &HREF" "Ctrl+Shift+H"'
  wd 'menusep'
  wd 'menu startrecord "Start Macro Record..." ""' 
  wd 'menu stoprecord "Stop Macro Record" "";set stoprecord enable 0' 
  wd 'menu startplay "Start Macro Play..." ""' 
  wd 'menusep'
  wd 'menu textfont "Text Fonts..." ""'
  wd 'menupopz'
  wd 'menupop "Help"'
  wd 'menu dbjhelp "db&j Help Page" "Ctrl+Shift+J"'
  wd 'menu jhelp "J Help Index" ""'
  wd 'menusep'
  wd 'menu maindoc "Main Script Source" ""'
  wd 'menu guidoc "GUI Script Source" ""'
  wd 'menusep'
  wd 'menu about "About dbj" ""'
  wd 'menupopz'
  wd 'splitv 0 1 110 440'
  wd 'splitv 0 1 44 66'
  wd 'bin h'
  wd 'cc tooldb toolbar 22x22'
  wd 'set tooldb add open "Open DB" "',DBV,'/images/server-database.png"'
  wd 'cc dblist combobox;set dblist wh 160 22'
  if. 0<#DBL do.
    wd 'set dblist items ',;,&LF each DBL
    wd 'set dblist select ',":(<:#DBL)<.DBL i.<DBN
  end.
  wd 'cc tools toolbar 22x22'
  wd 'set tools add reset "Reset" "',DBV,'/images/folder-sync.png"'
  wd 'set tools add undo "Undo" "',DBV,'/images/edit-undo.png"'
  wd 'set tools addsep'
  wd 'set tools add savetable "Save Table" "',DBV,'/images/document-save-t.png"'
  wd 'set tools add savequery "Save Query" "',DBV,'/images/document-save-q.png"'
  wd 'set tools addsep'
  wd 'set tools add browsehtml "Browse HTML" "',DBV,'/images/internet-web-browser.png"'
  wd 'set tools add browsehref "Browse HREF" "',DBV,'/images/internet-web-browser-1.png"'
  wd 'set tools add exportxls "Export xls.." "',DBV,'/images/applications-excel.png"'
  wd 'set tools addsep'
  wd 'set tools add startrecord "Macro Start Record.." "',DBV,'/images/media-record.png"'
  wd 'set tools add stoprecord "Macro Stop Record" "',DBV,'/images/media-playback-stop.png"'
  wd 'set tools add startplay "Macro Start Play.." "',DBV,'/images/media-playback-start.png"'
  wd 'set tools addsep'
  wd 'set tools add dbjhelp "dbj Help" "',DBV,'/images/help-browser.png"'
  wd 'set tools add jhelp "J Help" "',DBV,'/images/jwlogo.png"'
  wd 'set tools add maindoc "Main Script Source" "',DBV,'/images/help-contents.png"'
  wd 'set tools add guidoc "GUI Script Source" "',DBV,'/images/help-contents-1.png"'
  wd 'set tools add about "About" "',DBV,'/images/help-about.png"'
  wd 'set tools addsep'
  wd 'set tools add exit "Exit" "',DBV,'/images/application-exit.png"'
  wd 'set tools addsep'
  wd 'set tools enable undo ',":DBU>0
  wd 'set tools enable startrecord ',":0=#DBX
  wd 'set tools enable stoprecord ',":0<#DBX
  wd 'set tools enable startplay ',":0=#DBX
  wd 'cc cryptsave checkbox;cn "Crypt"'
  wd 'set cryptsave ',>1{y
  wd 'cc autosave checkbox;cn "ASave"'
  wd 'set autosave ',>2{y
  wd 'cc eventlog checkbox;cn "Log"'
  wd 'set eventlog ',":0<DBG_dbj_
  wd 'cc toggleide checkbox;cn "Ide"'
  wd 'set toggleide 0'
  wd 'bin sz'
  wd 'bin h'
  wd 'cc toolgo toolbar 22x22'
  wd 'set toolgo add goto "Goto Object" "',DBV,'/images/arrow-right-double.png"'
  wd 'cc objectlist combobox;set objectlist wh 160 22'
  if. 0<#DBD do.
    wd 'set objectlist items ',;,&LF each 0{"1 DBD
    wd 'set objectlist select ',>3{y
  end.
  wd 'cc toolobj toolbar 22x22'
  wd 'set toolobj add edit "Edit Object" "',DBV,'/images/edit-rename.png"'
  wd 'set toolobj add view "View Source File" "',DBV,'/images/document-preview.png"'
  wd 'set toolobj addsep'
  wd 'set toolobj add reload "Reload Object" "',DBV,'/images/view-refresh.png"'
  wd 'set toolobj add unload "Unload Object" "',DBV,'/images/edit-clear-list.png"'
  wd 'set toolobj add delete "Delete Object" "',DBV,'/images/edit-delete.png"'
  wd 'set toolobj add tryobject "Try k Object" "',DBV,'/images/list-add.png"'
  wd 'set toolobj addsep'
  wd 'set toolobj add template "Template" "',DBV,'/images/quickopen-file.png"'
  wd 'set toolobj add textfont "Text Fonts.." "',DBV,'/images/fontforge.png"'
  wd 'set toolobj addsep'
  wd 'cc listtable checkbox;cn "T"'
  wd 'set listtable ',>4{y
  wd 'cc listquery checkbox;cn "Q"'
  wd 'set listquery ',>5{y
  wd 'cc kverblist combolist;set kverblist wh 100 22'
  wd 'set kverblist items ', ; ,&' ' each 'kaddcol';'kaddkey';'kaddrow';'karray';'kascii';'kazsort';'kbmp';'kboxcol';'kboxed';'kcat';'kcln';'kclncol';'kclnrow';'kcol';'kcomplex';'kconf';'kcontent';'kday';'kdbj';'kdefine';'kdelcol';'kdelrow';'kdir';'kdirpath';'kdirtree';'kdu';'ke';'kfield';'kfile';'kfilter';'kfind';'kfirst';'kfloat';'kfolder';'kget';'kgetxls';'kgrid';'kgroup';'khead';'khref';'khtml';'khttp';'kimg';'kinfo';'kini';'kint';'kj';'kjbox';'kjdoc';'kjoin';'kl';'klast';'klocate';'klr';'kmerge';'kmix';'kmixall';'kmixkey';'kn';'knotcol';'knotrow';'kplot';'krd';'krename';'krgb';'krnd';'krow';'ks';'ksearch';'kself';'kselrow';'kstring';'ksurface';'ktable';'ktoboxed';'ktocomplex';'ktofloat';'ktoint';'ktorstring';'ktostring';'ktrans';'kud';'kunbox';'kview';'kviewmat';'kwget';'kwww';'kyescol';'kyesrow';'kzasort'
  wd 'set kverblist select 0'
  wd 'bin szs'
  wd 'splitsep'
  wd 'bin h'
  wd 'cc toolqry toolbar vertical 22x22'
  wd 'set toolqry add exec "Exec Query" "',DBV,'/images/fork.png"'
  wd 'set toolqry add test "Test Query" "',DBV,'/images/edit-bomb.png"'
  wd 'set toolqry add clear "Clear Text" "',DBV,'/images/edit-clear.png"'
  wd 'cc queryedit editm'
  wd 'set queryedit font ',DBH
  wd 'set queryedit text *',>0{y
  wd 'bin z'
  wd 'splitend'
  wd 'splitsep'
end.
wd 'cc t1 tab'
wd 'tabnew Grid'
wd 'cc tb table'
wd 'bin h'
wd 'cc nr static center sunken;set nr wh 50 24'
wd 'set nr stylesheet *color:#000000;background-color:#dddddd'
wd 'cc nc static center sunken;set nc wh 50 24'
wd 'set nc stylesheet *color:#000000;background-color:#dddddd'
wd 'cc toolgrid toolbar 22x22'
wd 'set toolgrid add cleantable "Clean Table" "',DBV,'/images/checkbox.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add insertrec "Insert Record" "',DBV,'/images/edit-table-insert-row-above.png"'
wd 'set toolgrid add appendcopy "Copy-Append Record" "',DBV,'/images/edit-table-insert-row-under.png"'
wd 'set toolgrid add deleterec "Delete Record" "',DBV,'/images/edit-table-delete-row.png"'
wd 'set toolgrid add removefield "Remove Field" "',DBV,'/images/edit-table-delete-column.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add azsort "AZ Sort" "',DBV,'/images/view-sort-ascending.png"'
wd 'set toolgrid add zasort "ZA Sort" "',DBV,'/images/view-sort-descending.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add printtable "Print Table.." "',DBV,'/images/printer.png"'
wd 'set toolgrid add openxls "Open xls.." "',DBV,'/images/excel-open.png"'
wd 'set toolgrid add savexls "Save xls.." "',DBV,'/images/excel-save.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add colwidth "Column Width" "',DBV,'/images/measure.png"'
wd 'set toolgrid add rowwidth "Row Width" "',DBV,'/images/measure-1.png"'
wd 'set toolgrid add zoomin "Zoom In" "',DBV,'/images/zoom-in.png"'
wd 'set toolgrid add zoomout "Zoom Out" "',DBV,'/images/zoom-out.png"'
wd 'set toolgrid add gridfont "Grid Fonts.." "',DBV,'/images/preferences-desktop-font.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add gridbackcolor "Grid Back Color.." "',DBV,'/images/fill-color.png"'
wd 'set toolgrid add gridtextcolor "Grid Text Color.." "',DBV,'/images/format-text-color.png"'
wd 'set toolgrid addsep'
wd 'set toolgrid add copycells "Copy Cells" "',DBV,'/images/edit-copy.png"'
wd 'set toolgrid add pastecells "Paste Cells" "',DBV,'/images/edit-paste.png"'
wd 'set toolgrid add editcell "Edit Cell" "',DBV,'/images/edit-text-frame-update.png"'
wd 'bin zh'
wd 'cc toolfindcell toolbar 22x22'
wd 'set toolfindcell add findnextcell "Find Next" "',DBV,'/images/edit-find.png"'
wd 'set toolfindcell add findprevcell "Find Back" "',DBV,'/images/edit-find-1.png"'
wd 'cc findcell edit'
wd 'set findcell stylesheet *color:#000000;background-color:#ffffff'
wd 'cc toolrplcell toolbar 22x22'
wd 'set toolrplcell add replacecell "Replace" "',DBV,'/images/edit-find-replace.png"'
wd 'cc rplcell edit'
wd 'set rplcell stylesheet *color:#000000;background-color:#ffffff'
wd 'bin sz'
wd 'tabnew Text'
wd 'cc xb editm'
wd 'set xb stylesheet *color:#000000;background-color:#ffffff'
wd 'set xb font ',DBH
wd 'set xb wrap 0'
wd 'set xb text *'
wd 'bin h'
wd 'cc toolfindtext toolbar 22x22'
wd 'set toolfindtext add findnexttext "Find Next" "',DBV,'/images/edit-find.png"'
wd 'set toolfindtext add findprevtext "Find Back" "',DBV,'/images/edit-find-1.png"'
wd 'cc findtext edit'
wd 'set findtext stylesheet *color:#000000;background-color:#ffffff'
wd 'cc toolrpltext toolbar 22x22'
wd 'set toolrpltext add replacetext "Replace in Selection" "',DBV,'/images/edit-find-replace.png"'
wd 'cc rpltext edit'
wd 'set rpltext stylesheet *color:#000000;background-color:#ffffff'
wd 'bin sz'
wd 'tabnew ASCII'
wd 'cc pb editm readonly'
wd 'set pb font ',DBH
wd 'set pb wrap 0'
wd 'set pb stylesheet *color:#000000;background-color:#dddddd'
wd 'set pb text *'
wd 'bin h'
wd 'cc toolfile toolbar 22x22'
wd 'set toolfile add openfile "Open File" "',DBV,'/images/system-file-manager.png"'
wd 'cc fileedit edit'
wd 'set fileedit stylesheet *color:#000000;background-color:#ffffff'
wd 'set fileedit text ',DBV,'/manifest.ijs'
wd 'bin z'
wd 'tabnew HTML'
if. UNAME-:'Android' do. wd 'cc hb edith;set hb wrap 0' else. wd 'cc hb webview' end.
wd 'bin h'
wd 'cc toolurl toolbar 22x22'
wd 'set toolurl add openurl "Set URL" "',DBV,'/images/applications-internet.png"'
wd 'cc urledit edit'
wd 'set urledit stylesheet *color:#000000;background-color:#ffffff'
wd 'set urledit text http://www.jsoftware.com'
wd 'bin z'
wd 'tabnew HREF'
wd 'splitv 1 1 400 200'
if. UNAME-:'Android' do. wd 'cc wb edith;set wb wrap 1' else. wd 'cc wb webview' end.
wd 'splitsep'
wd 'cc ub editm readonly'
wd 'set ub font ',DBH
wd 'set ub stylesheet *color:#000000;background-color:#ccffcc'
wd 'set ub text *'
wd 'tabnew isigrid'
wd 'cc isigridinfo static center'
wd 'set isigridinfo text isigrid is not yet fully implemented',LF,'grid is shown in a separate window' NB. remove
NB. wd 'cc ig isigrid'
wd 'splitend'
wd 'tabend'
if. 1=TBO do.
  wd 'splitend'
elseif. 2=TBO do.
  wd 'splitend'
  wd 'bin z'
  wd 'cc sbar statusbar'
  wd 'set sbar addlabel object'
  wd 'set sbar addlabel memory'
  wd 'set sbar addlabel exetim'
  wd 'set sbar addlabelp status'
end.
if. fexist jpath '~temp/tbk.tmp' do.
  wd 'pmove ',fread jpath '~temp/tbk.tmp'
end.
TBT=: '' NB. trace content of edit box
TBX=: 0  NB. trace changes in grid
TBY=: 1 0 0 0 0 0 NB. trace valid tabs
TBZ=: wd 'qd'
TBZ=: ('tb_select';'0 0 0 0') lookset ('tb';'0 0') lookset TBZ NB. jqt bug workaround
if. 2=TBO do. objectcheck'' end.
wd 'pshow'
)

NB.=====================================================================
NB.*tbk_build v build grid content, converting linked fields
tbk_build=: 3 : 0
TBH=: 0{TBK
TBR=: 0
TBC=: 0
TBL=: 0 = _1 { |: (,: '][') ss '][' ,"1 > t=. typesk ,:TBH
TBI=: ($TBH)$a:
if. 0=+/-.TBL do.                                   NB. there are not linked fields
  TBB=: frmt each bfi _1{TBK                        NB. just format table
else.                                               NB. there is some linked field
  z=. |: bfi _1{TBK
  for_i. I.-.TBL do.
    typ=. > i { t
    sel=. '[' ss typ
    ot=. k (_2 - -/ sel) {. (>: 0 {sel) }. typ      NB. linked table
    of=. _1 }. (>: 1 {sel) }. typ                   NB. linked field name
    ot=. kunbox of kcol ot                          NB. just relevant columns of linked table
    if. 1=1{$ot do. ot=. ot,"1 ot end.              NB. if linked field and key field are the same
    ot=. (<'k',>(<0 0){ ot) (<0 0)} ot              NB. prepend 'k' to key field name
    sel=. ;^:L. each i { z                          NB. values to be converted
    ot=. ((sel,.(": each sel),each<'(undefined)')kaddrow krow ot)kud ot NB. prevent index errors
    sel=. sel lookup (bfi _1{ot),'';'(undefined)'   NB. content of linked field
    z=. (boxopen sel) i} z                          NB. amend table with content of linked field
    ot=. kazsort (of;of,'k') kfield ot              NB. swap key and linked, then sort by linked
    sel=. DBS&escape@:frmt each , bfi of icol ot    NB. boxed list of values for combo control
    TBI=: (<sel) i} TBI
  end.
  TBB=: frmt each |: z
end.
if. +/5>(DBS,TAB,CR,LF,'\')i.;TBB do. NB. check if escape is necessary 
  TBB=: DBS&escape each TBB
end.
tbk_fill <0 0
)

NB.=====================================================================
NB.*tbk_revert v revert to dynaset from grid content
tbk_revert=: 3 : 0
if. 0=#y do.
  h=. TBH
  y=. TBB
  l=. TBL
else.
  h=. {.y
  y=. }.y
  l=. 0 = _1 { |: (,: '][') ss '][' ,"1 > typesk ,:h
end.
flag=. 0 < # '\' ss ;y                              NB. check if unescape is necessary 
if. 0=+/-.l do.                                     NB. there are not linked fields
  kcln kfbcheck h,DBS&unescape^:flag each y         NB. just check and clean current grid
else.                                               NB. there is some linked field
  t=. typesk ,:h
  obj=. kclncol |: checkrow DBS&unescape^:flag each y
  for_i. I.-.l do.
    typ=. > i { t
    sel=. '[' ss typ
    ot=. k (_2 - -/ sel) {. (>: 0 {sel) }. typ      NB. linked table
    of=. _1 }. (>: 1 {sel) }. typ                   NB. linked field name
    ot=. kunbox of kcol ot                          NB. just relevant columns of linked table
    if. 1=1{$ot do. ot=. ot,"1 ot end.              NB. if linked field and key field are the same
    ot=. (<'k',of) (<0 0)} ot                       NB. prepend 'k' to key field name
    ot=. (<":"1&>(<_1 0){ot) (<_1 0)} ot            NB. transform to string key field
    sel=. i { obj                                   NB. values to be reverted
    ot=. (((('(undefined)';'')&sr each sel),.sel) kaddrow krow ot)kud ot NB. prevent index errors
    ot=. frmt each bfi _1{ (of;'k',of) kfield ot    NB. swap key and linked field and format as boxed table
    sel=. sel lookup ot,('(undefined)';''),:'';''   NB. reverse content of linked field
    obj=. (boxopen sel) i} obj                      NB. amend table reversing content of linked field
  end.
  kcln kfbcheck h, |: obj
end.
)

NB.=====================================================================
NB.*tbk_fill v fill grid content
tbk_fill=: 3 : 0
'n m'=. $TBB
if. L.y do. NB. boxed argument when shape changes
  wd 'set tb shape 0 0'
  wd 'set tb hdr *'
  wd 'set tb lab *'
  wd 'set tb data *'
  wd 'set tb shape ',":n,m
  wd 'set tb hdr ',;(DEL&,)@:(,&DEL)each TBH
  wd 'set tb hdralign ',":m$1  NB. 0 left 1 center (all headers) 2 right
  wd 'set tb lab ',":i.n       NB. record labels
  wd 'set tb type ',":0*TBL    NB. 0 text (all) 10 for multi-line text 100 checkboxes 200 combolists 300 comboboxes 400 buttons
  wd 'set tb align ',":(+:-.((typek ,:TBH) e.<'string')+(typek ,:TBH) e.<'boxed')^TBL NB. 0 left (strings) 1 center (linked) 2 right (numbers)
  NB. wd 'set tb protect ',":-.TBL NB. 1 fixed (linked) 0 editable (other)
  wd 'set tb font ',DBY
  wd 'set tb background #',TBF
  wd 'set tb foreground #',TBG
end.
wd 'set tb data ',;(DEL&,)@:(,&DEL)each TBB
wd 'set tb resizecol'
if. 0<n*m do. tbk_tb_mark >y end.
)

NB.=====================================================================
NB.*tbk_t1_select v handle tab selection change
tbk_t1_select=: 3 : 0
if. 0<#y do.
  y=. ,y
  wd 'psel tbk'
  wd 'set t1 active ',y
else.
  TBZ=: wd 'qd'
  y=. 't1_select' lookup TBZ
end.
event_start't1';y
tbk_clean''
select. <y
case. ,'0' do. NB. Grid
  if. -.0{TBY do.
    tbk_build''
    TBX=: 0
    TBY=: TBY +. 1 0 0 0 0 0
  else.
    wd 'set tb resizecol'
  end.
case. ,'1' do. NB. Text
  if. -.1{TBY do.
    TBT=: }:^:(LF={:) DBS printk TBK
    wd 'set xb text *',TBT
    TBY=: TBY +. 0 1 0 0 0 0
  end.
case. ,'2' do. NB. ASCII
  if. -.2{TBY do.
    wd 'set pb text *',tostring 0&k :: ] TBK
    TBY=: TBY +. 0 0 1 0 0 0
  end.
case. ,'3' do. NB. HTML
  if. -.3{TBY do.
    res=. (('<h1>dbj html output</h1>';'')sr MYHTML),(dbjtohtml TBK),LF,'</body>',LF,'</html>',LF
    wd 'set hb ',(>(UNAME-:'Android'){'html';'text'),' *',res
    TBY=: TBY +. 0 0 0 1 0 0
  end.
case. ,'4' do. NB. HREF
  if. -.4{TBY do.
    res=. (('<h1>dbj href output</h1>';'')sr MYHREF),(dbjtohref 0&k :: ] TBK),LF,'</body>',LF,'</html>',LF
    wd 'set wb ',(>(UNAME-:'Android'){'html';'text'),' *',res
    wd 'set ub text *',res
    TBY=: TBY +. 0 0 0 0 1 0
  end.
case. ,'5' do. NB. isigrid
  if. -.5{TBY do.
    res=. frmt each bfk 0&k :: ] TBK
    hdr=. 1{.res
    res=. 1}.res
    'n m'=. $res
    wd 'pc isiviewer closeok' NB. remove
    wd 'pn isigrid ',19{. isotimestamp now'' NB. remove
    if. 0<n*m do.
      wd 'cc ig isigrid' NB. remove
      wd 'set ig shape ',":n,m
      wd 'set ig align ',":(+:-.((typek hdr) e.<'string')+(typek hdr) e.<'boxed')
      wd 'set ig hdr ',;(DEL&,)@:(,&DEL)each namesk hdr
      wd 'set ig lab ',":i.n  
      wd 'set ig data ',;(DEL&,)@:(,&DEL)each res
    end.
    wd 'pmove ',":(50+2{.".fread jpath '~temp/tbk.tmp'),640 480 NB. remove
    wd 'pshow' NB. remove
    wd 'psel tbk'  NB. remove
    TBY=: TBY +. 0 0 0 0 0 1
  end.
end.
event_stop't1'
)

NB.=====================================================================
NB.*tbk_tb_mark v handle cell selection in tb grid
tbk_tb_mark=: 3 : 0
if. 2=#y do.
  wd 'psel tbk'
  TBR=: _1
  TBC=: _1
else.
  TBZ=: wd 'qd'
  y=. 2{.0".'tb' lookup TBZ
end.
'row col'=. y
TBR=: row
TBC=: col
wd 'set nr text ',":TBR
wd 'set nc text ',":TBC
if. 2=#y do.
  wd 'set tb select ',":(TBR,TBC)
  wd 'set tb focus'
end.
)

NB.=====================================================================
NB.*tbk_tb_mbldown v handle left click in tb grid (update selection)
tbk_tb_mbldown=: 3 : 0
TBZ=: wd 'qd'
)

NB.=====================================================================
NB.*tbk_tb_mbrdbl v handle double right click in tb grid (edit by combo)
tbk_tb_mbrdbl=: 3 : 0
tbk_editcell_button''
)

NB.=====================================================================
NB.*tbk_tb_mbrdbl v handle double center click in tb grid (try to exec)
tbk_tb_mbmdbl=: 3 : 0
wd 'set queryedit text *k ''',(>(<TBR,TBC){TBB),''''
tbk_exec_button''
)

NB.=====================================================================
NB.*tbk_tb_change v handle changes in tb grid
tbk_tb_change=: 3 : 0
old=. (<TBR,TBC){TBB
if. L.y do.
  wd 'psel tbk'
  wd 'set tb cell ',(":TBR,TBC),' ',DEL,(>y),DEL
  wd 'set tb block'
else.
  TBZ=: wd 'qd'
  y=. <'tb' lookup TBZ
end.
if. TBC{TBL do. NB. not linked fields
  TBB=: y(<TBR,TBC)}TBB
else. NB. linked fields
  if. y e. >TBC{TBI do. NB. change confirmed
    TBB=: y(<TBR,TBC)}TBB
  else. NB. change canceled
    wdinfo 'Warning Linked Field';'Cell change not allowed',LF,'Please insert a valid value'
    wd 'psel tbk'
    wd 'set tb cell ',(":TBR,TBC),' ',DEL,(>old),DEL
    wd 'set tb block'
  end.
end.
if. 2=TBO do.
  if. 0<DBG_dbj_ do. NB. LOG enabled
    if. 1=DBG_dbj_ do.
      ('c=. 0 0$''''',LF) fappend jpath '~temp/dbk.log'
    end.
    c=. DBG_dbj_;(isotimestamp now'');'cg';(":TBR,TBC);y
    ('c=. c,',(5!:5 <'c'),LF) fappend jpath '~temp/dbk.log'
    DBG_dbj_=: >:DBG_dbj_
  end.
  if. 0<#DBX do. NB. macro record
    c=. (<. 1000*6!:1'');'cg';(":TBR,TBC);y
    ('c=. c,',(5!:5 <'c'),LF) fappend DBX
  end.
end.
if. 0<TBC do.
  tablegrid TBH,:TBR{TBB
else. NB. otherwise re-save whole table
  tablegrid''
end.
)

NB.=====================================================================
NB.*tbk_cleantable_button v handle click of cleantable button
tbk_cleantable_button=: 3 : 0
TBZ=: wd 'qd'
event_start,<'cleantable'
updategrid''
event_stop'cleantable'
)

NB.=====================================================================
NB.*tbk_insertrec_button v handle click of insertrec button
tbk_insertrec_button=: 3 : 0
TBZ=: wd 'qd'
event_start'insertrec';":TBR,TBC
'n m'=. $TBB
TBB=: (TBR{.TBB),(m#<''),(TBR-n){.TBB
tbk_fill <TBR,TBC
''tablegrid''
event_stop'insertrec'
)

NB.=====================================================================
NB.*tbk_appendcopy_button v handle click of appendcopy button
tbk_appendcopy_button=: 3 : 0
TBZ=: wd 'qd'
event_start'appendcopy';":TBR,TBC
TBB=: TBB,TBR{TBB
tbk_fill <(<:#TBB),TBC
''tablegrid''
event_stop'appendcopy'
)

NB.=====================================================================
NB.*tbk_deleterec_button v handle click of deleterec button
tbk_deleterec_button=: 3 : 0
TBZ=: wd 'qd'
event_start'deleterec';":TBR,TBC
TBB=: ((i.#TBB)-.TBR){TBB
tbk_fill <(TBR<.<:#TBB),TBC
tablegrid''
event_stop'deleterec'
)

NB.=====================================================================
NB.*tbk_removefield_button v handle click of removefield button
tbk_removefield_button=: 3 : 0
TBZ=: wd 'qd'
event_start'removefield';":TBR,TBC
sel=. (i.{:$TBB)-.TBC
TBH=: sel{TBH
TBL=: sel{TBL
TBI=: sel{TBI
TBB=: sel{"1 TBB
tbk_fill <TBR,TBC<.<:{:$TBB
tablegrid''
event_stop'removefield'
)

NB.=====================================================================
NB.*tbk_azsort_button v handle click of azsort button
tbk_azsort_button=: 3 : 0
TBZ=: wd 'qd'
event_start'azsort';":TBR,TBC
if. 0=TBC{TBL do.
  TBB=: TBB /: TBC {"1 TBB
else.
  if. TBC { ((typek ,:TBH) e.<'string')+(typek ,:TBH) e.<'boxed' do.
    TBB=: TBB /: TBC {"1 TBB
  else.
    TBB=: TBB /: (0&{)@(,&0)@(0&".) each TBC {"1 TBB
  end.
end.
tbk_fill TBR,TBC
tablegrid''
event_stop'azsort'
)

NB.=====================================================================
NB.*tbk_zasort_button v handle click of zasort button
tbk_zasort_button=: 3 : 0
TBZ=: wd 'qd'
event_start'zasort';":TBR,TBC
if. 0=TBC{TBL do.
  TBB=: TBB \: TBC {"1 TBB
else.
  if. TBC { ((typek ,:TBH) e.<'string')+(typek ,:TBH) e.<'boxed' do.
    TBB=: TBB \: TBC {"1 TBB
  else.
    TBB=: TBB \: (0&{)@(,&0)@(0&".) each TBC {"1 TBB
  end.
end.
tbk_fill TBR,TBC
tablegrid''
event_stop'zasort'
)

NB.=====================================================================
NB.*tbk_colwidth_button v handle click of colwidth button
tbk_colwidth_button=: 3 : 0
event_start,<'colwidth'
wd 'set tb resizecol'
event_stop'colwidth'
)

NB.=====================================================================
NB.*tbk_rowwidth_button v handle click of rowwidth button
tbk_rowwidth_button=: 3 : 0
event_start,<'rowwidth'
wd 'set tb resizerow'
event_stop'rowwidth'
)

NB.=====================================================================
NB.*tbk_zoomin_button v handle click of zoomin button
tbk_zoomin_button=: 3 : 0
event_start,<'zoomin'
fnt=. (] {.~ ' ' i:~ ]) DBY
siz=. ": <. 1.2 * 0 ". (] }.~ [: >: ' ' i:~ ]) DBY
DBY=: fnt,' ',siz
wd 'set tb block'
wd 'set tb font ',DBY
wd 'set tb resizecol'
wd 'set tb resizerow'
event_stop'zoomin'
)

NB.=====================================================================
NB.*tbk_zoomout_button v handle click of zoomout button
tbk_zoomout_button=: 3 : 0
event_start,<'zoomout'
fnt=. (] {.~ ' ' i:~ ]) DBY
siz=. ": 5 >. <. 1.2 %~ 0 ". (] }.~ [: >: ' ' i:~ ]) DBY
DBY=: fnt,' ',siz
wd 'set tb block'
wd 'set tb font ',DBY
wd 'set tb resizecol'
wd 'set tb resizerow'
event_stop'zoomout'
)

NB.=====================================================================
NB.*tbk_gridfont_button v handle click of gridfont button
tbk_gridfont_button=: 3 : 0
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb font ',DBY
end.
event_start'gridfont';mb
if. 0<#mb do.
  DBY=: mb
  wd 'set tb block'
  wd 'set tb font ',DBY
  wd 'set tb resizecol'
  wd 'set tb resizerow'
end.
event_stop'gridfont'
)

NB.=====================================================================
NB.*tbk_gridbackcolor_button v handle click of gridbackcolor button
tbk_gridbackcolor_button=: 3 : 0
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb color'
end.
event_start'gridbackcolor';mb
if. 0<#mb do.
  TBF=: ;('0'&,)^:(2>#)@:hfd each 0".mb
  wd 'set tb background #',TBF
end.
event_stop'gridbackcolor'
)

NB.=====================================================================
NB.*tbk_gridtextcolor_button v handle click of gridtextcolor button
tbk_gridtextcolor_button=: 3 : 0
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb color'
end.
event_start'gridtextcolor';mb
if. 0<#mb do.
  TBG=: ;('0'&,)^:(2>#)@:hfd each 0".mb
  wd 'set tb foreground #',TBG
end.
event_stop'gridtextcolor'
)

NB.=====================================================================
NB.*tbk_openxls_button v handle click of openxls button
tbk_openxls_button=: 3 : 0
TBZ=: wd 'qd'
if. 0<#y do.
  mb=. y
else.
  mb=. }:wd 'mb open "" "',(jpath '~user'),'" "Excel files (*.xls)"'
end.
event_start'openxls';mb
try.
  if. 0<#mb do.
    res=. kgetxls mb
    res updategrid''
  end.
catch.
  wdinfo'dbj error in tbk_openxls_button';13!:12''
end.
event_stop'openxls'
)

NB.=====================================================================
NB.*tbk_savexls_button v handle click of savexls button
tbk_savexls_button=: 3 : 0
TBZ=: wd 'qd'
if. 0<#y do.
  mb=. y
else.
  mb=. wd 'mb save "" "',(jpath '~user'),'" "Excel file (*.xls)"'
end.
event_start'savexls';mb
try.
  if. 0<#mb do.
    updategrid''
    (0&k TBK) writexls mb
  end.
catch.
  wdinfo'dbj error in tbk_savexls_button';13!:12''
end.
event_stop'savexls'
)

NB.=====================================================================
NB.*tbk_printtable_button v handle click of printtable button
tbk_printtable_button=: 3 : 0
wd 'mb print *',tostring kfb (namesk ,:TBH),TBB
)

NB.=====================================================================
NB.*tbk_copycells_button v handle click of copycells button
tbk_copycells_button=: 3 : 0
y=. 'tb_select' lookup TBZ
'r1 r2 c1 c2'=. 0".y
'r1 r2'=. (<./ , >./)r1,r2
'c1 c2'=. (<./ , >./)c1,c2
wd 'set tb select ',":r1,r2,c1,c2
sel=. (c1+i.>:c2-c1){"1 (r1+i.>:r2-r1){TBB
sel=. }:;(,&TAB each }:"1 sel),.(,&LF each {:"1 sel)
wd 'clipcopy ',sel
)

NB.=====================================================================
NB.*tbk_cctrl_fkey v handle Ctrl+C on table
tbk_cctrl_fkey=: 3 : 0
tbk_copycells_button''
)

NB.=====================================================================
NB.*tbk_pastecells_button v handle click of pastecells button
tbk_pastecells_button=: 3 : 0
y=. 'tb_select' lookup TBZ
'r1 r2 c1 c2'=. 0".y
r1=. r1<.r2
c1=. c1<.c2
'n m'=. $TBB
sel=. wd 'clippaste'
sel=. ([: <;._2 TAB ,~ ]) ;._2 sel,LF
rx=. (n&> # ]) r1+i.{.$sel
cx=. (m&> # ]) c1+i.{:$sel
for_r. rx do.
  for_c. cx do.
    s=. (<(r-r1),(c-c1)){sel
    if. (c{TBL)+.s e. >c{TBI do.
      TBB=: s (<r,c)}TBB
      wd 'set tb cell ',(":r,c),' ',DEL,(>s),DEL
    end.
  end.
end.
wd 'set tb block'
tbk_tb_mark r1,c1
tablegrid''
wd 'set tb select ',":(({.,{:)rx),({.,{:)cx
)

NB.=====================================================================
NB.*tbk_vctrl_fkey v handle Ctrl+V on table
tbk_vctrl_fkey=: 3 : 0
tbk_pastecells_button''
)

NB.=====================================================================
NB.*tbk_editcell_button v handle click of editcell button
tbk_editcell_button=: 3 : 0
if. 1=TBO do. wd 'set t0 enable 0' end.
wd 'set t1 enable 0'
wd 'pc tbkcell ptop dialog owner'
wd 'pn Cell ',":TBR,TBC
if. TBC{TBL do. NB. not linked field
  wd 'cc vb editm'
  wd 'set vb text *',DBS&unescape >(<TBR,TBC){TBB
else. NB. linked field
  wd 'cc vb combolist'
  r=. >TBC{TBI
  wd 'set vb items ',;,&' '@:(DEL&,)@:(,&DEL) each r
  wd 'set vb select ',":r i. TBC{TBR{TBB
end.
wd 'set vb font ',DBH
wd 'bin h'
wd 'cc acceptcell button;cn "Accept"'
wd 'cc discardcell button;cn "Discard"'
if. fexist jpath '~temp/tbk.tmp' do.
  wd 'pmove ',":(50+2{.".fread jpath '~temp/tbk.tmp'),300 200
end.
wd 'pshow'
)

NB.=====================================================================
NB.*tbkcell_acceptcell_button v handle click of acceptcell button
tbkcell_acceptcell_button=: 3 : 0
sel=. < DBS&escape 'vb' lookup wd 'qd'
wd 'pclose'
wd 'psel tbk'
if. 1=TBO do. wd 'set t0 enable 1' end.
wd 'set t1 enable 1'
tbk_tb_change sel
)

NB.=====================================================================
NB.*tbkcell_discardcell_button v handle click of discardcell button
tbkcell_discardcell_button=: 3 : 0
wd 'pclose'
wd 'psel tbk'
if. 1=TBO do. wd 'set t0 enable 1' end.
wd 'set t1 enable 1'
)

NB.=====================================================================
NB.*tbk_findnextcell_button v find next cell containing findcell
tbk_findnextcell_button=: 3 : 0
TBZ=: wd 'qd'
event_start'findnextcell';(":TBR,TBC);sel=. 'findcell' lookup TBZ
'n m'=. $TBB
if. (0=n*m)+.0=#sel do.
  wdinfo 'Find Next Cell';'Selection is empty'
else.
  res=. 0<,> #@:(sel&ss) each TBB
  if. 0<+/res do.
    res=. ((>:TBC+m*TBR)#0),(>:TBC+m*TBR)}.res
    if. 0<+/res do.
      res=. res i. 1
      res=. (<.res%m),(m|res)
      tbk_tb_mark res
    else.
      wdinfo 'Find Next Cell';'Not found after this point'
    end.
  else.
    wdinfo 'Find Next Cell';'Cell not found'
  end.
end.
event_stop'findnextcell'
)

NB.=====================================================================
NB.*tbk_findprevcell_button v find back cell containing findcell
tbk_findprevcell_button=: 3 : 0
TBZ=: wd 'qd'
event_start'findprevcell';(":TBR,TBC);sel=. 'findcell' lookup TBZ
'n m'=. $TBB
if. (0=n*m)+.0=#sel do.
  wdinfo 'Find Back Cell';'Selection is empty'
else.
res=. 0<,> #@:(sel&ss) each TBB
if. 0<+/res do.
    res=. ((TBC+m*TBR){.res),((n*m)-TBC+m*TBR)#0
    if. 0<+/res do.
      res=. res i: 1
      res=. (<.res%m),(m|res)
      tbk_tb_mark res
    else.
      wdinfo 'Find Back Cell';'Not found before this point'
    end.
  else.
    wdinfo 'Find Back Cell';'Cell not found'
  end.
end.
event_stop'findprevcell'
)

NB.=====================================================================
NB.*tbk_replacecell_button v replace findcell with rplcell in selected cell
tbk_replacecell_button=: 3 : 0
TBZ=: wd 'qd'
event_start'replacecell';(":TBR,TBC);(sel=. 'findcell' lookup TBZ);rpl=. 'rplcell' lookup TBZ
'n m'=. $TBB
if. (0=n*m)+.0=#sel do.
  wdinfo 'Replace Cell';'Selection is empty'
else.
  if. 0<res=. # sel  ss >(<TBR,TBC){TBB do.
    sel=. < (sel;rpl) sr >(<TBR,TBC){TBB
    if. (TBC{TBL)+.sel e. >TBC{TBI do.
      tbk_tb_change sel
      wdinfo 'Replace Cell';(":res),' match(es) replaced'
    else.
      wdinfo 'Replace Cell';'0 matches replaced (linked field)'
    end.
  else.
    wdinfo 'Replace Cell';'Match not found'
  end.
end.
event_stop'replacecell'
)

NB.=====================================================================
NB.*tbk_findnexttext_button v find next text containing findtext
tbk_findnexttext_button=: 3 : 0
TBZ=: wd 'qd'
event_start'findnexttext';(tsel=. 'xb_select' lookup TBZ);sel=. 'findtext' lookup TBZ
if. 0=#sel do.
  wdinfo 'Find Next Text';'Selection is empty'
else.
  txt=. 'xb' lookup TBZ
  res=. sel ss txt
  if. 0<#res do.
    res=. (res>{:0".tsel)#res
    if. 0<#res do.
      res=. {.res
      wd 'set xb select ',":res,res+#sel
      wd 'set xb focus'
    else.
      wdinfo 'Find Next Text';'Not found after this point'
    end.
  else.
    wdinfo 'Find Next Text';'Text not found'
  end.
end.
event_stop'findnexttext'
)

NB.=====================================================================
NB.*tbk_findprevtext_button v find back text containing findtext
tbk_findprevtext_button=: 3 : 0
TBZ=: wd 'qd'
event_start'findprevtext';(tsel=. 'xb_select' lookup TBZ);sel=. 'findtext' lookup TBZ
if. 0=#sel do.
  wdinfo 'Find Back Text';'Selection is empty'
else.
  txt=. 'xb' lookup TBZ
  res=. sel ss txt
  if. 0<#res do.
    res=. (res<{.0".tsel)#res
    if. 0<#res do.
      res=. {:res
      wd 'set xb select ',":res,res+#sel
      wd 'set xb focus'
    else.
      wdinfo 'Find Back Text';'Not found before this point'
    end.
  else.
    wdinfo 'Find Back Text';'Text not found'
  end.
end.
event_stop'findprevtext'
)

NB.=====================================================================
NB.*tbk_replacetext_button v replace findtext with rpltext in selected text
tbk_replacetext_button=: 3 : 0
TBZ=: wd 'qd'
event_start'replacetext';(tsel=. 'xb_select' lookup TBZ);(sel=. 'findtext' lookup TBZ);rpl=. 'rpltext' lookup TBZ
's1 s2'=. 0".tsel
if. (0=s2-s1)+.0=#sel do.
  wdinfo 'Replace Text';'Selection is empty'
else.
  txt=. 'xb' lookup TBZ
  mytext=. (s2-s1){.s1}.txt
  res=. sel ss mytext
  if. 0<#res do.
    mytext=. (sel;rpl) sr mytext
    wd 'set xb text *',(s1{.txt),mytext,(s2}.txt)
    wd 'set xb select ',":s1,s1+#mytext
    wd 'set xb focus'
    wdinfo 'Replace Text';(":#res),' match(es) replaced'
  else.
    wdinfo 'Replace Text';'Text not found in selection'
  end.
end.
event_stop'replacetext'
)

NB.=====================================================================
NB.*tbk_openfile_button v load in pb the file specified in fileedit
tbk_openfile_button=: 3 : 0
TBZ=: wd 'qd'
event_start'openfile';sel=. 'fileedit' lookup TBZ
if. fexist sel do.
  try.
    wd 'set pb text *',freads sel
    TBY=: TBY *. 1 1 0 1 1 1
  catch.
    wdinfo'dbj error in tbk_openfile_button';13!:12''
  end.
else.
  wdinfo'dbj error in tbk_openfile_button';'File does not exist'
end.
event_stop'openfile'
)

NB.=====================================================================
NB.*tbk_openurl_button v load in hb the url specified in urledit
tbk_openurl_button=: 3 : 0
TBZ=: wd 'qd'
event_start'openurl';sel=. 'urledit' lookup TBZ
try.
  wd 'set hb url ',sel
  TBY=: TBY *. 1 1 1 0 1 1
catch.
  wdinfo'dbj error in tbk_openurl_button';13!:12''
end.
event_stop'openurl'
)

NB.=====================================================================
NB.*tbk_ob_select v handle select changes in ob combo (object list)
tbk_ob_select=: 3 : 0
TBZ=: wd 'qd'
obj=. 'ob' lookup TBZ
wd 'set qb text *',}.^:(']'={.) (obj;'CALL') cell ke 'kinfo __'
)

NB.=====================================================================
NB.*tbk_eb_button v handle click of eb button (execute query)
tbk_eb_button=: 3 : 0
TBZ=: wd 'qd'
try.
  sel=. 't1_select' lookup TBZ
  qry=. 'qb' lookup TBZ
  y=. 'kquery=. 3 : 0',LF,qry,LF,')'
  0!:0 y
  y=. kquery''
  testk y
  TBK=: y
  tbk_update sel
catch.
  wdinfo'dbj error';13!:12''
end.
)

NB.=====================================================================
NB.*tbk_update v update content of tbk window
tbk_update=: 3 : 0
select. <y
case. ,'0' do. NB. Grid
  tbk_build''
  wd 'set xb text *'
  TBT=: ''
  TBX=: 0
  TBY=: 1 0 0 0 0 0
case. ,'1' do. NB. Text
  TBT=: }:^:(LF={:) DBS printk TBK
  wd 'set xb text *',TBT
  TBX=: 0
  TBY=: 0 1 0 0 0 0
case. ,'2' do. NB. ASCII
  wd 'set pb text *',tostring 0&k :: ] TBK
  wd 'set xb text *'
  TBT=: ''
  TBX=: 0
  TBY=: 0 0 1 0 0 0
case. ,'3' do. NB. HTML
  res=. (('<h1>dbj html output</h1>';'')sr MYHTML),(dbjtohtml TBK),LF,'</body>',LF,'</html>',LF
  wd 'set hb ',(>(UNAME-:'Android'){'html';'text'),' *',res
  wd 'set xb text *'
  TBT=: ''
  TBX=: 0
  TBY=: 0 0 0 1 0 0
case. ,'4' do. NB. HREF
  res=. (('<h1>dbj href output</h1>';'')sr MYHREF),(dbjtohref 0&k :: ] TBK),LF,'</body>',LF,'</html>',LF
  wd 'set wb ',(>(UNAME-:'Android'){'html';'text'),' *',res
  wd 'set ub text *',res
  wd 'set xb text *'
  TBT=: ''
  TBX=: 0
  TBY=: 0 0 0 0 1 0
case. ,'5' do. NB. isigrid
  res=. frmt each bfk 0&k :: ] TBK
  hdr=. 1{.res
  res=. 1}.res
  'n m'=. $res
  wd 'pc isiviewer closeok' NB. remove
  wd 'pn isigrid ',19{. isotimestamp now'' NB. remove
  if. 0<n*m do.
    wd 'cc ig isigrid' NB. remove
    wd 'set ig shape ',":n,m
    wd 'set ig align ',":(+:-.((typek hdr) e.<'string')+(typek hdr) e.<'boxed')
    wd 'set ig hdr ',;(DEL&,)@:(,&DEL)each namesk hdr
    wd 'set ig lab ',":i.n  
    wd 'set ig data ',;(DEL&,)@:(,&DEL)each res
  end.
  wd 'pmove ',":(50+2{.".fread jpath '~temp/tbk.tmp'),640 480 NB. remove
  wd 'pshow' NB. remove
  wd 'psel tbk'  NB. remove
  wd 'set xb text *'
  TBT=: ''
  TBX=: 0
  TBY=: 0 0 0 0 0 1
end.
)

NB.=====================================================================
NB.*tbk_clean v clean content of tbk window
tbk_clean=: 3 : 0
if. -.0=4!:0<'xb' do.
  wd 'psel tbk'
  xb=. 'xb' lookup wd'qd'
end.
if. TBX do.
  TBK=: tbk_revert''
  TBX=: 0
  TBY=: 0 0 0 0 0 0
elseif. -.TBT-:xb do.
  TBN=: '*'
  TBK=: DBS ktable xb
  TBT=: xb
  TBY=: 0 0 0 0 0 0
end.
)

NB.=====================================================================
NB.*tbk_close v handle close of tbk window
tbk_close=: 3 : 0
tbk_clean''
(": wd 'qform') fwrite jpath '~temp/tbk.tmp'
if. 2=TBO do.
  for_l. i.DBU do.
    ferase jpath '~temp/',DBN,'-',(":l),'.bak'
  end.
  wd'pclose'
  DBJ_dbj_=: 0
  sel=. DBL
  closek''
  if. (''-:y) do.
    DBG_dbj_=: 0
    if. (<('''';'')sr>{:;:>{:ARGV) e. sel do. exit 0 end.
  end.
else.
  wd 'pclose'
end.
)

sys_timer_z_=: sys_timer_dbj_