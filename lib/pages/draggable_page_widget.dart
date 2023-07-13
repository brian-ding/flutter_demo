import 'package:flutter/material.dart';
import 'package:flutter_demo/models/models.dart';

class DraggablePageWidget extends StatefulWidget {
  final List<Student> students;

  const DraggablePageWidget({required this.students, Key? key}) : super(key: key);

  @override
  _DraggablePageWidgetState createState() => _DraggablePageWidgetState();
}

class _DraggablePageWidgetState extends State<DraggablePageWidget> {
  Student? _draggingStudent;

  void exchange(Student oldStudent, Student newStudent) {
    final index = widget.students.indexOf(oldStudent);
    if (index >= 0) {
      setState(() {
        widget.students.remove(newStudent);
        widget.students.insert(index, newStudent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.students
          .map<Widget>(
            (s) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Draggable(
                onDragStarted: () {
                  setState(() {
                    _draggingStudent = s;
                  });
                },
                onDragEnd: (details) {},
                data: s,
                feedback: Text(
                  s.name,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                childWhenDragging: null,
                child: DragTarget(
                  onWillAccept: (data) {
                    if (data == null) {
                      return false;
                    }
                    if (data is! Student) {
                      return false;
                    }
                    exchange(s, data);
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      _draggingStudent = null;
                    });
                  },
                  builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.blue,
                            width: 5,
                          ),
                        ),
                      ),
                      child: Text(s.email),
                    );
                  },
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
