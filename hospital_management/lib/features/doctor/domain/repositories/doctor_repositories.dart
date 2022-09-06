import 'package:dartz/dartz.dart';
import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';

import '../../../../core/failure/failure.dart';
import '../usecases/filter_doctor_usecase.dart';
import '../usecases/get_doctor_usecase.dart';

abstract class DoctorRepositories {
  Stream<Either<Failure, GetDoctorModel>> getDoctorCall(GetDoctorParams params);
  Stream<Either<Failure, FilterDoctorModel>> filterDoctorCall(FilterDoctorParams params);
}