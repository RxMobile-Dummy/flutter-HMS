import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';
import 'package:hospital_management/features/profile/domain/usecases/get_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/domain/usecases/update_patient_profile_usecase.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_event.dart';
import 'package:hospital_management/features/profile/presentation/bloc/patient_profile_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';

class PatientProfileBloc extends Bloc<BaseEvent, BaseState> {
  GetPatientProfileUsecase? getPatientProfileUsecase;
  UpdatePatientUsecase? updatePatientUsecase;


  PatientProfileBloc(
      {required this.getPatientProfileUsecase,required this.updatePatientUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetPatientProfileEvent) {
        getPatientProfileCall(event.id);
      } else if (event is UpdatePatientEvent) {
        updatePatientCall(
          patient_id: event.patient_id,
            height: event.height,
            email: event.email,
            profile_pic: event.profile_pic,
            last_name: event.last_name,
            first_name: event.first_name,
            occupation: event.occupation,
            activity_level: event.activity_level,
            alchol_consumption: event.alchol_consumption,
            allergy: event.allergy,
            blood_group: event.blood_group,
            city: event.city,
            contact_number: event.contact_number,
            current_medication: event.current_medication,
            date_of_birth: event.date_of_birth,
            emergency_contact_number: event.emergency_contact_number,
            food_preference: event.food_preference,
            gender: event.gender,
            marital_status: event.marital_status,
            past_injury: event.past_injury,
            past_surgery: event.past_surgery,
            smoking_habits: event.smoking_habits,
            weight: event.weight
        );
      }else if (event is GetPatientProfileSuccessEvent) {
        GetPatientProfileModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetPatientProfileState(model: model));
        }
      }else if (event is UpdatePatientProfileSuccessEvent) {
        UpdatePatientProfileModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(UpdatePatientProfileState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getPatientProfileCall(int id) {
    getPatientProfileUsecase!
        .call(GetPatientProfileParams(id: id))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetPatientProfileSuccessEvent(model: onSuccess));
      });
    });
  }

  updatePatientCall({
    String? patient_id,
    String? first_name,
    String? last_name,
    String? contact_number,
    String? email,
    String? gender,
    String? date_of_birth,
    String? blood_group,
    String? marital_status,
    String? height,
    String? weight,
    String? emergency_contact_number,
    String? city,
    String? allergy,
    String? current_medication,
    String? past_injury,
    String? past_surgery,
    String? smoking_habits,
    String? alchol_consumption,
    String? activity_level,
    String? food_preference,
    String? occupation,
    String? profile_pic,
  }) {
    updatePatientUsecase!
        .call(UpdatePatientParams(
        patient_id: patient_id ?? "",
        email: email ?? "",
        allergy: allergy?? "",
        profile_pic: profile_pic?? "",
        first_name: first_name?? "",
        last_name: last_name?? "",
        occupation: occupation?? "",
        height: height?? "",
        activity_level: activity_level?? "",
        alchol_consumption: alchol_consumption?? "",
        blood_group: blood_group?? "",
        city: city?? "",
        contact_number: contact_number?? "",
        current_medication: current_medication?? "",
        date_of_birth: date_of_birth?? "",
        emergency_contact_number: emergency_contact_number?? "",
        food_preference: food_preference?? "",
        gender: gender?? "",
        marital_status: marital_status?? "",
        past_injury: past_injury ?? "",
        past_surgery: past_surgery ?? "",
        smoking_habits: smoking_habits ?? "",
        weight: weight ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdatePatientProfileSuccessEvent(model: onSuccess));
      });
    });
  }

}