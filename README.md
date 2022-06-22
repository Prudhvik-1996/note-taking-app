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

#### Creating a basic Notes object:
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

#### Date Store
- We want to store our notes in the shared_preferences (for now), hence there must be a Data Store class containing the CRUD methods, hence we've written a class, NotesStore which has all the CRUD static methods.

![](https://lh5.googleusercontent.com/VY6xYjqBKxfp2cSjZbtw5u-iPktiiHpdMQEotDBEhsQy1dfZIuQAhub29WGdABRXx2WhFqbTmVNF506u-LMHX4cRNqP73ekF6HUiSMEZCVlWb5IxS7HHOzpr4mlbTYgW3PyGg5aFRWZV9YXHVQ)

#### Widgets
Now that we have all the necessary classes, we can concentrate on our layout.
Our initial layout for the an individual Note in the list of notes in as below,

![](https://lh3.googleusercontent.com/6RBkOCpzR_laG6PWPE1PCyEOa2J2FDfk0v94c27XDZpeZEjnM7NSu1dj3g99UbAa5GGHb6MjSHhO0O81P3JU2utDaWhMJatDma8eUC0AAk6N26Bd3yp271bP01v4PeYiVoJol5mNi3vtqfHjyA)

And the design of each notes' page is
![](https://lh6.googleusercontent.com/7btifIuWIf9DVr2rE9Zto1tCkCQYjq47EWK18rBmm4SrFQuvvxlJrH3YQnfETNpwQPz8oKNimRTNQ8LMveL26id_3UdAWmIYt34ok85AsOF0500GZIgvfa0urscsK-9UNfDELJnkBCT5aGeFeQ)

#### Screenshots of implementation:

<img src="https://lh4.googleusercontent.com/SFvKpVYvoPeERXxqzQbZTiQDu-_YzaSeCpNKJG4Xrv77KYY2GD1Xc28dzjmDYNfCt8hLcRMcHO91qlhsLKk7RCSWT5Xgc4hzckG31-5Pos0iHUCGU85yPHiwkU3BmUIMgPxMGF0LTQ1iIdTnEQ" width="320">


<img src="https://lh5.googleusercontent.com/IyqHJLqeqxc3D4ZmhuYTJkcMNj-KfpkDxRPZG9edL2cCgCtTnuj6uvf2wjYI6U8gDd3uBRrPB2_QwE7VVwU0zReKwXakImhAX9B__wkqUidz3PlLYVw6vdgWam9TQQTv4rKssmF0QW6TasYvug" width="320">

#### Next Phase: Ability to archive or delete notes
- We want to archive or delete the notes with just a swipe, hence, introduced a new variable `status` in the Note class.
- Also implemented a filter to show all notes or only unarchived notes.
- Also implemented a feature to delete all notes.
  Implementation is shown in the following gif.


<img src="https://lh3.googleusercontent.com/XrjRdhlebDzCWWH4N0B8sRiY94XimSebZNLU-FFlM8sncRVxbYihjL5a1iBhsbCv0jLhT6gYDZ-xvAVDb62slMoOJBfQw-q343ZQFUtdk1idzO71f1bjvaQarymMllnT-_iw9NCc7PLC88FArQ" width="320">

You can download the apk from [here](https://drive.google.com/file/d/18caFdVW0DgvkEUNr116pFgqE0QproXO4/view?usp=sharing)


### THE END