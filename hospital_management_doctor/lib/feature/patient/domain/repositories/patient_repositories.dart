import 'package:dartz/dartz.dart';
import 'package:hospital_management_doctor/core/failure/failure.dart';
import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/usecases/get_patient_usecase.dart';

abstract class PatientRepositories {
  Stream<Either<Failure, GetPatientModel>> getPatientCall(GetPatientParams params);
}