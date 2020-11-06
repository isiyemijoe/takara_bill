import 'package:flutter/material.dart';
import 'package:takara_bill/AppEngine.dart';
import 'package:takara_bill/StaticItems.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const SliderPage({Key key, this.title, this.description, this.image}) : super(key: key);@override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SvgPicture.asset(
            image, width: width*0.7,
            height: width*0.7,
          ),
          SizedBox(
            height:30,
          ),
          Text(title, textAlign: TextAlign.center, style:  styleText(size: 20, weight: FontWeight.w700),),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text(description, textAlign: TextAlign.center, style:  styleText(size: 18, color:disabledIcon ),)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
