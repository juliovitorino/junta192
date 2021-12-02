import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:junta192/br/com/jcv/linker/classes/style/asset.dart';

class PrivacyPolycePage extends StatefulWidget {

  PrivacyPolycePage({ Key key }) : super(key: key);

  @override
  _PrivacyPolycePageState createState() => _PrivacyPolycePageState();
}

class _PrivacyPolycePageState extends State<PrivacyPolycePage> {

  String policytxt = "";

  fetchFileData() async {

    String response;
    response = await rootBundle.loadString(pathPrivacyPolicy);
    setState(() {
          policytxt = response;
        });

  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Política de Privacidade"),
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
                children: [
                  Text(policytxt),
                ],
              ),
            ),
        ),
      
    );
  }
}