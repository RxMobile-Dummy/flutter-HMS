import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';
import 'package:hospital_management/features/doctor/domain/usecases/filter_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/domain/usecases/get_doctor_usecase.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_event.dart';
import 'package:hospital_management/features/doctor/presentation/bloc/doctor_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';

class DoctorBloc extends Bloc<BaseEvent, BaseState> {
  GetDoctorUsecase? getDoctorUsecase;
  FilterDoctorUsecase? filterDoctorUsecase;


  DoctorBloc(
      {required this.getDoctorUsecase,required this.filterDoctorUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetDoctorEvent) {
        getDoctorCall(
          specialistField: event.specialistField
        );
      } else if (event is FilterDoctorEvent) {
        filterDoctorCall(
          specialistField: event.specialistField
        );
      }else if (event is GetDoctorSuccessEvent) {
        GetDoctorModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetDoctorState(model: model));
        }
      }else if (event is FilterDoctorSuccessEvent) {
        FilterDoctorModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(FilterDoctorState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getDoctorCall({required String specialistField}) {
    getDoctorUsecase!
        .call(GetDoctorParams(specialistField: specialistField))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetDoctorSuccessEvent(model: onSuccess));
      });
    });
  }

  filterDoctorCall({required String specialistField}) {
    filterDoctorUsecase!
        .call(FilterDoctorParams(specialistField: specialistField))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(FilterDoctorSuccessEvent(model: onSuccess));
      });
    });
  }


}