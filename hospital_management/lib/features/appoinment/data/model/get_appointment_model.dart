class GetAppointmentModel {
  bool? success;
  List<Data>? data;
  String? message;
  String? error;

  GetAppointmentModel({this.success, this.data, this.message, this.error});

  GetAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  String? staffId;
  String? patientId;
  String? lastName;
  String? patientProfilePic;
  String? statusId;
  String? bookingTime;
  String? appointmentDate;
  String? hospitalId;
  int? id;
  String? firstName;
  String? mobileNumber;
  String? disease;
  String? timeSlot;
  String? fileData;
  DoctorData? doctorData;
  PatientReportData? patientReportData;

  Data(
      {this.staffId,
        this.patientId,
        this.lastName,
        this.patientProfilePic,
        this.statusId,
        this.bookingTime,
        this.appointmentDate,
        this.hospitalId,
        this.id,
        this.firstName,
        this.mobileNumber,
        this.disease,
        this.timeSlot,
        this.fileData,
        this.doctorData,
        this.patientReportData});

  Data.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    patientId = json['patient_id'];
    lastName = json['last_name'];
    patientProfilePic = json['patient_profile_pic'];
    statusId = json['status_id'];
    bookingTime = json['booking_time'];
    appointmentDate = json['appointment_date'];
    hospitalId = json['hospital_id'];
    id = json['id'];
    firstName = json['first_name'];
    mobileNumber = json['mobile_number'];
    disease = json['disease'];
    timeSlot = json['time_slot'];
    fileData = json['file_data'];
    doctorData = json['doctor_data'] != null
        ? new DoctorData.fromJson(json['doctor_data'])
        : null;
    patientReportData = json['patient_report_data'] != null
        ? new PatientReportData.fromJson(json['patient_report_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['patient_id'] = this.patientId;
    data['last_name'] = this.lastName;
    data['patient_profile_pic'] = this.patientProfilePic;
    data['status_id'] = this.statusId;
    data['booking_time'] = this.bookingTime;
    data['appointment_date'] = this.appointmentDate;
    data['hospital_id'] = this.hospitalId;
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['mobile_number'] = this.mobileNumber;
    data['disease'] = this.disease;
    data['time_slot'] = this.timeSlot;
    data['file_data'] = this.fileData;
    if (this.doctorData != null) {
      data['doctor_data'] = this.doctorData!.toJson();
    }
    if (this.patientReportData != null) {
      data['patient_report_data'] = this.patientReportData!.toJson();
    }
    return data;
  }
}

class DoctorData {
  int? id;
  String? yearsOfExperience;
  String? specialistField;
  String? about;
  String? createAt;
  String? education;
  String? nextAvailableAt;
  String? inClinicAppointmentFees;
  String? password;
  String? profilePic;
  String? gender;
  String? bloodGroup;
  String? contactNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;

  DoctorData(
      {this.id,
        this.yearsOfExperience,
        this.specialistField,
        this.about,
        this.createAt,
        this.education,
        this.nextAvailableAt,
        this.inClinicAppointmentFees,
        this.password,
        this.profilePic,
        this.gender,
        this.bloodGroup,
        this.contactNumber,
        this.firstName,
        this.lastName,
        this.email,
        this.dateOfBirth,
        this.hospitalId});

  DoctorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yearsOfExperience = json['years_of_experience'];
    specialistField = json['specialist_field'];
    about = json['about'];
    createAt = json['create_at'];
    education = json['education'];
    nextAvailableAt = json['next_available_at'];
    inClinicAppointmentFees = json['in_clinic_appointment_fees'];
    password = json['password'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    contactNumber = json['contact_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['years_of_experience'] = this.yearsOfExperience;
    data['specialist_field'] = this.specialistField;
    data['about'] = this.about;
    data['create_at'] = this.createAt;
    data['education'] = this.education;
    data['next_available_at'] = this.nextAvailableAt;
    data['in_clinic_appointment_fees'] = this.inClinicAppointmentFees;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    data['contact_number'] = this.contactNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
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
  String? patientId;
  String? medicineName;

  MedicineDetails({this.patientId, this.medicineName});

  MedicineDetails.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    medicineName = json['medicine_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patient_id'] = this.patientId;
    data['medicine_name'] = this.medicineName;
    return data;
  }
}