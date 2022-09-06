import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hospital_management/features/appoinment/presentation/bloc/appointment_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/allergies_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/food_preference_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/injuries_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/medication_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/surgery_bloc.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/authentication/presentation/pages/login.dart';
import '../features/authentication/presentation/pages/sign_up_screen1.dart';
import '../features/authentication/presentation/pages/sign_up_screen_main.dart';
import '../features/onboarding.dart';
import '../utils/style.dart';
import '../widget/size.dart';
import 'package:hospital_management/injection_container.dart' as Sl;
import '../features/home.dart';


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
      var authToken = prefs.getString('access');
      var isOnBoardingComplete = prefs.getString("isOnBoardingCompleted");
      Timer(Duration(seconds: 2), () {
        Get.off(
            MultiBlocProvider(providers: [
              BlocProvider<AuthenticationBloc>(
                create: (context) => Sl.Sl<AuthenticationBloc>(),
              ),
              BlocProvider<AppointmentBloc>(
                create: (context) => Sl.Sl<AppointmentBloc>(),
              ),
              BlocProvider<DoctorBloc>(
                create: (context) => Sl.Sl<DoctorBloc>(),
              ),
            ], child: authToken == null ? (isOnBoardingComplete == "true") ? LoginScreen() : OnBoarding() : Home()
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
            Image.asset("assets/images/hospital1.png",width: imageWidth,height: imageWidth,),
            sized_16(),
            Text(
              "Hospital Management",
              style: CustomTextStyle.styleBold.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
