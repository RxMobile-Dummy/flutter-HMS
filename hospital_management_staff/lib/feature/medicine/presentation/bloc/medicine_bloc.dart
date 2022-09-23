import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospital_management_staff/core/base/base_bloc.dart';
import 'package:hospital_management_staff/core/failure/error_object.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/add_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/delete_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/get_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/data/model/update_medicine_model.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/add_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/delete_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/get_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/domain/usecases/update_medicine_usecase.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_event.dart';
import 'package:hospital_management_staff/feature/medicine/presentation/bloc/medicine_state.dart';
import 'package:hospital_management_staff/feature/profile/domain/usecases/update_profile_usecase.dart';

class MedicineBloc extends Bloc<BaseEvent, BaseState> {
  AddMedicineUsecase? addMedicineUsecase;
  GetMedicineUsecase? getMedicineUsecase;
  UpdateMedicineUsecase? updateMedicineUsecase;
  DeleteMedicineUsecase? deleteMedicineUsecase;

  MedicineBloc(
      {required this.addMedicineUsecase,
      required this.getMedicineUsecase,
      required this.updateMedicineUsecase,
      required this.deleteMedicineUsecase})
      : super(StateLoading()) {
    on<BaseEvent>((event, emit) {
      if (event is EventRequest) {
      } else if (event is AddMedicineEvent) {
        addMedicineCall(
            stockOfItem: event.stockOfItem,
        soldItem: event.soldItem,
        quantity: event.quantity,
        price: event.price,
        prescriptionRequired: event.prescriptionRequired,
        photo: event.photo,
        name: event.name,
        mg: event.mg,
        itemSubCategory: event.itemSubCategory,
        itemCategory: event.itemCategory,
        description: event.description,
          manufactureDate: event.manufactureDate,
          expiryDate: event.expiryDate
        );
      } else if (event is UpdateMedicineEvent) {
        updateMedicineCall(
          medicineId: event.medicineId,
            stockOfItem: event.stockOfItem,
            soldItem: event.soldItem,
            quantity: event.quantity,
            price: event.price,
            prescriptionRequired: event.prescriptionRequired,
            photo: event.photo,
            name: event.name,
            mg: event.mg,
            itemSubCategory: event.itemSubCategory,
            itemCategory: event.itemCategory,
            description: event.description,
            manufactureDate: event.manufactureDate,
            expiryDate: event.expiryDate
        );
      }else if (event is GetMedicineEvent) {
        getMedicineCall(
           id: event.id,
          name: event.name,
        );
      }else if (event is DeleteMedicineEvent) {
        deleteMedicineCall(
            id: event.id
        );
      }else if (event is AddMedicineSuccessEvent) {
        AddMedicineModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(AddMedicineState(model: model));
        }
      } else if (event is UpdateMedicineSuccessEvent) {
        UpdateMedicineModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(UpdateMedicineState(model: model));
        }
      }else if (event is GetMedicineSuccessEvent) {
        GetMedicineModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(GetMedicineState(model: model));
        }
      }else if (event is DeleteMedicineSuccessEvent) {
        DeleteMedicineModel? model = event.model;
        if (model?.success != true) {
          emit(StateErrorGeneral(model?.error ?? ""));
        } else {
          emit(DeleteMedicineState(model: model));
        }
      }else if (event is EventErrorGeneral) {
        emit(StateErrorGeneral(event.message));
      }
    });
  }


  addMedicineCall({
    required String name,
    required String photo,
    required String price,
    required String quantity,
    required String prescriptionRequired,
    required String stockOfItem,
    required String description,
    required String itemCategory,
    required String itemSubCategory,
    required String mg,
    required String soldItem,
    required String manufactureDate,
    required String expiryDate,
  }) {
    addMedicineUsecase!
        .call(AddMedicineParams(
      description: description,
      itemCategory: itemCategory,
      itemSubCategory: itemSubCategory,
      mg: mg,
      name: name,
      photo: photo,
      prescriptionRequired: prescriptionRequired,
      price: price,
      quantity: quantity,
      soldItem: soldItem,
      stockOfItem: stockOfItem,
      expiryDate: expiryDate,
      manufactureDate: manufactureDate
        ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(AddMedicineSuccessEvent(model: onSuccess));
      });
    });
  }

  updateMedicineCall({
    required String name,
    required String photo,
    required String price,
    required String quantity,
    required String prescriptionRequired,
    required String stockOfItem,
    required String description,
    required String itemCategory,
    required String itemSubCategory,
    required String mg,
    required String soldItem,
    required String manufactureDate,
    required String expiryDate,
    required String medicineId,
  }) {
    updateMedicineUsecase!
        .call(UpdateMedicineParams(
      medicineId: medicineId,
        description: description,
        itemCategory: itemCategory,
        itemSubCategory: itemSubCategory,
        mg: mg,
        name: name,
        photo: photo,
        prescriptionRequired: prescriptionRequired,
        price: price,
        quantity: quantity,
        soldItem: soldItem,
        stockOfItem: stockOfItem,
        expiryDate: expiryDate,
        manufactureDate: manufactureDate
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(UpdateMedicineSuccessEvent(model: onSuccess));
      });
    });
  }

  getMedicineCall({
    required String id,
    required String name,
  }) {
    getMedicineUsecase!
        .call(GetMedicineParams(
       id: id,
      name: name,
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(GetMedicineSuccessEvent(model: onSuccess));
      });
    });
  }

  deleteMedicineCall({
    required String id,
  }) {
    deleteMedicineUsecase!
        .call(DeleteMedicineParams(
        id: id
    ))
        .listen((data) {
      data.fold((onError) {
        add(EventErrorGeneral(ErrorObject.mapFailureToMessage(onError) ?? ""));
      }, (onSuccess) {
        add(DeleteMedicineSuccessEvent(model: onSuccess));
      });
    });
  }


}