import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/Screen/home_screen.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import '../resources/value_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

bool x =false;

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, sttate) {},
        builder: (context, state) {
          var cupit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
                body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.profileImageBackGround),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  NavigatorWidget(
                    function: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                  ),
                  ProfileData(
                    Image: NetworkImage(cupit.userInfo?.photo ??
                        "https://cdn1.vectorstock.com/i/thumb-large/22/05/male-profile-picture-vector-1862205.jpg"),
                    screenHeight: screenHeight,
                    function: () {
                      Alert(
                        context: context,
                        image: (x)?
                         CircularProgressIndicator():   SizedBox(),
                        title: "Upload  Image",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "gallery",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                                cupit.pickImage(ImageSource.gallery).whenComplete(() async{
                                  x= true;
                                 await FirebaseFirestore.instance.collection('user').doc(cupit.currentUser).
                                  collection('UserInfo').doc(cupit.currentUser).update({
                                   'photo' :cupit.link
                                  }).then((value) {
                                    cupit.getUserInfo(cupit.currentUser.toString()).then((value) {
                                      Navigator.pop(context);
                                      x= false;

                                    });
                                 });

                                  print(cupit.link);

                                }).catchError((e){
                                  print("FuckWorld");

                                });
                            }


                          ),
                          DialogButton(
                              child: const Text(
                                "camera",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                cupit.pickImage(ImageSource.camera).whenComplete(() async{
                                  x= true;

                                  await FirebaseFirestore.instance.collection('user').doc(cupit.currentUser).
                                  collection('UserInfo').doc(cupit.currentUser).update({
                                    'photo' :cupit.link
                                  }).then((value) {
                                    cupit.getUserInfo(cupit.currentUser.toString()).then((value){
                                      Navigator.pop(context);

                                    }
                                    );
                                    x= false;

                                  });

                                  print(cupit.link);

                                }).catchError((e){

                                });
                              }


                          ),



                        ],
                      ).show();
                    },
                    useName: cupit.userInfo?.fullName,
                    email: cupit.userInfo?.emailAddres,
                  ),
                  SizedBox(
                    height: screenHeight * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: rowInformation(
                        age: cupit.userInfo!.dateTime.toString(),
                        blood: cupit.userInfo?.bloodTybe,
                        gender: cupit.userInfo?.gender),
                  ),
                  Information(
                    screenWidth: screenWidth,
                    emergency: cupit.userInfo!.emergencyNumber.toString(),
                    userInformation: TextManager.userInformation,
                  ),
                  userInfo(screenHeight: screenHeight, data: 'User Info'),
                ],
              ),
            )),
          );
        });
  }
}
