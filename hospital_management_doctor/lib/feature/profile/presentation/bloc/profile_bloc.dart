import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/get_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/data/model/update_profile_model.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:hospital_management_doctor/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_event.dart';
import 'package:hospital_management_doctor/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<BaseEvent, BaseState> {
  GetProfileUsecase? getProfileUsecase;
  UpdateProfileUsecase? updateProfileUsecase;


  ProfileBloc(
      {required this.getProfileUsecase,required this.updateProfileUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetProfileEvent) {
        getPatientProfileCall(event.id);
      }  else if (event is UpdateProfileEvent) {
        updatePatientProfileCall(
          yearOfExperience: event.yearOfExperience,
          rating: event.rating,
          nextAvailableAt: event.nextAvailableAt,
          fees: event.fees,
          education: event.education,
          dateOfBirth: event.dateOfBirth,
          bloodGroup: event.bloodGroup,
          about: event.about,
          profilePic: event.profilePic,
          email: event.email,
          gender: event.gender,
          firstName: event.firstName,
          lastName: event.lastName,
          mobileNumber: event.mobileNumber,
          doctorId: event.doctorId,
          hospitalId: event.hospitalId,
          specialistField: event.hospitalId
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
    String? doctorId,firstName,lastName,email,mobileNumber,profilePic,gender,dateOfBirth,
    bloodGroup,yearOfExperience,nextAvailableAt,specialistField,about,education,hospitalId,fees,rating
}) {
    updateProfileUsecase!
        .call(UpdateProfileParams(
      specialistField: specialistField,
      hospitalId: hospitalId,
      doctorId: doctorId,
      mobileNumber: mobileNumber,
      lastName: lastName,
      firstName: firstName,
      gender: gender,
      email: email,
      profilePic: profilePic,
        about: about,
      bloodGroup: bloodGroup,
      dateOfBirth: dateOfBirth,
      education: education,
      fees: fees,
      nextAvailableAt: nextAvailableAt,
      rating: rating,
      yearOfExperience: yearOfExperience
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