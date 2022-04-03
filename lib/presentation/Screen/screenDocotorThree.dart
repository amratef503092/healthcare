import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'adminScreen.dart';
class ScreenDoctorThree extends StatefulWidget {
   ScreenDoctorThree({Key? key}) : super(key: key);

  @override
  State<ScreenDoctorThree> createState() => _ScreenDoctorThreeState();
}

class _ScreenDoctorThreeState extends State<ScreenDoctorThree> {
  var conditionController = TextEditingController();

   var treatmentController = TextEditingController();
   File ? image;
   String ? link;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
   pickImage(ImageSource imageSource) async{
    try {
      final image = await ImagePicker().pickImage(source: imageSource);

      if (image == null) {
        return;
      } else {
        final imageTeprary = File(image.path);
        setState(() {
          this.image = imageTeprary;
        });
      }
    } on PlatformException catch(e){
      print('$e');
    }

  }
  Future uploadFile() async {
    if (image == null) return;
    final fileName = basename(image!.path);
    final destination = 'files/$fileName';

    try {
      final ref = storage
          .ref(destination)
          .child('file/');
      await ref.putFile(image!);
      setState(() async{
        link = await ref.getDownloadURL();
      });
      print(link);
    } catch (e) {
      print('error occured');
    }
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;
    return BlocConsumer<AppCubit,AppStates>( listener: (context, state) {

    } , builder: (context,state){
      var cubit = AppCubit.get(context);
      return SafeArea(
          child: Scaffold(
            body: Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetsManager.backGroundAdmin),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NavigatorWidget(
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: screenHeight*.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            height: screenHeight*.2,

                            text: "Upload Photo",
                            function: () async {

                              Alert(
                                context: context,
                                image: (image == null)? CircularProgressIndicator() : Image(image: NetworkImage(
                                    link!
                                )),
                                title: "Send Success",
                                buttons: [
                                  DialogButton(
                                    child: const Text(
                                      "gallery",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () =>  pickImage(ImageSource.gallery).then((value) {
                              uploadFile().then((value) {
                                Navigator.pop(context);
                              });

                              }

                                      ),
                                  ),
                                  DialogButton(
                                    child: const Text(
                                      "camera",
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => pickImage(ImageSource.camera).then((value) {
                                      uploadFile().then((value) {
                                        Navigator.pop(context);
                                      });

                                    }

                                    ) ,
                                    width: 120,
                                  ),
                                ],
                              ).show();
                              // don`t forget validate amr,
                              print(image?.path);
                            },
                            colorText: Colors.black,
                            fontSize: 30,
                            coloBorder: Color(0xff707070),
                            colorButton: Colors.white,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          enterDate(
                              screenWidth: screenWidth,
                              text: "Condition...",
                              controller: conditionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              function: (){


                              }
                          ),
                          enterDate(
                              screenWidth: screenWidth,
                              text: "Treatment.....",
                              controller: treatmentController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              function: (){

                              }
                          ),
                          Button(
                            height: screenHeight*.1,
                            width: screenWidth*.8,
                            text: "Send",
                            function: () {

                               cubit.addDoctorTreatment(
                                conditions: conditionController.text,
                                treatment: treatmentController.text,
                                link: link
                              );
                                Alert(
                                  context: context,
                                  type: AlertType.success,
                                  title: "Send Success",
                                  buttons: [
                                    DialogButton(
                                      child: const Text(
                                        "Back",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pushReplacement(context , MaterialPageRoute(builder: (context)=>
                                      AdminScreen()
                                      )),
                                      width: 120,
                                    )
                                  ],
                                ).show();



                            },
                            colorText: Colors.black,
                            fontSize: 30,
                            coloBorder: Color(0xff707070),
                            colorButton: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
    },);
  }
}
