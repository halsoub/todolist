import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/constants/constants.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/provider/task.dart';
import 'package:todolist/provider/theme.dart';
import 'package:todolist/screens/home/create_task.dart';
import 'package:todolist/screens/home/task_descreption.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _selectedDay = DateTime.now();

  DateTime? _selectedDate = DateTime.now();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchAllTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    // var dateProvider = Provider.of<DatePickerProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Hello Hebah", style: TextStyle(fontSize: fontsm, fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Consumer<ThemeProvider>(
              builder: (context, themeprovider, child) {
                return IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  icon: Icon(Icons.dark_mode_sharp),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bodyTitle(),
            SizedBox(height: height * 0.02),
            _dayTime(context),
            _dateToday(context),
            Divider(thickness: 1, color: black, indent: width * 0.3),
            spacex,
            _ongoing(height, width, context),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => CreateTask()));
        },
        child: Icon(Icons.add),
        shape: CircleBorder(),
        backgroundColor: blue,
        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Expanded _ongoing(double height, double width, BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        width: width,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8),
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/todo.png"),
        //     fit: BoxFit.fill,
        //     opacity: 0.4,
        //   ),
        // ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ongoing", style: TextStyle(fontSize: fontmd, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    height: height * 0.04,
                    width: height * 0.04,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: blue),
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.event_available,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            _getApiTask(),
          ],
        ),
      ),
    );
  }

  Expanded _getApiTask() {
    return Expanded(
      child: Consumer<TaskProvider>(
        builder: (context, TaskProvider, child) {
          if (TaskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (TaskProvider.errorMessage != null) {
            return Center(child: Text(TaskProvider.errorMessage!));
          } else if (TaskProvider.tasks.isEmpty) {
            return const Center(child: Text("No products available"));
          }
          return ListView.builder(
            itemCount: TaskProvider.tasks.length,
            itemBuilder: (context, index) {
              Todos task = TaskProvider.tasks[index];

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [BoxShadow(color: lightGray, blurRadius: 1)],
                ),
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                child: ListTile(
                  title: Text(
                    "${task.title ?? "no"}",
                    style: TextStyle(fontSize: fontmd, fontWeight: FontWeight.w600),
                  ),
                  leading:
                      task.completed == true
                          ? Icon(Icons.task_alt, color: blue)
                          : Icon(Icons.timer_outlined),
                  trailing: Text(
                    task.completed.toString(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TaskDescreption(taskTitle: task)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Text _dateToday(BuildContext context) {
    return Text(
      "${DateFormat(' MMMM d, y').format(_selectedDate!)}",
      style: TextStyle(color: gray, fontSize: fontxs),
    );
  }

  Row _dayTime(BuildContext context) {
    return Row(
      children: [
        Text(
          "Today's",
          style: TextStyle(color: gray, fontSize: fontsm, fontWeight: FontWeight.w600),
        ),
        Text(
          " ${DateFormat('EEEE').format(_selectedDate!)},",
          style: TextStyle(color: blue, fontSize: fontsm, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Text _bodyTitle() {
    return Text(
      "Ready to do your\nDaily Taskd ??",
      style: TextStyle(fontSize: fontxl, fontWeight: FontWeight.w800),
    );
  }
}
