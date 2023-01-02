*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary
Library    Collections

Test Setup      Open The Browser With The Mortgage Payment Url
#test setup executa ao inicio do teste
#no nosso casos, ele vai triggar o primeiro teste case, e executar o teste completo
#até chegar no teardown e fechar o browser.
#no caso deste arquivo de teste ele irá puxar do resource, e posso reutilizar em outros testes

Test Teardown    Close Browser Session
Resource         resource.robot

*** Variables ***
${Error_Message_Login}       css:.alert-danger
${Shop_Page_Load}            css:.nav-link

*** Test Cases ***
#Validate Unsucessful Login
#    Open the browser with the Mortgage payment url
#    Fill the login Form     ${user_name}        ${invalid_password}
#    Wait until it Element is located in the page    ${Error_Message_Login}
#    Verify error message is correct

Validate Cards display in the Shopping Page
    Fill The Login Form     ${user_name}        ${valid_password}
    Wait until it Element is located in the page    ${Shop_Page_Load}
    Verify Card Titles In The Shop Page
    Select The Card     Nokia Edge

*** Keywords ***
Fill the login Form
    [Arguments]     ${username}     ${password}
    #argumentos passados via parametro.
    Input Text       id:username        ${username}
    Input Password   id:password        ${password}
    Click Button     signInBtn

Wait until it Element is located in the page
    [Arguments]     ${element}
    Wait Until Element Is Visible    ${element}

Verify error message is correct
  ${result}=  Get Text    css:.alert-danger
  Should Be Equal As Strings    ${result}   Incorrect username/password.
  Element Text Should Be        ${Error_Message_Login}  Incorrect username/password.

#Este método cria uma lista de elementos com base no seus card title
#O log, ecreve o valor do laço FOR em um arquivo para verificação
#Note que as variáveis foram declaradas com iterators mas depois foi utilizado o $ novamente.
#Nesse caso é para representar as listas.
Verify Card Titles In The Shop Page
    @{expectedList} =  Create List     iphone X     Samsung Note 8      Nokia Edge      Blackberry
    ${elements} =     Get Webelements    css:.card-title
    @{actualList} =    Create List
    FOR     ${element}  IN      @{elements}
       Log     ${element.text}
       Append To List       ${actualList}       ${element.text}
    END
    Lists Should Be Equal        ${expectedList}     ${actualList}

#Função genérica que busca um item pelo seu índice.
Select The Card
    [Arguments]     ${cardName}
    ${elements} =     Get Webelements    css:.card-title
    ${index}=   Set Variable    0
    FOR     ${element}  IN      @{elements}
               Exit For Loop If     '${cardName}' == '${element.text}'
               ${index}=   Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button[@class='btn btn-info']