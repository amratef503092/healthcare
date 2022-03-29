
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalHistoryModel {
  String? conditions;
  String? treatment;
  String? link;
  String ?  date;
  MedicalHistoryModel({
    this.conditions,
    this.link,
    this.treatment,
    this.date,
  });

  static MedicalHistoryModel fromJson(Map<String, dynamic> json) {
    return  MedicalHistoryModel(
      conditions: json['conditions'],
      link: json['link'],
      treatment: json['Treatment'],
      date: json['date'],
    );
  }




  Map<String, dynamic> toMap() {
    return {
      'conditions': conditions,
      'link': link,
      'Treatment': treatment,
      'date': date,
    };
  }
}
