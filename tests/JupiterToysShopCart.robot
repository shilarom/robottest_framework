*** Settings ***
Documentation     This Test Suite is composed of test cases related to Shopping Cart functionality of Jupiter Toys Website
Test Teardown     Close Browser
Force Tags        CART
Resource          ../resources/shop/shop.robot
Resource          ../resources/cart/cart.robot
Resource          ../resources/common/common.robot

*** Test Cases ***
001_Validate that Cart Page displays all the added items and their corresponding details
    [Tags]    TC1
    Given The Shop Page Is Open
    When User Buys 2 Quantity Of Funny Cow Item
    And User Buys 1 Quantity Of Fluffy Bunny Item
    Then The Funny Cow Item Should Be Displayed With Correct Details In Cart Page
    And The Fluffy Bunny Item Should Be Displayed With Correct Details In Cart Page

002_Validate that Cart Page displays all item details along with the correct Total Amount
    [Tags]    TC2
    Given The Shop Page Is Open
    When User Buys 2 Quantity Of Stuffed Frog Item
    And User Buys 5 Quantity Of Fluffy Bunny Item
    And User Buys 3 Quantity Of Valentine Bear Item
    Then The Stuffed Frog Item Should Be Displayed With Correct Details In Cart Page
    And The Fluffy Bunny Item Should Be Displayed With Correct Details in Cart Page
    And The Valentine Bear Item Should Be Displayed With Correct Details in Cart Page
    And Overall Total Amount Is Correct
