import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}
