import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hospital_management_doctor/core/assets/images_name.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../feature/authentication/presentation/pages/login_screen.dart';
import '../feature/onboarding.dart';
import '../utils/style.dart';
import '../widget/size.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString(Strings.kAccess);
      var isOnBoardingComplete = prefs.getString(Strings.kOnBoardingBool);
      Timer(Duration(seconds: 2), () {
        Get.off(
            MultiBlocProvider(providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => Sl.Sl<AuthenticationBloc>(),
              ),
              BlocProvider<AppointmentBloc>(
                create: (context) => Sl.Sl<AppointmentBloc>(),
              ),
            ], child: authToken == null ? (isOnBoardingComplete == Strings.kTrue) ? LoginScreen() : OnBoarding() : HomeScreen()
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var imageWidth = MediaQuery.of(context).size.width/4;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagesName.kHospitalImage,width: imageWidth,height: imageWidth,),
            sized_16(),
            Text(
              Strings.kHospitalManagement,
              style: CustomTextStyle.styleBold.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
