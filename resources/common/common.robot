*** Settings ***
Library           Selenium2Library
Library           String
Library           Collections
Resource          item_variables.robot
Resource          ../home/home_page_locators.robot

*** Keywords ***
Open JupiterToys Homepage
    [Documentation]    Open google chrome and navigate to JupiterToys Homepage
    Create Webdriver    Chrome    executable_path=C:/Python35/Scripts/TestProject/chromedriver.exe
    Maximize Browser Window
    Go To    ${URL}
    Wait Until Page Contains    Welcome to Jupiter Toys, a magical world for good girls and boys.
    Log    Jupiter Toys Homepage was successfully loaded.

The ${link_name} Page Is Open
    [Documentation]    Navigate to another page from Jupiter Toys HomePage
    Open JupiterToys Homepage
    Click Element    ${${link_name.upper()}}
    Wait Until Location Contains    /#/${link_name.lower()}
    Log    ${link_name} Page was successfully loaded.
    Sleep    1

User Clicks ${button_name} Button
    [Documentation]    Clicks Button Link that is present on the current Page.
    Sleep    2
    Wait Until Page Contains Element    ${${button_name.upper()}}    40
    Click Element    ${${button_name.upper()}}

Error Text ${field_name} Is Required Should Be Displayed
    [Documentation]    Verifies that error message is present in the page based on the supplied error text
    Wait Until Page Contains    We welcome your feedback - but we won't get it unless you complete the form correctly.    30
    Page Should Contain Element    ${${field_name.upper()}_ERROR}
    Page Should Contain    ${field_name} is required

Input Field Value
    [Arguments]    ${field}    ${field_val}
    [Documentation]    Enters a value on a specified field
    ...    Parameters needed are field name and field value
    Input Text    id=${field.lower()}    ${field_val}
    Set Test Variable    ${${field}}    ${field_val}
    Log    ${field} Field was populated with ${field_val}

Convert Price To Number
    [Arguments]    ${price_str}
    ${price}=    Remove String    ${price_str}    $
    ${price}=    Convert To Number    ${price}
    [Return]    ${price}

Get Item ${item_attribute} from ${item_name} List
    [Documentation]    This gets the correct item detail/attribute from a previously defined Item Detail List.
    ...    Item Attribute Name and Item Name should be supplied for this keyword.
    ${attribute_value}=    Get From List    ${${item_name.strip()}_list}    ${${item_attribute.lower()}_index}
    [Return]    ${attribute_value}

Get Correct Element Path
    [Arguments]    ${element_text}    ${path}
    [Documentation]    This keyword generates the correct xpath for a given page element. The xpaths declared in the page locator variable file are sometimes generic in order to be dynamic. This keyword changes the value of those xpaths in order to locate the correct page element. Parameters needed are the name of the locator variable in the page locator variable file, the text needs to be replaced and the name of the item being located.
    ${new_xpath}=    Replace String    ${path}    ELEMENT_TEXT    ${element_text}
    [Return]    ${new_xpath}

Verify Values Should Match
    [Arguments]    ${expected_value}    ${actual_value}
    [Documentation]    Verifies if 2 given values are equally match
    Log    Expected: ${expected_value}
    Log    Actual: ${actual_value}
    Run Keyword If    '${actual_value}'=='${expected Value}'    Log    Expected Value: ${expected_value} Matches the Actual Value: ${actual_value}
    ...    ELSE    Fail    Values Did Not Match
