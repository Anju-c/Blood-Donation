class DonorModel {
  String id;
  String firstName;
  String bloodGroup;
  String gender;
  String state;
  String district;
  String pinCode;
  String address;
  String contactNumber;
 

  DonorModel({
    required this.id,
    required this.firstName,
    required this.bloodGroup,
    required this.gender,
    required this.state,
    required this.district,
    required this.pinCode,
    required this.address,
    required this.contactNumber,
   
  });

  // Convert model to JSON structure for sending data to Backend
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      
      'BloodGroup': bloodGroup,
      'Gender': gender,
      'State': state,
      'District': district,
      'PinCode': pinCode,
      'Address': address,
      'ContactNumber': contactNumber,
      
    


};
  }
  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['id'],
       firstName: json['first_name'],
      bloodGroup: json['blood_group'],
      gender: json['gender'],
      state: json['state'],
      district: json['district'],
      pinCode: json['pin_code'],
      address: json['address'],
      contactNumber: json['contact_number'],
    );
  }
   factory DonorModel.fromlocationJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['id'],
      firstName: json['first_name'],
      bloodGroup: json['blood_group'],
      gender: json['gender'],
      state: json['state'],
      district: json['district'],
      pinCode: json['pin_code'],
      address: json['address'],
      contactNumber: json['contact_number'],
    );
  }
}