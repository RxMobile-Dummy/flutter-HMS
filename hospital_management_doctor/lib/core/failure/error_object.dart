import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/pages/login_screen.dart';
import 'package:hospital_management_doctor/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom/progress_bar.dart';
import '../strings/strings.dart';
import 'failure.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

class ErrorObject {


  static String? mapFailureToMessage(Failure failure) {
    if (failure.runtimeType == ServerFailure) {
      return Strings.kServerFailureMessage;
    } else if (failure.runtimeType == CacheFailure) {
      return Strings.kCacheFailureMessage;
    } else if (failure.runtimeType == FailureMessage) {
      if (failure is FailureMessage) {
        return failure.message;
      }
    }
  }

  static logout() async {
    ProgressDialog.hideLoadingDialog(navigatorKey.currentContext!);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("isOnBoardingCompleted", "true");
    print(prefs);
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,MaterialPageRoute(builder: (context) =>BlocProvider<AuthenticationBloc>(
        create: (context) => Sl.Sl<AuthenticationBloc>(),
        child: LoginScreen(),
      )),
            (route) => false,
      );
    });
  }

  static Future<Failure> checkErrorState(e) async {
    if (e is DioError) {
      if (e.error is SocketException) {
        return FailureMessage(Strings.kNoInternetConnection);
      } else if (e.response!.statusCode == 400) {
        return FailureMessage(e.response!.data.toString());
      } else if (e.response!.statusCode == 500) {
        return FailureMessage(Strings.kInternalServerError);
      } else {
        return FailureMessage(Strings.kSomethingWrong);
         // return FailureMessage(e.toString());
      }
    } else {
      if (e.errors!=null && e.errors[0].error.error is SocketException) {
        return InternetFailure(Strings.kNoInternetConnection);
      } else {
        return FailureMessage(e.response.data["error"].toString());
      }
    }
  }
}