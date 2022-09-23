class AddMedicineModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  AddMedicineModel({this.success, this.data, this.message, this.error});

  AddMedicineModel.fromJson(Map<String, dynamic> json) {
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
  String? medicinePhoto;
  String? quantity;
  String? prescriptionRequiredOrNot;
  String? stockOfItem;
  String? itemCategory;
  String? itemSubCategory;
  String? itemSold;
  String? unitOfQuantity;
  String? expiryDate;
  String? mrpDate;
  String? name;
  String? cost;
  String? description;

  Data(
      {this.id,
        this.medicinePhoto,
        this.quantity,
        this.prescriptionRequiredOrNot,
        this.stockOfItem,
        this.itemCategory,
        this.itemSubCategory,
        this.itemSold,
        this.unitOfQuantity,
        this.expiryDate,
        this.mrpDate,
        this.name,
        this.cost,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicinePhoto = json['medicine_photo'];
    quantity = json['quantity'];
    prescriptionRequiredOrNot = json['prescription_required_or_not'];
    stockOfItem = json['stock_of_item'];
    itemCategory = json['item_category'];
    itemSubCategory = json['item_sub_category'];
    itemSold = json['item_sold'];
    unitOfQuantity = json['unit_of_quantity'];
    expiryDate = json['expiry_date'];
    mrpDate = json['mrp_date'];
    name = json['name'];
    cost = json['cost'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medicine_photo'] = this.medicinePhoto;
    data['quantity'] = this.quantity;
    data['prescription_required_or_not'] = this.prescriptionRequiredOrNot;
    data['stock_of_item'] = this.stockOfItem;
    data['item_category'] = this.itemCategory;
    data['item_sub_category'] = this.itemSubCategory;
    data['item_sold'] = this.itemSold;
    data['unit_of_quantity'] = this.unitOfQuantity;
    data['expiry_date'] = this.expiryDate;
    data['mrp_date'] = this.mrpDate;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['description'] = this.description;
    return data;
  }
}