import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  String  nfc ='Nfc Not Found';
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

                Text(nfc.substring(105 , nfc.length)),
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
                      // ElevatedButton(
                      //     child: Text('Ndef Write'),
                      //     onPressed: _ndefWrite),
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



      var tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10),
          iosMultipleTagMessage: "Multiple tags found!", iosAlertMessage: "Scan your tag");
      if (tag.ndefAvailable){
        /// decoded NDEF records (see [ndef.NDEFRecord] for details)
        /// `UriRecord: id=(empty) typeNameFormat=TypeNameFormat.nfcWellKnown type=U uri=https://github.com/nfcim/ndef`
        for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
          setState(() {
            nfc = record.toString();
          });

        }
        /// raw NDEF records (data in hex string)
        /// `{identifier: "", payload: "00010203", type: "0001", typeNameFormat: "nfcWellKnown"}`
        for (var record in await FlutterNfcKit.readNDEFRawRecords(cached: false)) {
          print(jsonEncode(record).toString());
        }
      }

  }

  // void _ndefWrite() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null || !ndef.isWritable) {
  //       result.value = 'Tag is not ndef writable';
  //       NfcManager.instance.stopSession(errorMessage: result.value);
  //       return;
  //     }
  //
  //     NdefMessage message = NdefMessage([
  //       NdefRecord.createText('Hello World!'),
  //       NdefRecord.createUri(Uri.parse('https://flutter.dev')),
  //       NdefRecord.createMime(
  //           'text/plain', Uint8List.fromList('Hello'.codeUnits)),
  //       NdefRecord.createExternal(
  //           'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
  //     ]);
  //
  //     try {
  //       await ndef.write(message);
  //       result.value = 'Success to "Ndef Write"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e;
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }
  //   });
  // }
  //
  // void _ndefWriteLock() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null) {
  //       result.value = 'Tag is not ndef';
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }
  //
  //     try {
  //       await ndef.writeLock();
  //       result.value = 'Success to "Ndef Write Lock"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e;
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }
  //   });
  // }
}