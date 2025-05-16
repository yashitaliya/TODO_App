import 'package:flutter/material.dart';

void main()
{
  runApp(todo(receive_name: '',));
}

class todo extends StatefulWidget {
  String? receive_name;
  todo(
      {
        this.receive_name
      }
      );

  _todostate createState() => _todostate();

}

class _todostate extends State<todo>
{



  void add_note()
  {
        setState(() {
            item.add('Item $newitemcounter');
            newitemcounter++;
            subitem.add("hello");
        });
  }

  bool val = false;
  List item = ["yash","yug","vivek"];
  List subitem = ["hii","hello","hy"];
  int newitemcounter = 4;

  Widget build(BuildContext context)
{
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey,
        body: Column(
          children: [

            Container(
              padding: EdgeInsets.only(top: 40),
              width: 400,
            child: Text("Hello.. ${widget.receive_name}",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.white),textDirection: TextDirection.ltr,textAlign: TextAlign.start,),
            ),

                Expanded(
                child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context,index)
                  {
                    return CheckboxListTile(value: val, onChanged: (bool? newval){
                      setState(() {
                        val = newval ?? false;
                      });
                    },
                      title: Text(item[index]),
                      subtitle: Text(subitem[index]),
                      tileColor: Colors.white,
                    );
                  },
              ),
              ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
          shape: CircleBorder(),
          onPressed: ()
          {
            add_note();
          },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    ),
  );
}
}
