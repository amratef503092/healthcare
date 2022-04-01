import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/presentation/Screen/addDoctorScreen.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';
import 'package:intl/intl.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import '../resources/value_manager.dart';




class CreateUserScreen extends StatefulWidget {
  CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  var fullNameController = TextEditingController();

  var addressController = TextEditingController();

  var birthdateController = TextEditingController();

  var idController = TextEditingController();

  var genderController = TextEditingController();

  var emailController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var emergencyNumber = TextEditingController();

  var bloodTypeController = TextEditingController();

  var loginIDController = TextEditingController();

  var passwordController = TextEditingController();

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;

  String ? birthDate ;

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
        var size = MediaQuery.of(context).size;
        var screenHeight = size.height;
        var screenWidth = size.width;
        return SafeArea(
          child: Scaffold(
            body: Container(
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.backGroundAdmin),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                    child: Form(
                      key: formKey,
                  child: ListView(
                    children: [
                      NavigatorWidget(
                        function: () {
                          Navigator.pop(context);
                        },
                      ),
                      enterDate(
                        screenWidth: screenWidth,
                        text: "Full Name",
                        controller: fullNameController,
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
                          text: "Address",
                          controller: addressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          function: (){

                          }
                      ),
                    Column(
                      children: [
                        const Text(
                          "Date of birth",
                          style: TextStyle(fontSize: AppSize.s20, color: Colors.white),
                        ),
                        Container(
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Color(0xffF5F5F5).withOpacity(0.27),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                child: InkWell(
                                  onTap: () async{
                                    await showDatePicker(context: context,
                                        initialDate: DateTime.now(), lastDate: DateTime.now(),
                                        firstDate: DateTime((1920))

                                    ).then((value)  {
                                     var x =  DateFormat.yMd('en_US').format(value!).toString();
                                      setState(() {
                                        birthDate = x ;
                                      });
                                    });
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Center(
                                      child: Text(
                                        birthDate ??"Enter birth DAte" ,style: const TextStyle(
                                          fontSize: AppSize.s18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold

                                      ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                      enterDate(
                          screenWidth: screenWidth,
                          text: "Phone Number",
                          controller: phoneNumberController,
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
                          text: "Emergency Number",
                          controller: emergencyNumber,
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
                          text: "Blood Type",
                          controller: bloodTypeController,
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
                          text: "Login ID",
                          controller: loginIDController,
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
                          text: "ID",
                          controller: idController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          function: (){

                          }
                      ),

                      DropdownButtonFormField2(

                        decoration: InputDecoration(

                          isDense: true,
                          contentPadding: EdgeInsets.zero,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,

                        hint: const Text(
                          'Select Your Gender',

                          style: TextStyle(fontSize: 14 , color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        items: genderItems
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value.toString();

                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            selectedValue = value.toString();

                          });

                        },
                      ),
                      enterDate(
                          screenWidth: screenWidth,
                          text: "email address",
                          controller: emailController,
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
                        password: true,
                          screenWidth: screenWidth,
                          text: "Password",
                          controller: passwordController,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          function: (){


                          }
                      ),

                    ],
                  ),
                ))),
            floatingActionButton: FloatingActionButton(
              onPressed: () async{

                if(formKey.currentState!.validate() && birthDate!.isNotEmpty)  {
                   await cubit.createUser(
                    address: addressController.text,
                    id: idController.text,
                    phoneNumber: phoneNumberController.text,
                    date: birthDate.toString(),
                    gender: selectedValue!,
                    bloodType: bloodTypeController.text,
                    emailAddress: emailController.text,
                    emergencyNumber: emergencyNumber.text,
                    fullName: fullNameController.text,
                    password: passwordController.text,
                    userName: loginIDController.text,
                     context: context
                  );


                }
                },



              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Colors.blue,
                size: 50,
              ),
            ),
          ),
        );
      },
    );
  }
}
