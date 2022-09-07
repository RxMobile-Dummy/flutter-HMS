import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/domain/repositories/patient_profile_repositories.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/usecase.dart';

class GetPatientProfileUsecase extends UseCase<GetPatientProfileModel, GetPatientProfileParams> {
  final PatientProfileRepositories? patientProfileRepositories;

  GetPatientProfileUsecase({this.patientProfileRepositories});

  @override
  Stream<Either<Failure, GetPatientProfileModel>> call(GetPatientProfileParams params) {
    return patientProfileRepositories!.getPatientProfileCall(params);
  }

}

class GetPatientProfileParams extends Equatable {
  int id;

  GetPatientProfileParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;

    return data;
  }
}