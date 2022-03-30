import 'dart:convert';


import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:nfc_manager/nfc_manager.dart';
class NFCScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NFCScanState();
}

class NFCScanState extends State<NFCScan> {
  String  nfc = "" ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child :
          Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: [
                (nfc!= "") ?Text(nfc) : Text('nfc plz'),

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
                          child: Text('Tag Read'), onPressed: _tagRead),
                      ElevatedButton(
                          child: Text('Ndef Write'),
                          onPressed: _ndefWrite),
                      // ElevatedButton(
                      //     child: Text('Ndef Write Lock'),
                      //     onPressed: _ndefWriteLock),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Future<void> _tagRead() async {

    // NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
    //   result.value = tag.data.keys;
    //   print(result.value);
    //   NfcManager.instance.stopSession();
    // });
    var tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));

        if (tag.ndefAvailable){

      for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
        print(record.toString());
        setState(() {
          nfc = record.toString().substring(105 , record.toString().length);
        });
      }
    }



  }

  void _ndefWrite()  async {
    var tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!", iosAlertMessage: "Scan your tag");

    if (tag.ndefWritable!) {
      await FlutterNfcKit.writeNDEFRecords([new ndef.TextRecord(text:'fffadasdadad s adasdAmr Atef Goda',language: 'en' )]);
      // raw NDEF records
    }
      // raw NDEF records
    }


    }
