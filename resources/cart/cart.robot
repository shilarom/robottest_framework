*** Settings ***
Library           Selenium2Library
Library           String
Library           Collections
Resource          ../common/common.robot
Resource          cart_page_locators.robot

*** Keywords ***
The ${item_name} Item Should Be Displayed With Correct Details in Cart Page
    [Documentation]    This keyword validates the Item Details based on previously saved item data list matches the item details shown in Cart Page. Item name is specified to access correct data set. \
    Click Element    ${CART}
    Wait Until Page Contains    There are ${Overall_Total_Qty} items in your cart    30
    ${actual_item_price}=    Get Item Attribute From Cart Table    ${item_name}    ITEMPRICE    text
    ${actual_item_qty}=    Get Item Attribute From Cart Table    ${item_name}    ITEMQTY    value
    ${actual_item_subtotal}=    Get Item Attribute From Cart Table    ${item_name}    ITEMSUBTOTAL    text
    ${expected_item_name}=    Get Item Name From ${item_name.strip()} List
    ${expected_item_price}=    Get Item Price From ${item_name.strip()} List
    ${expected_item_quantity}=    Get Item Quantity From ${item_name.strip()} List
    ${expected_item_subtotal}=    Get Item Subtotal From ${item_name.strip()} List
    Verify Item Detail Matches The Expected Value    Item Name    ${expected_item_name}    ${item_name.strip()}
    Verify Item Detail Matches The Expected Value    Item Price    ${expected_item_price}    ${actual_item_price}
    Verify Item Detail Matches The Expected Value    Item Quantity    ${expected_item_quantity}    ${actual_item_qty}
    Verify Item Detail Matches The Expected Value    Item SubTotal    ${expected_item_subtotal}    ${actual_item_subtotal}

Get Item Attribute From Cart Table
    [Arguments]    ${item_name}    ${item_attribute}    ${xpath_attr}=text
    [Documentation]    This keyword gets the correct item data / attribute from the item data table found in the Cart Page.
    ${new_xpath}=    Get Correct Element Path    ${item_name}    ${${item_attribute}_TD}
    ${attribute}=    Run Keyword If    '${xpath_attr}'== 'text'    Get Text    ${new_xpath}
    ...    ELSE    Get Value    ${new_xpath}
    [Return]    ${attribute}

Verify Item Detail Matches The Expected Value
    [Arguments]    ${item_attribute}    ${expected_value}    ${actual_value}
    Verify Values Should Match    ${expected_value}    ${actual_value}
    Log    ${item_attribute} is correctly displayed

Overall Total Amount Is Correct
    [Documentation]    Validates that the Overall Total Amount found in Cart Page matches the calculated total amount
    ${total_in_cart}=    Get Text    ${TOTAL}
    ${total_in_cart}=    Remove String    ${total_in_cart}    Total:
    ${total_in_cart}=    Convert To Number    ${total_in_cart}
    Verify Values Should Match    ${Overall_Total_Amount}    ${total_in_cart}
    Log    Overall Total Amount is correctly displayed
