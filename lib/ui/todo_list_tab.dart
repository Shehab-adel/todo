import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo2/date/firebase_utiles.dart';
import 'package:todo2/date/todo.dart';
import 'package:todo2/ui/todo_widget.dart';

class TodoListTab extends StatefulWidget {
  const TodoListTab({Key? key}) : super(key: key);

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          selectedDayPredicate: (day) {
            return isSameDay(day, selectedDay);
          },
          onDaySelected: (sDay, fDay) {
            setState(() {
              selectedDay = sDay;
              focusedDay = fDay;
            });
          },
          calendarFormat: CalendarFormat.week,
          focusedDay: focusedDay,
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          calendarStyle: CalendarStyle(
            selectedTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            todayTextStyle: const TextStyle(
              color: Colors.white,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(12),
            ),
            defaultTextStyle: const TextStyle(
              color: Colors.black,
            ),
            defaultDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          weekendDays: const [],
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Todo>>(
          stream: getTodoCollectionWithConverter()
              .orderBy(
                "dateTime",
              )
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Todo>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Todo> items =
                snapshot.data!.docs.map((dec) => dec.data()).toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (buildContext, index) {
                return TodoWidget(items[index]);
              },
            );
          },
        )),
      ],
    );
  }
}
