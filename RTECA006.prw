#include "protheus.ch"
#include "topconn.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  RTECA006   �Autor  �Rubens Simi        � Data �  31/08/20    ���
�������������������������������������������������������������������������͹��
���Desc.     �Axcadastro da tabela PKL                           .        ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function  RTECA006 ()
Local aArea   := GetArea()
Local oBrowse
Local cFunBkp := FunName()
     
    SetFunName("RTECA006")
     
    //Inst�nciando FWMBrowse - Somente com dicion�rio de dados
    oBrowse := FWMBrowse():New()
     
    //Setando a tabela de cadastro de Autor/Interprete
    oBrowse:SetAlias("PKL")
 
    //Setando a descri��o da rotina
    oBrowse:SetDescription(cTitulo)
     
    //Legendas
    oBrowse:AddLegend( "PKL->PKL_COD <= '000005'", "GREEN",    "Menor ou igual a 5" )
    oBrowse:AddLegend( "PKL->PKL_COD >  '000005'", "RED",    "Maior que 5" )
     
    //Filtrando
    //oBrowse:SetFilterDefault("PKL->PKL_COD >= '000000' .And. PKL->PKL_COD <= 'ZZZZZZ'")
     
    //Ativa a Browse
    oBrowse:Activate()
     
    SetFunName(cFunBkp)
    RestArea(aArea)
Return Nil
 
/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o do menu MVC                                          |
 *---------------------------------------------------------------------*/
 
Static Function MenuDef()
    Local aRot := {}
     
    //Adicionando op��es
    ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.RTECA006' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_pklleg'      OPERATION 6                      ACCESS 0 //OPERATION X
    ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.RTECA006' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.RTECA006' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.RTECA006' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
 
Return aRot
 
/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
 
Static Function ModelDef()
    //Cria��o do objeto do modelo de dados
    Local oModel := Nil
     
    //Cria��o da estrutura de dados utilizada na interface
    Local oStPKL := FWFormStruct(1, "PKL")
     
    //Editando caracter�sticas do dicion�rio
    oStPKL:SetProperty('PKL_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edi��o
    oStPKL:SetProperty('PKL_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("PKL", "PKL_COD")'))         //Ini Padr�o
    oStPKL:SetProperty('PKL_DESC',  MODEL_FIELD_VALID,   FwBuildFeature(STRUCT_FEATURE_VALID,   'Iif(Empty(M->PKL_DESC), .F., .T.)'))   //Valida��o de Campo
    oStPKL:SetProperty('PKL_DESC',  MODEL_FIELD_OBRIGAT, Iif(RetCodUsr()!='000000', .T., .F.) )                                         //Campo Obrigat�rio
     
    //Instanciando o modelo, n�o � recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
    oModel := MPFormModel():New("pklmodel",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
     
    //Atribuindo formul�rios para o modelo
    oModel:AddFields("FORMPKL",/*cOwner*/,oStPKL)
     
    //Setando a chave prim�ria da rotina
    oModel:SetPrimaryKey({'PKL_FILIAL','PKL_COD'})
     
    //Adicionando descri��o ao modelo
    oModel:SetDescription("Cadastro de Celulas"+cTitulo)
     
    //Setando a descri��o do formul�rio
    oModel:GetModel("FORMPKL"):SetDescription("Formul�rio do Cadastro "+cTitulo)
Return oModel
 
/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o da vis�o MVC                                         |
 *---------------------------------------------------------------------*/
 
Static Function ViewDef()
    Local aStruPKL    := PKL->(DbStruct())
     
    //Cria��o do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
    Local oModel := FWLoadModel("RTECA006")
     
    //Cria��o da estrutura de dados utilizada na interface do cadastro de Autor
    Local oStPKL := FWFormStruct(2, "PKL")  //pode se usar um terceiro par�metro para filtrar os campos exibidos { |cCampo| cCampo $ 'SPKL_NOME|SPKL_DTAFAL|'}
     
    //Criando oView como nulo
    Local oView := Nil
 
    //Criando a view que ser� o retorno da fun��o e setando o modelo da rotina
    oView := FWFormView():New()
    oView:SetModel(oModel)
     
    //Atribuindo formul�rios para interface
    oView:AddField("VIEW_PKL", oStPKL, "FORMPKL")
     
    //Criando um container com nome tela com 100%
    oView:CreateHorizontalBox("TELA",100)
     
    //Colocando t�tulo do formul�rio
    oView:EnableTitleView('VIEW_PKL', 'Dados - '+cTitulo )  
     
    //For�a o fechamento da janela na confirma��o
    oView:SetCloseOnOk({||.T.})
     
    //O formul�rio da interface ser� colocado dentro do container
    oView:SetOwnerView("VIEW_PKL","TELA")
     
    /*
    //Tratativa para remover campos da visualiza��o
    For nAtual := 1 To Len(aStruPKL)
        cCampoAux := Alltrim(aStruPKL[nAtual][01])
         
        //Se o campo atual n�o estiver nos que forem considerados
        If Alltrim(cCampoAux) $ "PKL_COD;"
            oStPKL:RemoveField(cCampoAux)
        EndIf
    Next
    */
Return oView
 
/*/{Protheus.doc} pklleg
Fun��o para mostrar a legenda
@author Atilio
@since 31/07/2016
@version 1.0
    @example
    u_pklleg()
/*/
 
User Function pklleg()
    Local aLegenda := {}
     
    //Monta as cores
    AADD(aLegenda,{"BR_VERDE",        "Menor ou igual a 5"  })
    AADD(aLegenda,{"BR_VERMELHO",    "Maior que 5"})
     
    BrwLegenda(cTitulo, "Status", aLegenda)
Return
