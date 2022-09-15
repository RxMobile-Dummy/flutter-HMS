import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/usecases/get_medicine_usecase.dart';

abstract class MedicineDataSource {
  Future<GetMedicineModel> getMedicineCall(GetMedicineParams params);
}