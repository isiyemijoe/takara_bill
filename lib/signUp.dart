import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:takara_bill/AppEngine.dart';
import 'package:takara_bill/Mainactivity.dart';
import 'package:takara_bill/StaticItems.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takara_bill/StringAssets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_riverpod/all.dart';
import 'package:takara_bill/models/SignupDetails.dart';
import 'package:takara_bill/providers/authProvider.dart';
import 'package:takara_bill/signIn.dart';
import 'main.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String nameState = "",
      emailState = "",
      phoneState = "",
      passState = "",
      rePassState = "";
  bool passwordVisible = false, rePasswordVisible = false, passwordIcon = true;

  FocusNode _nameNode = FocusNode();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        exitApp(context);
      },
      child: SafeArea(
        child: Scaffold(
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 25,),
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
                                    "Name",
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
                                    focusNode: _nameNode,
                                    controller: _nameController,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (val) {
                                      if (_nameController.text.isNotEmpty) {
                                        setState(() {
                                          nameState = val;
                                        });
                                      }
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
                                  height: nameState == null ? 20 : 0,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Name is empty",
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
                                    onChanged: (val) {
                                      setState(() {
                                        emailState = val;
                                      });
                                    },
                                    keyboardType: TextInputType.emailAddress,
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
                                    "Mobile Number",
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
                                        phoneState = val;
                                      });
                                    },
                                    controller: _phoneController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
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
                                  height: phoneState == null ? 20 : 0,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Name is empty",
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
                                        suffixIcon: passwordIcon
                                            ? InkWell(
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
                                                ))
                                            : null),
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
                                    "Confirm Password",
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
                                        if (_confirmPasswordController
                                            .text.isNotEmpty) {
                                          passwordIcon = false;
                                          passwordVisible = true;
                                        } else {
                                          passwordIcon = true;
                                        }
                                        rePassState = val;
                                      });
                                    },
                                    obscureText: rePasswordVisible ? true : false,
                                    controller: _confirmPasswordController,
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
                                                rePasswordVisible =
                                                    !rePasswordVisible;
                                              });
                                            },
                                            child: Icon(
                                              rePasswordVisible
                                                  ? Icons.visibility_rounded
                                                  : Icons.visibility_off,
                                              color: primaryColor.withOpacity(0.5),
                                            ))),
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 250),
                                  height: rePassState == null ? 20 : 0,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "password mismatch",
                                        style: styleText(
                                          size: 12,
                                          color: Colors.red,
                                        ),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
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
                                        signup();
                                      },
                                      child: Center(
                                        child: Text(
                                          "Register",
                                          style: styleText(
                                              size: 20,
                                              weight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                    )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "Have an account? ",
                                    style: styleText(
                                        size: 15,
                                        color: textColor.withOpacity(0.6)),
                                    children: [
                                  TextSpan(
                                    text: "Login",
                                    style: styleText(size: 15, color: primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      Navigator.push(context, PageTransition(
                                        duration: Duration(milliseconds: 500),
                                        type:PageTransitionType.fade,
                                        alignment: Alignment.bottomCenter,
                                        child: SignIn()
                                      ));

                                      /*Navigator.push(context, PageRouteBuilder(
                                        transitionDuration: Duration(milliseconds: 400),
                                        transitionsBuilder: (context, animation, secanimation, child){
                                          return ScaleTransition(
                                              alignment: Alignment.bottomCenter,
                                              scale: animation,
                                          child: child,);
                                        },
                                        // ignore: missing_return
                                        pageBuilder: (context, animation, secAnimation){
                                          return SignIn();
                                        }
                                      ));*/
                                     /*   Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SignIn()));*/
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
                  )
                ],
              ),
                  inAsyncCall: loading ,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(
                backgroundColor: primaryColor,
              ),
            )),
      ),
    );
  }

  signup() async{
    if (!validateName(_nameController)) {
      setState(() {
        nameState = null;
      });
      return;
    }

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
    if (!validateName(_phoneController)) {
      setState(() {
        phoneState = null;
      });
      return;
    }

    if (!validateName(_passwordController)) {
      setState(() {
        passState = null;
      });
      return;
    }
    if (!validateName(_confirmPasswordController)) {
      setState(() {
        rePassState = null;
      });
      return;
    }
    else{
      if(_passwordController.text.trim() != _confirmPasswordController.text.trim()){
        setState(() {
          rePassState = null;
        });
        return;
      }
    }
    SignupDetails details = SignupDetails(_nameController.text.trim(),_emailController.text.trim(),_passwordController.text.trim(),_phoneController.text.trim());
setState(() {
  loading = true;
});
    final  provider =context.read(authProvider);
    print(provider);
    var response = await provider.signUp(details);
    setState(() {
      loading = true;
    });
     if(response == SIGN_UP ){
       print("Signup successfully");
       showAlertDialog(context, "Welcome ${details.name}", "A confirmation mail has been sent to ${details.email}", yesText: "Ok", onYes:  (){
         setState(() {
           loading = false;
         });
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) {
           return SignIn();
         }));
       });
     }
     else{
       print("Unsuccessful");
       showAlertDialog(context, "Error Occured","$response", yesText: "OK", onYes: (){
         setState(() {
           loading = false;
         });
         Navigator.of(context).pop();} );
       }
     }
  }


