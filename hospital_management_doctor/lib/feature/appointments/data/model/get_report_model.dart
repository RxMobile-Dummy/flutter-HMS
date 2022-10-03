class GetReportListModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetReportListModel({this.success, this.data, this.message, this.error});

  GetReportListModel.fromJson(Map<String, dynamic> json) {
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
  String? reportData;
  int? id;

  Data({this.reportData, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    reportData = json['report_data'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_data'] = this.reportData;
    data['id'] = this.id;
    return data;
  }
}