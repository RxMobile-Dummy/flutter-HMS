import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';
import '../../data/model/get_injuries_model.dart';
import '../../domain/usecases/get_injuries_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class InjuryBloc extends Bloc<BaseEvent, BaseState> {
  GetInjuriesUsecase? getInjuriesUsecase;


  InjuryBloc(
      {required this.getInjuriesUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetInjuriesEvent) {
        getInjuriesCall();
      }else if (event is GetInjuriesSuccessEvent) {
        GetInjuriesModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetInjuriesState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getInjuriesCall() {
    getInjuriesUsecase!
        .call(GetInjuriesParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetInjuriesSuccessEvent(model: onSuccess));
      });
    });
  }

}