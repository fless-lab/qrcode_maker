import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = TextEditingController();
  var _qrcode;
  String _host = "http://10.0.2.2:8000";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QrCode Maker"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.qr_code),
                title: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Entrer une url ou un texte',
                      border: InputBorder.none),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => getQRcode(controller.text),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
            width: 300,
            height: 300,
            child: _buildQRcode(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        tooltip: "Rafraichir",
        onPressed: () {
          setState(() {
            controller.clear();
            _qrcode = null;
          });
        },
        child: Icon(
          Icons.refresh_outlined,
          size: 35,
        ),
      ),
    );
  }

  void getQRcode(String content) async {
    if (content.isEmpty) {
      return;
    }

    //Send « to encode » string and get the name of the qrcode
    final http.Response response =
        await http.post(Uri.parse("$_host/qrcode"), body: jsonEncode(content));
    final decodedResponse = json.decode(response.body);

    //qrcode final link
    final _qrcodeURL = "$_host/get_qrcode?name=$decodedResponse";

    //Build Qrcode
    final ByteData imageData =
        await NetworkAssetBundle(Uri.parse(_qrcodeURL)).load("");
    final Uint8List bytes = imageData.buffer.asUint8List();
    setState(() {
      _qrcode = bytes;
    });
  }

  Widget _buildQRcode() {
    if (_qrcode == null) {
      return Card(
          child: Center(
        child: Text(
          "N/A",
          style: TextStyle(fontSize: 30, color: Colors.grey),
        ),
      ));
    }
    return Image.memory(
      _qrcode,
      fit: BoxFit.cover,
    );
  }
}
