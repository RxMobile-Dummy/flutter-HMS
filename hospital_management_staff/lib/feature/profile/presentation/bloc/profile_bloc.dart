import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:hospital_management_staff/feature/profile/presentation/bloc/profile_event.dart';
import 'package:hospital_management_staff/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<BaseEvent, BaseState> {
  GetProfileUsecase? getProfileUsecase;
  UpdateProfileUsecase? updateProfileUsecase;


  ProfileBloc(
      {required this.getProfileUsecase, required this.updateProfileUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetProfileEvent) {
        getPatientProfileCall(event.id);
      } else if (event is UpdateProfileEvent) {
        updatePatientProfileCall(
          contactNumber: event.contactNumber,
          profilePic: event.profilePic,
          yearOfExperience: event.yearOfExperience,
          education: event.education,
          dateOfBirth: event.dateOfBirth,
          bloodGroup: event.bloodGroup,
          email: event.email,
          gender: event.gender,
          firstName: event.firstName,
          lastName: event.lastName,
          hospitalId: event.hospitalId,
          staffId: event.staffId
        );
      }else if (event is GetProfileSuccessEvent) {
        GetProfileModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetProfileState(model: model));
        }
      }else if (event is UpdateProfileSuccessEvent) {
        UpdateProfileModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(UpdateProfileState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getPatientProfileCall(int id) {
    getProfileUsecase!
        .call(GetProfileParams(id: id))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetProfileSuccessEvent(model: onSuccess));
      });
    });
  }

  updatePatientProfileCall({
    String? staffId,firstName,lastName,contactNumber,email,profilePic,gender,dateOfBirth, bloodGroup, yearOfExperience, education, hospitalId
  }) {
    updateProfileUsecase!
        .call(UpdateProfileParams(
      staffId: staffId,
      hospitalId: hospitalId,
      lastName: lastName,
      firstName: firstName,
      gender: gender,
      email: email,
      bloodGroup: bloodGroup,
      dateOfBirth: dateOfBirth,
      education: education,
      yearOfExperience: yearOfExperience,
      profilePic: profilePic,
      contactNumber: contactNumber
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateProfileSuccessEvent(model: onSuccess));
      });
    });
  }



}