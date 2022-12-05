
:: =========================================
::  This .bat file demonstrates how to create or update an automation task in Zephyr for Jira Cloud, run this task, and publish test results to Zephyr.
::  Author: SmartBear Software
:: =========================================

:: =========================================
::  Zephyr base URL.
:: =========================================
set "$zephyrBaseUrl=https://prod-api.zephyr4jiracloud.com/connect" 


:: =========================================
::  Access and secret keys, and user id needed for connection to Zephyr for Jira. 
::  Replace the constants below with values relevant to your project and account.
:: =========================================
:: The accessKey and secretKey to access your project. You can find them in your Jira project: Zephyr > API Keys.
set "$accessKey=ZGxhdHZhcmcuYXRsYXNzaWFuLm5ldCA2MzVmY2U1YTc2YjkxYjYyNTYyZWRmYzkgVVNFUl9ERUZBVUxUX05BTUU"
set "$secretKey=hmr72_WDTNdvmQQiWmbKxmpvc0zVJAfYUfeLgRb-bXg"
:: Id of the user who will create the automation task. You can find it in Jira.
set "$accountId=635fce5a76b91b62562edfc9"

:: =========================================
::  Create a JSON Web Token  (required to access Zephyr for Jira).
::  Keep this section as it is.
:: =========================================
echo "Generating a JSON Web Token ..."
for /F "tokens=*" %%i in (' curl -s -X POST -H "Content-Type: application/json" --data "{ \"accessKey\":\"%$accessKey%\", \"secretKey\":\"%$secretKey%\",\"accountId\":\"%$accountId%\",\"zephyrBaseUrl\": \"%$zephyrBaseUrl%\",\"expirationTime\":360000}" "https://prod-vortexapi.zephyr4jiracloud.com/api/v1/jwt/generate" ')  do set jwtgenerated=%%i
set "$finaljwt=%jwtgenerated%"
echo %$finaljwt%

:: =========================================
::  Define properties of the automation task.
::  Replace the values below with data relevant to your project.
:: =========================================

:: Task info
set "$taskName=Test Trainees"
set "$taskDescription=Execute an API with pytest "
set "$automationFramework=junit"
set "$projectKey=PLY-6507"
set "$versionName=Unscheduled"

:: Cycle info
set "$cycleName=Test Trainees"
set "$createNewCycle=false"
set "$appendDateTimeInCycleName=true"

:: Folder info
set "$folderName=testtrainees"
set "$createNewFolder=false"
set "$appendDateTimeInFolderName=true"
set "$assigneeUser=635fce5a76b91b62562edfc9"

:: Fully-qualitified name of the test result file
set "$resultPath=@\"C:/Users/canellasa/Documents/testtrainees\"

:: =========================================
::  Create an automation task, run it, send test results to Zephyr.
::  Keep this section as it is.
:: =========================================
echo "Creating and running an automation task ..."
curl -v -X POST  https://prod-vortexapi.zephyr4jiracloud.com/api/v1/automation/job/saveAndExecute  -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -H "accessKey: %$accessKey%" -H "jwt: %$finaljwt%" -F "jobName=%$taskName%" -F "jobDescription=%$taskDescription%" -F "automationFramework=%$automationFramework%" -F "projectKey=%$projectKey%" -F "versionName=%$versionName%" -F "cycleName=%$cycleName%" -F "createNewCycle=%$createNewCycle%" -F "appendDateTimeInCycleName=%$appendDateTimeInCycleName%" -F "folderName=%$folderName%" -F "createNewFolder=%$createNewFolder%" -F "appendDateTimeInFolderName=%$appendDateTimeInFolderName%" -F "assigneeUser=%$assigneeUser%" -F "file=%$resultPath%"


:: =========================================
::  Update the properties of automation task and  run it, send test results to Zephyr.
:: 
::  The code below uses "task properties" values defined in lines 38-56.
::  Update them to change task properties.
:: 
::  To run the code below, first comment out the lines 62-63 above that create your automation task, 
::  and then uncomment in the lines below.
:: =========================================

:: Id of your automation task. You get it after the task is created.
:: set "$taskId=XXXXXXXXXXXXXXXXXXXX42E96E8863BF7EEE44BDB95FF763DA3E9C3BC4776886"

:: echo "Updating and running the automation task"
:: curl -v -X PUT  https://prod-vortexapi.zephyr4jiracloud.com/api/v1/automation/job/updateAndExecute  -H "Content-Type: multipart/form-data" -H "Content-Type: application/json" -H "accessKey: %$accessKey%" -H "jwt: %$finaljwt%"  -F "jobId=%$taskId%" -F "jobName=%$taskName%" -F "jobDescription=%$taskDescription%" -F "automationFramework=%$automationFramework%" -F "versionName=%$versionName%" -F "cycleName=%$cycleName%" -F "createNewCycle=%$createNewCycle%" -F "appendDateTimeInCycleName=%$appendDateTimeInCycleName%" -F "folderName=%$folderName%" -F "createNewFolder=%$createNewFolder%" -F "appendDateTimeInFolderName=%$appendDateTimeInFolderName%" -F "assigneeUser=%$assigneeUser%" -F "file=%$resultPath%"

