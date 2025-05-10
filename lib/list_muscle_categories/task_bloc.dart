import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metal_human/list_muscle_categories/repository.dart';
import 'package:metal_human/list_muscle_categories/task_event.dart';
import 'package:metal_human/list_muscle_categories/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {

    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());

      try {
        final tasks = await repository.fetchTasks();
        emit(TaskLoaded(tasks));

      } catch (e) {
        emit(TaskError('Error loading tasks'));
      }
    });
  }
}
