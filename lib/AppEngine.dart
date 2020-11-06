import 'dart:io';

import 'package:flutter/material.dart';
import 'package:takara_bill/StaticItems.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class SignInDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    /* Path firstCircle = Path();
    firstCircle.moveTo(width, height * 0.13);
    firstCircle.lineTo(0, height * 0.17);
    firstCircle.lineTo(0, 0);
    firstCircle.lineTo(width, 0);

    paint.color = Colors.white;
    canvas.drawPath(firstCircle, paint);


    Path SecondCircle = Path();
    SecondCircle.moveTo(width, height * 0.81);
    SecondCircle.moveTo(0, height * 0.77);
    SecondCircle.lineTo(0, 0.94);
    SecondCircle.lineTo(width, 0.971);
    //SecondCircle.lineTo(0, 0);
    paint.color = Colors.white;
    canvas.drawPath(SecondCircle, paint);*/

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = height *0.14;
    Path firstCircle = Path();
    firstCircle.addOval(Rect.fromCircle(
        center: Offset(width * 0.60,height * 0.46),

        radius: height * 0.46
    ));
    paint.color = Color(0xff0A53DF).withOpacity(0.05);
    canvas.drawPath(firstCircle, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}
class SignUpDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = height *0.14;
    Path firstCircle = Path();
    firstCircle.addOval(Rect.fromCircle(
        center: Offset(width * 0.30,height * 0.38),

        radius: height * 0.45
    ));
    paint.color = Color(0xff0A53DF).withOpacity(0.04);
    canvas.drawPath(firstCircle, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

styleText({double size, Color color, FontWeight weight }){
  return GoogleFonts.cabin(
    textStyle:  TextStyle(
        fontSize: size ?? 18,
        color: color?? textColor,
        fontWeight:  weight?? FontWeight.normal
    )
  );
}

logoText({double size, Color color, FontWeight weight }){
  return GoogleFonts.amaranth(
      textStyle:  TextStyle(
          fontSize: size ?? 18,
          color: color?? textColor,
          fontWeight:  weight?? FontWeight.normal
      )
  );
}

bool verifyMail( String email){
  bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return emailValid;
}

showAlertDialog(BuildContext context,String title, String message, {Function onYes, Function onNo, String noText, String yesText}) {

  // set up the button
  var okButton = onYes ==null?null:FlatButton(
    child: Text(yesText),
    onPressed: onYes,
  );
  var noButton = onNo ==null?null:FlatButton(
    child: Text(noText),
    onPressed: onNo,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title, textAlign:TextAlign.center,  style: styleText(size: 18, color: primaryColor, weight: FontWeight.bold),),
    content: Text(message,textAlign:TextAlign.center, style: styleText(size: 18, color: Colors.grey,)),
    actions: [
      okButton,
      noButton
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

bool validateName(TextEditingController controller) {
  if (controller.text.isNotEmpty) {
    return true;
  }
  return false;
}

void signout(BuildContext context){
  var auth = context.read(authProvider);
  showAlertDialog(
      context, "Logout?", "Do you want to Logout?",noText: "No", yesText: "Yes",
      onYes: () {
        Navigator.of(context).pop();
        auth.signOut();
      }, onNo: (){
    Navigator.of(context).pop();
  });
}

String getName(String name){
  if(name.contains(" ")){
    int index = name.indexOf(" ");
    String text = name.substring(0,index);
    print(text);
    return text[0].toUpperCase()+text.substring(1);
  }
  else{
    print(name);
    return name;
  }

}

exitApp( BuildContext context){
  return showAlertDialog(context, "Exit", "Do you want to leave the app?", yesText: "Yes", noText: "No", onYes: (){exit(0);}, onNo: (){Navigator.of(context).pop();});
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Color(0xff0A53DF);
    canvas.drawPath(mainBackground, paint);

    Path circlePath = Path();
    circlePath.moveTo(height * 0.05, 0);
    circlePath.quadraticBezierTo(
        width * 0.23, height * 0.37, width, height * 0.5);
    paint.color = Colors.white.withOpacity(0.05);
    circlePath.lineTo(width, 0);
    //circlePath.arcTo(rect, startAngle, sweepAngle, forceMoveTo)
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

parseDate( dateStamp){
  if(dateStamp!=null){
    var ts = dateStamp;
    var date = ts.toDate();
    return date;
  }
  return "";
}
String moneyFmt(dynamic amount ){
  if(amount != null){
    NumberFormat format = NumberFormat("₦ #,##0.0", "en_US");
    try{
      String num  = format.format(amount);
      return num;
    } catch (e){
      return "0";
    }
  }
  return "0";
}

