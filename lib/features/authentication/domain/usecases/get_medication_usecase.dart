import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/authentication/data/model/get_medication_model.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';
import '../repositories/authentication_repositories.dart';

class GetMedicationUsecase extends UseCase<GetMedicationModel,GetMedicationParams> {
  final AuthenticationRepositories? authenticationRepositories;

  GetMedicationUsecase({this.authenticationRepositories});

  @override
  Stream<Either<Failure, GetMedicationModel>> call(GetMedicationParams params) {
    return authenticationRepositories!.getMedicationCall(params);
  }

}

class GetMedicationParams extends Equatable {

  GetMedicationParams();

  @override
  List<Object> get props => [id];

}