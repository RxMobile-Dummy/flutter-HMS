import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_doctor/core/base/base_bloc.dart';
import 'package:hospital_management_doctor/core/failure/error_object.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_event.dart';
import 'package:hospital_management_doctor/feature/medicine/presentation/bloc/medicine_state.dart';

class MedicineBloc extends Bloc<BaseEvent, BaseState> {
  GetMedicineUsecase? getMedicineUsecase;

  MedicineBloc(
      {required this.getMedicineUsecase,})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetMedicineEvent) {
        getMedicineCall(
            id: event.id,);
      } else if (event is GetMedicineSuccessEvent) {
        GetMedicineModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetMedicineState(model: model));
        }
      }  else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getMedicineCall({
    String? id,
  }) {
    getMedicineUsecase!
        .call(GetMedicineParams(
        id: id ?? '',))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetMedicineSuccessEvent(model: onSuccess));
      });
    });
  }


}