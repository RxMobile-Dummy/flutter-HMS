import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/failure/error_object.dart';
import '../../data/model/get_food_prefrence_model.dart';
import '../../domain/usecases/get_food_preference_usecase.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class FoodPreferenceBloc extends Bloc<BaseEvent, BaseState> {
  GetFoodPreferenceUsecase? getFoodPreferenceUsecase;


  FoodPreferenceBloc(
      {required this.getFoodPreferenceUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is GetFoodPreferenceEvent) {
        getFoodPreferenceCall();
      }else if (event is GetFoodPreferenceSuccessEvent) {
        GetFoodPreferenceModel? model = event.model;
        if(model?.success != true){
          emit(StateErrorGeneral(model?.error ?? ""));
        }else {
          emit(GetFoodPreferenceState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  getFoodPreferenceCall() {
    getFoodPreferenceUsecase!
        .call(GetFoodPreferenceParams())
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetFoodPreferenceSuccessEvent(model: onSuccess));
      });
    });
  }


}