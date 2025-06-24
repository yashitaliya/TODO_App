import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/main.dart';

void main() {
  runApp(todo());
}

TextEditingController taskinput = new TextEditingController();
TextEditingController taskdetail = new TextEditingController();

class todo extends StatefulWidget {
  _todostate createState() => _todostate();
}

class _todostate extends State<todo> {
  @override
  void initState() {
    super.initState();
    loadTasks(); // Load saved tasks when app starts
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('task_titles', item.cast<String>());
    await prefs.setStringList('task_details', subitem.cast<String>());
    await prefs.setStringList('task_times', time.cast<String>());

    // Save completed list as string list of "true"/"false"
    await prefs.setStringList(
      'task_completed',
      completed.map((e) => e.toString()).toList(),
    );
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedTitles = prefs.getStringList('task_titles');
    List<String>? savedDetails = prefs.getStringList('task_details');
    List<String>? savedTimes = prefs.getStringList('task_times');
    List<String>? savedCompleted = prefs.getStringList('task_completed');
    setState(() {
      item = savedTitles ?? [];
      subitem = savedDetails ?? [];
      time = savedTimes ?? [];
      completed = savedCompleted?.map((e) => e == 'true').toList() ?? [];
    });
  }

  void enterdata(BuildContext context) {
    taskinput.clear();
    taskdetail.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskinput,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    label: Text("Enter Your Task"),
                  ),
                ),
                TextField(
                  controller: taskdetail,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    label: Text("Enter Detail for task"),
                  ),
                  maxLength: 300,
                  maxLines: 2,
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (taskinput.text.isNotEmpty ||
                        taskdetail.text.isNotEmpty) {
                      setState(() {
                        item.add(taskinput.text);
                        // newitemcounter++;
                        subitem.add(taskdetail.text);
                        completed.add(false);

                        String currenttime = TimeOfDay.now().format(context);
                        time.add(currenttime);
                      });
                      saveTasks();
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok")),
            ],
          );
        });
  }

  List<bool> completed = [];
  List item = [];
  List subitem = [];
  List<String> time = [];
  //int newitemcounter = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        body: Column(
          children: [
            AppBar(
              title: Text(
                "TODO App",
                style: TextStyle(
                    color: Color(0xFFA9A9A9), fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.black,
              elevation: 5,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Color(0xFFA9A9A9),
                    ),
                    onPressed: () async {
                      // Clear login status
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedin', false);

                      // Navigate to login screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: item.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No tasks yet! Add a new one.",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        top: 35,
                      ),
                      itemCount: item.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            margin: EdgeInsets.only(bottom: 8),
                            color: Colors.redAccent,
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              item.removeAt(index);
                              subitem.removeAt(index);
                              completed.removeAt(index);
                            });
                            saveTasks();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task deleted')),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            margin:
                                EdgeInsets.only(bottom: 7, right: 10, left: 10),
                            elevation: 10,
                            child: CheckboxListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              value: completed[index],
                              onChanged: (bool? newval) {
                                setState(() {
                                  completed[index] = newval ?? false;
                                });
                                saveTasks();
                              },
                              title: Text(
                                item[index],
                                style: TextStyle(
                                    color: Color(0xFF424242),
                                    fontWeight: FontWeight.bold,
                                    decoration: completed[index]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Color(0xFFBDBDBD)),
                              ),
                              subtitle: Text(
                                "${subitem[index]}\nAdded at: ${time[index]}",
                                style: TextStyle(
                                    color: Color(0xFF424242),
                                    decoration: completed[index]
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    decorationColor: Color(0xFFBDBDBD)),
                              ),
                              tileColor: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          shape: CircleBorder(),
          onPressed: () {
            enterdata(context);
            //add_note();
          },
          child: Icon(
            Icons.add,
            color: Color(0xFFA9A9A9),
          ),
        ),
      ),
    );
  }
}
