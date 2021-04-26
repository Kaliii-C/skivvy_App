import 'package:flutter/material.dart';
import 'package:skivvy_app/screens/Login_screen.dart';
import 'package:skivvy_app/store/size_config.dart';
import 'package:skivvy_app/widgets/default_button.dart';
import 'package:skivvy_app/widgets/welcome_content.dart';
import 'package:skivvy_app/theme.dart';

class WelcomeBody extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeBody> {
  int activePage = 0;
  List<Map<String, String>> welcomeData = [
    {
      "image": "assets/icons/welcome_1.png",
      "text": "Welcome to Skivvy, Let's get started!"
    },
    {
      "image": "assets/icons/welcome_2.png",
      "text": "Manage your plans and events"
    },
    {"image": "assets/icons/welcome_3.png", "text": "Plan your tasks"},
    {
      "image": "assets/icons/welcome_4.png",
      "text": "Share it with your friends and family"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    activePage = value;
                  });
                },
                itemBuilder: (context, index) => WelcomeContent(
                  text: welcomeData[index]["text"],
                  image: welcomeData[index]["image"],
                ),
                itemCount: welcomeData.length,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: getPropScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: List.generate(welcomeData.length,
                          (index) => buildDotSlide(index: index)),
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    DefaultBtn(
                      text: 'Get Started',
                      click: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDotSlide({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: activePage == index ? 20 : 8,
      height: 8,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: activePage == index ? skivvySecondaryColor : skivvyBaseColor,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
