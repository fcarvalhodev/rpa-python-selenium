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

*** Test Cases ***
Validate Unsucessful Login
    Open the browser with the Mortgage payment url
    Fill the login Form
    Wait until it checks and display error message
    Verify error message is correct

*** Keywords ***
Fill the login Form
    Input Text       id:username        ${user_name}
    Input Password   id:password        ${invalid_password}
    Click Button     signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}


Verify error message is correct
  ${result}=  Get Text    css:.alert-danger
  Should Be Equal As Strings    ${result}   Incorrect username/password.
  Element Text Should Be        ${Error_Message_Login}  Incorrect username/password.