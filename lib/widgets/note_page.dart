import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_taking_app/modal/note.dart';
import 'package:note_taking_app/store/notes_store.dart';
import 'package:note_taking_app/utils/date_time_utils.dart';
import 'package:note_taking_app/widgets/more_options.dart';

class NotePage extends StatefulWidget {
  final Note noteInEditing;

  const NotePage({Key? key, required this.noteInEditing}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleTextEditingController = TextEditingController();
  final _contentTextEditingController = TextEditingController();

  final _titleFocus = FocusNode();
  final _contentFocus = FocusNode();

  late Note _editableNote;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _editableNote = widget.noteInEditing.copy();
    _titleTextEditingController.text = _editableNote.title ?? "-";
    _contentTextEditingController.text = _editableNote.content ?? "-";
  }

  @override
  Widget build(BuildContext context) {
    if (_editableNote.id == -1 && (_editableNote.title ?? "").trim().isEmpty) {
      FocusScope.of(context).requestFocus(_titleFocus);
    }

    return WillPopScope(
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          leading: const BackButton(),
          actions: actionButtons(context),
          elevation: 1,
          backgroundColor: _editableNote.color,
          title: _pageTitle(),
        ),
        body: _bodyWidget(context),
      ),
      onWillPop: _readyToPop,
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      color: _editableNote.color,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: EditableText(
                  maxLines: null,
                  controller: _titleTextEditingController,
                  focusNode: _titleFocus,
                  style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                  cursorColor: Colors.blue,
                  backgroundCursorColor: Colors.blue,
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: EditableText(
                  maxLines: 300,
                  controller: _contentTextEditingController,
                  focusNode: _contentFocus,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  backgroundCursorColor: Colors.red,
                  cursorColor: Colors.blue,
                ),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Last Updated: ${convertEpochToDDMMYYYYNHHMMAA(_editableNote.lastUpdatedMillis ?? DateTime.now().millisecondsSinceEpoch)}",
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ],
        ),
        left: true,
        right: true,
        top: false,
        bottom: false,
      ),
    );
  }

  Widget _pageTitle() {
    return Text(_editableNote.id == -1 ? "New Note" : "Edit Note");
  }

  List<Widget> actionButtons(BuildContext context) {
    List<Widget> actions = [];
    actions += [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          child: GestureDetector(
            onTap: () => bottomSheet(context),
            child: const Icon(
              Icons.color_lens,
            ),
          ),
        ),
      ),
      InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () => updateNoteObject(context),
            child: const Icon(
              Icons.check,
            ),
          ),
        ),
      )
    ];
    return actions;
  }

  Future<void> updateNoteObject(BuildContext context) async {
    _editableNote.content = _contentTextEditingController.text.trim();
    _editableNote.title = _titleTextEditingController.text.trim();

    if (!(_editableNote.title == widget.noteInEditing.title && _editableNote.content == widget.noteInEditing.content) ||
        _editableNote.colorCode != widget.noteInEditing.colorCode) {
      if (_editableNote.id != -1) {
        _editableNote.lastUpdatedMillis = DateTime.now().millisecondsSinceEpoch;
        await NotesStore.updateNotes(_editableNote);
      } else {
        await NotesStore.addNewNotes(_editableNote);
      }
      Navigator.of(context).pop(true);
    }
  }

  Future<bool> _readyToPop() async {
    return true;
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MoreOptionsSheet(
          color: widget.noteInEditing.color,
          callBackColorTapped: _changeColor,
          dateLastEdited: _editableNote.lastUpdatedDate,
        );
      },
    );
  }

  void _changeColor(Color newColorSelected) {
    setState(() {
      _editableNote.colorCode = "${newColorSelected.value}";
    });
  }
}
