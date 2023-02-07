import 'package:flutter/material.dart';
import 'package:todo2/date/firebase_utiles.dart';

class AddToddBottomSheet extends StatefulWidget {
  const AddToddBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddToddBottomSheet> createState() => _AddToddBottomSheetState();
}

final formKey = GlobalKey<FormState>();

class _AddToddBottomSheetState extends State<AddToddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var title = '';
  var description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Todo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Form(
            key: formKey,
            child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter todo title';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    Form.of(context);
                  },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                    minLines: 3,
                    maxLines: 3,
                    validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter description';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    description = text;
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Date'),
          InkWell(
            onTap: () {
              showDateDialge();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addTodo();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }

  void addTodo() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    addTodoFireStore(title, description, selectedDate).then((value) {
      addShowMessage('Task is added succesfully');
    }).onError((error, stackTrace) {
      print('Error adding');
    }).timeout(Duration(seconds: 20), onTimeout: () {});
  }

  void showDateDialge() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {});
    }
  }

  void addShowMessage(String message) {
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
}
