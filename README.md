### Dependencies

| Requirements | Version |
|--|--|
| Python | 3.9.5 |
|Robot-Framework | 4.0.3 |
| RIDE | 2.0b1 |
| robotframework-selenium2library | 3.0.0 |
| names | 0.3.0 | 

### Installation
To get started please follow the instructions below.

 - In order to run the scripts included in the repository, you need to install python and robot-framework in your machine. follow this [guide](https://digital.ai/catalyst-blog/how-to-start-working-with-robot-framework-an-overview) to make sure both are configured properly. 
 - Install other dependencies using pip install command. 

    pip install robotframework-selenium2library
    pip install names

 - Once all dependencies are installed and all the python and robot-framework configuration are completed, you may now clone this repository to your desired directory. 
 
 ### Running Tests
 Running robot test suites are done using Windows CLI. Please follow the steps below to do this:
 
 - Open your command line
 - Navigate to the directory where you cloned the repository.
 - Make sure to go to the "tests" folder
 - Run this command: `robot -T <testsuitename>.robot`
      Example: robot -T JupiterToysContact.robot
 - There are other filters that you can include when running robot test   cases. Some examples are found [here](https://dev.to/juperala/how-to-run-robot-framework-test-from-command-line-5aa). 

 ### Viewing and Editing the Code
 By default Robot-Framework is using RIDE as its IDE. Once RIDE is installed just run `ride.py` in the command line to open it. Other IDE such as Eclipse also supports Robot-Framework. 
 