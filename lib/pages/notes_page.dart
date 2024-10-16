import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //text controller to access what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //fetch the existing notes at the startup
    readNotes();
  }

  //creating a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //create button
          MaterialButton(
            onPressed: () {
              //add to db
              context.read<NoteDatabase>().addNote(textController.text);

              //clear controler
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Create"),
          )
        ],
      ),
    );
  }

  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update note
  void updateNote(Note note) {
    //preFill the current note text
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
            child: const Text("Update"),
          )
        ],
      ),
    );
  }

  //delete note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();
    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];

          //list title ui
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //eddit button
                IconButton(
                  onPressed: () => updateNote(note),
                  icon: const Icon(Icons.edit),
                ),
                //delete button
                IconButton(
                  onPressed: () => deleteNote(note.id),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
