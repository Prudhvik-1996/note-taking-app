import 'package:flutter/material.dart';
import 'package:note_taking_app/widgets/color_picker.dart';

enum moreOptions { delete, share, copy }

class MoreOptionsSheet extends StatefulWidget {
  final Color color;
  final DateTime dateLastEdited;
  final void Function(Color) callBackColorTapped;

  const MoreOptionsSheet({
    Key? key,
    required this.color,
    required this.dateLastEdited,
    required this.callBackColorTapped,
  }) : super(key: key);

  @override
  _MoreOptionsSheetState createState() => _MoreOptionsSheetState();
}

class _MoreOptionsSheetState extends State<MoreOptionsSheet> {
  late Color noteColor;

  @override
  void initState() {
    noteColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: noteColor,
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: ColorPicker(
                callBackColorTapped: _changeColor,
                // call callBack from notePage here
                noteColor: noteColor, // take color from local variable
              ),
            ),
          ),
          const ListTile()
        ],
      ),
    );
  }

  void _changeColor(Color color) {
    setState(() {
      noteColor = color;
      widget.callBackColorTapped(color);
    });
  }
}
