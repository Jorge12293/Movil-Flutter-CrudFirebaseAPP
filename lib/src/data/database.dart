import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class Database {
  
 late FirebaseFirestore firestore;

  initiliase(){
    firestore = FirebaseFirestore.instance;
  }
  
  void create (String name, String code) async{

    try{
      await firestore.collection("countries").add({
        'name':name,
        'code':code,
        'timestamp':FieldValue.serverTimestamp()
      });

    }catch(e){
      print(e);
    }

  }

    void delete (String id) async{

    try{
      await firestore.collection("countries").doc(id).delete();
    }catch(e){
      print(e);
    }

  }


  Future<List> read() async{
    QuerySnapshot querySnapshot;
    List docs=[];
    
    try{
      querySnapshot = await firestore.collection('countries').orderBy('timestamp').get();
      if(querySnapshot.docs.isNotEmpty){
        for(var doc in querySnapshot.docs.toList()){
          Map a = { 'id':doc.id, 'name':doc['name'], 'code':doc['code'] };
          docs.add(a);
        }
        return docs;
      }
    }catch (e){
      debugPrint(e.toString());
      return docs;
    }
    return docs;
  } 

  void update(String id, String name, String code) async{
    try{
      await firestore.collection('countries').doc(id).update({
        'name':name,
        'code':code
      });
    }catch(e){
      print(e);
    }
  }

}