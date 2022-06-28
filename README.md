# Welcome to Note Taking App!

## Description
Inorder to take a quick notes either while on a call or when in a meeting, I’m sure there are quiet many apps on the play store and the app store but nothing is as easy to use and effective as our app.

The focus of my app is to have a clean and minimalistic UI for note taking.

The app should provide an easy way to maintain notes, lists and ideas.

One should just launch the app, type some notes and they should be done, while being able to start where they stopped easily.

One should also be able to categorize the notes with custom color codes for each note.

## Why Note Taking App?
Out there in the market, there are a lot of apps, but either one has a lot of ads or one has clumsy UI or one has a lot of features (taking too much size), but none which satisfies all my requirements. Hence I thought, why not build my own…

## Tools and Technologies
- Flutter
- Android Studio

## Project Checkpoints
1.  Having a rough layout of what it would look like.
2.  Make a basic app with the ability to store the data from TextField into local storage and be able to edit the same by reopening the app.
3.  Create a beautiful notes widget accommodating the text, color, create time, last updated time, etc,.
4.  Add features like
    -   delete the notes
    -   move notes to last
5.  Build production ready app

## Implementation

### Applying custom App Icon:
I’ve studied varius resources online & understood that indorder generate the app icons manually, there is a lot of cumbersome process, & in pub.dev, I’ve found a package called flutter_launcher_icons which will do the entire process for us.

#### App Icon:
<img src="https://lh3.googleusercontent.com/JeYFGO7n41LwW0wP5krV-ws0iDFdX0k_6M5S-sK4bRMLCSfXoLt3_QfTw2i_WbqUujelwPIRmlPRHwZudVTPG_hIAFVRrjBHzz9jBhj5HdIL_gSZogxAD_aWmTqp1O-Mgky5ooC8FGVIoMZkMg" width="60">

Following steps:
- Add the icon.png into assets folder as shown in the image_path
- Add flutter_launcher_icons: ^0.9.3 to the dev dependency
- Make the following changes in pubspec.yaml file

