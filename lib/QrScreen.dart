import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
class GenerateQrCode extends StatefulWidget {
  @override
  _GenerateQrCodeState createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  TextEditingController urlController = TextEditingController();
  String qrCodeResult = "Not Yet Scanned";


  Future _qrScanner()async{
    var cameraStatues = await Permission.camera.status;
    if(cameraStatues.isGranted){
      String data = await scanner.scan();
      print(data);
      setState(() {
        qrCodeResult = data;
      });
    }else{
      var isGrant = await Permission.camera.request();
      if(isGrant.isGranted){
        String data = await scanner.scan();
        print(data);
        setState(() {
          qrCodeResult = data;
        });
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qr Code Generator"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
                data: urlController.text,
              size: 200,
            ),
            SizedBox(height: 10),
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
                qrCodeResult,
                style: TextStyle(fontSize: 14), textAlign: TextAlign.center
            ),
            SizedBox(height: 10),
            
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  hintText: 'Enter URL',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Enter Url',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  setState(() {

                  });
                },
                child: Text('Generate Qr Code')),
            SizedBox(height: 5),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _qrScanner();
                  });
                },
                child: Text('Scan Qr Code')),
          ],
        ),
      ),
    );
  }
}
