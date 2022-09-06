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
  String? patientId;
  String? hospitalId;
  int? id;
  String? firstName;
  String? mobileNumber;
  String? disease;
  String? bookingTime;
  String? appointmentDate;
  String? staffId;
  String? lastName;
  String? patientProfilePic;
  String? statusId;
  String? timeSlot;
  String? fileData;
  DoctorData? doctorData;

  Data(
      {this.patientId,
        this.hospitalId,
        this.id,
        this.firstName,
        this.mobileNumber,
        this.disease,
        this.bookingTime,
        this.appointmentDate,
        this.staffId,
        this.lastName,
        this.patientProfilePic,
        this.statusId,
        this.timeSlot,
        this.fileData,
        this.doctorData});

  Data.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    hospitalId = json['hospital_id'];
    id = json['id'];
    firstName = json['first_name'];
    mobileNumber = json['mobile_number'];
    disease = json['disease'];
    bookingTime = json['booking_time'];
    appointmentDate = json['appointment_date'];
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
    data['patient_id'] = this.patientId;
    data['hospital_id'] = this.hospitalId;
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['mobile_number'] = this.mobileNumber;
    data['disease'] = this.disease;
    data['booking_time'] = this.bookingTime;
    data['appointment_date'] = this.appointmentDate;
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
  String? education;
  String? yearsOfExperience;
  String? nextAvailableAt;
  String? inClinicAppointmentFees;
  String? rating;
  int? id;
  String? specialistField;
  String? about;
  String? createAt;
  String? contactNumber;
  String? email;
  String? dateOfBirth;
  String? profilePic;
  String? firstName;
  String? lastName;
  String? gender;
  String? bloodGroup;

  DoctorData(
      {this.education,
        this.yearsOfExperience,
        this.nextAvailableAt,
        this.inClinicAppointmentFees,
        this.rating,
        this.id,
        this.specialistField,
        this.about,
        this.createAt,
        this.contactNumber,
        this.email,
        this.dateOfBirth,
        this.profilePic,
        this.firstName,
        this.lastName,
        this.gender,
        this.bloodGroup});

  DoctorData.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    yearsOfExperience = json['years_of_experience'];
    nextAvailableAt = json['next_available_at'];
    inClinicAppointmentFees = json['in_clinic_appointment_fees'];
    rating = json['rating'];
    id = json['id'];
    specialistField = json['specialist_field'];
    about = json['about'];
    createAt = json['create_at'];
    contactNumber = json['contact_number'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    profilePic = json['profile_pic'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education'] = this.education;
    data['years_of_experience'] = this.yearsOfExperience;
    data['next_available_at'] = this.nextAvailableAt;
    data['in_clinic_appointment_fees'] = this.inClinicAppointmentFees;
    data['rating'] = this.rating;
    data['id'] = this.id;
    data['specialist_field'] = this.specialistField;
    data['about'] = this.about;
    data['create_at'] = this.createAt;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['profile_pic'] = this.profilePic;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}