import 'package:crudfirebasestore/src/data/database.dart';
import 'package:crudfirebasestore/src/pages/add_page.dart';
import 'package:crudfirebasestore/src/pages/view_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 Database? db;
 List docs = [];

 initilise(){
   db = Database();
   db?.initiliase();
   db?.read().then((value) => {

     setState((){
       docs = value;
     })
   
   });
 }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
      appBar:AppBar(
        title: Text('Crud Firebase'),
      ),
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            margin: EdgeInsets.all(30),
            child: ListTile(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>
                  ViewPage(country:docs[index], db:db as Database))).then((value) => {
                    print(value),
                    if(value!=null){
                      initilise()
                    }
                  });
              },
              contentPadding: EdgeInsets.only(right: 30,left: 36),
              title: Text(docs[index]['name']),
              trailing: Text(docs[index]['code']),
            ),
          );
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddPage(db:db as Database)))
            .then((value) => {
              print(value),
              if(value!=null){
                initilise()
              }
            });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}