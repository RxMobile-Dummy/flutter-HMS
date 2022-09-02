import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/pages/reset_success_screen.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/text_field_with_border.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  String email;
   ResetPasswordScreen({Key? key,required this.email}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

@override
  void initState() {
  timer = Timer.periodic(Duration(seconds: 1), (_) {
    if (secondsRemaining != 0) {
      setState(() {
        secondsRemaining--;
      });
    } else {
      setState(() {
        enableResend = true;
      });
    }
  });
    super.initState();
  }

  @override
  dispose(){
    timer!.cancel();
    super.dispose();
  }

  void _resendCode() {
    setState((){
      secondsRemaining = 60;
      enableResend = false;
      _forgotPassward(widget.email);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBlocListener<AuthenticationBloc>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<AuthenticationBloc, BaseState>(builder: (context, state)  {
          if(state is ResetPasswordState){
            ProgressDialog.hideLoadingDialog(context);
            Get.to(ResetSuccess());
          } else if(state is ForgotPasswordState){
            ProgressDialog.hideLoadingDialog(context);
          }
          return  Form(
            key: _formKey,
            child: Center(
              child: buildWidget(),
            ),
          );
        }),
      ),
    );
  }

  buildWidget(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/reset.png"),
                                fit: BoxFit.fill,
                              )
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "RESET",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: 22,
                                  color: CustomColors.colorDarkBlue
                              ),
                            ),
                            Text(
                              "PASSWORD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'Open Sans',
                                  fontSize: 22,
                                  color: CustomColors.colorPowerBlue
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFieldWithBorder(
                        key: const Key("tefOtp"),
                        label: "OTP",
                        hint: "Enter OTP",
                        errorMessage: "Please Enter 6 digit OTP",
                        textInputType: TextInputType.number,
                        lengthLimit: 6,
                        textEditingController: otpController,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFieldWithBorder(
                        key: const Key("tefPassword"),
                        label: "Password",
                        hint: "Enter Password",
                        errorMessage: "Please Enter Password",
                        isEmail: true,
                        textInputType: TextInputType.emailAddress,
                        textEditingController: passwordController,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFieldWithBorder(
                        key: const Key("tefConfirmPassword"),
                        label: "Confirm Password",
                        hint: "Enter Confirm Password",
                        errorMessage: "Please Enter Confirm Password",
                        isEmail: true,
                        textInputType: TextInputType.emailAddress,
                        textEditingController: confirmPasswordController,
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState?.save();
                                  if(passwordController.text == confirmPasswordController.text){
                                    _resetPassward(passwordController.text,otpController.text);
                                  }else{
                                    Fluttertoast.cancel();
                                    Fluttertoast.showToast(
                                        msg: "Password does not same.",
                                        toastLength: Toast.LENGTH_LONG,
                                        fontSize: DeviceUtil.isTablet ? 20 : 12,
                                        backgroundColor: CustomColors.colorDarkBlue,
                                        textColor: Colors.white
                                    );
                                  }
                                }else{
                                  Fluttertoast.cancel();
                                  Fluttertoast.showToast(
                                      msg: "Please fill all the details.",
                                      toastLength: Toast.LENGTH_LONG,
                                      fontSize: DeviceUtil.isTablet ? 20 : 12,
                                      backgroundColor: CustomColors.colorDarkBlue,
                                      textColor: Colors.white
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: CustomColors.colorDarkBlue,
                                shape: StadiumBorder(),
                              ),
                              child:  Text(
                                "Reset Password",
                                style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child:  Text(
                          'after $secondsRemaining seconds',
                          style: CustomTextStyle.styleBold.copyWith(fontSize: 18,color: Colors.black),
                        ),
                      ),
                      Center(
                        child: FlatButton(
                          onPressed: enableResend ? _resendCode : null,
                          child: Text(
                            'Resend Code',
                            style: CustomTextStyle.styleBold.copyWith(fontSize: 18,color: CustomColors.colorDarkBlue),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _forgotPassward(String email) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AuthenticationBloc>(context).add(
          ForgotPasswordEvent(email: email.trim()));
      return "";
    });
  }

  Future<String> _resetPassward(String passward,String otp) {
    return Future.delayed(const Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AuthenticationBloc>(context).add(
          ResetPasswordEvent(password: passward.trim(),otp: otp));
      return "";
    });
  }
}
