class UserProfile {
  final int? id;
  final String? clientName;
  final String? clientUsername;
  final String? firmName;
  final String? purpose;
  final String? dscExpDate;
  final String? remark;
  final String? emailId;
  final String? phone;
  final String? clientAlternateNo;
  final String? clientAddress;
  final String? clientPassword;
  final String? aadharCard;
  final String? panCard;
  final String? clientId;
  final String? ownerId;
  final String? createdAt;
  final String? updatedAt;
  final String? clientNo2;
  final String? clientAlt2;
  final String? description;
  final String? clientPasswordWord;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final String? gstNo;
  final String? clientImage;
  final String? clientType;
  final String? digitalYear;

  UserProfile({
    this.id,
    this.clientName,
    this.clientUsername,
    this.firmName,
    this.purpose,
    this.dscExpDate,
    this.remark,
    this.emailId,
    this.phone,
    this.clientAlternateNo,
    this.clientAddress,
    this.clientPassword,
    this.aadharCard,
    this.panCard,
    this.clientId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.clientNo2,
    this.clientAlt2,
    this.description,
    this.clientPasswordWord,
    this.city,
    this.district,
    this.state,
    this.country,
    this.gstNo,
    this.clientImage,
    this.clientType,
    this.digitalYear,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      clientName: json['client_name'],
      clientUsername: json['client_username'],
      firmName: json['firm_name'],
      purpose: json['purpose'],
      dscExpDate: json['dsc_exp_date'],
      remark: json['remark'],
      emailId: json['email_id'],
      phone: json['phone'],
      clientAlternateNo: json['client_alternate_no'],
      clientAddress: json['client_address'],
      clientPassword: json['client_password'],
      aadharCard: json['aadhar_card'],
      panCard: json['pan_card'],
      clientId: json['client_id'],
      ownerId: json['owner_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      clientNo2: json['client_no2'],
      clientAlt2: json['client_alt_2'],
      description: json['description'],
      clientPasswordWord: json['client_password_word'],
      city: json['city'],
      district: json['district'],
      state: json['state'],
      country: json['country'],
      gstNo: json['gst_no'],
      clientImage: json['client_image'],
      clientType: json['client_type'],
      digitalYear: json['digital_year'],
    );
  }
} 