import 'package:flutter/material.dart';
import 'package:todo2/ui/add_todo_widget.dart';
import 'package:todo2/ui/settings_tab.dart';
import 'package:todo2/ui/todo_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routName = 'homescreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        title: Text('Route todo app'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 4,
        )),
        onPressed: () {
          showAddTodoSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(label: '', icon: Icon(Icons.list)),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  List<Widget> tabs = [
    TodoListTab(),
    Settings(),
  ];

  void showAddTodoSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddToddBottomSheet();
        });
  }
}
