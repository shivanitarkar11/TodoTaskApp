import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToDOList extends StatefulWidget {
  const ToDOList({super.key});

  @override
  State<ToDOList> createState() => _ToDOListState();
}

class _ToDOListState extends State<ToDOList> {

  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  late TabController _tabController;

  void _addTask() {
    String taskTitle = _taskController.text;
    if (taskTitle.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: taskTitle));
      });
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isComplete = !_tasks[index].isComplete;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.withOpacity(0.4)
            ),
            child:   const Text("To Do List",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      )
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    labelText: 'New Task',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),

                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.4),
                ),
                onPressed: _addTask,
                child: const Text('Add',
                style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      _toggleTaskCompletion(index);
                    },
                    child: Text(
                      _tasks[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        color: _tasks[index].isComplete ? Colors.black : Colors.red,
                      ),
                    ),
                  ),
                  leading: Checkbox(
                    value: _tasks[index].isComplete,
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index);
                    },
                    activeColor: Colors.blue.withOpacity(0.4),
                  ),
                  trailing: Text(
                    _tasks[index].isComplete ? 'Complete' : 'Incomplete',
                    style: TextStyle(
                      fontSize: 20,
                      color: _tasks[index].isComplete ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class Task {
  String title;
  bool isComplete;
  Task({required this.title, this.isComplete = false});
}
