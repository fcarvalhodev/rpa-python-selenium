*** Settings ***
Documentation   To validate the Login form
Library    SeleniumLibrary

Test Setup      Open The Browser With The Mortgage Payment Url
#test setup executa ao inicio do teste
#no nosso casos, ele vai triggar o primeiro teste case, e executar o teste completo
#até chegar no teardown e fechar o browser.
#no caso deste arquivo de teste ele irá puxar do resource, e posso reutilizar em outros testes

Test Teardown    Close Browser Session
Resource         resource.robot

*** Variables ***
${Error_Message_Login}       css:.alert-danger
${Shop_Page_Load}            css.nav-link

*** Test Cases ***
Validate Unsucessful Login
    Open the browser with the Mortgage payment url
    Fill the login Form     ${user_name}        ${invalid_password}
    Wait until it Element is located in the page    ${Error_Message_Login}
    Verify error message is correct

Validate Cards display in the Shopping Page
    Fill The Login Form     ${user_name}        ${valid_password}
    Wait until it Element is located in the page    ${Shop_Page_Load}

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