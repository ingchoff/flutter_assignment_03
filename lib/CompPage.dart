import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/services/crud.dart';

class CompPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompPageState();
  }
}

class _CompPageState extends State<CompPage> {

  List<bool> inputs = new List<bool>();
  crudMedthods crudObj = new crudMedthods();

  @override
  void initState(){
    for (int i = 0;i<25;i++) {
      inputs.add(true);
    }
    super.initState();
  }

  void ItemChange(bool val,int index){
    setState(() {
      inputs[index] = val;
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document, index) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: CheckboxListTile(
        title: Text(document['title'], style: TextStyle(fontWeight: FontWeight.bold)),
        value: inputs[index],
        onChanged: (bool value) {
          ItemChange(value, index);
          crudObj.updateDone(document.documentID, value);
          ItemChange(true, index);
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do'),
        actions: <Widget>[
          new IconButton(
            onPressed: (){
              crudObj.deleteData();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: Firestore.instance.collection('todo').where('done', isEqualTo: 1).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.documents.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => _buildListItem(context, snapshot.data.documents[index], index),
                );
              } else {
                return new Center(
                child: Text('No data found..'),
              );
              }
            } else {
              return new Center(
                child: Text('Loading...'),
              );
            }
          },
        ),
      )
    );
  }
}