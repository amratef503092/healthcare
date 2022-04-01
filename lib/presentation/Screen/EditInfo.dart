import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppCubit.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
import '../resources/value_manager.dart';
import 'addDoctorScreen.dart';
class EditInfo extends StatefulWidget {
  const EditInfo({Key? key}) : super(key: key);

  @override
  State<EditInfo> createState() => _EditInfoState();
}


class _EditInfoState extends State<EditInfo> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = AppCubit.get(context);


          return SafeArea(
              child: Scaffold(
                  body: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,

                        height: height,
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
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width,
                                child: Row(
                                  children: [


                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(cubit.userInfo2[0].photo.toString()),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      children: [
                                        Text(cubit.userInfo2[0].fullName ,style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 41,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text(cubit.userInfo2[0].dateTime.toString() ,style: const TextStyle(
                                            color: Colors.white,
                                            fontSize:32,
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Text(cubit.userInfo2[0].id ,style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*.7,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    enterDate(
                                      controller: cubit.addressControllerEdit,
                                      validator: (value){
                                        if(value!.isEmpty || value == null){
                                          return "Enter data";

                                        }
                                        else{
                                          return null;

                                        }
                                      },
                                      text: "Address",
                                      screenWidth: 300,
                                      password: false,
                                      function: (){},
                                    ),
                                    enterDate(
                                      controller: cubit.phoneNumberControllerEdit,
                                      validator: (value){
                                        if(value!.isEmpty || value == null){
                                          return "Enter data";

                                        }
                                        else{
                                          return null;

                                        }
                                      },
                                      text: "phone Number",
                                      screenWidth: 300,
                                      password: false,
                                      function: (){},
                                    ),
                                    enterDate(
                                      controller: cubit.emergencyNumberEdit,
                                      validator: (value){
                                        if(value!.isEmpty || value == null){
                                          return "Enter data";

                                        }
                                        else{
                                          return null;

                                        }

                                      },
                                      text: "Emergency Number",
                                      screenWidth: 300,
                                      password: false,
                                      function: (){

                                      },
                                    ),

                                    Button(
                                        width: 231,
                                        height: 50,
                                        colorButton: const Color(0xffFFFFFF),
                                        coloBorder: const Color(0xff707070),
                                        fontSize: AppSize.s28,
                                        colorText: Colors.black,
                                        function: ()  async{
                                          if(formKey.currentState!.validate()){
                                            // cubit.getDoctorQualifications().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            //     AddDoctorScreen())));
                                            cubit.updateDate();
                                          }

                                        },
                                        text: 'Update'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))));
        });
  }}
