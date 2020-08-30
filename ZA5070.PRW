#Include 'Protheus.ch'
#INCLUDE "TBICONN.CH"

USER FUNCTION ZA5070()

 

PRIVATE cCadastro  := "Cadastro dos Parâmetros de Integração"


PRIVATE aRotina := { { OemToAnsi("Pesquisar")  ,"AxPesqui"   ,0,1},;  //"Pesquisar"
      { OemToAnsi("Visual")  ,"AxAlter"  ,0,2},;  //"Visual"
      { OemToAnsi("Incluir")  ,"AxInclui"  ,0,3},;  //"Incluir"
      { OemToAnsi("Alterar")  ,"AxAlter"  ,0,4},;  //"Alterar"
      { OemToAnsi("Exclusao")  ,"AxAlter"  ,0,5} }  //"Exclusao"  
      
      DBSELECTAREA("ZA5")
      DBSETORDER(1)

AxCadastro("ZA5", "Cadastro dos Parâmetros de Integração",".T.",".T.")

 

Return Nil