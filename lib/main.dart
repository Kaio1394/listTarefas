import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoCOntroller = TextEditingController();

  List _toDOlist = [];

  void _addToDo(){
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _todoCOntroller.text;
      _todoCOntroller.text = ""; //Reset no texto quando clicar o botão "ADD"
      newToDo["OK"] = false;
      _toDOlist.add(newToDo);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column( //Coluna
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row( //Linha
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoCOntroller,
                    decoration: InputDecoration(
                      labelText: "Nova tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent),
                    ),
                  ),),
                RaisedButton(
                  onPressed: _addToDo,
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,

                )
              ],

            ),
          ),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: _toDOlist.length,
                itemBuilder: (context, index){

                  return CheckboxListTile(
                    title: Text(_toDOlist[index]["title"]),
                    value: _toDOlist[index]["Ok"],
                    secondary: CircleAvatar(
                      child: Icon(_toDOlist[index]["Ok"] ?
                      Icons.check : Icons.error),
                    ),
                  );
                },
              )),

        ],
      ),

    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}//data.json");
  }

  Future<File> _saveData() async {
    // Transformando a lista em um arquivo json
    String data = json.encode(_toDOlist);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}


