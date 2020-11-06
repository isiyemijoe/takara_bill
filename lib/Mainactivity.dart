import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takara_bill/AppEngine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takara_bill/bills/billPage.dart';
import 'package:takara_bill/profile/profilePage.dart';
import 'package:takara_bill/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takara_bill/vendor/vendorPage.dart';

import 'Homepage.dart';
import 'StaticItems.dart';
import 'StringAssets.dart';
import 'autoLogin.dart';
import 'main.dart';

class Mainactivity extends StatefulWidget {
  @override
  _MainactivityState createState() => _MainactivityState();
}

class _MainactivityState extends State<Mainactivity> {
  int buttomIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var auth = context.read(authProvider);
    return StreamBuilder<User>(
      stream: auth.authStateChange,
      // ignore: missing_return
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return AutoLogin();
        }
        return WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            exitApp(context);
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: white,
              body: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  HomePage(),
                  BillPage(),
                  VendorPage(),
                  ProfilePage()
                ],

              ),
              bottomNavigationBar: BubbleBottomBar(
                opacity: .2,
                currentIndex: buttomIndex,
                onTap: (val) {
                  setState(() {
                    _pageController.jumpToPage(val);
                    buttomIndex = val;
                  });
                },
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                elevation: 8,
                iconSize: 20,

                //new, gives a cute ink effect
                //optional, uses theme color if not specified
                items: <BubbleBottomBarItem>[
                  BubbleBottomBarItem(
                      backgroundColor: Color(0xff0A53DF),
                      icon: SvgPicture.asset(
                        ic_homeUnfilled,
                        height: 22,
                        width: 22,
                      ),
                      activeIcon: SvgPicture.asset(
                        ic_homeFilled,
                        height: 25,
                        width: 25,
                      ),
                      title: Text("Home",
                          style: styleText(
                              size: 14,
                              weight: FontWeight.w600,
                              color: primaryColor))),
                  BubbleBottomBarItem(
                      backgroundColor: Color(0xff0A53DF),
                      icon: SvgPicture.asset(
                        ic_billUnFilled,
                        height: 22,
                        width: 22,
                      ),
                      activeIcon: SvgPicture.asset(
                        ic_billFilled,
                        height: 25,
                        width: 25,
                      ),
                      title: Text("Bills",
                          style: styleText(
                              size: 14,
                              weight: FontWeight.w600,
                              color: primaryColor))),
                  BubbleBottomBarItem(
                      backgroundColor: Colors.indigo,
                      icon: SvgPicture.asset(
                        ic_vendorUnfilled,
                        height: 22,
                        width: 22,
                      ),
                      activeIcon: SvgPicture.asset(
                        ic_vendorFilled,
                        height: 25,
                        width: 25,
                      ),
                      title: Text("Vendors",
                          style: styleText(
                              size: 14,
                              weight: FontWeight.w600,
                              color: primaryColor))),
                  BubbleBottomBarItem(
                      backgroundColor: Color(0xff0A53DF),
                      icon: SvgPicture.asset(
                        ic_profileUnfilled,
                        height: 22,
                        width: 22,
                      ),
                      activeIcon: SvgPicture.asset(
                        ic_profileFilled,
                        height: 25,
                        width: 25,
                      ),
                      title: Text(
                        "Profile",
                        style: styleText(
                            size: 14,
                            weight: FontWeight.w600,
                            color: primaryColor),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
