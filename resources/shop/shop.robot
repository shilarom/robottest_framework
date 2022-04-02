*** Settings ***
Library           Selenium2Library
Library           String
Library           Collections
Resource          ../common/common.robot
Resource          ../common/item_variables.robot
Resource          shop_page_locator.robot

*** Keywords ***
User Buys ${quantity} Quantity Of ${item_name} Item
    [Documentation]    This keyword specifies how many times an item is bought in the Shop Page.
    ...    This keyword also stores a list of item data that are needed for succeeding assertions. The item name, price, subtotal and quantity are saved in a list / collection to be later accessed by other keyword. \ \ \
    ${total_item_qty}=    Buy Item Based On Specified Quantity    ${item_name}    ${quantity}
    ${item_price}=    Get Item Price in Specified Format    ${item_name}    text
    ${subtotal}=    Calculate Subtotal    ${total_item_qty}    ${item_price}
    Add Item Qty And Subtotal To Overall Totals    ${total_item_qty}    ${subtotal}
    ${subtotal_str}=    Convert To String    $${subtotal}
    ${item_name}=    Set Variable    ${item_name.strip()}
    ${item_list}=    Create List    ${item_name}    ${item_price}    ${total_item_qty}    ${subtotal_str}
    Set Test Variable    ${${item_name}_list}    ${item_list}
    Log    ItemName: ${item_name} Item Price: ${item_price} Item Qty: ${total_item_qty} SubTotal: ${subtotal_str}

Add Item Qty And Subtotal To Overall Totals
    [Arguments]    ${item_qty}    ${subtotal}
    [Documentation]    This keyword calculates the overall total amount for each order in Shop Page.
    ...    It also calculates the total quantity of all items bought.
    ${overall_total_qty}=    Evaluate    ${overall_total_qty}+${item_qty}
    ${overall_total_amount}=    Evaluate    ${overall_total_amount}+${subtotal}
    Set Test Variable    ${Overall_Total_Qty}    ${overall_total_qty}
    Set Test Variable    ${Overall_Total_Amount}    ${overall_total_amount}

Calculate Subtotal
    [Arguments]    ${item_qty}    ${item_price}
    [Documentation]    This keyword calculats the subtotal amount based on the selected quantity and item price.
    ...    Before calculation it also converts the price value to number format.
    ${price_int}=    Convert Price To Number    ${item_price}
    ${subtotal}=    Evaluate    ${item_qty}*${price_int}
    [Return]    ${subtotal}

Buy Item Based On Specified Quantity
    [Arguments]    ${item_name}    ${quantity}
    [Documentation]    This keyword is used to click on the Buy button based on the specified Item name and Quantity
    ${qty}=    Convert to Integer    0
    ${buy_path}=    Get Correct Element Path    ${item_name}    ${BUY}
    FOR    ${index}    IN RANGE    ${quantity}
        Click Element    ${buy_path}
        ${qty}=    Set Variable    ${qty+1}
        Log    Bought ${qty} ${item_name} Item
        Sleep    1
    END
    [Return]    ${qty}

Get Item Price in Specified Format
    [Arguments]    ${element_identifier}    ${format}=text
    [Documentation]    This converts item price based on either text or number format.
    ...    Accepted format type is number or text only.
    ${price_path}=    Get Correct Element Path    ${element_identifier}    ${PRICE}
    ${str_price}=    Get Text    ${price_path}
    ${item_price}=    Run Keyword If    '${format}'=='number'    Convert Price To Number    ${str_price}
    ...    ELSE    Set Variable    ${str_price}
    [Return]    ${item_price}
