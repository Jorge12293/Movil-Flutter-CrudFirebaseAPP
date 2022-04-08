import 'package:crudfirebasestore/src/data/database.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  
  ViewPage({required this.country, required this.db});
 
  Map country;
  Database db;

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController codeController = new TextEditingController();
  
  @override
  void initState() {
    super.initState();
   
    nameController.text = widget.country['name'];
    codeController.text = widget.country['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
         backgroundColor: Color.fromRGBO(56, 75, 49, 1.0),
         title: Text('Conuntry View'),
         actions: [
           IconButton(
             icon: Icon(Icons.delete),
             onPressed: (){
                widget.db.delete(widget.country['id']);
                Navigator.pop(context,true);
             },
           )
         ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color:Colors.white),
                decoration: inputDecoration("Country Name"),
                controller: nameController,
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color:Colors.white),
                decoration: inputDecoration("Country Code"),
                controller: codeController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: RaisedButton(
            color: Colors.black,
            onPressed: (){
              widget.db.update(widget.country['id'], nameController.text, codeController.text);
              Navigator.pop(context,true);
            },
            child:Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )

          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration (String labelTexto){
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.white),
      labelText: labelTexto,
      fillColor: Colors.white,
      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: Colors.black,
          width: 2.0
        ),
      )

    );
  }
}