import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:helthcare/shared/bloc/AppStates.dart';

import '../../constant/constants.dart';
import '../resources/assets/assetclass.dart';
import '../resources/text_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var useNameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [

                      (!isLand(context))?  Container(

                        child:   Image(image: AssetImage(AssetsManager.loginImage )),
                      ) : AutoSizeText(
                        'Welcome in Health Care' , maxLines: 1,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.1,
                          color: Colors.blue
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(54, 0, 54, 0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textFormField(
                                  labelTitle: "User Name",
                                  pass: false,
                                  validateText: 'Type any thing',
                                  controller: useNameController),
                              const SizedBox(
                                height: 40,
                              ),
                              textFormField(
                                  labelTitle: "Password",
                                  pass: true,
                                  validateText: 'Type any thing',
                                  controller: passwordController),
                              const SizedBox(
                                height: 40,
                              ),
                              Button(
                                width: (isLand(context)) ? constraints.maxHeight*.5 :constraints.maxWidth*.7  ,
                                height:(isLand(context)) ?constraints.maxHeight*.1 : constraints.maxWidth*.2,
                                fontSize: 20,
                                colorButton: Color(0xff010920),
                                colorText: Colors.white,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit
                                        .login(useNameController.text,
                                        passwordController.text ,context).then((value) {
                                    });


                                  }

                                },
                                text: "Sign in",
                                coloBorder: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },);
      },
    );
  }
}
