import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notesapp/model/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier{
  static late Isar isar;

//INITIALIZE DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

 //list of notes
 final List<Note> currentNotes=[]; 

//CREATE - a note and save to db
Future<void> addNote(String textFromUser)async{
  //create a note object
  final newNote=Note()..text=textFromUser;
  //save to db
  await isar.writeTxn(() => isar.notes.put(newNote));
  fetchNotes();
  //re read from db

}

//READ
Future<void> fetchNotes()async{
List<Note>fetchedNots=await isar.notes.where().findAll();
currentNotes.clear();
currentNotes.addAll(fetchedNots);
notifyListeners();
}

//UPDATE
Future<void>updateNotes(int id,String newText)async{
  final existingNote=await isar.notes.get(id);
  if(existingNote!=null){
    existingNote.text=newText;
    await isar.writeTxn(() => isar.notes.put(existingNote));
    //important to call fetch notes,otherwise list is not updated after update
    await fetchNotes();
  }
 
}

//DELETE
Future<void>deleteNotes(int id)async{
  await isar.writeTxn(() => isar.notes.delete(id));
  await fetchNotes();
}
}
