import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takara_bill/Mainactivity.dart';
import 'package:takara_bill/resetPassword.dart';
import 'package:takara_bill/signUp.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'AppEngine.dart';
import 'StaticItems.dart';
import 'StringAssets.dart';
import 'main.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String passState = "", emailState = "";
  bool passwordVisible = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        exitApp(context);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: height >= 750?false : true,
        backgroundColor: white,
        body: ModalProgressHUD(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: CustomPaint(
                    painter: SignInDesign(),
                    child: const Center(),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Hero(
                            tag: "Logo",
                            child: SvgPicture.asset(
                              svgLogo,
                              height: 100,
                              width: 200,
                            ),
                          ),
                          Text(
                            "Takara Bill",
                            style: logoText(
                                size: 30,
                                color: primaryColor,
                                weight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: double.infinity,
                                child: Text(
                                  "Email",
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
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (val) {
                                    setState(() {
                                      emailState = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                height: emailState == null ? 20 : 0,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Invalid mail",
                                      style: styleText(
                                        size: 12,
                                        color: Colors.red,
                                      ),
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
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
                                  controller: _passwordController,
                                  obscureText: passwordVisible ? true : false,
                                  onChanged: (val) {
                                    setState(() {
                                      passState = val;
                                    });
                                  },
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
                                              passwordVisible = !passwordVisible;
                                            });

                                            print(passwordVisible);
                                          },
                                          child: Icon(
                                            passwordVisible
                                                ? Icons.visibility_rounded
                                                : Icons.visibility_off,
                                            color: primaryColor.withOpacity(0.5),
                                          ))),
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                height: passState == null ? 20 : 0,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "password is empty",
                                      style: styleText(
                                        size: 12,
                                        color: Colors.red,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                    text: "Forgot password ",
                                    style: styleText(
                                        size: 15,
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
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Hero(
                            tag: "btn",
                            child: Container(
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
                                  print(height);
                                  signin();
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
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: styleText(
                                      size: 14,
                                      color: textColor.withOpacity(0.6)),
                                  children: [
                                TextSpan(
                                  text: "Register",
                                  style: styleText(size: 15, color: primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context, PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type:PageTransitionType.fade,
                                          alignment: Alignment.bottomCenter,
                                          child: Signup()
                                      ));
                                    },
                                )
                              ])),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                height > 750? Positioned(
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
                                    size: 14, color: textColor.withOpacity(0.6)),
                                children: [
                                  TextSpan(
                                    text: "Cavidel's terms,conditions",
                                    style:
                                        styleText(size: 15, color: primaryColor),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: styleText(
                                        size: 14,
                                        color: textColor.withOpacity(0.6)),
                                  ),
                                  TextSpan(
                                    text: "privacy policy",
                                    style:
                                        styleText(size: 14, color: primaryColor),
                                  )
                                ])),
                      ),
                    )): Container()
              ],
            ),
            inAsyncCall: _loading,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: primaryColor,
            )),
      )),
    );
  }

  signin() async {

    if (!validateName(_emailController)) {
      setState(() {
        emailState = null;
      });
      return;
    } else {
      if (!verifyMail(_emailController.text)) {
        print(verifyMail(_emailController.text));
        setState(() {
          emailState = null;
        });
        return;
      }
    }

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
    var response = await provider.signIn(
        _emailController.text.trim(), _passwordController.text.trim());
    setState(() {
      _loading = true;
    });
    if (response == SIGN_IN) {
      setState(() {
        _loading = false;
      });
      Navigator.push(context, PageTransition(
          duration: Duration(milliseconds: 400),
          type:PageTransitionType.fade,
          alignment: Alignment.center,
          child: Mainactivity()
      ));
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
