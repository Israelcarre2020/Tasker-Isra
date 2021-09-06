import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/controllers/controller.dart';
import 'package:todo/controllers/newtask-controller.dart';

Future<bool> addTask() async {
  try {
    NewTaskController newTaskController = Get.put(NewTaskController());
    print(newTaskController.text);
    if (newTaskController.text == "") {
      return false;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> tasks = prefs.getStringList('tasks') ?? [];
      tasks.add(
          "${newTaskController.text}&&--++&&${newTaskController.colorNum}");
      prefs.setStringList('tasks', tasks);
      getTasks();
      return true;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> removeTask(int index) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(index);
    prefs.setStringList('tasks', tasks);
    getTasks();
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> getTasks() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List tasks = prefs.getStringList('tasks') ?? [];
    tasks = tasks.map((e) => e.split("&&--++&&")).toList();
    Get.find<MainController>().updateMainStete(newTasks: tasks);
    return true;
  } catch (e) {
    return false;
  }
}
