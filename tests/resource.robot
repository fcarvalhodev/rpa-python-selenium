*** Settings ***
Documentation    A resource file with reusable keywords and variabels.
...
...             The system specific keywords created here from our own
...             domain specific language. They utilize keywords provided
...             by the imported SeleniumLibrary.
Library         SeleniumLibrary
Library         OperatingSystem

*** Variables ***
${user_name}            rahulshettyacademy
${invalid_password}     12345678
${url}                  https://rahulshettyacademy.com/loginpagePractise/
${valid_password}       learning

*** Keywords ***
Open the browser with the Mortgage payment url
    Create Webdriver    Chrome  executable_path=./webdriver/chrome/chromedriver.exe
    Go To               ${url}

Close Browser Session
    Close Browser