import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:takara_bill/StringAssets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:takara_bill/StaticItems.dart';
import 'package:takara_bill/main.dart';
import 'AppEngine.dart';
import 'models/bill.dart';
import 'providers/dataBank.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;



@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final provider = context.read(dataProvider);
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
              top: 20,
              left: 20,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 53,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: iconButton),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlatButton(
                          onPressed: () {
                            signout(context);
                          },
                          splashColor: white,
                          child: SvgPicture.asset(
                            ic_profileWhite,
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill Balance",
                              style: GoogleFonts.cabin(
                                  fontSize: 20, letterSpacing: 2, color: white),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "\u{20A6} 300,000",
                              style: GoogleFonts.cabin(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: white),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: iconButton),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FlatButton(
                                splashColor: white.withOpacity(0.5),
                                onPressed: () {},
                                child: Icon(
                                  Icons.navigate_next,
                                  color: white,
                                  size: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                  padding:
                      EdgeInsets.only(left: 15, top: 25, right: 15, bottom: 15),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: textColor, shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Recent bills",
                                  style: styleText(
                                      size: 18, weight: FontWeight.w700),
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
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: StreamBuilder<List<Bill>>(
                          stream: provider.bills,
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    print(snapshot.data[index].unitPrice);
                                    bool color = true;
                                    if ((numbers[index] % 2) == 0) {
                                      color = false;
                                    }
                                    return buildTile(snapshot.data[index], color);
                                  });
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }

  buildTile(Bill bill, bool color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      //color: textFieldColor.withOpacity(0.8),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: () {
          },
          leading: Container(
            height: double.infinity,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ? green.withOpacity(0.1) : red.withOpacity(0.1),
            ),
            child: Icon(
              color ? Icons.arrow_drop_down_sharp : Icons.arrow_drop_up,
              size: 30,
              color: color ? green : red,
            ),
          ),
          title: Text(
            bill.description??"not found",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: styleText(size: 18),
          ),
          subtitle: Text(
            bill.vendorName??"not Found",
            style: styleText(size: 14, color: grey),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${ moneyFmt(bill.billAmount)}",
                style: styleText(
                    size: 18,
                    color: color ? green : red,
                    weight: FontWeight.w800),
              ),
              Text(
                "days",
                style: styleText(size: 14, color: grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
