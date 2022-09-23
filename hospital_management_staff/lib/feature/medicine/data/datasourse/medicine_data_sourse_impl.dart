import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hospital_management_staff/core/api_call/base_client.dart';
import 'package:hospital_management_staff/core/common_keys/common_keys.dart';
import 'package:hospital_management_staff/core/strings/strings.dart';
import 'package:hospital_management_staff/feature/medicine/data/datasourse/medicine_data_sourse.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:path/path.dart' as pathManager;

class MedicineDataSourceImpl implements MedicineDataSource {
  final ApiClient _apiClient;

  MedicineDataSourceImpl(this._apiClient);

  @override
  Future<AddMedicineModel> addMedicineCall(AddMedicineParams params) async {
    MultipartFile? multipartFile;
    if(params.photo.isNotEmpty) {
      if(!params.photo[0].contains("medicine/app/medicine_photos")) {
        multipartFile =
        await MultipartFile.fromFile(
          params.photo,
          filename: pathManager.basename(params.photo),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map['name'] = params.name;
    map['cost'] = params.price;
    map['quantity'] = params.quantity;
    map['prescription_required_or_not'] = params.prescriptionRequired;
    map['stock_of_item'] = params.stockOfItem;
    map['description'] = params.description;
    map['item_category'] = params.itemCategory;
    map['item_sub_category'] = params.itemSubCategory;
    map['unit_of_quantity'] = params.mg;
    map['item_sold'] = params.soldItem;
    map['mrp_date'] = params.manufactureDate;
    map['expiry_date'] = params.expiryDate;
    map['medicine_photo'] =   params.photo.isNotEmpty ? multipartFile : params.photo;
    FormData formData =  FormData.fromMap(map);
    print(formData);
    final response = await _apiClient.addMedicine(formData);
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }

  @override
  Future<GetMedicineModel> getMedicineCall(GetMedicineParams params)async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id;
    map[CommonKeys.K_Name] = params.name;
    final response = await _apiClient.getMedicine(map);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }

  @override
  Future<UpdateMedicineModel> updateMedicineCall(UpdateMedicineParams params) async {
    MultipartFile? multipartFile;
    if(params.photo.isNotEmpty) {
      if(!params.photo[0].contains("medicine/app/medicine_photos")) {
        multipartFile =
            await MultipartFile.fromFile(
          params.photo,
          filename: pathManager.basename(params.photo),
        );
      }
    }
    var map =  HashMap<String, dynamic>();
    map['name'] = params.name;
    map['medicine_id'] = params.medicineId;
    map['cost'] = params.price;
    map['quantity'] = params.quantity;
    map['prescription_required_or_not'] = params.prescriptionRequired;
    map['stock_of_item'] = params.stockOfItem;
    map['description'] = params.description;
    map['item_category'] = params.itemCategory;
    map['item_sub_category'] = params.itemSubCategory;
    map['unit_of_quantity'] = params.mg;
    map['item_sold'] = params.soldItem;
    map['mrp_date'] = params.manufactureDate;
    map['expiry_date'] = params.expiryDate;
    map['medicine_photo'] =   params.photo.isNotEmpty ? multipartFile : params.photo;
    FormData formData =  FormData.fromMap(map);
    print(formData);
    final response = await _apiClient.updateMedicine(formData);
    print(response.error);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print('failed');
    }
    return data;
  }

  @override
  Future<DeleteMedicineModel> deleteMedicineCall(DeleteMedicineParams params) async {
    var map =  HashMap<String, dynamic>();
    map[CommonKeys.K_Id] = params.id;
    final response = await _apiClient.deleteMedicine(map);
    var data;
    if (response != null) {
      data = response;
      return data;
    } else {
      print(Strings.kFailed);
    }
    return data;
  }




}