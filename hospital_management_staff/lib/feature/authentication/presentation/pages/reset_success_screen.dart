import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/assets/images_name.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_staff/feature/authentication/presentation/pages/login_screen.dart';
import 'package:hospital_management_staff/injection_container.dart' as Sl;
import 'package:hospital_management_staff/utils/colors.dart';
import 'package:hospital_management_staff/utils/device_file.dart';
import 'package:hospital_management_staff/utils/style.dart';

class ResetSuccess extends StatefulWidget {
  @override
  _ResetSuccessState createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Image.asset(
              ImagesName.kResetSuccessImage,
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.width * .5,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Strings.kSuccessful,
              textAlign: TextAlign.center,
              style: CustomTextStyle.styleBold.copyWith(
                  fontSize: DeviceUtil.isTablet ? 32 : 28),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              Strings.kSuccessfulChangePassword,
              textAlign: TextAlign.center,
              style: CustomTextStyle.styleMedium
                  .copyWith(fontSize: DeviceUtil.isTablet ? 20 :14, color: Colors.grey.shade700),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,MaterialPageRoute(builder: (context) =>BlocProvider<AuthenticationBloc>(
                  create: (context) => Sl.Sl<AuthenticationBloc>(),
                  child: LoginScreen(),
                )),
                      (route) => false,
                );
              },
              child: Text(
                Strings.kLogin,
                style: CustomTextStyle.styleBold
                    .copyWith(color: CustomColors.colorDarkBlue,
                    fontSize: DeviceUtil.isTablet ? 20 :14),
              ),
            ),
            Expanded(child: Container()),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}