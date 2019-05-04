import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/services/crud.dart';

class NewSub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewSubState();
  }
}

class _NewSubState extends State<NewSub> {

  crudMedthods crudObj = new crudMedthods();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  final textValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Subject'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
          children: <Widget>[
            TextFormField(
              controller: textValue,
              validator: (String value){
                if (value.isEmpty) {
                  return 'Please fill subject';
                }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Subject'
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: SizedBox(
                height: 40,
                child: RaisedButton(
                  onPressed: () {
                    crudObj.addData(textValue.text);
                    Navigator.pop(context);
                  },
                  child: Text('Save'),
                ),
              ),
            ) 
          ],
        ) 
      )
    );
  }
}
