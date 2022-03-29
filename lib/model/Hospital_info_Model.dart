class HospitalInfoModel {
  String? address;
  String? phone;
  String? city;
  String? id;
  String? name;
  HospitalInfoModel(
      {required this.address,
      required this.id,
      required this.city,
      required this.name,
      required this.phone});

  static HospitalInfoModel fromJson(Map<String,dynamic> json)=> HospitalInfoModel(
    name: json['name'],
    address: json['Address'],
    phone: json['Phone'],
    city: json['city'],
    id :json['id'],
  );
  Map<String ,dynamic>toMap (){
    return {
      'name' : name,
      'Address' : address,
      'phone' : phone,
      'city':city,
      'id':id,
    };
  }

}
