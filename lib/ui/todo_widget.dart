import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo2/date/firebase_utiles.dart';
import 'package:todo2/date/todo.dart';
import 'package:todo2/ui/edit/editing_task.dart';

import '../main.dart';
import 'app_config_provider.dart';

class TodoWidget extends StatefulWidget {
  Todo item;

  TodoWidget(this.item);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, EditingScreen.routeName,
                  arguments: widget.item);
            },
            child: Container(
              height: 120,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: provider.isDark()
                    ? MyThemeData.darkScaffoldBackground
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(width: 4, height: 62, color: textColor()),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            widget.item.title,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: textColor(),
                                    ),
                          ),
                          Text(
                            widget.item.description,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: textColor()),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      editIsDone(widget.item);
                    },
                    child: widget.item.isDone
                        ? Container(
                            margin: EdgeInsets.all(12),
                            child: Text(
                              'Done!',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(color: textColor()),
                            ))
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                                'assets/images/Icon awesome-check.png'),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconSlideAction(
          color: Colors.transparent,
          iconWidget: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          onTap: () {
            deleteTodo(widget.item)
                .then((value) {
              deleteshowMessage('Task is deletd succesfully');
            })
                .onError((error, stackTrace) {})
                .timeout(Duration(seconds: 10), onTimeout: () {});
          },
        )
      ],
    );
  }

  void deleteshowMessage(String message) {
    showDialog(
        context: context,
        builder: (buildContext) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Color textColor() {
    if (!widget.item.isDone) {
      return Colors.blue;
    }
    return MyThemeData.greenColor;
  }
}
