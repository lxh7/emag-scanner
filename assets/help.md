# 1. Introduction

The app is intended to be used to check access for activities. Participants will have a badge with an QR-code on it. This QR code links to the activities they booked and paid for. As access checker, you'll scan these QR-codes.

In order to scan, you first need to load the activity from the server (the participants registration site) into the app. This requires a working connection to the server, i.e. proper configuration and an active internet connection. Refer to the tech desk for the proper information and access codes.

# 2. Load activity/activities

1. From the home page, tap "Scan for access". The page "Confirm activity" with the last selected activity will be shown (none if used for the first time).
2. Tap "Select another activity" at the bottom. The page "Select activity" will be shown with the activities loaded on the device (none if used for the first time).
3. Tap the "+" button at the bottom. The page "Load activity" will be shown.
4. Tap the category your activity is in.
5. Tap the activity you want to load.
6. Repeat steps 3 to 5 as often as you need.
7. Page "Select Activity": Tap the activity you need to check access for.
8. Either return to the home page, or start scanning.

# 3. Scan for access

1. From the home page, tap "Scan for access". The page "Confirm activity" with the last selected activity will be shown.
2. Page "Confirm Activity": Check if the proper activity is selected. This extra confirmation page helps to make sure you scan the right one in hectic or otherwise in a bit more chaotic moment. If the proper activity is not selected, tap "Select another activity" and select the right one.
3. Tap the activity to start scanning.
4. Start scanning QR-codes opn the badges of the participants. Each code can have up to 3 different results:
  - **PASS**: Access allowed. The screen will show green, and a single vibration can be felt as feedback. After 1.5 seconds the next code can be scanned
  - **CHECK**: Access allowed after additional check: This code has been scanned before and was allowed to access. You need to verify that this person actually (still?) has the right to enter. The screen will show orange, and 2 times a vibration can be felt as feedback. Read the message on screen for more info and confirm the message by tapping the OK button. After this, the next QR-code can be scanned.
  - **BLOCK**: Access **NOT** allowed. The screen will show red, and 3 times a vibration can be felt as feedback. Read the message on screen for more info (there are various reason why a code does not grant access) and confirm by tapping the OK button. After this, the next QR-code can be scanned.
5. If there is low light making scanning codes difficult, you can switch on the "light" on your phone by tapping the light bulb icon on top.

*Please make sure you don't blind participants* 😊

## Tips and notes

- If you are not scanning for a while, return to the "Confirm activity" page or the home page. The scan page will keep the camera on, this may consume a little power.
- The data is not very "heavy", mobile data connections should work fine, If you have limited data on your subscription, make sure you use a Wi-Fi connection to load activities.
- You can load multiple activities

# 4. Scan for goodies

1. From the home page, tap "Scan for goodies". The page "Scan for goodies" will be shown.
2. Scan the QR-code of the participant
3. The app will show the name of the participant, and the list of cards and goodies they ordered, together with payment status
4. Pick the goodies, check them together with the participant. Check the boxes of everything that is handed over to the participant, and click save. If something is not (yet) available, do not check the box.

## Tips and notes

- **Internet connection is required!**
- If something is not (yet) available, do not check the box. If a goodie will be delivered e.g., the next day, the participant can come back to collect it then.
- You cannot undo the save action on goodies handed out, so make sure you only tick the correct boxes.

# 5.Overall notes

- If there is an active internet connection, the code is sent to the server for access control (and scan time is stored there), and scan time is also stored on the device. If there is no internet connection, the access control is done on data stored on the device and the scan time is queued for later synchronisation to the server.
- While scanning, an active internet connection is not required. The scan data will be stored on your device and synchronised with the server when internet connection is restored (app must be active for this).
- If there are multiple people scanning for access (big events), an active internet connection is highly advisable (otherwise another device will not know the actual status of the participant).
- If the activity is over, you can delete it from your device to free up space (and remove potentially privacy-sensitive data). _Only do this after the app had an internet connection, to make sure the scan data has been synchronised to the server._ Go to the "Select activity" Page and long-press the old activity. Confirm deletion from your device.