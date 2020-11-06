import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AppEngine.dart';
import '../StaticItems.dart';
import '../StringAssets.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: BluePainter(),
                child: const Center(),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *0.1,
              left: 20,
              right: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  children: [],
                )
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                  padding: EdgeInsets.only(
                      left: 15, top: 25, right: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                    color: white,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: textColor,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Recent bills",
                                  style: styleText(
                                      size: 18,
                                      weight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Text(
                              "History",
                              style: styleText(
                                  size: 16,
                                  weight: FontWeight.w500,
                                  color: grey),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:10,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: numbers.length,
                            itemBuilder: (context, index){
                              bool color = true;
                              if ((numbers[index] % 2) == 0){
                                color = false;
                              }
                              return buildTile(numbers[index], color);
                            }),
                      )

                    ],
                  )),
            )
          ],
        ),
        inAsyncCall: false,
      ),
    );
  }
  buildTile(int number, bool color ){
    return  Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      //color: textFieldColor.withOpacity(0.8),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {},
          leading: Container(
            height: double.infinity,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color? green.withOpacity(0.1): red.withOpacity(0.1),
            ),
            child: Icon(
              color? Icons.arrow_drop_down_sharp: Icons.arrow_drop_up,
              size: 30,
              color: color? green:red,
            ),
          ),
          title: Text(
            "Energy purchased",
            style: styleText(size: 18),
          ),
          subtitle: Text(
            "Mainstream Energy",
            style: styleText(size: 14, color: grey),
          ),
          trailing: Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Text(
                "\$ 50,000",
                style: styleText(
                    size: 18,
                    color: color? green: red,
                    weight: FontWeight.w800),
              ),
              Text(
                "$number days",
                style: styleText(
                    size: 14, color: grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
