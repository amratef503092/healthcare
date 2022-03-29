class DoctorInfoModel{
  String ? name;
  String ? address;
  String ? department;
  String ? id;
  String ? phoneNumber;
  String ? qualification;
  DoctorInfoModel({
    required this.name,
    required this.id,
    required this.address,
    required this.phoneNumber,
    required this.department,
    required this.qualification,
});
  static DoctorInfoModel fromJson(Map<String ,dynamic> json)=>DoctorInfoModel(
    name: json['Name'],
    address: json['Address'],
    department: json['Department'],
    id: json['id'],
    phoneNumber: json['phone Number'],
    qualification:json['qualifications'],
  );

  Map<String ,dynamic> toMap (){
    return {
      'Name' : name,
      'Address': address,
      'Department' :department,
      'id' : id,
      'phone Number' : phoneNumber,
      'qualifications' : qualification,
    };
  }

}