import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note_taking_app/modal/note.dart';
import 'package:note_taking_app/store/notes_store.dart';
import 'package:note_taking_app/utils/date_time_utils.dart';
import 'package:note_taking_app/widgets/color_picker.dart';

class NotePage extends StatefulWidget {
  final Note noteInEditing;

  const NotePage({Key? key, required this.noteInEditing}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleTextEditingController = TextEditingController();
  final _contentTextEditingController = TextEditingController();

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
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: const BackButton(),
        actions: actionButtons(context),
        elevation: 1,
        backgroundColor: _editableNote.color,
        title: _pageTitle(),
      ),
      body: bodyWidget(context),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Container(
      color: _editableNote.color,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildTitleTextFieldWidget(),
            buildBodyTextFieldWidget(),
            buildLastUpdatedTimeWidget(),
          ],
        ),
        left: true,
        right: true,
        top: false,
        bottom: false,
      ),
    );
  }

  Flexible buildTitleTextFieldWidget() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: TextField(
          maxLines: null,
          controller: _titleTextEditingController,
          style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Flexible buildBodyTextFieldWidget() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: TextField(
          maxLines: 300,
          controller: _contentTextEditingController,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Align buildLastUpdatedTimeWidget() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Text(
          "Last Updated: ${convertEpochToDDMMYYYYNHHMMAA(_editableNote.lastUpdatedMillis ?? DateTime.now().millisecondsSinceEpoch)}",
          textAlign: TextAlign.end,
        ),
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
            onTap: () => showBottomSheetAction(context),
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
            onTap: () => updateNoteAction(context),
            child: const Icon(
              Icons.check,
            ),
          ),
        ),
      )
    ];
    return actions;
  }

  Future<void> updateNoteAction(BuildContext context) async {
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

  void showBottomSheetAction(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: widget.noteInEditing.color,
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
                    noteColor: widget.noteInEditing.color, // take color from local variable
                  ),
                ),
              ),
              const ListTile()
            ],
          ),
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
