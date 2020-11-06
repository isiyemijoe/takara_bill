import 'package:flutter/material.dart';
import 'package:takara_bill/StaticItems.dart';
import 'package:takara_bill/signIn.dart';
import 'package:page_transition/page_transition.dart';

import 'AppEngine.dart';
import 'StringAssets.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;
  PageController _pageController = PageController();

  _onPageChanged(int index){
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        exitApp(context);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  itemCount: onboardingPages.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, int index){
                    return onboardingPages[index];
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingPages.length, (index){
                      return AnimatedContainer(
                        curve: Curves.bounceInOut,
                          duration: Duration(milliseconds: 300),
                        height: 10,
                        width:(_currentPage == index)? 30 :10 ,

                     margin: EdgeInsets.symmetric(vertical: 30, horizontal: 2),
                        decoration: BoxDecoration(
                            color:(_currentPage == index)? primaryColor : disabledIcon ,
                          borderRadius: BorderRadius.circular(20)
                        ),
                      );
                    },
                  )),
                  InkWell(
                    onTap: (){

                      if(_currentPage == onboardingPages.length -1){
                        Navigator.push(context, PageTransition(
                            duration: Duration(milliseconds: 500),
                            type:PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.bottomCenter,
                            child: SignIn()
                        ));
                      }
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOutQuart);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 60,
                      width:  (_currentPage == onboardingPages.length-1)? 200: 60,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: (_currentPage == onboardingPages.length-1)?
                      Center(child: Text("Get Started", style: styleText( size: 18, color: white, weight: FontWeight.bold),)):
                      Center(child: Icon(Icons.navigate_next_outlined, color: Colors.white, size: 50,)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              )

            ],

          )),
    );
  }
}
