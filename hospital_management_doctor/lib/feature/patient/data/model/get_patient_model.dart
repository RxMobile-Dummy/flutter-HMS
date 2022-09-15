class GetPatientModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetPatientModel({this.success, this.data, this.message, this.error});

  GetPatientModel.fromJson(Map<String, dynamic> json) {
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
  String? contactNumber;
  String? lastName;
  String? profilePic;
  String? gender;
  String? hospitalId;
  String? password;
  String? firstName;
  int? id;
  String? email;
  String? dateOfBirth;
  String? bloodGroup;
  PatientReportData? patientReportData;

  Data(
      {this.contactNumber,
        this.lastName,
        this.profilePic,
        this.gender,
        this.hospitalId,
        this.password,
        this.firstName,
        this.id,
        this.email,
        this.dateOfBirth,
        this.bloodGroup,
        this.patientReportData});

  Data.fromJson(Map<String, dynamic> json) {
    contactNumber = json['contact_number'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    hospitalId = json['hospital_id'];
    password = json['password'];
    firstName = json['first_name'];
    id = json['id'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    patientReportData = json['patient_report_data'] != null
        ? new PatientReportData.fromJson(json['patient_report_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_number'] = this.contactNumber;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['hospital_id'] = this.hospitalId;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['id'] = this.id;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    if (this.patientReportData != null) {
      data['patient_report_data'] = this.patientReportData!.toJson();
    }
    return data;
  }
}

class PatientReportData {
  int? id;
  String? doctorId;
  String? appointmentId;
  String? hospitalId;
  String? patientId;
  String? reportDescription;
  List<MedicineDetails>? medicineDetails;

  PatientReportData(
      {this.id,
        this.doctorId,
        this.appointmentId,
        this.hospitalId,
        this.patientId,
        this.reportDescription,
        this.medicineDetails});

  PatientReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorId = json['doctor_id'];
    appointmentId = json['appointment_id'];
    hospitalId = json['hospital_id'];
    patientId = json['patient_id'];
    reportDescription = json['report_description'];
    if (json['medicine_details'] != null) {
      medicineDetails = <MedicineDetails>[];
      json['medicine_details'].forEach((v) {
        medicineDetails!.add(new MedicineDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_id'] = this.doctorId;
    data['appointment_id'] = this.appointmentId;
    data['hospital_id'] = this.hospitalId;
    data['patient_id'] = this.patientId;
    data['report_description'] = this.reportDescription;
    if (this.medicineDetails != null) {
      data['medicine_details'] =
          this.medicineDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineDetails {
  String? medicineId;
  String? patientId;
  String? medicineName;

  MedicineDetails({this.medicineId, this.patientId, this.medicineName});

  MedicineDetails.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicine_id'];
    patientId = json['patient_id'];
    medicineName = json['medicine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicine_id'] = this.medicineId;
    data['patient_id'] = this.patientId;
    data['medicine_name'] = this.medicineName;
    return data;
  }
}