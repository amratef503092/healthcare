import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class Pdf extends StatelessWidget {
  int index;
   Pdf(this.index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {

      },builder: (context ,state){
        var cubit = AppCubit.get(context);
        return   SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title:Text( cubit.medicalHistoryModel[index].conditions.toString()) ,
            ),
      body: SfPdfViewer.network(
      cubit.medicalHistoryModel[index].link.toString()),
      ),
        );
    },
    );
  }
}
