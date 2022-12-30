# Declaração de módulo abaixo, no caso, módulo Settings.
*** Settings ***
#Documentation é para descrever o que o teste faz. Ter atenção ao espaço,
# Robot framework espera que tenhamos '1 tab' de espaço entre a declaração e o valor.
Documentation   To validate the Login form
#Bibliotecas e imports necessários. Tenha certeza do nome das referências, e não esqueça do tab ao invés de space.
Library    SeleniumLibrary
Documentation    To validate the login form
Library    SeleniumLibrary

*** Test Cases ***
Validate Unsucessful Login
    Open the browser with the Mortgage payment url
    Fill the login Form
    Wait until it checks and display error message
    Verify error message is correct

#No teste acima, as keywords ainda não foram criadas,
#em seguida nós precisamos criar e atrelar as keywords do Selenium
#Para isso vamos importa outro módulo chamado KeyWords,
#com isso teremos 3 módulos declarados até o momento, settings, test cases e keywords

*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome  executable_path=./webdriver/chrome/chromedriver.exe
    Go To    https://rahulshettyacademy.com/loginpagePractise/

#Na declaração do caso de teste acima nós atrelamos duas key words,
#que é a de criação do webdriver e acesso ao site.*** Keywords ***

Fill the login Form
    Input Text       id:username        rahulshettyacademy
    Input Password   id:password        12345678
    Click Button     signInBtn

#Observação, nos campos acima, nós estamos utilizando o id dos elementos html na DOM

Wait until it checks and display error message
    Wait Until Element Is Visible    css:.alert-danger


Verify error message is correct
  ${result}=  Get Text    css:.alert-danger
  #result é uma variável declarada dentro desse escopo que recebe o valor de Get Text do elemento indicado.
  Should Be Equal As Strings    ${result}   Incorrect username/password.