class UpdateMedicineModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  UpdateMedicineModel({this.success, this.data, this.message, this.error});

  UpdateMedicineModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  int? id;
  String? quantity;
  String? stockOfItem;
  String? itemSubCategory;
  String? unitOfQuantity;
  String? mrpDate;
  String? prescriptionRequiredOrNot;
  String? medicinePhoto;
  String? itemCategory;
  String? itemSold;
  String? expiryDate;
  String? name;
  String? cost;
  String? description;

  Data(
      {this.id,
        this.quantity,
        this.stockOfItem,
        this.itemSubCategory,
        this.unitOfQuantity,
        this.mrpDate,
        this.prescriptionRequiredOrNot,
        this.medicinePhoto,
        this.itemCategory,
        this.itemSold,
        this.expiryDate,
        this.name,
        this.cost,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    stockOfItem = json['stock_of_item'];
    itemSubCategory = json['item_sub_category'];
    unitOfQuantity = json['unit_of_quantity'];
    mrpDate = json['mrp_date'];
    prescriptionRequiredOrNot = json['prescription_required_or_not'];
    medicinePhoto = json['medicine_photo'];
    itemCategory = json['item_category'];
    itemSold = json['item_sold'];
    expiryDate = json['expiry_date'];
    name = json['name'];
    cost = json['cost'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['stock_of_item'] = this.stockOfItem;
    data['item_sub_category'] = this.itemSubCategory;
    data['unit_of_quantity'] = this.unitOfQuantity;
    data['mrp_date'] = this.mrpDate;
    data['prescription_required_or_not'] = this.prescriptionRequiredOrNot;
    data['medicine_photo'] = this.medicinePhoto;
    data['item_category'] = this.itemCategory;
    data['item_sold'] = this.itemSold;
    data['expiry_date'] = this.expiryDate;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['description'] = this.description;
    return data;
  }
}