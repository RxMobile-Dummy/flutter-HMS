import 'package:hospital_management_doctor/feature/patient/data/model/get_patient_model.dart';
import 'package:hospital_management_doctor/feature/patient/domain/usecases/get_patient_usecase.dart';

abstract class PatientDataSource {
  Future<GetPatientModel> getPatientCall(GetPatientParams params);
}