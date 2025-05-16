import 'package:flutter/material.dart';
import 'package:todo_list/final.dart';
import 'package:todo_list/main.dart';

void main()
{
  runApp(signup());
}

class signup extends StatefulWidget
{
  _signup createState() => _signup();
}

class _signup extends State<signup>
{
  TextEditingController name = new TextEditingController();

  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
              children: [
                //Image.network("https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTAyL3Jhd3BpeGVsX29mZmljZV8yNF9ibGFja19hbmRfd2hpdGVfYWVzdGhldGljX3Bob3RvZ3JhcGh5X29mX2ZhYl81M2JkZDc2NS0zNzNkLTQzMzMtYWRjNy0zNGNmMmUzNzIxMGNfMS5qcGc.jpg"),
                Image.asset('assets/back.jpg'),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 650,
                      width: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight: Radius.circular(50) )
                      ),
                      child: Column(
                        children: [

                          Padding(padding: EdgeInsets.only(top: 30),child:
                          Image(image: AssetImage('assets/todo.png'),width:150,height: 150,),
                          ),

                          Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 20,),
                            child:TextField(
                              controller : name,
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  fillColor: Colors.grey[300],
                                  filled: true
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 12,),
                            child:TextField(
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  fillColor: Colors.grey[300],
                                  filled: true
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 12,),
                            child:TextField(
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  fillColor: Colors.grey[300],
                                  filled: true
                              ),
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(top: 30,right: 15,left: 15),
                            width: 400,
                            height: 80,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                                onPressed: ()
                                {
                                  String pass_name = name.text.toString();
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>todo(receive_name: pass_name)));
                                },
                                child: Text("Create Account",style: TextStyle(color: Colors.white,fontSize: 20),)),
                          ),

                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => login() ));
                            }
                            ,
                            child: Padding(padding: EdgeInsets.only(top: 15,bottom: 5),child: Text("Already have an account ?",style: TextStyle(fontSize: 20),)
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                )
              ],
          ),
        ),
      ),
    );
  }
}