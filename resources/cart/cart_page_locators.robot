*** Variables ***
${ITEMPRICE_TD}        //td[contains(text(), "ELEMENT_TEXT")]/parent::tr/td[2] 
${ITEMQTY_TD}        //td[contains(text(), "ELEMENT_TEXT")]/parent::tr/td[3]/input
${ITEMSUBTOTAL_TD}    //td[contains(text(), "ELEMENT_TEXT")]/parent::tr/td[4]
${TOTAL}                //tfoot//td/strong