#include "rwmake.ch"
#include "protheus.ch"
#INCLUDE "REPORT.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±                                  

±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ"±±
±±ºPrograma ³RAPIDR01 ºAutor ³Microsiga º Data ³ 01/28/14 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc. ³ º±±
±±º ³ º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso ³ AP º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RapidR02()
local oReport := nil
Private cPerg := 'rapid2'

AjustaSx1()
oReport := reportDef()
oReport:printDialog() 
Return 




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ"±±
±±ºPrograma ³RAPIDR01 ºAutor ³Microsiga º Data ³ 01/28/14 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc. ³ º±±
±±º ³ º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso ³ AP º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
static function reportDef()
local cTitulo := '[RapidR01] - Impressão de Movimentos RapidAr'
Local aOrdem :={"Data","Conta","Iata","Status"} 
local oReport
local oSection
local oSection2


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao ³
//³ ³
//³TReport():New ³
//³ExpC1 : Nome do relatorio ³
//³ExpC2 : Titulo ³
//³ExpC3 : Pergunte ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ³
//³ExpC5 : Descricao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport := TReport():New('RapidR02', cTitulo,cPerg , {|oReport| PrintReport(oReport)},"Este relatorio ira imprimir a relacao de movimentos do RapidAr.")

oSection := TRSection():New(oReport,"Rapid",{"QRY"},aOrdem,.f.,.f.)

//TRCell():New(oParent, cName, cAlias, cTitle, cPicture, nSize, lPixel, bBlock, cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)

