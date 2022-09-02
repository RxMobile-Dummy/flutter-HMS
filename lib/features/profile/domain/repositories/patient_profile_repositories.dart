import 'package:dartz/dartz.dart';
import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';

import '../../../../core/failure/failure.dart';
import '../usecases/get_patient_profile_usecase.dart';
import '../usecases/update_patient_profile_usecase.dart';

abstract class PatientProfileRepositories {
  Stream<Either<Failure, GetPatientProfileModel>> getPatientProfileCall(GetPatientProfileParams params);
  Stream<Either<Failure, UpdatePatientProfileModel>> updatePatientProfileCall(UpdatePatientParams params);
}