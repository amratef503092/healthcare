
import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helthcare/model/medicalHistory_Model.dart';
import 'package:helthcare/model/user_info.dart';
import 'package:helthcare/presentation/resources/text_manager.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ndef/ndef.dart' as ndef;

import '../../constant/constants.dart';
import '../../model/Hospital_info_Model.dart';
import '../../model/doctorInfoModel.dart';
import '../../model/user_model.dart';
import '../../presentation/Screen/addDoctorScreen.dart';
import '../../presentation/Screen/adminScreen.dart';
import '../../presentation/Screen/homeScreenSearch.dart';
import '../../presentation/Screen/home_screen.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());

  static AppCubit get(context) => BlocProvider.of(context);

  String ? doctorNameId;
  int index = 0;
  UserModel? userModel;
  String? currentUser;
  String? date;
  String? selectedValue2;
  var addressControllerEdit = TextEditingController();
  var phoneNumberControllerEdit = TextEditingController();
  var emergencyNumberEdit= TextEditingController();

  List<String> doctorQualification = [];
  List<String> doctorName = [];
  String ?userNameP ;

  Future<void>updateDate() async{
    var updateData= await FirebaseFirestore.instance.collection('user').doc(currentUser).collection('UserInfo').doc(currentUser).update(
      {
        'Phone Number' : phoneNumberControllerEdit.text,
        'Emergency Number' : emergencyNumberEdit.text,
        'Address' :addressControllerEdit.text,
      }
    );


}
  void getDate(value) {
    date =  DateFormat('yyyy-MM-dd').format(value);

    emit(DatePiker());
  }
  
  Future<void> createUser(
      {required String userName,
      required  String password,
      required  String fullName,
      required  String date,
      required  String phoneNumber,
      required  String emergencyNumber,
      required  String bloodType,
      required  String address,
      required  String id,
      required  String gender,
      required  String emailAddress,
        context
      }) async {
    bool show= false;
    UserInfo userInfo = UserInfo(
        fullName: fullName,
        address: address,
        phoneNumber: phoneNumber,
        id: id,
        loginID: userName,
        emergencyNumber: emergencyNumber,
        bloodTybe: bloodType,
        dateTime: date,
        emailAddres: emailAddress,
        photo: "https://cdn1.vectorstock.com/i/thumb-large/22/05/male-profile-picture-vector-1862205.jpg",
        gender: gender,
        hospitalInfo: 'Dar Al Hekma Hospital');
    var doc =
        await FirebaseFirestore.instance.collection('user').doc(userName).get();

    if (!doc.exists) {

      String ? nfc ;
      bool wirteNFC = false;
      Alert(
        context: context,
        type: AlertType.info,
        title:  "write the ID in Nfc  $userName",
        buttons: [
          DialogButton(
            child: const Text(
              "Write ID",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () async{
              var tag = await FlutterNfcKit.poll(
                  timeout: Duration(seconds: 10),
                  iosMultipleTagMessage: "Multiple tags found!",
                  iosAlertMessage: "Scan your tag");
              if (tag.ndefWritable!) {
                await FlutterNfcKit.writeNDEFRecords(
                    [ ndef.TextRecord(text: userName, language: 'en')]);
                wirteNFC = true;

              }
            },
          ),
    DialogButton(
    child: const Text(
    "NFC read",
    style: TextStyle(color: Colors.white, fontSize: 10),
    ),
    onPressed: () async{
      if(wirteNFC){
        var tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));

        if (tag.ndefAvailable) {
          for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
            print(record.toString());
            nfc = record.toString().substring(105, record.toString().length);
          }
          showToastFlutter(
            color: Colors.red,
            message: 'your id is $nfc',
          );
          show = true;
        }
      }else{
        showToastFlutter(
          color: Colors.red,
          message: 'Write Id in NFC First',
        );

      }

    },
    ),
           DialogButton(
            child: const Text(
              "booked doctor",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            onPressed: () async{
              if(show){
                await FirebaseFirestore.instance.collection('user').doc(userName).set({
                  "useName": userName,
                  "password": password,
                }).then((value)  async{
                  userNameP = userName;
                  await FirebaseFirestore.instance.collection('user').doc(userName).collection('UserInfo').doc(userName).set(userInfo.toMap());
                  print(userInfo.toMap());
                  getDoctorQualifications().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      AddDoctorScreen()
                  )));
                  emit(CreateUserSuccessful());
                });

              }
              else{
                showToastFlutter(
                  color: Colors.red,
                  message: 'please test First',
                );

              }
            }

          )

    ],
      ).show();

      // await FirebaseFirestore.instance.collection('user').doc(userName).set({
      //   "useName": userName,
      //   "password": password,
      // }).then((value)  async{
      //   userNameP = userName;
      //   await FirebaseFirestore.instance.collection('user').doc(userName).collection('UserInfo').doc(userName).set(userInfo.toMap());
      //   print(userInfo.toMap());
      //   getDoctorQualifications().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>
      //       AddDoctorScreen()
      //   )));
      //   emit(CreateUserSuccessful());
      // });

          // raw NDEF records
        }

        else {
      showToastFlutter(
        color: Colors.red,
        message: 'íd is exist',
      );
      emit(CreateUserError());

    }

  }
  List < UserInfo> userInfo2  = [];
  Future<void>findUser({required String id ,context}) async {
     await FirebaseFirestore.instance.collection('user').doc(id).get().then((value) async {
      userInfo2  = [];
      await  FirebaseFirestore.instance.collection('user').doc(id).collection('UserInfo').doc(id).get().then((value)  {
         userInfo2.add(UserInfo.fromJson(value.data()!));
        currentUser = id;
        userNameP = id;
        print(userInfo2[0].emergencyNumber);

        emit(FoundId());
      });
    }).catchError((e){
       Alert(
         context: context,
         type: AlertType.error,
         title: "Not Found",
         buttons: [
           DialogButton(
             child: const Text(
               "Back",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: () {
               Navigator.pop(context);
             },
             width: 120,
           )
         ],
       ).show();
       emit(NotFound());
     }).catchError((e){
       Alert(
         context: context,
         type: AlertType.error,
         title: "Not Found",
         buttons: [
           DialogButton(
             child: const Text(
               "Back",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: () {
               Navigator.pop(context);
             },
             width: 120,
           )
         ],
       ).show();
       emit(NotFound());
     });


  }

  Future<void> login(String username, String password, context) async {
    var doc =
        await FirebaseFirestore.instance.collection('user').doc(username).get();
    if (doc.exists) {
      userModel = UserModel.fromJson(doc.data()!);
      print(userModel!.username);
      if (username == password && userModel?.username == userModel?.password) {
        currentUser = username;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminScreen()));
        showToastFlutter(
          color: Colors.blue,
          message: TextManager.welcome,
        );
        emit(LoginUserSuccessful());
      } else if (username == userModel?.username &&
          password == userModel?.password) {
        currentUser = username;

        getUserInfo(username).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));

        showToastFlutter(
          color: Colors.blue,
          message: TextManager.welcome,
        );
        emit(LoginUserSuccessful());
      }
    } else {
      showToastFlutter(
        color: Colors.red,
        message: TextManager.loginError,
      );
      emit(LoginUserError());
    }
  }

  Future<void> getDoctorQualifications()async {
    var x = await  FirebaseFirestore.instance.collection('doctorInfo').get();
    doctorQualification = [];
    x.docs.forEach((element) {
      doctorQualification.add(element.data()['qualifications']);
    });
    print(doctorQualification);
  }
  Future<void> getDoctorName(String qualification)async {
    var x = await  FirebaseFirestore.instance.collection('doctorInfo').where('qualifications',isEqualTo:qualification).get();
      doctorName = [];
      x.docs.forEach((element) {
        doctorName.add(element.id);
      });


    print(doctorName);


  }

  void addDoctorTreatment({
  required treatment,
    required conditions,
    required link

})  async {
    await FirebaseFirestore.instance.collection('user').doc(userNameP).collection('doctorInfo').doc(selectedValue2).set({  'date' :  DateFormat('yyyy-MM-dd').format(DateTime.now()),});
    await FirebaseFirestore.instance.collection('user').doc(userNameP).collection('doctorInfo').doc(selectedValue2).collection('doctors').add({
      'Treatment' : treatment,
      'date' :  DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'conditions' : conditions,
      'link' :link?? "https://firebasestorage.googleapis.com/v0/b/healthcare-22920.appspot.com/o/default-image-620x600.jpg?alt=media&token=ce63bf2b-2f4f-4a0f-aa4a-20cb38d5a632",
    }).catchError((onError){
      print(onError.toString());
    });

  }
  UserInfo? userInfo;

  Future<void> getUserInfo(String userName) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(userName)
        .collection('UserInfo')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userInfo = UserInfo.fromJson(element.data());
      });

      emit(GetUserInfoSuccessful());
    }).catchError((e) {
      print(e.toString());
      emit(GetUserInfoError());
    });
  }

  // String getAge(String dateTime) {
  //   DateDuration duration;
  //   DateTime dt = DateTime.parse(dateTime);
  //   duration = AgeCalculator.age(dt);
  //   return duration.years.toString();
  // }

  HospitalInfoModel? hospitalInfoModel;
  Future<void> getHospitalInformation() async {
    await FirebaseFirestore.instance
        .collection('hospital Info')
        .doc(userInfo?.hospitalInfo)
        .get()
        .then((value) {
      hospitalInfoModel = HospitalInfoModel.fromJson(value.data()!);
    });
    print(hospitalInfoModel?.id);
  }

  List<DoctorInfoModel> doctorInfoModel = [];
  List<String> docId = [];


  List<String> doctor =[];
  Future<void> getDoctorInfo() async {
    var doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUser)
        .collection('doctorInfo')
        .orderBy('date', descending: true)
        .get();
    docId = [];
    for (var element in doc.docs) {
      docId.add(element.id);
    }

    doctorInfoModel = [];

    for (var element in docId) {
        await FirebaseFirestore.instance
          .collection('doctorInfo')
          .doc(element)
          .get()
          .then((value) =>
              {doctorInfoModel.add(DoctorInfoModel.fromJson(value.data()!))});
    }

    emit(GetDoctorInfoSuccessful());
  }
  Future<void> getDoctorHistory() async {
     doctor =[];
    final doctorInfo = await FirebaseFirestore.instance.collection('user').doc(currentUser).collection('doctorInfo').orderBy('date' ,descending: true).get();
    doctorInfo.docs.forEach((element) {
      doctor.add(element.id);
    });
    print(doctor);
  }
  List<MedicalHistoryModel> medicalHistoryModel = [];
  Future<void> getDoctorDataHistory(String date) async {
    medicalHistoryModel = [];
    // doctor.forEach((element) async{
    //   print(element);
    //   await FirebaseFirestore.instance.collection('user').doc(currentUser).collection('doctorInfo').doc(element).get().then((value) {
    //     medicalHistoryModel.add(MedicalHistoryModel.fromJson(value.data()!));
    //   });
    // });
    await FirebaseFirestore.instance.collection('user').doc(currentUser).collection('doctorInfo').doc(date).collection('doctors').get().then((value) {
      value.docs.forEach((element) {
        medicalHistoryModel.add(MedicalHistoryModel.fromJson(element.data()));
      });
      });
    }
    String ? qualification;
  Future<void>getQualifications(String date)async {

    FirebaseFirestore.instance.collection('doctorInfo').doc(date).get().then((value) {
      qualification = value.data()!['qualifications'];
    });

  }



  // Future<void> geDoctorHistory() async {
  //   medicalHistoryModel = [];
  //
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(currentUser)
  //       .collection('doctorInfo').orderBy('date' ,descending: true)
  //       .get()
  //       .then((value)  {
  //     doctor =[];
  //     value.docs.forEach((element)  {
  //       doctor.add(element.id);
  //        FirebaseFirestore.instance
  //           .collection('user')
  //           .doc(currentUser)
  //           .collection('doctorInfo').doc(element.id).collection('doctors').orderBy('date' ,descending: true).get()
  //           .then((value)  {
  //          doctor =[];
  //          value.docs.forEach((element)  {
  //            doctor.add(element.id);
  //            print(element.id);
  //          });
  //         doctor =[];
  //         value.docs.forEach((element)  {
  //           doctor.add(element.id);
  //           print(element.id);
  //         });
  //       });
  //       print(element.id);
  //     });
  //   });
  //   emit(GetMedicalInfoSuccessful());
  // }
  // Future<void> getMedicalHistory() async {
  //   medicalHistoryModel = [];
  //
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(currentUser)
  //       .collection('doctorInfo').doc().collection('doctors').orderBy('date' ,descending: true).get()
  //       .then((value)  {
  //     doctor =[];
  //     value.docs.forEach((element)  {
  //       doctor.add(element.id);
  //       print(element.id);
  //     });
  //   });
  //   emit(GetMedicalInfoSuccessful());
  // }

}


// FirebaseFirestore.instance
//     .collection('user')
// .doc(currentUser)
// .collection('doctorInfo').doc(element.id).collection('doctors').get().then((value) {
// value.docs.forEach((element)  {
// medicalHistoryModel.add(MedicalHistoryModel.fromJson(element.data()));
// });
// });