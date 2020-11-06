import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:takara_bill/Mainactivity.dart';
import 'package:takara_bill/StringAssets.dart';
import 'package:takara_bill/autoLogin.dart';
import 'package:takara_bill/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takara_bill/providers/authProvider.dart';
import 'package:takara_bill/providers/dataProvider.dart';
import 'package:takara_bill/signIn.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp()),
  ));
}

final authProvider = ChangeNotifierProvider<AuthenticationService>((ref){
  return AuthenticationService(FirebaseAuth.instance);
});

final dataProvider = ChangeNotifierProvider<DataProvider>((ref){
  return DataProvider();
});

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.white,
      seconds: 5,
      photoSize: 75,
      image: Image.asset(
        pngLogo,
        height: 75,
        width: 75,
      ),
      navigateAfterSeconds: checkUser(),
    );
  }

  checkUser() async {

    Future.delayed(Duration(seconds: 5)).whenComplete(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool(FIRST_TIME);
      String name = prefs.getString(NAME);
      String email = prefs.getString(EMAIL);
      print(isFirstTime);
      if (isFirstTime == null ) {
        print("returned Homepage");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
          return Onboarding();
        }));
      }
      else {
          bool autoLogin = prefs.getBool(AUTO_LOGIN)?? true;
          //check user and navigate to dashboard
          print(name);
          print(email);
          if (autoLogin) {
            if(name == null || email == null){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
                return SignIn();
              }));
            }
            else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
                return Mainactivity();
              }));
            }
          }
          if(name == null || email == null){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
              return SignIn();
            }));
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
            return AutoLogin();
          }));
          // check user and navigate to customized logon
          // navigate to normal signin
        }
    });

  }
}

