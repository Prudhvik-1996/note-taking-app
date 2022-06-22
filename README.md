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
- DateTime date_created;
- DateTime date_last_edited;
- Color note_color;

The object should look like some thing like this,
![](https://lh4.googleusercontent.com/gF-N8C6oxttmCGLFc4D3puhPXy5ih8ifXPmJgI3HSsFyPKNurm2MA6ZflPNssNInlFXlmOv3V9iaJs2roFfo23u3pfp8WFWH4xYwH7dY98e31T99-12isBmOdISW5dqPUreFIbDBLJn8b9qJQw)

- Since we want to store our data into shared_preferences for easy and fast access, we shall add `toJson` and `fromJson` factory methods to the same modal class.


