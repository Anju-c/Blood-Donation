class RecipientModel {
  final String id;
  
  final String bloodGroup;
  final String patientName;
  final String attendeeName;
final String attendeePhoneNumber;

  final String requiredDate;
  final String selectUnits;
  final String location;
  // final bool isCritical;

  RecipientModel({
    required this.id,
   
    required this.bloodGroup,
    required this.patientName,
    required this.attendeeName,

    required this.attendeePhoneNumber,
    required this.requiredDate,
    required this.selectUnits,
    required this.location,
    // required this.isCritical,
  });

  // Convert a RecipientModel object into a map for sending to the API.
  Map<String, dynamic> toJson() {
    return {
      'blood_group': bloodGroup,
      'patient_name': patientName,
      'attendee_name': attendeeName,
   
      'attendee_contact_number': attendeePhoneNumber,
      'required_date': requiredDate,
      'select_units': selectUnits,
      'location': location,
      // 'is_critical': isCritical,
    };
  }

  // Convert a map (from API or database) to a RecipientModel object.
  factory RecipientModel.fromJson(Map<String, dynamic> json) {
    return RecipientModel(
      id: json['id'], 
      bloodGroup: json['blood_group'],
      patientName: json['patient_name'],
      attendeeName: json['attendee_name'],
   
      attendeePhoneNumber: json['attendee_contact_number'],
      requiredDate: json['required_date'],
      selectUnits: json['selected_units'],
      location: json['location'],
     
    );
  }
}
