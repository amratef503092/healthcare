import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
class MedicalHistoryScreenTwo extends StatefulWidget {
   int ? index;
   MedicalHistoryScreenTwo( {this.index});

  @override
  State<MedicalHistoryScreenTwo> createState() => _MedicalHistoryScreenTwoState();
}

class _MedicalHistoryScreenTwoState extends State<MedicalHistoryScreenTwo> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = size.height;
    var screenWidth = size.width;

    return BlocConsumer<AppCubit,AppStates>( listener: (context, state) {

    } , builder: (context ,satate){
      var cubit = AppCubit.get(context);

      List<DataGet> list = [
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.conditions,
          dataText: cubit.medicalHistoryModel[widget.index!].conditions.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.doctorQualifications,
          dataText: cubit.qualification.toString(),
        ),
        DataGet(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: TextManager.treatment,
          dataText: cubit.medicalHistoryModel[widget.index!].treatment.toString(),
        ),
      ];
      return SafeArea(child:
      Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsManager.backGroundMedical),
                fit: BoxFit.cover,
              ),
            ),
            child:Column(
              children: [
                NavigatorWidget(
                  function: () {
                    Navigator.pop(context);
                  },
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight*.4,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return DataGet(
                          dataText: list[index].dataText,
                          text: list[index].text,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        );
                      },
                      itemCount: list.length,
                    ),
                  ),
                ),

                MaterialButton(onPressed: () async {

                  openFile(url: cubit.medicalHistoryModel[widget.index!].link.toString());
                } ,
                  height: 56,
                  minWidth: screenWidth*.8,
                  color: Colors.white.withOpacity(0.7),
                  shape:  RoundedRectangleBorder(borderRadius:BorderRadius.circular(28.0), ),
                  child:  Text(TextManager.downloadFiles),
                ),
                // SizedBox(height: screenHeight*0.3,),
                // MaterialButton(onPressed: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                //       MedicalHistoryScreenThree(),
                //   ));
                // } ,
                //   height: 56,
                //   minWidth: screenWidth*.5,
                //   color: Colors.white.withOpacity(0.7),
                //   shape:  RoundedRectangleBorder(borderRadius:BorderRadius.circular(28.0), ),
                //   child: Text(TextManager.next),
                // ),

              ],
            ),
          )
      ));
    },);
  }
  String getFileName(String url) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);

    var match = matches.elementAt(0);
    print("${Uri.decodeFull(match.group(2)!)}");
    return Uri.decodeFull(match.group(2)!);
  }
  Future openFile({required String url }) async{
    print(url);
    String fileName=  getFileName(url);
    final file = await downloadFile(url,fileName);
    // final x = await pickFile();
    if(file==null){
      return;
    }else{
      print('path : ${file.path}');
      OpenFile.open(file.path);
    }


  }
  Future<File?> pickFile() async{
    final result = await FilePicker.platform.pickFiles();
    return File(result!.files.first.path.toString());
}
  Future<File?>downloadFile(String url ,String name)async{
    final appStorage = await getApplicationDocumentsDirectory();
    File file = File('${appStorage.path}/$name');
    try{
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0
        )
      );
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();
      return file;
    }catch(e){
      print(e.toString());
    }



  }
  // Future<void> downloadFileExample() async {
  //   //First you get the documents folder location on the device...
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   //Here you'll specify the file it should be saved as
  //   File downloadToFile = File('${appDocDir.path}/downloaded-pdf.pdf');
  //   //Here you'll specify the file it should download from Cloud Storage
  //   String fileToDownload = 'uploads/uploaded-pdf.pdf';
  //
  //   //Now you can try to download the specified file, and write it to the downloadToFile.
  //   try {
  //     await FirebaseStorage.instance
  //         .ref(fileToDownload)
  //         .writeToFile(downloadToFile);
  //   } on firebase_core.FirebaseException catch (e) {
  //     // e.g, e.code == 'canceled'
  //     print('Download error: $e');
  //   }
  // }
}