TRCell():new(oSection, "ZA2_IATA" , "QRY", 'IATA' ,PesqPict('ZA2',"ZA2_IATA") ,TamSX3("ZA3_CONTA")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "A1_NOME" , "QRY", 'NOME' ,PesqPict('SA1',"A1_NOME") ,TamSX3("A1_NOME")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "ZA2_VALOR" , "QRY", 'VALOR' ,PesqPict('SE1',"E1_VALOR") ,TamSX3("ZA2_VALOR")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "ZA2_ACFIN" , "QRY", 'ACAO' ,PesqPict('SA1',"ZA2_ACFIN") ,TamSX3("ZA2_ACFIN")[1]+5,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "ZA2_CHFIN" , "QRY", 'TITULO FIN' ,PesqPict('ZA2',"ZA2_ACFIN") ,TamSX3("E2_PREFIXO")[1]+TamSX3("E2_NUM")[1]+TamSX3("E2_TIPO")[1]+13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "ZA2_CHCTB" , "QRY", 'REGISTRO CTB' ,PesqPict('ZA2',"ZA2_ACFIN") ,TamSX3("CT2_LOTE")[1]+TamSX3("CT2_SBLOTE")[1]+TamSX3("CT2_DOC")[1]+13,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )
TRCell():new(oSection, "ZA2_DATA" , "QRY", 'DATA' ,PesqPict('ZA2',"ZA2_DATA") ,10,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" )



oSection:SetLineBreak()
oSection:SetHeaderPage()
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a secao detalhamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection2 := TRSection():New( oSection, "Detalhamento", {"ZA4"} ) //"Movimentação"
TRCell():new(oSection2, "ZA4_NATURE" , "QRY2", 'COD. NATUREZA' ,PesqPict('ZA4',"ZA4_NATURE") ,TamSX3("ZA4_NATURE")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" ) 
TRCell():new(oSection2, "ED_DESCRIC" , "QRY2", 'DESCRICAO' ,PesqPict('SED',"ED_DESCRIC") ,TamSX3("ED_DESCRIC")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" ) 
TRCell():new(oSection2, "ZA4_VALOR" , "QRY2", 'VALOR' ,PesqPict('SE1',"E1_VALOR") ,TamSX3("E1_VALOR")[1]+1,/*lPixel*/,/*{|| code-block de impressao }*/,,,"CENTER" ) 

oReport:SetLandScape()
oReport:DisableOrientation()
                                                 
Return oReport




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ"±±
±±ºPrograma ³RAPIDR01 ºAutor ³Microsiga º Data ³ 01/28/14 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc. ³ º±±
±±º ³ º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso ³ AP º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport)
Local oSection := oReport:Section(1)
Local oSection2 := oSection:Section(1)
Local cQuery
Local nOrdem :=oSection:GetOrder() 
Local aAreaQRY :={}

dbSelectArea('SA2')
DBSETORDER(10)
dbSelectArea('SA1')
DBSETORDER(9)
dbSelectArea('SED')
DBSETORDER(4)

Pergunte( cPerg , .F. )

//If Select("QRY") > 0
// QRY->(dbCloseArea())
//Endif

cQuery := " SELECT * FROM " + RetSqlName("ZA2")
cQuery += " WHERE "
//cQuery += " ZA2_CONTA BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND "
cQuery += " ZA2_IATA BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' AND "

IF MV_PAR07==1
cQuery += " ZA2_DATA BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' AND "
ELSE
cQuery += " ZA2_DTPROC BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' AND "
ENDIF 

DO CASE

CASE MV_PAR08==1

cQuery += "ZA2_ACFIN='CR' AND "

CASE MV_PAR08==2

cQuery += "ZA2_ACFIN='CP' AND "

ENDCASE


DO CASE

CASE MV_PAR09==1

cQuery += "ZA2_STATUS='E' AND "

CASE MV_PAR09==2

cQuery += "ZA2_STATUS='N' AND "

CASE MV_PAR09==3

cQuery += "ZA2_STATUS='I' AND "

ENDCASE



cQuery += " D_E_L_E_T_ = ' ' "

DO CASE
CASE nOrdem=1 .AND. MV_PAR07==1
cQuery += " ORDER BY ZA2_DATA,ZA2_LINHA"
CASE nOrdem=1 .AND. MV_PAR07==2
cQuery += " ORDER BY ZA2_DTPROC,ZA2_LINHA"
CASE nOrdem=2
cQuery += " ORDER BY ZA2_IATA"
CASE nOrdem=3
cQuery += " ORDER BY ZA2_ACFIN"
ENDCASE


dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY",.F.,.F.)
QRY->( dbGoTop() )

While !oReport:Cancel() .And. !QRY->(Eof())
oSection:Init()
oSection:Cell("ZA2_IATA"):SetValue(QRY->ZA2_IATA)
oSection:Cell("ZA2_IATA"):SetAlign("LEFT")

IF QRY->ZA2_ACFIN=='CR' 
if SA1->(Dbseek(XFILIAL("SA1")+QRY->ZA2_IATA))
cClifor:=ALLTRIM(SA1->A1_NOME )
else
cClifor:='Iata não encontrado no cad. cli'
endif

ELSE

if SA2->(Dbseek(XFILIAL("SA2")+QRY->ZA2_IATA))
cClifor:=ALLTRIM(SA2->A2_NOME )
else
cClifor:='Iata não encontrado no cad. Forn'
endif

ENDIF 

oSection:Cell("A1_NOME"):SetValue(cClifor)
oSection:Cell("A1_NOME"):SetAlign("RIGHT")





oSection:Cell("ZA2_VALOR"):SetValue(QRY->ZA2_VALOR)
oSection:Cell("ZA2_VALOR"):SetAlign("RIGHT")


cAcao:= IF (!EMPTY(QRY->ZA2_ACFIN),'-'+QRY->ZA2_ACFIN,'')

oSection:Cell("ZA2_ACFIN"):SetValue(QRY->ZA2_STATUS+ cAcao)
oSection:Cell("ZA2_ACFIN"):SetAlign("CENTER")
cChave:=''
IF QRY->ZA2_ACFIN=='CR' .and. !empty(QRY->ZA2_CHFIN)
SE1->(DBGOTO(QRY->ZA2_CHFIN))
cChave:='PRE:'+SE1->E1_PREFIXO+'/NUM:'+SE1->E1_NUM+'/TP:'+SE1->E1_TIPO
ENDIF
IF QRY->ZA2_ACFIN=='CP' .and. !empty(QRY->ZA2_CHFIN)
SE2->(DBGOTO(QRY->ZA2_CHFIN))
cChave:='PRE:'+SE2->E2_PREFIXO+'/NUM:'+SE2->E2_NUM+'/TP:'+SE2->E2_TIPO
ENDIF

oSection:Cell("ZA2_CHFIN"):SetValue(cChave)
oSection:Cell("ZA2_CHFIN"):SetAlign("LEFT")

cChave:=''
IF !EMPTY(QRY->ZA2_CHCTB )
CT2->(DBGOTO(QRY->ZA2_CHCTB))
cChave:='LT:'+CT2->CT2_LOTE+"/SBL:"+CT2->CT2_SBLOTE+"/DOC:"+CT2->CT2_DOC 
ENDIF


oSection:Cell("ZA2_CHCTB"):SetValue(cChave)
oSection:Cell("ZA2_CHCTB"):SetAlign("LEFT")                                      

IF MV_PAR07==1
cData:=DTOCY(STOD(QRY->ZA2_DATA))
else
cData:=DTOCY(STOD(QRY->ZA2_DTPROC))
endif

oSection:Cell("ZA2_DATA"):SetValue(cData)
oSection:Cell("ZA2_DATA"):SetAlign("CENTER")

oSection:PrintLine()


aAreaQRY := GetArea('QRY')

cQuery := " SELECT * FROM " + RetSqlName("ZA4")
cQuery += " WHERE ZA4_LOTE='"+QRY->ZA2_LOTE+"' AND ZA4_IATA='"+ QRY->ZA2_IATA+"'"
cQuery += " AND D_E_L_E_T_ = ' ' "
cQuery += " ORDER BY ZA4_LINHA"

dbuseArea(.T.,"TopConn",TCGenQry(,,cQuery),"QRY2",.F.,.F.)
QRY2->( dbGoTop() )

While !oReport:Cancel() .And. !QRY2->(Eof())
oSection2:Init()

oSection2:Cell("ZA4_NATURE"):SetValue(QRY2->ZA4_NATURE)
oSection2:Cell("ZA4_NATURE"):SetAlign("LEFT")


if SED->(Dbseek(XFILIAL("SED")+QRY2->ZA4_NATURE))
cDescric:=ALLTRIM(SED->ED_DESCRIC )
else
cDescric:='Natureza nao cadastrada'
endif


oSection2:Cell("ED_DESCRIC"):SetValue(cDescric)
oSection2:Cell("ED_DESCRIC"):SetAlign("LEFT")




oSection2:Cell("ZA4_VALOR"):SetValue(QRY2->ZA4_VALOR)
oSection2:Cell("ZA4_VALOR"):SetAlign("RIGHT")
oSection2:PrintLine()
QRY2->(dbSkip())
EndDo
QRY2->(dbCloseArea()) 
oReport:SkipLine()
oReport:SkipLine()
oReport:ThinLine()
oReport:ThinLine()
oReport:SkipLine()
oReport:SkipLine()
oReport:SkipLine()

oSection2:Finish()
RestArea(aAreaQRY) 
dbSelectArea("QRY")
QRY->(dbSkip())
EndDo
QRY->(dbCloseArea())
Return 




/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o ³AjustaSx1 ³ Autor ³Rubens Simi ³ Data ³ 28/01/14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Ajusta SX1 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSx1()

Local aArea := GetArea()
Local nTamConta := TamSX3("CT1_CONTA")[1]



aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Conta contabil Inicial' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'01','Conta contábil inicial ?','¿Cuenta contable inicial ?','Initial ledger account ?','MV_CH1','C',nTamConta,0,0,'G','','CT1','003','S','mv_par01','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)


aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Conta contabil Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'02','Conta contábil final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH2','C',nTamConta,0,0,'G','','CT1','003','S','mv_par02','','','','ZZZZZZZZZZZZZZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Cod Iata Final' ) // fazer consulta padrao!!!!!!!!!!!!!!!!!!!!!!!!!
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'03','Cod Iata Inicial ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH3','C',7,0,0,'G','','IATA','003','S','mv_par03','','','','','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)



aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Cod Iata Final' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cperg,'04','Cod Iata final ?','¿Cuenta contable final ?','Final ledger account ?','MV_CH4','C',7,0,0,'G','','IATA','003','S','mv_par04','','','','ZZZZZZZ','','','','','','','','','','','','',aHelpPor,aHelpEng,aHelpSpa)

aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Data inicial do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "05","Data de?" ,"¿De Adquisicion ? " ,"Acquisition from ? " ,"mv_ch5","D",8,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)




aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Data Final do movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "06","Data até?" ,"¿A Adquisicion ? " ,"Acquisition To ? " ,"mv_ch6","D",8,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)



aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Considera Data do movimento ou integracao' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "07","Considera ?","¿Considera ?","Consider ?","mv_ch7","N",1,0,1,"C","","","","","MV_PAR07","Movimento","","","","Integracao","","","" ,"" ,"","","","","","","",aHelpPor,aHelpSpa,aHelpSpa)




aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Considera qual tipo de movimento' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "08","Tipo de Movi ?","","","mv_ch8","N",1,0,1,"C","","","","","MV_PAR08","Receber","","","","Pagar","","","Todos","" ,"","","","","","","",aHelpPor,aHelpSpa,aHelpEng)

aHelpPor := {}
aHelpEng := {}
aHelpSpa := {} 
Aadd( aHelpPor, 'Considera qual Situação' )
Aadd( aHelpSpa, ' ' )
Aadd( aHelpEng, ' ' )
PutSx1( cPerg, "09","Tipo de Sit ?","","","mv_ch9","N",1,0,1,"C","","","","","MV_PAR09","Inconsistente","","","","Não Integrados","","","Integrados" ,"" ,"","Todos","","","","","",aHelpPor,aHelpSpa,aHelpEng)


RestArea(aArea)

Return
 
