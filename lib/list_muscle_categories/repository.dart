
import 'package:firebase_database/firebase_database.dart';
import 'package:metal_human/list_muscle_categories/model.dart';



class TaskRepository {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref('muscle_categories');

  Future<List<Task>> fetchTasks() async {
    final snapshot = await _dbRef.get();

    if (snapshot.exists) {
      final rawData = snapshot.value as Map;
      final data = rawData.map((key, value) => MapEntry(
        key.toString(),
        Map<String, dynamic>.from(value),
      ));

      return data.entries.map((entry) {
        return Task.fromMap(entry.value);
      }).toList();
    } else {
      return [];
    }
  }

}