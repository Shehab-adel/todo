import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo2/date/todo.dart';

extension MyDateExtention on DateTime {
  DateTime getDateOnly() {
    return DateTime(this.year, this.month, this.day);
  }
}

CollectionReference<Todo> getTodoCollectionWithConverter() {
  return FirebaseFirestore.instance
      .collection(Todo.collectionName)
      .withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}

Future<void> addTodoFireStore(
    String title, String description, DateTime dateTime) {
  CollectionReference<Todo> collectionReference =
      getTodoCollectionWithConverter();
  DocumentReference<Todo> decRef = collectionReference.doc();
  Todo item = Todo(
    id: decRef.id,
    title: title,
    description: description,
    dateTime: dateTime,
  );

  return decRef.set(item);
}

Future<void> deleteTodo(Todo item) {
  CollectionReference collectionReference = getTodoCollectionWithConverter();
  DocumentReference itemDec = collectionReference.doc(item.id);
  return itemDec.delete();
}

Future<void> editTaskDetails(Todo item) {
  CollectionReference todoRef = getTodoCollectionWithConverter();
  return todoRef.doc(item.id).update({
    'title': item.title,
    'description': item.description,
    'dateTime': item.dateTime.getDateOnly().microsecondsSinceEpoch,
  });
}

void editIsDone(Todo item) {
  CollectionReference collectionRef = getTodoCollectionWithConverter();
  collectionRef.doc(item.id).update({'isDone': item.isDone ? false : true});
}