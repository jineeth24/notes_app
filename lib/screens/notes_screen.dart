import 'package:flutter/material.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/model/notes_database.dart';
import 'package:notesapp/widgets/note_tile.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_drawer.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
//text controller
  final noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //on app startup fetch existing notes
    readNote();
  }

//create note
  void creatNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: noteController,
              ),
              actions: [
                //cancel button
                MaterialButton(
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
                //create button
                MaterialButton(
                  onPressed: () {
                    //create note
                    context.read<NoteDatabase>().addNote(noteController.text);
                    //clear controller
                    noteController.clear();
                    //pop
                    Navigator.pop(context);
                  },
                  child: const Text("Create"),
                ),
              ],
            ));
  }

//read note
  void readNote() {
    //
    context.read<NoteDatabase>().fetchNotes();
  }

//update note
  void updateNote(Note note) {
    //prefill the field
    noteController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("update note"),
              content: TextField(controller: noteController),
              actions: [
                //cancal button
                MaterialButton(onPressed: () {
                  Navigator.pop(context);
                }),
                //update button
                MaterialButton(
                  onPressed: () {
                    context
                        .read<NoteDatabase>()
                        .updateNotes(note.id, noteController.text);
                    noteController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("update"),
                )
              ],
            ));
  }

//delete note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNotes(id);
  }

  @override
  Widget build(BuildContext context) {
    //context.watch to rebuild whenever changes occurs,
    //and for the first build,other wise screen is build without list, need refresh to see list
    //but this leads to entire screen rebuild,use consumer instead


    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text("N O T E S",
              style: GoogleFonts.dmSerifText(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 25,
              )),
          centerTitle: true,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        //drawer
        drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: creatNote,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 80,),
              Expanded(
                child: Consumer<NoteDatabase>(builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.currentNotes.length,
                    itemBuilder: (context, index) {
                      //get individual notes
              
                      final note = value.currentNotes[index];
                      return NoteTile(
                        text: note.text,
                        onEditPressed: ()=>updateNote(note),
                        onDeletePressed: () => deleteNote(note.id),
                      );
                      // return ListTile(
                      //   title: Text(note.text),
                      //   trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      //     //edit button
                      //     IconButton(
                      //       onPressed: () => updateNote(note),
                      //       icon: const Icon(Icons.edit),
                      //     ),
              
                      //     //   //delete button
                      //     IconButton(
                      //       onPressed: () => deleteNote(note.id),
                      //       icon: const Icon(Icons.delete),
                      //     ),
                      //   ]),
                      // );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
