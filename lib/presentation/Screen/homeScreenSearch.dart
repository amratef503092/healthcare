import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/constants.dart';
import '../../shared/bloc/AppCubit.dart';
import '../../shared/bloc/AppStates.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import '../resources/value_manager.dart';
import 'EditInfo.dart';
import 'addDoctorScreen.dart';
import 'medical add.dart';

class HomeScreenSearch extends StatefulWidget {
  const HomeScreenSearch({Key? key}) : super(key: key);

  @override
  State<HomeScreenSearch> createState() => _HomeScreenSearchState();
}

class _HomeScreenSearchState extends State<HomeScreenSearch> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, staate) {},
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
                SizedBox(
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
                            Text(cubit.userInfo2[0].fullName ,style: TextStyle(
                              color: Colors.white,
                              fontSize: 41,
                              fontWeight: FontWeight.bold
                            ),),
                            Text(cubit.userInfo2[0].dateTime.toString() ,style: TextStyle(
                                color: Colors.white,
                                fontSize:32,
                                fontWeight: FontWeight.bold
                            ),),
                            Text(cubit.userInfo2[0].id ,style: TextStyle(
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
               Container(
                 height: height*.7,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Button(
                         width: 231,
                         height: 50,
                         colorButton: const Color(0xffFFFFFF),
                         coloBorder: const Color(0xff707070),
                         fontSize: AppSize.s28,
                         colorText: Colors.black,
                         function: () {
                           cubit.getUserInfo(cubit.currentUser.toString()).then((value) {
                             cubit.addressControllerEdit.text = cubit.userInfo!.address;
                             cubit.phoneNumberControllerEdit.text = cubit.userInfo!.phoneNumber;
                             cubit.emergencyNumberEdit.text = cubit.userInfo!.emergencyNumber;
                           });
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>
                           const EditInfo()
                           ));
                         },
                         text: 'Edit info'),
                     SizedBox(
                       height: 30,
                     ),
                     Button(
                         width: 231,
                         height: 50,
                         colorButton: Color(0xffFFFFFF),
                         coloBorder: Color(0xff707070),
                         fontSize: AppSize.s28,
                         colorText: Colors.black,
                         function: ()  async{

                             // await  cubit.getDoctorInfo();
                             //
                             // await cubit.getMedicalHistory().then((value) {
                             //   if(cubit.medicalHistoryModel.isNotEmpty){
                             //     Navigator.push(
                             //         context,
                             //         MaterialPageRoute(
                             //             builder: (context) =>Medicaladd()));
                             //   }
                             // });
                             cubit.getDoctorQualifications().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                 AddDoctorScreen())));



                         },
                         text: 'Doctor info '),
                   ],
                 ),
               )
              ],
            ),
          ))));
        });
  }
}
