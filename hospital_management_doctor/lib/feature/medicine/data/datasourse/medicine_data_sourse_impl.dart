import 'dart:collection';

import 'package:hospital_management_doctor/core/api_call/baseClient.dart';
import 'package:hospital_management_doctor/feature/medicine/data/datasourse/medicine_data_sourse.dart';
import 'package:hospital_management_doctor/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_doctor/feature/medicine/domain/usecases/get_medicine_usecase.dart';

class MedicineDataSourceImpl implements MedicineDataSource {
  final ApiClient _apiClient;

  MedicineDataSourceImpl(this._apiClient);

  @override
  Future<GetMedicineModel> getMedicineCall(GetMedicineParams params) async {
    var map =  HashMap<String, dynamic>();
    map["id"] = params.id;
    final response = await _apiClient.getMedicine(map);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }


}