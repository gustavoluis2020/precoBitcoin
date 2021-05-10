import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _precoReal = '0';
  String _precoDollar = '0';

  void _recupararPreco() async {
    String url = 'https://blockchain.info/ticker';

    http.Response resposta = await http.get(url);

    Map<String, dynamic> retorno = json.decode(resposta.body);

    setState(() {
      _precoReal = retorno['BRL']['buy'].toString();
      _precoDollar = retorno['USD']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Preço do Bitcoin',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(60),
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/image/bit.png'),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'R\$ ' + _precoReal,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  '\$ ' + _precoDollar,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  height: 50,
                  width: 260,
                  child: ElevatedButton(
                    child: Text('Atualizar Preço'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange, // background
                      onPrimary: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 10,
                      textStyle: TextStyle(fontSize: 25),
                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.grey),
                      )),
                    ),
                    onPressed: _recupararPreco,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
