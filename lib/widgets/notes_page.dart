import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_taking_app/modal/note.dart';
import 'package:note_taking_app/store/notes_store.dart';
import 'package:note_taking_app/widgets/note_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool _isLoading = true;
  bool _showOnlyUnArchived = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    await NotesStore.initNotes();
    setState(() {
      _isLoading = false;
    });
  }

  void handleMoreOptions(String choice) {
    switch (choice) {
      case "Show all notes":
        setState(() {
          _showOnlyUnArchived = false;
        });
        break;
      case "Do not show archived":
        setState(() {
          _showOnlyUnArchived = true;
        });
        break;
      case "Delete all notes":
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (dialogueContext) {
            return AlertDialog(
              content: const Text("Are you sure you want to delete all notes"),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogueContext);
                    await NotesStore.deleteAllNotes();
                    setState(() {});
                  },
                  child: const Text("YES"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogueContext);
                  },
                  child: const Text("No"),
                ),
              ],
            );
          },
        );
        setState(() {});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Notes"),
          actions: [
                const SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  child: const Icon(Icons.refresh),
                  onTap: _loadData,
                ),
                const SizedBox(
                  width: 15,
                ),
              ] +
              <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleMoreOptions,
                  itemBuilder: (BuildContext context) {
                    return {(_showOnlyUnArchived ? "Show all notes" : "Do not show archived"), 'Delete all notes'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
        ),
        body: _isLoading
            ? const Center(
                child: Text("Loading.."),
              )
            : NotesStore.notes.where((e) => _showOnlyUnArchived ? e.noteStatus != "ARCHIVED" : true).isEmpty
                ? const Center(
                    child: Text(
                      "No notes available to display..\n"
                      "Click the + button and proceed to add notes..",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView(
                    children: NotesStore.notes
                        .where((e) => _showOnlyUnArchived ? e.noteStatus != "ARCHIVED" : true)
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotePage(
                                      noteInEditing: e.copy(),
                                    ),
                                  ),
                                ).then((value) => setState(() {}));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                child: Slidable(
                                  enabled: true,
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      buildSlidableDeleteAction(e),
                                      buildSlidableArchiveAction(e),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      buildSlidableArchiveAction(e),
                                      buildSlidableDeleteAction(e),
                                    ],
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: e.color,
                                    ),
                                    child: ListTile(
                                      title: Text(e.title ?? "-"),
                                      subtitle: Text(e.content ?? "-"),
                                      trailing: e.noteStatus == "ARCHIVED" ? const Icon(Icons.archive) : null,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add New Note',
          onPressed: () => _newNoteTapped(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _newNoteTapped(BuildContext context) async {
    var emptyNote = Note(
      id: -1,
      title: "",
      content: "",
      createdMillis: DateTime.now().millisecondsSinceEpoch,
      lastUpdatedMillis: DateTime.now().millisecondsSinceEpoch,
      colorCode: "${Colors.white.value}",
    );
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotePage(
          noteInEditing: emptyNote,
        ),
      ),
    ).then((value) => setState(() {}));
    setState(() {});
  }

  SlidableAction buildSlidableArchiveAction(Note eachNote) {
    return SlidableAction(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      onPressed: (context) async {
        if (eachNote.noteStatus == "ARCHIVED") {
          eachNote.status = "ACTIVE";
        } else {
          eachNote.status = "ARCHIVED";
        }
        await NotesStore.updateNotes(eachNote);
        setState(() {});
      },
      backgroundColor: eachNote.noteStatus == "ARCHIVED" ? Colors.blue : Colors.cyan,
      icon: eachNote.noteStatus == "ARCHIVED" ? Icons.archive_outlined : Icons.archive,
      label: eachNote.noteStatus == "ARCHIVED" ? "Unarchive" : 'Archive',
    );
  }

  SlidableAction buildSlidableDeleteAction(Note eachNote) {
    return SlidableAction(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      onPressed: (context) async {
        showDialog(
          context: _scaffoldKey.currentContext!,
          builder: (dialogueContext) {
            return AlertDialog(
              content: const Text("Are you sure you want to delete the notes"),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogueContext);
                    await NotesStore.deleteNotes(eachNote);
                    setState(() {});
                  },
                  child: const Text("YES"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogueContext);
                  },
                  child: const Text("No"),
                ),
              ],
            );
          },
        );
        setState(() {});
      },
      backgroundColor: Colors.red,
      icon: Icons.delete,
      label: 'Delete',
    );
  }
}
