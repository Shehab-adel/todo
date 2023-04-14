import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/date/firebase_utiles.dart';
import 'package:todo2/ui/app_config_provider.dart';

import '../functions/add_show_message.dart';

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
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      color: provider.containerBackgroundColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Todo',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: Theme.of(context).textTheme.titleSmall),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter todo title';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    title = text;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: Theme.of(context).textTheme.titleSmall),
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
          const SizedBox(
            height: 10,
          ),
          const Text('Date'),
          InkWell(
            onTap: () {
              showDateDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
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
      addShowMessage('Task is added successfully', context);
    }).onError((error, stackTrace) {
      addShowMessage('Error', context);
    }).timeout(const Duration(seconds: 20), onTimeout: () {});
  }

  void showDateDialog() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {});
    }
  }
}
