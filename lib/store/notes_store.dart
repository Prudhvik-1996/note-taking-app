import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_taking_app/modal/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesStore {
  static List<Note> notes = [];

  static Future<void> initNotes() async {
    await getAllNotes();
  }

  static Future<List<Note>> getAllNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJsonString = prefs.getString('notes');
    notes = <Note>[];
    if (notesJsonString != null) {
      notes = (json.decode(notesJsonString) as List).map((data) => Note.fromJson(data)).toList();
    }
    notes.sort(
      (b, a) => (a.id ?? 0).compareTo((b.id ?? 0)),
    );
    return notes;
  }

  static Future<void> addNewNotes(Note note) async {
    debugPrint("Adding new notes: ${json.encode(note.toJson())}");
    note.createdMillis = DateTime.now().millisecondsSinceEpoch;
    note.lastUpdatedMillis = DateTime.now().millisecondsSinceEpoch;
    note.id = notes.length + 1;
    notes.add(note);
    await saveNotes();
  }

  static Future<void> updateNotes(Note note) async {
    debugPrint("Updating notes: ${json.encode(note.toJson())}");
    notes.removeWhere((e) => e.id == note.id);
    notes.add(note);
    await saveNotes();
  }

  static Future<void> deleteNotes(Note note) async {
    debugPrint("Deleting notes: ${json.encode(note.toJson())}");
    notes.removeWhere((e) => e.id == note.id);
    await saveNotes();
  }

  static Future<void> deleteAllNotes() async {
    debugPrint("Deleting all notes");
    notes.clear();
    await saveNotes();
  }

  static Future<void> saveNotes() async {
    String notesJson = json.encode(notes.map((e) => e.toJson()).toList());
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('notes', notesJson);
    await initNotes();
  }
}
