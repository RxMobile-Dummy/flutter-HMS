import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/get_food_prefrence_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class GetFoodPreferenceUsecase extends UseCase<GetFoodPreferenceModel,GetFoodPreferenceParams> {
  final AuthenticationRepositories? authenticationRepositories;

  GetFoodPreferenceUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, GetFoodPreferenceModel>> call(GetFoodPreferenceParams params) {
    return authenticationRepositories!.getFoodPreferenceCall(params);
  }

}

class GetFoodPreferenceParams extends Equatable {

  GetFoodPreferenceParams();

  @override
  List<Object> get props => [id];

}