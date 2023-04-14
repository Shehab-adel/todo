import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo2/date/firebase_utiles.dart';
import 'package:todo2/date/todo.dart';
import 'package:todo2/ui/edit/editing_task.dart';

import '../main.dart';
import 'app_config_provider.dart';

// ignore: must_be_immutable
class TodoWidget extends StatefulWidget {
  Todo item;

  TodoWidget(this.item, {Key? key}) : super(key: key);

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
              Navigator.pushNamed(
                context,
                EditingScreen.routeName,
                arguments: widget.item,
              );
            },
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(12),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: textColor(),
                                  ),
                            ),
                            Text(
                              widget.item.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: textColor()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      editIsDone(widget.item);
                    },
                    child: widget.item.isDone
                        ? Container(
                            margin: const EdgeInsets.all(12),
                            child: Text(
                              'Done!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: textColor()),
                            ))
                        : Container(
                            padding: const EdgeInsets.symmetric(
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
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )),
            child: const Column(
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
                  deleteShowMessage('Task is deleted successfully');
                })
                .onError((error, stackTrace) {})
                .timeout(const Duration(seconds: 10), onTimeout: () {});
          },
        )
      ],
    );
  }

  void deleteShowMessage(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (buildContext) {
          return AlertDialog(
            backgroundColor: provider.containerBackgroundColor(),
            content:
                Text(message, style: Theme.of(context).textTheme.titleSmall),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      Text('OK', style: Theme.of(context).textTheme.titleSmall))
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
