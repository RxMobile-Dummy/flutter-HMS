import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/strings/strings.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management_doctor/feature/authentication/data/model/sign_in_doctor.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/domain/usecases/sign_in_doctor_usecase.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management_doctor/feature/authentication/presentation/bloc/authentication_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failure/error_object.dart';

class AuthenticationBloc extends Bloc<BaseEvent, BaseState> {
  SignInDoctorUsecase? signInDoctorUsecase;
  ForgotPasswordUsecase? forgotPasswordUsecase;
  ResetPasswordUsecase? resetPasswordUsecase;


  AuthenticationBloc(
      {required this.signInDoctorUsecase,
      required this.forgotPasswordUsecase,
      required this.resetPasswordUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) async {
      if (event is EventRequest) {
      }  else if (event is SignInDoctorEvent) {
        loginCall(
          event.email,
          event.password,
        );
      }else if (event is ForgotPasswordEvent) {
        forgotPasswordCall(
          event.email,
        );
      }else if (event is ResetPasswordEvent) {
        resetPasswordCall(
          password: event.password,
          otp: event.otp,
        );
      }else if (event is SignInDoctorSuccessEvent){
        SignInDoctorModel? model = event.model;

        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(Strings.kAccess, model!.data?.authenticationToken?.access ?? "");
          prefs.setString(Strings.kRefresh, model.data?.authenticationToken?.refresh ?? "");
          prefs.setString(Strings.kId, model.data?.id!.toString() ?? "");
          String? token = prefs.getString(Strings.kAccess);
          print(token);
          String user = jsonEncode(model.data?.toJson());
          prefs.setString(Strings.kUserData, user);
          emit(SignInDoctorState(model: model));
        }
      }else if (event is ForgotPasswordSuccessEvent){
        ForgotPasswordModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          emit(ForgotPasswordState(model: model));
        }
      }else if (event is ResetPasswordSuccessEvent){
        ResetPasswardModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          emit(ResetPasswordState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }

  loginCall(String email, String password) {
    signInDoctorUsecase!
        .call(SignInParams(email: email, password: password))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(SignInDoctorSuccessEvent(model: onSuccess));
      });
    });
  }

  forgotPasswordCall(String email) {
    forgotPasswordUsecase!
        .call(ForgotPasswordParams(email: email))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(ForgotPasswordSuccessEvent(model: onSuccess));
      });
    });
  }

  resetPasswordCall({String? otp, String? password}) {
    resetPasswordUsecase!
        .call(ResetPasswordParams(OTP: otp ?? "",password: password ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(ResetPasswordSuccessEvent(model: onSuccess));
      });
    });
  }

}