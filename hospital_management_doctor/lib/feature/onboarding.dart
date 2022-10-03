import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/assets/images_name.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/pages/login_screen.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom/curve_painter.dart';
import '../../utils/colors.dart';
import '../../utils/style.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

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
    Strings.kOnBoardingTitle1,
    Strings.kOnBoardingTitle2,
    Strings.kOnBoardingTitle3
  ];
  List<String> listDescription = [
    Strings.kOnBoardingDescription1,
    Strings.kOnBoardingDescription2,
    Strings.kOnBoardingDescription3
  ];
  List<String> listImage = [
    ImagesName.kOnBoardingImage1,
    ImagesName.kOnBoardingImage2,
    ImagesName.kOnBoardingImage3
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
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
                        child: Text(Strings.kGetStarted,
                            style: CustomTextStyle.styleBold
                                .copyWith(color: Colors.white,
                                fontSize: DeviceUtil.isTablet ? 22: 14)),
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.colorDarkBlue,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(horizontal: 35,vertical: 10)
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString(Strings.kOnBoardingBool, Strings.kTrue);
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                BlocProvider<AuthenticationBloc>(
                                create: (context) => Sl.Sl<AuthenticationBloc>(),
                                child: LoginScreen(),
                              )),
                            );
                          });
                        },
                      )
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
          child: Image.asset(
              listImage[index],
              height: DeviceUtil.isTablet ? 350:250),
        ),),
        const SizedBox(height: 20,),
        Text(
          listTitle[index],
          style: CustomTextStyle.styleBold.copyWith(
              fontSize: DeviceUtil.isTablet ? 26:20),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              listDescription[index],
              textAlign: TextAlign.center,
              style: CustomTextStyle.styleRegular.copyWith(
                  fontSize: DeviceUtil.isTablet ? 22:16),
            ),
          ),
        )
      ],
    );
  }
}
