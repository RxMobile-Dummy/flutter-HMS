import 'package:hospital_management/features/doctor/data/model/filter_doctor_model.dart';
import 'package:hospital_management/features/doctor/data/model/get_doctor_model.dart';

import '../../domain/usecases/filter_doctor_usecase.dart';
import '../../domain/usecases/get_doctor_usecase.dart';

abstract class DoctorDataSource {
  Future<GetDoctorModel> getDoctorCall(GetDoctorParams params);
  Future<FilterDoctorModel> filterDoctorCall(FilterDoctorParams params);
}