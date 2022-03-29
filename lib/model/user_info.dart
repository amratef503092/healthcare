class UserInfo {
  String fullName;
  String address;
  String id;
  String phoneNumber;
  String emergencyNumber;
  String bloodTybe;
  String loginID;
  String? dateTime;
  String? emailAddres;
  String? photo;
  String? gender;
  String? hospitalInfo;

  UserInfo(
      {required this.fullName,
      required this.address,
      required this.phoneNumber,
      required this.id,
      required this.loginID,
      required this.emergencyNumber,
      required this.bloodTybe,
      required this.dateTime,
      required this.emailAddres,
      required this.photo ,
        required this.gender ,
        required this.hospitalInfo
      });

  static UserInfo fromJson(Map<String, dynamic> json) => UserInfo(
        fullName: json['Full Name'],
        id: json['Id'],
        phoneNumber: json['Phone Number'],
        emergencyNumber: json['Emergency Number'],
        bloodTybe: json['Blood Type'],
        loginID: json['Login Id'],
        address: json['Address'],
        dateTime: json['birth Date'],
        emailAddres: json['email address'],
        photo: json['photo'],
        gender: json['gender'],
    hospitalInfo: json['hospital info'],
      );

  Map<String, dynamic> toMap() {
    return {
      'Full Name': fullName,
      'Id': id,
      'Phone Number': phoneNumber,
      'Emergency Number': emergencyNumber,
      'Blood Type': bloodTybe,
      'Login Id': loginID,
      'Address': address,
      'birth Date': dateTime,
      'email address': emailAddres,
      'photo': photo,
      'gender': gender,
      'hospital info':hospitalInfo,
    };
  }
}
