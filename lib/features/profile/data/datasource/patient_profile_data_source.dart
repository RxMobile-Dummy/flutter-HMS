import 'package:hospital_management/features/profile/data/model/get_patient_profile_model.dart';
import 'package:hospital_management/features/profile/data/model/update_patient_profile_model.dart';

import '../../domain/usecases/get_patient_profile_usecase.dart';
import '../../domain/usecases/update_patient_profile_usecase.dart';

abstract class PatientProfileDataSource {
  Future<GetPatientProfileModel> getPatientProfileCall(GetPatientProfileParams params);
  Future<UpdatePatientProfileModel> updatePatientProfileCall(UpdatePatientParams params);
}