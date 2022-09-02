import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';
import '../../data/model/get_surgery_model.dart';
import '../../domain/usecases/get_surgery_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class SurgeryBloc extends Bloc<BaseEvent, BaseState> {
  GetSurgeryUsecase? getSurgeryUsecase;


  SurgeryBloc(
      {required this.getSurgeryUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      }else if (event is GetSurgeryEvent) {
        getSurgeryCall();
      } else if (event is GetSurgerySuccessEvent) {
        GetSurgeryModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetSurgeryState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }



  getSurgeryCall() {
    getSurgeryUsecase!
        .call(GetSurgeryParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetSurgerySuccessEvent(model: onSuccess));
      });
    });
  }


}