import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/usecases/get_patient_usecase.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/bloc/patient_event.dart';
import 'package:hospital_management_doctor/feature/patient/presentation/bloc/patient_state.dart';

class PatientBloc extends Bloc<BaseEvent, BaseState> {
  GetPatientUsecase? getPatientUsecase;

  PatientBloc(
      {required this.getPatientUsecase,})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetPatientEvent) {
        getPatientCall(doctorId: event.doctorId,search: event.search);
      } else if (event is GetPatientSuccessEvent) {
        GetPatientModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetPatientState(model: model));
        }
      }  else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getPatientCall({String? doctorId,String? search}) {
    getPatientUsecase!
        .call(GetPatientParams(doctorId: doctorId ?? "",search: search ?? ""))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetPatientSuccessEvent(model: onSuccess));
      });
    });
  }


}