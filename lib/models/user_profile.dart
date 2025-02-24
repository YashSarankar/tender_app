class UserProfile {
  final int id;
  final String clientName;
  final String emailId;
  final String phone;
  final String city;
  final String district;
  final String state;
  final String country;
  final String gstNo;
  final String panCard;
  final String aadharCard;
  final String dscExpDate;
  final String? clientImage;

  UserProfile({
    required this.id,
    required this.clientName,
    required this.emailId,
    required this.phone,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.gstNo,
    required this.panCard,
    required this.aadharCard,
    required this.dscExpDate,
    this.clientImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      clientName: json['client_name'],
      emailId: json['email_id'],
      phone: json['phone'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      gstNo: json['gst_no'],
      panCard: json['pan_card'],
      aadharCard: json['aadhar_card'],
      dscExpDate: json['dsc_exp_date'],
      clientImage: json['client_image'],
    );
  }
} 