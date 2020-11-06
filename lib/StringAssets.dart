import 'package:flutter/material.dart';
import 'file:///C:/Users/Isiyemi%20Joseph/AndroidStudioProjects/takara_bill/lib/widgets/sliderPage.dart';

const String svgLogo = "assets/logoSvg.svg";
const String pngLogo = "assets/logopng.png";
const String ic_authentication = "assets/authentication.svg";
const String ic_reminder_note = "assets/reminder_note_.svg";
const String ic_boss= "assets/boss.svg";
const String ic_profileFilled= "assets/Profile.svg";
const String ic_profileWhite= "assets/Profile_white.svg";
const String ic_profileUnfilled= "assets/Profile_unfilled.svg";

const String ic_homeUnfilled= "assets/Home_Unfilled.svg";
const String ic_homeFilled= "assets/Home.svg";
const String  ic_vendorFilled= "assets/Work.svg";
const String ic_vendorUnfilled= "assets/Work_unfilled.svg";
const String ic_billFilled= "assets/Graph.svg";
const String ic_billUnFilled= "assets/Graph_unfilled.svg";



String FIRST_TIME = "firstTime";
String AUTO_LOGIN = "autoLogin";
String SIGN_UP = "Sign up";
String SIGN_IN = "Sign in";
String NAME = "Name";
String EMAIL = "Email";
String SUCCESSFUL = "Successful";
String FAILED = "Failed";
String NUMBER = "Number";
String FULLNAME = "Fullname";

List<Widget> onboardingPages = [
  SliderPage(
    title: "Instant Notification",
    description: "Stay on top of your bills  with realtime bill notificaton from your accredited vendors",
    image: ic_reminder_note ,
  ),
  SliderPage(
    title: "Pay bills like a Boss!",
    description: "Settle  bills as soon as possible directly with receipts from your phone like a boss would!",
    image: ic_boss ,
  ),
  SliderPage(
    title: "Top-notch security",
    description: "Be rest assured that your billing detail are kept safe from prying eyes",
    image: ic_authentication ,
  ),
];

List numbers = [1,2,3,4,5,6,7,8,9,10];
