import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';
import '../../data/model/get_medication_model.dart';
import '../../domain/usecases/get_medication_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class MedicationBloc extends Bloc<BaseEvent, BaseState> {
  GetMedicationUsecase? getMedicationUsecase;


  MedicationBloc(
      {required this.getMedicationUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetMedicationEvent) {
        getMedicationCall();
      } else if (event is GetMedicationSuccessEvent) {
        GetMedicationModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetMedicationState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }




  getMedicationCall() {
    getMedicationUsecase!
        .call(GetMedicationParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetMedicationSuccessEvent(model: onSuccess));
      });
    });
  }

}