import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'API.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleTranslator translator = new GoogleTranslator();
  String url;
  String out = "";
  String res = "";
  var Data;

  final lang = TextEditingController();

  void trans(String res) {
    translator.translate(res, to: lang.text).then((output) {
      setState(() {
        out = output.toString();
      });
      print(output);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Translator"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    url =
                        "https://sillytranslator.herokuapp.com/translate?text=" +
                            value.toString();
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: lang,
                ),
                RaisedButton(
                  onPressed: () async {
                    Data = await Getdata(url);
                    var DecodedData = jsonDecode(Data);
                    setState(() {
                      res = DecodedData['result'];
                    });
                    print(res);
                    trans(res);
                  },
                  child: Text("Ok Boomer!"),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  out.toString(),
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        ));
  }
}
