import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/core/common_keys/common_keys.dart';
import 'package:hospital_management/features/authentication/data/model/forgot_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/reset_password_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_in_model.dart';
import 'package:hospital_management/features/authentication/data/model/sign_up_model.dart';
import 'package:hospital_management/features/authentication/domain/usecases/add_patient_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:hospital_management/features/authentication/domain/usecases/sign_in_patient_usecase.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';

class AuthenticationBloc extends Bloc<BaseEvent, BaseState> {
AddPatientUsecase addPatientUsecase;
SignInPatientUsecase? signInPatientUsecase;
ForgotPasswordUsecase? forgotPasswordUsecase;
ResetPasswordUsecase? resetPasswordUsecase;


  AuthenticationBloc(
      {required this.resetPasswordUsecase,required this.addPatientUsecase,required this.signInPatientUsecase,required this.forgotPasswordUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) async {
      if (event is EventRequest) {
      } else if (event is AddPatientEvent) {
        getAllergiesCall(
          height: event.height,
          email: event.email,
          profilePic: event.profilePic,
          lastName: event.lastName,
          firstName: event.firstName,
          password: event.password,
          occupation: event.occupation,
          activityLevel: event.activityLevel,
          alcoholConsumption: event.alcoholConsumption,
          allergy: event.allergy,
          bloodGroup: event.bloodGroup,
          city: event.city,
          contactNumber: event.contactNumber,
          currentMedication: event.currentMedication,
          dateOfBirth: event.dateOfBirth,
          emergencyContactNumber: event.emergencyContactNumber,
          foodPreference: event.foodPreference,
          gender: event.gender,
          maritalStatus: event.maritalStatus,
          pastInjury: event.pastInjury,
          pastSurgery: event.pastSurgery,
          smokingHabits: event.smokingHabits,
          weight: event.weight
        );
      } else if (event is SignInPatientEvent) {
        loginCall(
            event.email,
            event.password,
        );
      } else if (event is ForgotPasswordEvent) {
        forgotPasswordCall(
          event.email,);
      } else if (event is ResetPasswordEvent) {
        resetPasswordCall(
          password: event.password,
          otp: event.otp,
        );
      } else if (event is AddPatientSuccessEvent) {
        AddPatientModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(CommonKeys.K_Access, model?.data!.authenticationToken!.access ?? "");
          prefs.setString(CommonKeys.K_Refresh, model?.data!.authenticationToken!.refresh ?? "");
          prefs.setString(CommonKeys.K_Id, model?.data?.id!.toString() ?? "");
          String patient = jsonEncode(model?.data?.toJson());
          prefs.setString(CommonKeys.K_Patient_Data, patient);
          emit(AddPatientState(model: model));
        }
      }else if (event is SignInPatientSuccessEvent){
        SignInPatientModel? model = event.model;

        if(model?.success != true){
          emit(StateErrorGeneral(model?.error??""));
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(CommonKeys.K_Access, model!.data?.authenticationToken?.access ?? "");
          prefs.setString(CommonKeys.K_Refresh, model.data?.authenticationToken?.refresh ?? "");
          prefs.setString(CommonKeys.K_Id, model.data?.id!.toString() ?? "");
          String? token = prefs.getString(CommonKeys.K_Access);
          print(token);
          String user = jsonEncode(model.data?.toJson());
          prefs.setString(CommonKeys.K_User_Data, user);
          emit(SignInPatientState(model: model));
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
  signInPatientUsecase!
      .call(SignInParams(email: email, password: password))
      .listen((data) {
    data.fold((onError) {
      add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
    }, (onSuccess) {
      add(SignInPatientSuccessEvent(model: onSuccess));
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


  getAllergiesCall({
  String? firstName,
  String? lastName,
  String? contactNumber,
  String? password,
  String? email,
  String? gender,
  String? dateOfBirth,
  String? bloodGroup,
  String? maritalStatus,
  String? height,
  String? weight,
  String? emergencyContactNumber,
  String? city,
  String? allergy,
  String? currentMedication,
  String? pastInjury,
  String? pastSurgery,
  String? smokingHabits,
  String? alcoholConsumption,
  String? activityLevel,
  String? foodPreference,
  String? occupation,
    String? profilePic,
}) {
    addPatientUsecase
        .call(AddPatientParams(
        email: email ?? "",
        password: password ?? "",
        allergy: allergy ?? "",
        profilePic: profilePic ?? "",
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        occupation: occupation ?? "",
        height: height ?? "",
        activityLevel: activityLevel ?? "",
        alcoholCunsumption: alcoholConsumption ?? "",
        bloodGroup: bloodGroup ?? "",
        city: city ?? "",
        contactNumber: contactNumber ?? "",
        currentMedication: currentMedication ?? "",
        dateOfBirth: dateOfBirth ?? "",
        emergencyContactNumber: emergencyContactNumber ?? "",
        foodPreference: foodPreference ?? "",
        gender: gender ?? "",
        maritalStatus: maritalStatus ?? "",
        pastInjury: pastInjury ?? "",
        pastSurgery: pastSurgery ?? "",
        smokingHabits: smokingHabits ?? "",
        weight: weight ?? "",
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddPatientSuccessEvent(model: onSuccess));
      });
    });
  }

}