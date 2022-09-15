class GetMedicineModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetMedicineModel({this.success, this.data, this.message});

  GetMedicineModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? productionDate;
  int? id;
  String? country;
  String? quantity;
  String? expireDate;
  String? company;
  String? supplierId;
  String? type;
  String? description;
  String? cost;
  String? name;

  Data(
      {this.productionDate,
        this.id,
        this.country,
        this.quantity,
        this.expireDate,
        this.company,
        this.supplierId,
        this.type,
        this.description,
        this.cost,
        this.name});

  Data.fromJson(Map<String, dynamic> json) {
    productionDate = json['production_date'];
    id = json['id'];
    country = json['country'];
    quantity = json['quantity'];
    expireDate = json['expire_date'];
    company = json['company'];
    supplierId = json['supplier_id'];
    type = json['type'];
    description = json['description'];
    cost = json['cost'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['production_date'] = this.productionDate;
    data['id'] = this.id;
    data['country'] = this.country;
    data['quantity'] = this.quantity;
    data['expire_date'] = this.expireDate;
    data['company'] = this.company;
    data['supplier_id'] = this.supplierId;
    data['type'] = this.type;
    data['description'] = this.description;
    data['cost'] = this.cost;
    data['name'] = this.name;
    return data;
  }
}