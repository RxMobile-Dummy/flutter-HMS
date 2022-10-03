import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/feature/appointments/data/model/get_report_model.dart';
import 'package:hospital_management_doctor/feature/appointments/domain/usecases/get_report_usecase.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_event.dart';
import 'package:hospital_management_doctor/feature/appointments/presentation/bloc/appointment_state.dart';

class ReportListBloc extends Bloc<BaseEvent, BaseState> {
  GetReportListUsecase? getReportListUsecase;

  ReportListBloc(
      {required this.getReportListUsecase,})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetReportListEvent) {
        getReportListCall();
      }else if (event is GetReportListSuccessEvent) {
        GetReportListModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetReportListState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getReportListCall() {
    getReportListUsecase!
        .call(GetReportListParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetReportListSuccessEvent(model: onSuccess));
      });
    });
  }

}