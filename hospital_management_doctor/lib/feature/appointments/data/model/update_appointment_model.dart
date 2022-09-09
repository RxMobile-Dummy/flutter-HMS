class UpdateAppointmentModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  UpdateAppointmentModel({this.success, this.data, this.message, this.error});

  UpdateAppointmentModel.fromJson(Map<String, dynamic> json) {
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
  PatientReportData? patientReportData;
  DoctorData? doctorData;

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
        this.patientReportData,
        this.doctorData});

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
    patientReportData = json['patient_report_data'] != null
        ? new PatientReportData.fromJson(json['patient_report_data'])
        : null;
    doctorData = json['doctor_data'] != null
        ? new DoctorData.fromJson(json['doctor_data'])
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
    if (this.patientReportData != null) {
      data['patient_report_data'] = this.patientReportData!.toJson();
    }
    if (this.doctorData != null) {
      data['doctor_data'] = this.doctorData!.toJson();
    }
    return data;
  }
}

class PatientReportData {
  String? hospitalId;
  String? patientId;
  String? reportDescription;
  String? doctorId;
  int? id;
  String? appointmentId;
  List<MedicineDetails>? medicineDetails;

  PatientReportData(
      {this.hospitalId,
        this.patientId,
        this.reportDescription,
        this.doctorId,
        this.id,
        this.appointmentId,
        this.medicineDetails});

  PatientReportData.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    patientId = json['patient_id'];
    reportDescription = json['report_description'];
    doctorId = json['doctor_id'];
    id = json['id'];
    appointmentId = json['appointment_id'];
    if (json['medicine_details'] != null) {
      medicineDetails = <MedicineDetails>[];
      json['medicine_details'].forEach((v) {
        medicineDetails!.add(new MedicineDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['patient_id'] = this.patientId;
    data['report_description'] = this.reportDescription;
    data['doctor_id'] = this.doctorId;
    data['id'] = this.id;
    data['appointment_id'] = this.appointmentId;
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

class DoctorData {
  String? education;
  int? id;
  String? nextAvailableAt;
  String? inClinicAppointmentFees;
  String? yearsOfExperience;
  String? specialistField;
  String? about;
  String? createAt;
  String? lastName;
  String? contactNumber;
  String? firstName;
  String? email;
  String? dateOfBirth;
  String? hospitalId;
  String? password;
  String? profilePic;
  String? gender;
  String? bloodGroup;

  DoctorData(
      {this.education,
        this.id,
        this.nextAvailableAt,
        this.inClinicAppointmentFees,
        this.yearsOfExperience,
        this.specialistField,
        this.about,
        this.createAt,
        this.lastName,
        this.contactNumber,
        this.firstName,
        this.email,
        this.dateOfBirth,
        this.hospitalId,
        this.password,
        this.profilePic,
        this.gender,
        this.bloodGroup});

  DoctorData.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    id = json['id'];
    nextAvailableAt = json['next_available_at'];
    inClinicAppointmentFees = json['in_clinic_appointment_fees'];
    yearsOfExperience = json['years_of_experience'];
    specialistField = json['specialist_field'];
    about = json['about'];
    createAt = json['create_at'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    firstName = json['first_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    hospitalId = json['hospital_id'];
    password = json['password'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education'] = this.education;
    data['id'] = this.id;
    data['next_available_at'] = this.nextAvailableAt;
    data['in_clinic_appointment_fees'] = this.inClinicAppointmentFees;
    data['years_of_experience'] = this.yearsOfExperience;
    data['specialist_field'] = this.specialistField;
    data['about'] = this.about;
    data['create_at'] = this.createAt;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['hospital_id'] = this.hospitalId;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}