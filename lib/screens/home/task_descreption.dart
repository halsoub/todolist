import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/constants/constants.dart';
import 'package:todolist/model/task_model.dart';
import 'package:todolist/provider/task.dart';
import 'package:todolist/provider/time.dart';

class TaskDescreption extends StatefulWidget {
  TaskDescreption({required this.taskTitle, super.key});
  final Todos taskTitle;

  @override
  State<TaskDescreption> createState() => _TaskDescreptionState();
}

class _TaskDescreptionState extends State<TaskDescreption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.border_color_outlined, color: Theme.of(context).secondaryHeaderColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.taskTitle.title}",
              style: TextStyle(fontSize: fontxl, fontWeight: FontWeight.w800),
            ),
            spacex,
            Container(
              height: getHieght(context) * 0.18,
              width: getWidth(context) * 0.4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Due Date"),
                      Consumer<TimePickerProvider>(
                        builder: (context, timeProvider, child) {
                          final duration = timeProvider.duration;
                          final isOvernight =
                              timeProvider.startTime != null &&
                              timeProvider.endTime != null &&
                              timeProvider.endTime!.hour < timeProvider.startTime!.hour;
                          return Text(timeProvider.formattedDuration);
                        },
                      ),
                    ],
                  ),
                  spacex,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text("Time"),
                      Consumer<TimePickerProvider>(
                        builder: (context, value, child) {
                          return Text(value.startTimeController.text);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text("Descreptin", style: TextStyle(fontSize: fontmd, fontWeight: FontWeight.w600)),
            Container(
              height: getHieght(context) * 0.45,
              // color: black,
              child: Text("Task"),
            ),
            _saveBtn(context),
          ],
        ),
      ),
    );
  }

  Center _saveBtn(BuildContext context) {
    return Center(
      child: Container(
        height: getHieght(context) * 0.06,
        width: getWidth(context),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: blue),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: blue),
          child: Text("Save As Done", style: TextStyle(fontSize: fontmd, color: background)),
        ),
      ),
    );
  }
}
