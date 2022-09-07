import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/pages/login_screen.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

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
              "assets/images/reset_successfully.png",
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.width * .5,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Successful!",
              textAlign: TextAlign.center,
              style: CustomTextStyle.styleBold.copyWith(
                  fontSize: DeviceUtil.isTablet ? 32 : 28),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "You have successfully change password.\nPlease use your new password when\nlogging in.",
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
                "Login",
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