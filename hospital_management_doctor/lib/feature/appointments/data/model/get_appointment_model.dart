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
  PatientData? patientData;

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
        this.patientData});

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
    patientData = json['patient_data'] != null
        ? new PatientData.fromJson(json['patient_data'])
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
    if (this.patientData != null) {
      data['patient_data'] = this.patientData!.toJson();
    }
    return data;
  }
}

class PatientData {
  String? maritalStatus;
  String? height;
  String? emergencyContactNumber;
  String? smokingHabits;
  String? alcholConsumption;
  String? occupation;
  String? weight;
  int? id;
  String? city;
  String? activityLevel;
  String? lastName;
  String? contactNumber;
  String? profilePic;
  String? gender;
  String? hospitalId;
  String? firstName;
  String? password;
  String? email;
  String? dateOfBirth;
  String? bloodGroup;
  List<PatientMedicineReportDetails>? patientMedicineReportDetails;
  List<PatientReportData>? patientReportData;
  List<PatientAllergies>? patientAllergies;
  List<PatientCurrentMedications>? patientCurrentMedications;
  List<PatientPastInjuries>? patientPastInjuries;
  List<PatientPastSurgeries>? patientPastSurgeries;
  List<PatientFoodPreferences>? patientFoodPreferences;

  PatientData(
      {this.maritalStatus,
        this.height,
        this.emergencyContactNumber,
        this.smokingHabits,
        this.alcholConsumption,
        this.occupation,
        this.weight,
        this.id,
        this.city,
        this.activityLevel,
        this.lastName,
        this.contactNumber,
        this.profilePic,
        this.gender,
        this.hospitalId,
        this.firstName,
        this.password,
        this.email,
        this.dateOfBirth,
        this.bloodGroup,
        this.patientMedicineReportDetails,
        this.patientReportData,
        this.patientAllergies,
        this.patientCurrentMedications,
        this.patientPastInjuries,
        this.patientPastSurgeries,
        this.patientFoodPreferences});

