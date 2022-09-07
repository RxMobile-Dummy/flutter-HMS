import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/error_bloc_builder/error_builder_listener.dart';
import 'package:hospital_management_doctor/custom/progress_bar.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_state.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/pages/forgot_password_screen.dart';
import 'package:hospital_management_doctor/feature/home.dart';
import 'package:hospital_management_doctor/utils/colors.dart';
import 'package:hospital_management_doctor/utils/device_file.dart';
import 'package:hospital_management_doctor/utils/style.dart';
import 'package:hospital_management_doctor/widget/text_field_with_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_management_doctor/injection_container.dart' as Sl;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordShow = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorBlocListener<AuthenticationBloc>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        // callback:  _loginUser(userName.text,tiePassword.text),
        child:  BlocBuilder<AuthenticationBloc, BaseState>(builder: (context, state)  {
          if(state is SignInDoctorState) {
            ProgressDialog.hideLoadingDialog(context);
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()/*MultiBlocProvider(
                      providers: [
                        BlocProvider<AppointmentBloc>(
                          create: (context) => Sl.Sl<AppointmentBloc>(),
                        ),
                        BlocProvider<DoctorBloc>(
                          create: (context) => Sl.Sl<DoctorBloc>(),
                        ),
                      ],
                      child: Home())*/),
                      (route) => false);
            });
          }
          return Form(
              key: _formKey,
              child: buildWidget());
        }),
      ),
    );
  }

  buildWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 80,horizontal: 40),
      child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Card(
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
                                  height: DeviceUtil.isTablet ? 300: 200,
                                  width: DeviceUtil.isTablet ? 300: 200,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/patient.jpeg"),
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                ),
                              ),
                              SizedBox(height:  DeviceUtil.isTablet ? 10 : 5,),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Open Sans',
                                          fontSize: DeviceUtil.isTablet ? 36 : 28,
                                          color: CustomColors.colorDarkBlue
                                      ),
                                    ),
                                    Text(
                                      "PAGE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Open Sans',
                                          fontSize: DeviceUtil.isTablet ? 36 :  28,
                                          color: CustomColors.colorPowerBlue
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: DeviceUtil.isTablet ? 20 : 5,),
                              CustomTextFieldWithBorder(
                                key: const Key("tefEmail"),
                                label: "Email Address",
                                hint: "Enter Email",
                                errorMessage: "Please Enter Email",
                                isEmail: true,
                                textInputType: TextInputType.emailAddress,
                                textEditingController: emailController,
                              ),
                              SizedBox(height:  DeviceUtil.isTablet ? 20 : 10,),
                              CustomTextFieldWithBorder(
                                key: const Key("tefPassword"),
                                label: "Password",
                                hint: "Enter Password",
                                isObscureText: isPasswordShow,
                                icon: IconButton(
                                    icon: Icon(
                                      isPasswordShow
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordShow = !isPasswordShow;
                                      });
                                    }),
                                errorMessage: "Please Enter Password",
                                textEditingController: passwordController,
                              ),
                              SizedBox(height: DeviceUtil.isTablet ? 20 : 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: Text(
                                      "Forgot Password ?",
                                      style: CustomTextStyle.styleMedium.copyWith(
                                          color: CustomColors.colorDarkBlue,
                                          fontSize: DeviceUtil.isTablet ? 16 : 14
                                      ),
                                    ),
                                    onTap: (){
                                      Future.delayed(Duration.zero, () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>BlocProvider<AuthenticationBloc>(
                                            create: (context) => Sl.Sl<AuthenticationBloc>(),
                                            child: ForgotPasswordScreen(),
                                          )),
                                        );
                                      });
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: (){
                                        if(_formKey.currentState!.validate()){
                                          _formKey.currentState?.save();
                                          FocusScope.of(context).unfocus();
                                          _loginPatient(emailController.text,passwordController.text);
                                        }else{
                                          FocusScope.of(context).unfocus();
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
                                        "Log In",
                                        style: CustomTextStyle.styleSemiBold.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height:  DeviceUtil.isTablet ?  20 : 7,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  Future<String> _loginPatient(String email,String password) {
    return Future.delayed(Duration()).then((_) {
      ProgressDialog.showLoadingDialog(context);
      BlocProvider.of<AuthenticationBloc>(context).add(
          SignInDoctorEvent(email: email.trim(), password: password.trim()));
      return "";
    });
  }
}
