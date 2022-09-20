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
  String? lastName;
  String? contactNumber;
  String? profilePic;
  String? gender;
  String? hospitalId;
  String? firstName;
  String? password;
  int? id;
  String? email;
  String? dateOfBirth;
  String? bloodGroup;
  PatientReportData? patientReportData;

  Data(
      {this.lastName,
        this.contactNumber,
        this.profilePic,
        this.gender,
        this.hospitalId,
        this.firstName,
        this.password,
        this.id,
        this.email,
        this.dateOfBirth,
        this.bloodGroup,
        this.patientReportData});

  Data.fromJson(Map<String, dynamic> json) {
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    password = json['password'];
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
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['password'] = this.password;
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
  String? reportDescription;
  String? patientId;
  String? doctorId;
  String? appointmentId;
  int? id;
  String? hospitalId;
  List<MedicineDetails>? medicineDetails;

  PatientReportData(
      {this.reportDescription,
        this.patientId,
        this.doctorId,
        this.appointmentId,
        this.id,
        this.hospitalId,
        this.medicineDetails});

  PatientReportData.fromJson(Map<String, dynamic> json) {
    reportDescription = json['report_description'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    appointmentId = json['appointment_id'];
    id = json['id'];
    hospitalId = json['hospital_id'];
    if (json['medicine_details'] != null) {
      medicineDetails = <MedicineDetails>[];
      json['medicine_details'].forEach((v) {
        medicineDetails!.add(new MedicineDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_description'] = this.reportDescription;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['appointment_id'] = this.appointmentId;
    data['id'] = this.id;
    data['hospital_id'] = this.hospitalId;
    if (this.medicineDetails != null) {
      data['medicine_details'] =
          this.medicineDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineDetails {
  String? patientId;
  String? medicineId;
  String? medicineName;

  MedicineDetails({this.patientId, this.medicineId, this.medicineName});

  MedicineDetails.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    medicineId = json['medicine_id'];
    medicineName = json['medicine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['medicine_id'] = this.medicineId;
    data['medicine_name'] = this.medicineName;
    return data;
  }
}