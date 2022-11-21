// ignore_for_file: prefer_typing_uninitialized_variables

class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  var sortTime;
  int? color;
  String? repeat;
  var mapCoor;
  int? savedTask;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.sortTime,
    this.color,
    this.repeat,
    this.mapCoor,
    this.savedTask,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    sortTime = json['sortTime'];
    color = json['color'];
    repeat = json['repeat'];
    mapCoor = json['mapCoor'];
    savedTask = json['savedTask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['sortTime'] = this.sortTime;
    data['color'] = this.color;
    data['repeat'] = this.repeat;
    data['mapCoor'] = this.mapCoor;
    data['savedTask'] = this.savedTask;
    return data;
  }
}