![](https://lh6.googleusercontent.com/DApTGe_xV_WaIDtzbdp2XSxLd2m4-WhkLhJocwwj7EFSsb1asLuW4p2ti_JKATLYQ2N0Ser43DWt5xd-ie5X77IJ97AKPRbEJxHy_3lQ5huwRoHXK9lmw0yyJcy_QNgbPCBpxIYs6ta3wTEgOg)

- Now run following commands on terminal
```
flutter pub get
flutter pub run flutter_launcher_icons:main
```

![](https://lh6.googleusercontent.com/eG9NtmOfGgLWtnJMUHh-gRij_hECuZvj2xDNpLArG_GeRXxh9Stln4XCUPdTzb3pM7fmxfru-315Vjql0BlYzKema-ZAxKGZrW1pWLWKft_XDLKceOmK-jS8TVSrBkRyp2gYcyHYU5YVfwdeMw)

### Creating a basic Notes object:
Our expected design of a notes object must contain the following parameters,
- int id;
- String title;
- String content;
- DateTime createdDate;
- DateTime lastUpdatedDate;
- Color color;

The object should look like some thing like this,

![](https://lh4.googleusercontent.com/gF-N8C6oxttmCGLFc4D3puhPXy5ih8ifXPmJgI3HSsFyPKNurm2MA6ZflPNssNInlFXlmOv3V9iaJs2roFfo23u3pfp8WFWH4xYwH7dY98e31T99-12isBmOdISW5dqPUreFIbDBLJn8b9qJQw)

- Since we want to store our data into shared_preferences for easy and fast access, we shall add `toJson` and `fromJson` factory methods to the same modal class.

### Date Store
- We want to store our notes in the shared_preferences (for now), hence there must be a Data Store class containing the CRUD methods, hence we've written a class, NotesStore which has all the CRUD static methods.

![](https://lh5.googleusercontent.com/VY6xYjqBKxfp2cSjZbtw5u-iPktiiHpdMQEotDBEhsQy1dfZIuQAhub29WGdABRXx2WhFqbTmVNF506u-LMHX4cRNqP73ekF6HUiSMEZCVlWb5IxS7HHOzpr4mlbTYgW3PyGg5aFRWZV9YXHVQ)

### Widgets
Now that we have all the necessary classes, we can concentrate on our layout.
Our initial layout for the an individual Note in the list of notes in as below,

![](https://lh3.googleusercontent.com/6RBkOCpzR_laG6PWPE1PCyEOa2J2FDfk0v94c27XDZpeZEjnM7NSu1dj3g99UbAa5GGHb6MjSHhO0O81P3JU2utDaWhMJatDma8eUC0AAk6N26Bd3yp271bP01v4PeYiVoJol5mNi3vtqfHjyA)

And the design of each notes' page is
![](https://lh6.googleusercontent.com/7btifIuWIf9DVr2rE9Zto1tCkCQYjq47EWK18rBmm4SrFQuvvxlJrH3YQnfETNpwQPz8oKNimRTNQ8LMveL26id_3UdAWmIYt34ok85AsOF0500GZIgvfa0urscsK-9UNfDELJnkBCT5aGeFeQ)

### Screenshots of implementation:
#### Open the Notes app.

<img src="https://lh5.googleusercontent.com/l5lzXDXGwiQYXZKuznCjHGkaAPEGtQjoE9Ftxpd_Dgs0B94ekQOsTVqqFenSerDVq2hy-o8HBVo7RO_KzL14ft-ER4ZzulRRTNis8U1hlvjhEht_XeCBDiBW0lzY6bD8sfdnioFi2zbEf6bdhQ" width="320">

#### After clicking on the "plus" button,

<img src="https://lh6.googleusercontent.com/kF8_BzE_TRjiYZk6CmTShw3nyTdPZ2LL5q1JoeXCIEyfMMqVR8kV3bXhewVKje2bxx80b63a8ZOQ7Qlu3gVNRUCefe0q0bo-6K6NBQIFTPlZm1AectUTSNvPHfCFT0pe_MAv4AkEvU78Vr9jdw" width="200">

#### Once you are done with typing the note, click on the "tick" icon, to save and close the note.

<img src="https://lh4.googleusercontent.com/QEBZpZgMfxQ8lZgyP2EG9VEBjb6PzbcgctBzHdzQ2GSsw6ckJJiOdx_AxyENX8bU-sqVdP1G7KZE9Ztf2sIbEjJvotwTVJ1YeGQg4GVECKVmmdn2GjXk__oXuUTs1xJDt26Hut3yiWbHIxAFBA" width="200">

#### Adding color to the note
(Why not make a note :wink:),

##### Creating a new note
<img src="https://lh5.googleusercontent.com/nQiM4a4RDAZFbsWVrRrwbBvC45cn-OraRJcMODt0MKRKD9C-ISMDZGd4mlvnuMJpTtCCtQw2ISLdl2o1ylgT4rV9hNV3ES500VVxtKnM52x66ALsqmdXnSCB-Uy6ejLpbKpIADDYoiINufq2pA" width="200">

##### List of notes
<img src="https://lh4.googleusercontent.com/WXckPJ-dWHW9enb4-z1hGA6_8C82Wx8h8fguIbXNvSjJ-0E2ZgMH_M3h5U5-Bg67uf6B0-pRUUkpCYmAB4A0IF2FtQmrNJ1O97W1ZmH-Boc-qxlNQpFY9_hckRDQLY879DIzaEusjt15RGo0LQ" width="200">

##### Editing notes to add color

<img src="https://lh6.googleusercontent.com/z43rdf4tkL-HWK-WB_8ok-Gbvu6y-4G2zknRabrj4EbcaG_oojmg2oGpqUj6WCsguNkPmXTT5xApsRzQ5Jgz8q6EimSCSDjU_D0_JKHGlw03AUywRuga3R7oLimMOWR6lejGCeoMlXdWR2yB2Q" width="200">

<img src="https://lh4.googleusercontent.com/LK119kkraLBEW2vtML5d3fDBxT74FSQ-CZUiKV9KXx-bys-S5wLSp0UWSMRfZ4AH1xUhRoKYVdrsHwT_V0ivfqn9cgdcf0vCBlKE5Gl_YvQGRZCxxCto3Bkaqd3f23bDjKH1iIpNIYNjM9fGUw" width="200">

<img src="https://lh5.googleusercontent.com/S2o1DdRTdUm92Esyz2lk07D6Om3o3lLLjKTTTbRC0JseTZP4jYLCf47a-25Q9iLaJy3f1G5NLWF-EFqGNsO0acPLDQYj7f632BWnnKGi7adbA0229RBt1r10AjYLV3LHgQhjS0RSoHA4EBOexA" width="200">


#### Archive Notes

Adding the ability to archive the notes
<img src="https://lh5.googleusercontent.com/OUD-zwi56ttG45aK6CwgcaI9c65CC7KK2HPI7XRBGrcbwxF-wk0XAtgMS7QvgEBS84bkoqXLPOW-bO94hMAKLROMY-gHAza0z4WwrQB2MtdMIsaxSPJLj59fgJ0mxaEctlhlwoC1pI9P36EG-A" width="200">

##### Video demo  of archiving a note:
[<img src="https://lh5.googleusercontent.com/Qo48WleNRu9EcwNd3SYihiYfGfiqdJDypTcmk9XM18MZ7PwW-MGWIaLyOZJsrKXuRd2c0sgP514ZSUQ1i_3K8ReN8lKJ5aH7FCLZQctKwhW4IfUla-hS47a__L0WJu-fvdCKs9XySs_NA4vn9Q" width="200">](https://photos.app.goo.gl/o5c8ghBn5JZPG6eM6)

##### Video demo to show all notes (including unarchived):
[<img src="https://lh4.googleusercontent.com/ChGRbNa17H_Egiq7qld1rTe2Ux1GdlbY-UWScdIX9Y8IXu05LMaD35yd3_2nRVRXA2sZOPf5ZGFdP6uhVs_ww428txCfLGPSO4OSWslWC1yX5rqRfUf0MlIQ4Fnbu4DNWxxQDbwRrVqI_QLNaw" width="200">](https://photos.app.goo.gl/C5RPYdubhn8ju2f6A)


#### Delete Notes

Inorder to delete the notes, we want to take the consent of the user, so, we use an `AlertDialogue` to do so.

##### Video demo to delete a note:
[<img src="https://lh4.googleusercontent.com/BsylKpAymL-wlGmfoS4nX6O50QktIEHsF5xiYDzhdp6jfZLNQ29MWDOPwbiivyPjzZvn5IHpjOpV-ymfnBsC2eokLYQIcYShUNd4LpJ9bOSRO5_jGuPI_HEb0dEOUeBtoTbnDK37EKFAXl71jw" width="200">](https://photos.app.goo.gl/arYowYJSiw3SqQnW9)


## Demo
Implementation is shown in the video provided [here](https://drive.google.com/file/d/1ILdDF8HnhJkTSWgK1hFP1z2LTDl7LF6V/view?usp=sharing)

You can download the apk from [here](https://drive.google.com/file/d/18caFdVW0DgvkEUNr116pFgqE0QproXO4/view?usp=sharing)

---
### THE END
---
