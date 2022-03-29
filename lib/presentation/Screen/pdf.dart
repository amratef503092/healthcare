import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../resources/assets/assetclass.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Pdf extends StatelessWidget {
  const Pdf({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      print(cubit.medicalHistoryModel[ cubit.index].conditions.toString());
      print(cubit.index);
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff335971),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cubit.medicalHistoryModel[ cubit.index].conditions
                      .toString()),

                  Text(cubit.medicalHistoryModel[ cubit.index].date.toString()),
                ],
              ),
            ),
            body: Column()
        ),
      );
    },
    );
  }
}

// Column(
// children: [
// Padding(
// padding: const EdgeInsets.fromLTRB(20.0 ,20,0,20),
// child: SizedBox(
// width: double.infinity,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Expanded(
//
// child: Column(
// children: [
// Row(
//
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Text("Date   / " ,style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),) ,
// Text(
// cubit.medicalHistoryModel[ cubit.index].date.toString(),style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),
// )
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
// Text("Name / " ,style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),) ,
// Text(
// cubit.userInfo!.fullName,style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),
// )
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
// Text("age / " ,style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),) ,
// Text(
// cubit.userInfo!.dateTime.toString(),style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),
// )
// ],
// ),
// ],
// ),
// ),
// Expanded(
// child: Column(
// children: [
// Image(image:     AssetImage(AssetsManager.logo),),
// Text(   cubit.userInfo!.hospitalInfo.toString() ,style: TextStyle(
// fontSize: 18,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),) ,
// ],
// ),
// ),
// Expanded(
// child: Column(
// children: [
//
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
//
// Text(
// cubit.doctorNameId.toString(),style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),
// )
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
//
// Text(
// cubit.qualification.toString(),style: TextStyle(
// fontSize: 12,
// color: Colors.black,
// fontWeight: FontWeight.bold
// ),
// )
// ],
// ),
// ],
// ),
// ),
//
//
// ],
// ),
// ),
// ),
// Divider(
// thickness: 10,
// indent: 20,
// endIndent: 20,
// color:Color(0xff335971)
// ),
//
//
//
// ],
// )

