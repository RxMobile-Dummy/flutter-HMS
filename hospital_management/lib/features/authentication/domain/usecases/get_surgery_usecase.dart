import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/get_surgery_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class GetSurgeryUsecase extends UseCase<GetSurgeryModel,GetSurgeryParams> {
  final AuthenticationRepositories? authenticationRepositories;

  GetSurgeryUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, GetSurgeryModel>> call(GetSurgeryParams params) {
    return authenticationRepositories!.getSurgeryCall(params);
  }

}

class GetSurgeryParams extends Equatable {

  GetSurgeryParams();

  @override
  List<Object> get props => [id];

}