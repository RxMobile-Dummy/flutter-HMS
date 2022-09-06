import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:hospital_management/features/authentication/presentation/bloc/authentication_state.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';
import '../../data/model/get_alleries_model.dart';
import '../../domain/usecases/get_allergies_usecase.dart';

class AllergiesBloc extends Bloc<BaseEvent, BaseState> {
  GetAllergiesUsecase? getAllergiesUsecase;


  AllergiesBloc(
      {required this.getAllergiesUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetAllergiesEvent) {
        getAllergiesCall();
      } else if (event is GetAllergiesSuccessEvent) {
        GetAllergiesModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetAllergiesState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getAllergiesCall() {
    getAllergiesUsecase!
        .call(GetAllergiesParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetAllergiesSuccessEvent(model: onSuccess));
      });
    });
  }

}