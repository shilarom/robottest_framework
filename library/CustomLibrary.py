import random
import string
import names
import datetime


##############################################################################################################################
# Function Name: Create Random String
# Description: Randomly generates string containing 6 alphanumeric characters by default. 
# Params: 
#    strLength - length of generated string (default is 6) 
#    withUppercase - boolean whether to include uppercase letters in generated string or not (default is True)
#    withLowercase - boolean whether to include lowercase letters in generated string or not (default is True)
#    withNumber - boolean whether to include numbers in generated string or not (default is True)
#    withSpecialChar - boolean whether to include special characters in generated string or not (default is True)                                                      
###########################################################################################################################

def CreateRandomString(strLength=6, withUppercase=True, withLowercase=True, withNumber=True, withSpecialChar=True):
    
    str_chars = ''
    
    #   If string is not required to have a specific type of character, by default the type character is set as Used. 
    #   Example: string not required to have uppercase (withUppercase=False) hence uppercase is set as 'Used' (uppercaseIsUsed=True)
    #   This is to ensure that the generated string will have all types of character needed because if we just randomly pick the characters
    #   from the list of alphanumeric characters, there are instances that a type of character is missing (i.e number is missing) even 
    #   though user is expecting it to be in the string.    

    uppercaseIsUsed = (False if withUppercase == True else True)
    lowercaseIsUsed = (False if withLowercase == True else True)
    numberIsUsed = (False if withNumber == True else True)
    specialcharIsUsed = (False if withSpecialChar == True else True)
        
    for x in range(strLength):
        flag = False
        while (flag == False):
            temp_chars = (string.ascii_uppercase if withUppercase == True else '') + \
            (string.ascii_lowercase if withLowercase == True else '') + \
            (string.digits if withNumber == True else '') + (string.punctuation if withSpecialChar == True else '') 
            new_char = ''.join(random.sample(temp_chars,1))
            
            if new_char.istitle() and uppercaseIsUsed == False:
                str_chars = str_chars + new_char
                uppercaseIsUsed = True
                flag = True
            elif new_char.islower() and lowercaseIsUsed == False:
                str_chars = str_chars + new_char
                lowercaseIsUsed = True
                flag = True
            elif new_char.isnumeric() and numberIsUsed == False:
                str_chars = str_chars + new_char
                numberIsUsed = True
                flag = True
            elif new_char in string.punctuation and specialcharIsUsed == False:
                str_chars = str_chars + new_char
                specialcharIsUsed = True
                flag = True
            elif specialcharIsUsed == True and numberIsUsed == True and lowercaseIsUsed == True and uppercaseIsUsed == True:
                str_chars = str_chars + ''.join(random.sample(temp_chars,1))
                flag = True                
    return str_chars

###############################################################################################################################################
# Function Name: Generate Name
# Description: Randomly generates a realistic name
# Params: 
#    withFirstName - Boolean. To determine if name to generate should contain first name.
#    numOfFirstName - Number of words that the first name will contain. 
#    withLastName - Boolean. To determine if name to generate should contain last name.
#    numOfLastName - Number of words that the last name will contain.     
#    gender - Valid values are 'male' and 'female' only. Default is 'male'. First name to be generated is based on gender.
###############################################################################################################################################

def GenerateName(withFirstName=True,numOfFirstName=1,withLastName=True,numOfLastName=1,gender='male'): 
    
    FirstName = ''
    LastName = ''
    for x in range(numOfFirstName):
        FirstName = FirstName + (names.get_first_name(gender=gender) if withFirstName and x == 0 else ' ' + names.get_first_name(gender=gender) if withFirstName and x == 0 else '')    
    for y in range(numOfLastName):
        LastName = LastName + (names.get_last_name() if withLastName and y == 0 else ' ' + names.get_last_name() if withLastName and y == 0 else '')    
    return (FirstName + ' ' + LastName if withFirstName and withLastName else LastName if withLastName else FirstName if withFirstName else '')

#####################################################################################################################################
# Function Name: Generate Email
# Description: Randomly generates an email address
# Params: 
#  emailLength = Number
###############################################################################################################################################

def GenerateEmail(emailLength=6):

    Email = ''
    Email = CreateRandomString(strLength=emailLength, withSpecialChar=False)
    Email += '@testemail.com'
    return Email
