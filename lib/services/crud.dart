import 'package:cloud_firestore/cloud_firestore.dart';

class crudMedthods {

  deleteData() async {
    Firestore.instance.collection('todo').where('done', isEqualTo: 1).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }

  updateDone(String id, value) async {
    if (value == true) {
      Firestore.instance.collection('todo').document(id).setData({
        'done': 1
      }, merge: true);
    } else {
      Firestore.instance.collection('todo').document(id).setData({
        'done': 0
      }, merge: true);
    }
  }

  addData(String title) {
    Firestore.instance.collection('todo').document().setData({
      'title': title,
      'done': 0
    });
  }
}