  PatientData.fromJson(Map<String, dynamic> json) {
    maritalStatus = json['marital_status'];
    height = json['height'];
    emergencyContactNumber = json['emergency_contact_number'];
    smokingHabits = json['smoking_habits'];
    alcholConsumption = json['alchol_consumption'];
    occupation = json['occupation'];
    weight = json['weight'];
    id = json['id'];
    city = json['city'];
    activityLevel = json['activity_level'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    hospitalId = json['hospital_id'];
    firstName = json['first_name'];
    password = json['password'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    if (json['patient_medicine_report_details'] != null) {
      patientMedicineReportDetails = <PatientMedicineReportDetails>[];
      json['patient_medicine_report_details'].forEach((v) {
        patientMedicineReportDetails!
            .add(new PatientMedicineReportDetails.fromJson(v));
      });
    }
    if (json['patient_report_data'] != null) {
      patientReportData = <PatientReportData>[];
      json['patient_report_data'].forEach((v) {
        patientReportData!.add(new PatientReportData.fromJson(v));
      });
    }
    if (json['patient_allergies'] != null) {
      patientAllergies = <PatientAllergies>[];
      json['patient_allergies'].forEach((v) {
        patientAllergies!.add(new PatientAllergies.fromJson(v));
      });
    }
    if (json['patient_current_medications'] != null) {
      patientCurrentMedications = <PatientCurrentMedications>[];
      json['patient_current_medications'].forEach((v) {
        patientCurrentMedications!
            .add(new PatientCurrentMedications.fromJson(v));
      });
    }
    if (json['patient_past_injuries'] != null) {
      patientPastInjuries = <PatientPastInjuries>[];
      json['patient_past_injuries'].forEach((v) {
        patientPastInjuries!.add(new PatientPastInjuries.fromJson(v));
      });
    }
    if (json['patient_past_surgeries'] != null) {
      patientPastSurgeries = <PatientPastSurgeries>[];
      json['patient_past_surgeries'].forEach((v) {
        patientPastSurgeries!.add(new PatientPastSurgeries.fromJson(v));
      });
    }
    if (json['patient_food_preferences'] != null) {
      patientFoodPreferences = <PatientFoodPreferences>[];
      json['patient_food_preferences'].forEach((v) {
        patientFoodPreferences!.add(new PatientFoodPreferences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['emergency_contact_number'] = this.emergencyContactNumber;
    data['smoking_habits'] = this.smokingHabits;
    data['alchol_consumption'] = this.alcholConsumption;
    data['occupation'] = this.occupation;
    data['weight'] = this.weight;
    data['id'] = this.id;
    data['city'] = this.city;
    data['activity_level'] = this.activityLevel;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['hospital_id'] = this.hospitalId;
    data['first_name'] = this.firstName;
    data['password'] = this.password;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    if (this.patientMedicineReportDetails != null) {
      data['patient_medicine_report_details'] =
          this.patientMedicineReportDetails!.map((v) => v.toJson()).toList();
    }
    if (this.patientReportData != null) {
      data['patient_report_data'] =
          this.patientReportData!.map((v) => v.toJson()).toList();
    }
    if (this.patientAllergies != null) {
      data['patient_allergies'] =
          this.patientAllergies!.map((v) => v.toJson()).toList();
    }
    if (this.patientCurrentMedications != null) {
      data['patient_current_medications'] =
          this.patientCurrentMedications!.map((v) => v.toJson()).toList();
    }
    if (this.patientPastInjuries != null) {
      data['patient_past_injuries'] =
          this.patientPastInjuries!.map((v) => v.toJson()).toList();
    }
    if (this.patientPastSurgeries != null) {
      data['patient_past_surgeries'] =
          this.patientPastSurgeries!.map((v) => v.toJson()).toList();
    }
    if (this.patientFoodPreferences != null) {
      data['patient_food_preferences'] =
          this.patientFoodPreferences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientMedicineReportDetails {
  String? patientId;
  String? medicineId;
  String? medicineName;

  PatientMedicineReportDetails(
      {this.patientId, this.medicineId, this.medicineName});

  PatientMedicineReportDetails.fromJson(Map<String, dynamic> json) {
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

class PatientReportData {
  String? reportFile;
  String? patientId;
  String? reportId;
  int? id;
  String? reportName;

  PatientReportData(
      {this.reportFile,
        this.patientId,
        this.reportId,
        this.id,
        this.reportName});

  PatientReportData.fromJson(Map<String, dynamic> json) {
    reportFile = json['report_file'];
    patientId = json['patient_id'];
    reportId = json['report_id'];
    id = json['id'];
    reportName = json['report_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_file'] = this.reportFile;
    data['patient_id'] = this.patientId;
    data['report_id'] = this.reportId;
    data['id'] = this.id;
    data['report_name'] = this.reportName;
    return data;
  }
}

class PatientAllergies {
  String? allergy;
  int? id;

  PatientAllergies({this.allergy, this.id});

  PatientAllergies.fromJson(Map<String, dynamic> json) {
    allergy = json['allergy'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allergy'] = this.allergy;
    data['id'] = this.id;
    return data;
  }
}

class PatientCurrentMedications {
  String? currentMedication;
  int? id;

  PatientCurrentMedications({this.currentMedication, this.id});

  PatientCurrentMedications.fromJson(Map<String, dynamic> json) {
    currentMedication = json['current_medication'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_medication'] = this.currentMedication;
    data['id'] = this.id;
    return data;
  }
}

class PatientPastInjuries {
  int? id;
  String? pastInjury;

  PatientPastInjuries({this.id, this.pastInjury});

  PatientPastInjuries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pastInjury = json['past_injury'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['past_injury'] = this.pastInjury;
    return data;
  }
}

class PatientPastSurgeries {
  int? id;
  String? pastSurgery;

  PatientPastSurgeries({this.id, this.pastSurgery});

  PatientPastSurgeries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pastSurgery = json['past_surgery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['past_surgery'] = this.pastSurgery;
    return data;
  }
}

class PatientFoodPreferences {
  String? foodPreference;
  int? id;

  PatientFoodPreferences({this.foodPreference, this.id});

  PatientFoodPreferences.fromJson(Map<String, dynamic> json) {
    foodPreference = json['food_preference'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_preference'] = this.foodPreference;
    data['id'] = this.id;
    return data;
  }
}