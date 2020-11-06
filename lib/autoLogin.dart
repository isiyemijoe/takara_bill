import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takara_bill/resetPassword.dart';
import 'package:takara_bill/signIn.dart';
import 'package:takara_bill/signUp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'AppEngine.dart';
import 'Mainactivity.dart';
import 'StaticItems.dart';
import 'StringAssets.dart';
import 'main.dart';

class AutoLogin extends StatefulWidget {
  @override
  _AutoLoginState createState() => _AutoLoginState();
}

class _AutoLoginState extends State<AutoLogin> {
  bool _loading = false;
  bool passwordVisible = true;
  String passState = "";
  String name;
  String email;
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString(NAME);
    email = prefs.getString(EMAIL);
    setState(() {});
    print(name);
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        exitApp(context);
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white,
          body: ModalProgressHUD(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: CustomPaint(
                      painter: SignUpDesign(),
                      child: const Center(),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          svgLogo,
                          height: 40,
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Takara Bill",
                          style: logoText(
                              size: 25,
                              color: primaryColor,
                              weight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name ?? "",
                                        style: styleText(
                                            size: 30,
                                            color: primaryColor,
                                            weight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Securely login to Takara",
                                          style: styleText(
                                            size: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: iconButton,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      ic_profileWhite,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: double.infinity,
                                  child: Text(
                                    "Password",
                                    textAlign: TextAlign.start,
                                    style: styleText(
                                        color: primaryColor,
                                        weight: FontWeight.w600,
                                        size: 15),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: primaryColor, width: 0.5),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      color: textFieldColor),
                                  child: TextField(
                                    obscureText: passwordVisible ? true : false,
                                    onChanged: (val) {
                                      setState(() {
                                        passState = val;
                                      });
                                    },
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                        contentPadding: EdgeInsets.all(10),
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                passwordVisible =
                                                    !passwordVisible;
                                              });

                                              print(passwordVisible);
                                            },
                                            child: Icon(
                                              passwordVisible
                                                  ? Icons.visibility_rounded
                                                  : Icons.visibility_off,
                                              color:
                                                  primaryColor.withOpacity(0.5),
                                            ))),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: passState == null ? 20 : 0,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "password is empty",
                                        style: styleText(
                                          size: 12,
                                          color: Colors.red,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: FlatButton(
                                  splashColor: iconButton,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  color: primaryColor,
                                  onPressed: () {
                                    login();
                                  },
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: styleText(
                                          size: 20,
                                          weight: FontWeight.bold,
                                          color: white),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            RichText(
                                text: TextSpan(
                              text: name == null
                                  ? "Not your account?"
                                  : "No, I am not ${name}",
                              style: styleText(
                                  size: 17,
                                  weight: FontWeight.w600,
                                  color: primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()));
                                },
                            )),
                            SizedBox(
                              height: 30,
                            ),
                            RichText(
                                text: TextSpan(
                              text: "Forgot password ",
                              style: styleText(
                                  size: 17,
                                  weight: FontWeight.w600,
                                  color: textColor.withOpacity(0.6)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ResetPassword()));
                                },
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              softWrap: true,
                              text: TextSpan(
                                  text:
                                      "By logging in into this account you are accepting ",
                                  style: styleText(
                                      size: 14,
                                      color: textColor.withOpacity(0.6)),
                                  children: [
                                    TextSpan(
                                      text: "Cavidel's terms,conditions",
                                      style: styleText(
                                          size: 15, color: primaryColor),
                                    ),
                                    TextSpan(
                                      text: " & ",
                                      style: styleText(
                                          size: 14,
                                          color: textColor.withOpacity(0.6)),
                                    ),
                                    TextSpan(
                                      text: "privacy policy",
                                      style: styleText(
                                          size: 14, color: primaryColor),
                                    )
                                  ])),
                        ),
                      ))
                ],
              ),
              inAsyncCall: _loading,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(
                backgroundColor: primaryColor,
              )),
        ),
      ),
    );
  }

  login() async {
    if (!validateName(_passwordController)) {
      setState(() {
        passState = null;
      });
      return;
    }

    setState(() {
      _loading = true;
    });
    final provider = context.read(authProvider);
    var response =
        await provider.signIn(email, _passwordController.text.trim());
    setState(() {
      _loading = true;
    });
    if (response == SIGN_IN) {
      setState(() {
        _loading = false;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
        return Mainactivity();
      }));
    } else {
      showAlertDialog(context, "Error Occured", "$response", yesText: "OK",
          onYes: () {
        setState(() {
          _loading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }
}
