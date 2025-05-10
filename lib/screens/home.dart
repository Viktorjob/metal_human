import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metal_human/list_muscle_categories/task_bloc.dart';
import 'package:metal_human/list_muscle_categories/task_event.dart';
import 'package:metal_human/list_muscle_categories/task_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;


    context.read<TaskBloc>().add(LoadTasks());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Muscle categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                print('Category: ${task.name}');
                return GestureDetector(
                  onTap: () {
                    print('Clicked on: ${task.name}');
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [

                        if (task.image != null && task.image!.isNotEmpty)
                          Image.network(
                            task.image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        else
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 50, color: Colors.white),
                          ),

                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              task.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                backgroundColor: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No data.'));
        },
      ),
    );
  }
}
