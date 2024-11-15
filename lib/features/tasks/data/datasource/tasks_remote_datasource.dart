import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_app/infrastructure/either.dart';
import 'package:tasks_app/infrastructure/exceptions/http_exception.dart';

abstract class TasksDataSource {
  Future<Either<AppException, String>> createTask({
    required String title,
    required String description,
    required bool completed,
  });

  Future<Either<AppException, List<Map<String, dynamic>>>> retrieveTasks();

  Future<Either<AppException, void>> updateTask({
    required String taskId,
    required Map<String, dynamic> updates,
  });

  Future<Either<AppException, void>> deleteTask({
    required String taskId,
  });
}

class TasksRemoteDataSource implements TasksDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either<AppException, String>> createTask({
    required String title,
    required String description,
    required bool completed,
  }) async {
    try {
      final taskDoc = await _firestore.collection('tasks').add({
        'title': title,
        'description': description,
        'completed': completed,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return Right(taskDoc.id); // Return the task ID
    } catch (e) {
      return Left(AppException(
        message: e.toString(),
        statusCode: 1,
        identifier: '${e.toString()}\nTasksRemoteDataSource.createTask',
      ));
    }
  }

  @override
  Future<Either<AppException, List<Map<String, dynamic>>>> retrieveTasks() async {
    try {
      final snapshot = await _firestore.collection('tasks').orderBy('createdAt', descending: true).get();
      final tasks = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      return Right(tasks);
    } catch (e) {
      return Left(AppException(
        message: e.toString(),
        statusCode: 1,
        identifier: '${e.toString()}\nTasksRemoteDataSource.retrieveTasks',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> updateTask({
    required String taskId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update(updates);
      return const Right(null); // Return void on success
    } catch (e) {
      return Left(AppException(
        message: e.toString(),
        statusCode: 1,
        identifier: '${e.toString()}\nTasksRemoteDataSource.updateTask',
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deleteTask({
    required String taskId,
  }) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      return const Right(null); // Return void on success
    } catch (e) {
      return Left(AppException(
        message: e.toString(),
        statusCode: 1,
        identifier: '${e.toString()}\nTasksRemoteDataSource.deleteTask',
      ));
    }
  }
}
