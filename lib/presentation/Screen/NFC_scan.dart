import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:helthcare/shared/bloc/AppCubit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../shared/bloc/AppStates.dart';
import 'infoUserUsingNfc.dart';

class NFCScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NFCScanState();
}

class NFCScanState extends State<NFCScan> {
  String nfc = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(title: Text('Found User Using NFC')),
        body: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return SafeArea(
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.vertical,
                children: [
                  (nfc != "") ? Text(nfc) : Text('nfc plz'),
                  Flexible(
                    flex: 3,
                    child: GridView.count(
                      padding: EdgeInsets.all(4),
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: [
                        ElevatedButton(
                            child: const Text('Tag Read'),
                            onPressed: () {
                              _tagRead().then((value) {
                                // if (cubit.userInfo2.isNotEmpty) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               UserInfoUsingNFC()));
                                // }
                                cubit.findUser(id: nfc).whenComplete(() => {
                                  if(cubit.userInfo2.isNotEmpty )
                                      Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "Found user",
                                        buttons: [
                                          DialogButton(
                                            child: const Text(
                                              "go to information",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserInfoUsingNFC()));
                                            },
                                            width: 120,
                                          )
                                        ],
                                      ).show()
                                    });
                              });
                            }),
                        // ElevatedButton(
                        //     child: Text('Ndef Write'), onPressed: _ndefWrite),
                        // ElevatedButton(
                        //     child: Text('Ndef Write Lock'),
                        //     onPressed: _ndefWriteLock),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Future<void> _tagRead() async {
    var tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));

    if (tag.ndefAvailable) {
      for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
        print(record.toString());
        setState(() {
          nfc = record.toString().substring(105, record.toString().length);
        });
      }
      AppCubit.get(context).findUser(id: nfc,context: context);
    }

  }

  // void _ndefWrite() async {
  //   var tag = await FlutterNfcKit.poll(
  //       timeout: Duration(seconds: 10),
  //       iosMultipleTagMessage: "Multiple tags found!",
  //       iosAlertMessage: "Scan your tag");
  //
  //   if (tag.ndefWritable!) {
  //     await FlutterNfcKit.writeNDEFRecords(
  //         [new ndef.TextRecord(text: 'amr198882', language: 'en')]);
  //
  //     // raw NDEF records
  //   }
  //   // raw NDEF records
  // }
}
