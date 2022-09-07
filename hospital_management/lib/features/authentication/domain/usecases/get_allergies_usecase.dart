import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/get_alleries_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class GetAllergiesUsecase extends UseCase<GetAllergiesModel,GetAllergiesParams> {
  final AuthenticationRepositories? authenticationRepositories;

  GetAllergiesUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, GetAllergiesModel>> call(GetAllergiesParams params) {
    return authenticationRepositories!.getAllergiesCall(params);
  }

}

class GetAllergiesParams extends Equatable {

  GetAllergiesParams();

  @override
  List<Object> get props => [id];

}