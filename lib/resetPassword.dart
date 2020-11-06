import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takara_bill/signIn.dart';
import 'package:takara_bill/signUp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'AppEngine.dart';
import 'Mainactivity.dart';
import 'StaticItems.dart';
import 'StringAssets.dart';
import 'main.dart';

class ResetPassword extends StatefulWidget {

  final String email;

  const ResetPassword({Key key, this.email}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _loading = false;
  String emailState = "";
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  if(widget.email != null){
    _emailController.text = widget.email;
  }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                                     "Reset Password",
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
                                        "Enter your email to reset your password",
                                        style: styleText(
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
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
                                  "Email Address",
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

                                  onChanged: (val) {
                                    setState(() {
                                      emailState = val;
                                    });
                                  },
                                  controller: _emailController,
                                  textInputAction: TextInputAction.next,
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
                                decoration:
                                BoxDecoration(color: Colors.white),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Invalid email",
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
                                  resetPassword();
                                },
                                child: Center(
                                  child: Text(
                                    "Reset Password",
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
                                text: "Go Back",
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            inAsyncCall: _loading,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator(
              backgroundColor: primaryColor,
            )),
      ),
    );
  }

  resetPassword() async {
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

    setState(() {
      _loading = true;
    });
    final provider = context.read(authProvider);
    var response =
    await provider.resetPassword(_emailController.text.trim());
    setState(() {
      _loading = true;
    });
    if (response == SUCCESSFUL) {
      setState(() {
        _loading = false;
      });
      showAlertDialog(context, "Successful", "Password reset link has been sent to ${_emailController.text}", yesText: "OK",
          onYes: () {
            setState(() {
              _loading = false;
            });
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
              return SignIn();
            }));
          });
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
