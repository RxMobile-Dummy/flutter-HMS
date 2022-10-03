import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hospital_management_staff/core/failure/failure.dart';
import 'package:hospital_management_staff/core/usecase.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/repositories/medicine_repositories.dart';

class GetMedicineUsecase extends UseCase<GetMedicineModel, GetMedicineParams> {
  final MedicineRepositories? medicineRepositories;

  GetMedicineUsecase({this.medicineRepositories});

  @override
  Stream<Either<Failure, GetMedicineModel>> call(GetMedicineParams params) {
    return medicineRepositories!.getMedicineCall(params);
  }

}

class GetMedicineParams extends Equatable {
  String id;
  String name;

  GetMedicineParams({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}