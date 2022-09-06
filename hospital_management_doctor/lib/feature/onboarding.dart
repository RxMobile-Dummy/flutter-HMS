import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/feature/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom/curve_painter.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<Color> listColors = [
    CustomColors.colorDarkBlue,
    CustomColors.colorBrightBlue,
    CustomColors.colorPowerBlue
  ];
  List<String> listTitle = [
    "Need A Doctor",
    "Health Advice",
    "24X7 Home Service"
  ];
  List<String> listDescription = [
    "HomeCare's doctor at home service provides expert care for you and your family that encompasses day-to-day healthcare needs as well as long term assistance.",
    "Everyday Health inspires and empowers people to live their healthiest lives, every day, through trusted, medically reviewed information and expert",
    "We provide low cost ambulance services with complete ICU Backup, advance life support. Fully Medical Equipped 100% sanitised Ambulance Available at Your Doorstep!"
  ];
  List<String> listImage = [
    "assets/images/need_a_doctor.jpeg",
    "assets/images/health_advice.jpeg",
    "assets/images/ambulance.jpeg"
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [

            /*CustomPaint(
              painter: CurvePainter(color: listColors[currentPage]),
              child: Container(),
            ),*/
           /* CustomPaint(
              painter: CurvePainter1(
                  color: listColors[currentPage].withOpacity(0.2)),
              child: Container(),
            ),
            CustomPaint(
              painter: CurvePainter2(
                  color: listColors[currentPage].withOpacity(0.2)),
              child: Container(),
            ),*/
            Column(
              children: [
                Expanded(
                  flex: 50,
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return pageItem(index);
                    },
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    itemCount: listTitle.length,
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPage == index
                                    ? Colors.black
                                    : Colors.grey),
                            margin: EdgeInsets.only(
                                right: index == listTitle.length ? 0 : 8),
                          );
                        },
                        itemCount: listTitle.length,
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                )
              ],
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      //width: double.infinity,
                      margin: const EdgeInsets.only(left: 32, right: 32),
                      child: ElevatedButton(
                        child: Text("Get Started",
                            style: CustomTextStyle.styleBold
                                .copyWith(color: Colors.white, fontSize: 14)),
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.colorDarkBlue,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 10)
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("isOnBoardingCompleted", "true");
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>LoginScreen()
                                /*BlocProvider<AuthenticationBloc>(
                                create: (context) => Sl.Sl<AuthenticationBloc>(),
                                child: LoginScreen(),
                              )*/),
                            );
                          });

                          // Get.off(Login());
                        },

                      )/*RaisedButton(
                        color: Colors.white,
                        elevation: 2,
                        splashColor: listColors[currentPage].withOpacity(.2),
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString("isOnBoardingCompleted", "true");
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>LoginScreen()
                                *//*BlocProvider<AuthenticationBloc>(
                                create: (context) => Sl.Sl<AuthenticationBloc>(),
                                child: LoginScreen(),
                              )*//*),
                            );
                          });

                          // Get.off(Login());
                        },
                        child: Text("Get Started",
                            style: CustomTextStyle.styleBold
                                .copyWith(color: Colors.black, fontSize: 14)),
                      ),*/
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  pageItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Container(
          color:  index == 0 ? Colors.white70 : Colors.white,
          margin: const EdgeInsets.all(16),
          child: Image.asset(listImage[index],height: 250),
        ),),
        const SizedBox(height: 20,),
        Text(
          listTitle[index],
          style: CustomTextStyle.styleBold.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              listDescription[index],
              textAlign: TextAlign.center,
              style: CustomTextStyle.styleRegular.copyWith(fontSize: 16),
            ),
          ),
        )
      ],
    );
  }
}
