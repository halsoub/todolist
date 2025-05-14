import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/constants/constants.dart';
import 'package:todolist/provider/date.dart';
import 'package:todolist/provider/post_data.dart';
import 'package:todolist/provider/time.dart';
import 'package:todolist/screens/home/home.dart';

class CreateTask extends StatefulWidget {
  CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController _titleTxt = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Home"), value: "Home"),
      DropdownMenuItem(child: Text("Work"), value: "Work"),
      DropdownMenuItem(child: Text("Health"), value: "Health"),
    ];
    return menuItems;
  }

  DateTime? _selectedDate = DateTime.now();

  String selectedValue = "Home";

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DatePickerProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(Icons.close, color: gray),
        ),
        title: Text("Create New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView(
          children: [
            _Schedule(context, dateProvider),
            spacex,
            _titleTextField(),
            spacex,
            _porpuseDropdownButton(),
            spacex,
            spacex,
            Row(
              children: [
                Expanded(child: _startTextField()),
                SizedBox(width: getWidth(context) * 0.08),
                Expanded(child: _endTextField()),
              ],
            ),
            spacex,

            _descriptionTextField(),
            spacex,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reminder", style: TextStyle(color: lightGray)),
                Switch(value: true, activeColor: blue, onChanged: (value) {}),
              ],
            ),
            spacex,
            spacex,
            spacex,
            _btnCreattask(context),
          ],
        ),
      ),
    );
  }

  Center _btnCreattask(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(5)),
        height: getHieght(context) * 0.06,
        width: getWidth(context),
        child: Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: blue),
            child: Text("Create Task", style: TextStyle(fontSize: fontmd, color: background)),
          ),
        ),
      ),
    );
  }

  Row _Schedule(BuildContext context, DatePickerProvider dateProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Schedule",
          style: TextStyle(color: gray, fontSize: fontmd, fontWeight: FontWeight.w500),
        ),
        Container(
          width: getWidth(context) * 0.28,
          child: TextField(
            onTap: () {
              dateProvider.selectDate(context);
            },
            controller: dateProvider.dateController,
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () {
                  dateProvider.selectDate(context);
                },
                icon: Icon(Icons.arrow_drop_down, color: gray),
              ),

              hintText: "${DateFormat(' MMMM d').format(_selectedDate!)}",
              helperStyle: TextStyle(color: gray),
            ),
          ),
        ),
      ],
    );
  }

  _titleTextField() {
    return TextField(
      controller: _titleTxt,
      decoration: InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(color: lightGray),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: blue)),

        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: lightGray)),
      ),
    );
  }

  _porpuseDropdownButton() {
    return DropdownButton(
      isExpanded: true,
      underline: Divider(height: 1, color: lightGray),
      focusColor: Colors.transparent,
      hint: Text("Select Purpose", style: TextStyle(color: lightGray)),

      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
      value: selectedValue,
      items: dropdownItems,
    );
  }

  _startTextField() {
    return Consumer<TimePickerProvider>(
      builder: (context, providertime, child) {
        return TextField(
          readOnly: true,
          controller: providertime.startTimeController,
          onTap: () => providertime.selectStartTime(context),
          decoration: InputDecoration(
            label: Text("Start"),
            labelStyle: TextStyle(color: lightGray),
            hintText: providertime.startTimeController.text,
            hintStyle: TextStyle(color: lightGray),
            suffixIcon: IconButton(
              onPressed: () {
                providertime.selectStartTime(context);
              },
              icon: Icon(Icons.timer_outlined, color: lightGray),
            ),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2, color: blue)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: lightGray)),
          ),
        );
      },
    );
  }

  _endTextField() {
    return Consumer<TimePickerProvider>(
      builder: (context, providertime, child) {
        return TextField(
          readOnly: true,

          controller: providertime.endimeController,
          onTap: () => providertime.selectEndTime(context),
          decoration: InputDecoration(
            label: Text("End"),
            labelStyle: TextStyle(color: lightGray),
            hintText: providertime.endimeController.toString(),
            hintStyle: TextStyle(color: lightGray),
            suffixIcon: IconButton(
              onPressed: () {
                providertime.selectEndTime(context);
              },
              icon: Icon(Icons.timer_outlined, color: lightGray),
            ),
            focusedBorder: UnderlineInputBorder(
              // borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: blue),
            ),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: lightGray)),
          ),
        );
      },
    );
  }

  _descriptionTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Description",
        labelStyle: TextStyle(color: lightGray),
        hintStyle: TextStyle(color: lightGray),
        focusedBorder: UnderlineInputBorder(
          // borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 2, color: blue),
        ),

        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: lightGray)),
      ),
    );
  }
}
