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
  String? hospitalId;
  String? firstName;
  String? mobileNumber;
  String? disease;
  String? bookingTime;
  String? appointmentDate;
  String? patientId;
  int? id;
  String? staffId;
  String? lastName;
  String? patientProfilePic;
  String? statusId;
  String? timeSlot;
  String? fileData;
  DoctorData? doctorData;

  Data(
      {this.hospitalId,
        this.firstName,
        this.mobileNumber,
        this.disease,
        this.bookingTime,
        this.appointmentDate,
        this.patientId,
        this.id,
        this.staffId,
        this.lastName,
        this.patientProfilePic,
        this.statusId,
        this.timeSlot,
        this.fileData,
        this.doctorData});

  Data.fromJson(Map<String, dynamic> json) {
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    mobileNumber = json['mobile_number'];
    disease = json['disease'];
    bookingTime = json['booking_time'];
    appointmentDate = json['appointment_date'];
    patientId = json['patient_id'];
    id = json['id'];
    staffId = json['staff_id'];
    lastName = json['last_name'];
    patientProfilePic = json['patient_profile_pic'];
    statusId = json['status_id'];
    timeSlot = json['time_slot'];
    fileData = json['file_data'];
    doctorData = json['doctor_data'] != null
        ? new DoctorData.fromJson(json['doctor_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['mobile_number'] = this.mobileNumber;
    data['disease'] = this.disease;
    data['booking_time'] = this.bookingTime;
    data['appointment_date'] = this.appointmentDate;
    data['patient_id'] = this.patientId;
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['last_name'] = this.lastName;
    data['patient_profile_pic'] = this.patientProfilePic;
    data['status_id'] = this.statusId;
    data['time_slot'] = this.timeSlot;
    data['file_data'] = this.fileData;
    if (this.doctorData != null) {
      data['doctor_data'] = this.doctorData!.toJson();
    }
    return data;
  }
}

class DoctorData {
  int? id;
  String? nextAvailableAt;
  String? education;
  String? inClinicAppointmentFees;
  String? rating;
  String? specialistField;
  String? yearsOfExperience;
  String? about;
  String? createAt;
  String? lastName;
  String? profilePic;
  String? gender;
  String? bloodGroup;
  String? contactNumber;
  String? firstName;
  String? email;
  String? dateOfBirth;

  DoctorData(
      {this.id,
        this.nextAvailableAt,
        this.education,
        this.inClinicAppointmentFees,
        this.rating,
        this.specialistField,
        this.yearsOfExperience,
        this.about,
        this.createAt,
        this.lastName,
        this.profilePic,
        this.gender,
        this.bloodGroup,
        this.contactNumber,
        this.firstName,
        this.email,
        this.dateOfBirth});

  DoctorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nextAvailableAt = json['next_available_at'];
    education = json['education'];
    inClinicAppointmentFees = json['in_clinic_appointment_fees'];
    rating = json['rating'];
    specialistField = json['specialist_field'];
    yearsOfExperience = json['years_of_experience'];
    about = json['about'];
    createAt = json['create_at'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    contactNumber = json['contact_number'];
    firstName = json['first_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['next_available_at'] = this.nextAvailableAt;
    data['education'] = this.education;
    data['in_clinic_appointment_fees'] = this.inClinicAppointmentFees;
    data['rating'] = this.rating;
    data['specialist_field'] = this.specialistField;
    data['years_of_experience'] = this.yearsOfExperience;
    data['about'] = this.about;
    data['create_at'] = this.createAt;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    data['contact_number'] = this.contactNumber;
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    return data;
  }
}