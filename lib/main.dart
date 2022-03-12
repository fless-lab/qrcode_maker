import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QrCode Maker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = TextEditingController();
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
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
            width: 300,
            height: 300,
            child: Card(
                child: Center(
              child: Text(
                "N/A",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
