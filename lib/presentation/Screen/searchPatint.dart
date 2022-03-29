import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import 'homeScreenSearch.dart';
class SearchPatient extends StatefulWidget {
  const SearchPatient({Key? key}) : super(key: key);

  @override
  State<SearchPatient> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return BlocConsumer <AppCubit,AppStates>(listener: (context,staate){}
    ,builder: (context ,state){
      var cubit = AppCubit.get(context);
      return SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
      width: width,
            decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage(AssetsManager.backGroundAdmin),
          fit: BoxFit.cover,
          ),
          ),
          child: Column(

            children: [
              NavigatorWidget(
              function: () {
          Navigator.pop(context);
          },
          ),
              Container(
                height: height*.87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavigatorWidget(
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: searchController,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white
                            ),
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'enter any thing';
                              }
                              return null;
                            },
                            decoration:  const InputDecoration(
                              label: Text("Patient Id" ,style: TextStyle(
                                  color: Colors.white
                              ),),
                              hintText: 'Patient Id',
                              hintStyle: TextStyle(
                                  color: Colors.white
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            )


                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Button(
                      height:height*0.1 ,
                      colorText: Colors.white,
                      colorButton: Color(0xff2A50BD),
                      coloBorder: Color(0xff707070),
                      fontSize: 18,
                      function: () async{
                         await cubit.findUser(
                          context: context,
                          id: searchController.text,
                        );

                      },
                      text: "search",
                      width: width*0.4,
                    )
                  ],
                ),
              )

            ],
          ),
      ),
        )));
      },);
  }
}
