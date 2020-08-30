#Include 'Protheus.ch'
#INCLUDE "TBICONN.CH"

USER FUNCTION ZAA070()

 

PRIVATE cCadastro  := "Cadastro das Aliquotas de ISS"
teste

PRIVATE aRotina := { { OemToAnsi("Pesquisar")  ,"AxPesqui"   ,0,1},;  //"Pesquisar"
      { OemToAnsi("Visual")  ,"AxAlter"  ,0,2},;  //"Visual"
      { OemToAnsi("Incluir")  ,"AxInclui"  ,0,3},;  //"Incluir"
      { OemToAnsi("Alterar")  ,"AxAlter"  ,0,4},;  //"Alterar"
      { OemToAnsi("Exclusao")  ,"AxAlter"  ,0,5} }  //"Exclusao"  
      
      DBSELECTAREA("ZAA")
      DBSETORDER(1)

AxCadastro("ZAA", "Cadastro das Aliquotas de ISS",".T.",".T.")

 

Return Nil
