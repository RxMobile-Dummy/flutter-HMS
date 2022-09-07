import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/get_injuries_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class GetInjuriesUsecase extends UseCase<GetInjuriesModel,GetInjuriesParams> {
  final AuthenticationRepositories? authenticationRepositories;

  GetInjuriesUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, GetInjuriesModel>> call(GetInjuriesParams params) {
    return authenticationRepositories!.getInjuriesCall(params);
  }

}

class GetInjuriesParams extends Equatable {

  GetInjuriesParams();

  @override
  List<Object> get props => [id];

}