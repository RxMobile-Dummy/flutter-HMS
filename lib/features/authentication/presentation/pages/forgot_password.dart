import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:hospital_management/features/authentication/presentation/pages/reset_password_screen.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/error_bloc_builder/error_builder_listener.dart';
import '../../../../custom/progress_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/device_file.dart';
import '../../../../utils/style.dart';
import '../../../../widget/text_field_with_border.dart';
import '../bloc/authentication_bloc.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBlocListener<AuthenticationBloc>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<AuthenticationBloc, BaseState>(builder: (context, state)  {
          if(state is ForgotPasswordState) {
            ProgressDialog.hideLoadingDialog(context);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: emailController.text,)),
                      (route) => false);
            });
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
                                image: AssetImage("assets/images/forgot.png"),
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
                              "FORGOT",
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
                        key: const Key("tefEmail"),
                        label: "Email Address",
                        hint: "Enter Email",
                        errorMessage: "Please Enter Email",
                        isEmail: true,
                        textInputType: TextInputType.emailAddress,
                        textEditingController: emailController,
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){
                                  _formKey.currentState?.save();
                                  _forgotPassward(emailController.text);
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
                                "Send Email",
                                style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: TextButton(
                         child: Text(
                           "Login",
                           style: CustomTextStyle.styleSemiBold.copyWith(color: CustomColors.colorDarkBlue),
                         ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
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
}
