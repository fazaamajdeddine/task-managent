import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_app/features/authentication/presentation/providers/states/auth_state.dart';
import 'package:tasks_app/features/tasks/presentation/providers/states/tasks_notifier.dart';
import 'package:tasks_app/features/tasks/presentation/providers/states/tasks_state.dart';
import 'package:tasks_app/features/tasks/presentation/providers/tasks_providers.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../routes/app_router.gr.dart';

@RoutePage()
class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(taskNotifierProvider.notifier).retrieveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(taskNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55.h),
            if (tasksState is RetrieveLoading)
              Column(
                children: [
                  ListTile(
                    leading: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey,
                      child: Container(
                        height: ScreenUtil().setHeight(85),
                        width: ScreenUtil().setWidth(85),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.25),
                      highlightColor: Colors.grey,
                      child: Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.25),
                      highlightColor: Colors.grey,
                      child: Container(
                        height: 10,
                        width: 100,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              )
            else if (tasksState is Failure)
              Center(child: Text("Error"))
            else if (tasksState is TasksRetrieved)
              if (tasksState.tasks.isEmpty)
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Aucun task disponible pour le moment',
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasksState.tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final task = tasksState.tasks[index];
                    return Dismissible(
                      key: Key(task['id'].toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          ref
                              .read(taskNotifierProvider.notifier)
                              .deleteTask(task['id']);
                        }
                      },
                      background: Container(
                        width: 535.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          _showUpdateTaskBottomSheet(task);
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(15),
                            ),
                            child: Container(
                              height: ScreenUtil().setHeight(110),
                              width: ScreenUtil().setWidth(352),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80.sp,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.task,
                                              size: 40.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(task['title']),
                                            SizedBox(height: 4),
                                            Text(task['description']),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 8.0,
                                    right: 8.0,
                                    child: Container(
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                        border: Border.all(
                                          color: task['completed']
                                              ? Colors.green
                                              : Colors.red,
                                          width: 0.5,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            task['completed']
                                                ? 'Completed'
                                                : 'Incomplete',
                                            style: TextStyle(
                                              color: task['completed']
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            SizedBox(height: 53.h),
            Center(
              child: GestureDetector(
                onTap: _showAddTaskBottomSheet,
                child: Container(
                  height: 55.h,
                  width: 333.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1.w,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 21.0.w, right: 23.w),
                    child: Row(
                      children: [
                        Text('Ajouter un nouveau task'),
                        Spacer(),
                        Container(
                          height: 21.h,
                          width: 21.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blue,
                              width: 1.w,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 15.sp,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ajouter un nouveau task',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final title = _titleController.text;
                      final description = _descriptionController.text;

                      ref
                          .read(taskNotifierProvider.notifier)
                          .createTask(title, description);
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showUpdateTaskBottomSheet(Map<String, dynamic> task) {
    // Prepopulate the form with task details
    final TextEditingController titleController =
        TextEditingController(text: task['title']);
    final TextEditingController descriptionController =
        TextEditingController(text: task['description']);
    bool isCompleted = task['completed'];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Update Task',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value ?? false;
                            });
                          },
                        ),
                        Text('Mark as completed')
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Update the task
                        ref.read(taskNotifierProvider.notifier).updateTask(
                          task['id'],
                          {
                            'title': titleController.text,
                            'description': descriptionController.text,
                            'completed': isCompleted,
                          },
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text('Update Task'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
