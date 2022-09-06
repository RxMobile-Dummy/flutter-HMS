class GetPatientProfileModel {
  bool? success;
  Data? data;
  String? message;
  String? error;

  GetPatientProfileModel({this.success, this.data, this.message, this.error});

  GetPatientProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? maritalStatus;
  String? height;
  String? emergencyContactNumber;
  String? smokingHabits;
  String? activityLevel;
  String? occupation;
  String? weight;
  int? id;
  String? city;
  String? alcholConsumption;
  String? password;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? gender;
  String? hospitalId;
  String? contactNumber;
  String? email;
  String? dateOfBirth;
  String? bloodGroup;
  List<PatientAllergies>? patientAllergies;
  List<PatientCurrentMedications>? patientCurrentMedications;
  List<PatientPastInjuries>? patientPastInjuries;
  List<PatientPastSurgeries>? patientPastSurgeries;
  List<PatientFoodPreferences>? patientFoodPreferences;

  Data(
      {this.maritalStatus,
        this.height,
        this.emergencyContactNumber,
        this.smokingHabits,
        this.activityLevel,
        this.occupation,
        this.weight,
        this.id,
        this.city,
        this.alcholConsumption,
        this.password,
        this.firstName,
        this.lastName,
        this.profilePic,
        this.gender,
        this.hospitalId,
        this.contactNumber,
        this.email,
        this.dateOfBirth,
        this.bloodGroup,
        this.patientAllergies,
        this.patientCurrentMedications,
        this.patientPastInjuries,
        this.patientPastSurgeries,
        this.patientFoodPreferences});

  Data.fromJson(Map<String, dynamic> json) {
    maritalStatus = json['marital_status'];
    height = json['height'];
    emergencyContactNumber = json['emergency_contact_number'];
    smokingHabits = json['smoking_habits'];
    activityLevel = json['activity_level'];
    occupation = json['occupation'];
    weight = json['weight'];
    id = json['id'];
    city = json['city'];
    alcholConsumption = json['alchol_consumption'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePic = json['profile_pic'];
    gender = json['gender'];
    hospitalId = json['hospital_id'];
    contactNumber = json['contact_number'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
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
    data['activity_level'] = this.activityLevel;
    data['occupation'] = this.occupation;
    data['weight'] = this.weight;
    data['id'] = this.id;
    data['city'] = this.city;
    data['alchol_consumption'] = this.alcholConsumption;
    data['password'] = this.password;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_pic'] = this.profilePic;
    data['gender'] = this.gender;
    data['hospital_id'] = this.hospitalId;
    data['contact_number'] = this.contactNumber;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
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

class PatientAllergies {
  int? id;
  String? allergy;

  PatientAllergies({this.id, this.allergy});

  PatientAllergies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allergy = json['allergy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allergy'] = this.allergy;
    return data;
  }
}

class PatientCurrentMedications {
  int? id;
  String? currentMedication;

  PatientCurrentMedications({this.id, this.currentMedication});

  PatientCurrentMedications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentMedication = json['current_medication'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_medication'] = this.currentMedication;
    return data;
  }
}

class PatientPastInjuries {
  String? pastInjury;
  int? id;

  PatientPastInjuries({this.pastInjury, this.id});

  PatientPastInjuries.fromJson(Map<String, dynamic> json) {
    pastInjury = json['past_injury'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['past_injury'] = this.pastInjury;
    data['id'] = this.id;
    return data;
  }
}

class PatientPastSurgeries {
  String? pastSurgery;
  int? id;

  PatientPastSurgeries({this.pastSurgery, this.id});

  PatientPastSurgeries.fromJson(Map<String, dynamic> json) {
    pastSurgery = json['past_surgery'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['past_surgery'] = this.pastSurgery;
    data['id'] = this.id;
    return data;
  }
}

class PatientFoodPreferences {
  int? id;
  String? foodPreference;

  PatientFoodPreferences({this.id, this.foodPreference});

  PatientFoodPreferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodPreference = json['food_preference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_preference'] = this.foodPreference;
    return data;
  }
}