import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/component/drawer.dart';
import 'package:notes_app/component/note_tile.dart';
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
  /*  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Note'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
              hintText: "Enter Note", hintStyle: TextStyle(color: Colors.grey)),
          style: const TextStyle(color: Colors.black),
          autofocus: true,
        ),
        actions: [
          //create button
          MaterialButton(
            child: const Text("Create"),
            onPressed: () {
              //add to db
              context.read<NoteDatabase>().addNote(textController.text);
              //clear controler
              textController.clear();

              //pop dialog box
              Navigator.pop(context);
            },
          ),
          //cancel button
          MaterialButton(
            child: const Text("Cancel"),
            onPressed: () {
              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
          ),
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Update Note'),
        content: TextField(controller: textController),
        actions: [
          //update button
          MaterialButton(
            child: const Text("Update"),
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
          ),
          //cancel button
          MaterialButton(
            child: const Text("Cancel"),
            onPressed: () {
              //clear controller
              textController.clear();
              //pop dialog box
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  //delete note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  } */

  // Clear text controller
  void clearTextController() {
    textController.clear();
  }

  // Creating a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Note'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: "Enter Note",
              hintStyle: TextStyle(color: Colors.grey),
            ),
            autofocus: true,
          ),
          actions: _buildDialogActions(() {
            context.read<NoteDatabase>().addNote(textController.text);
            clearTextController();
            Navigator.pop(context);
          }),
        );
      },
    );
  }

  // Read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // Update note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text('Update Note'),
          content: TextField(
            controller: textController,
            autofocus: true,
          ),
          actions: _buildDialogActions(() {
            context
                .read<NoteDatabase>()
                .updateNote(note.id, textController.text);
            clearTextController();
            Navigator.pop(context);
          }),
        );
      },
    );
  }

  // Delete note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  // Build dialog actions
  List<Widget> _buildDialogActions(VoidCallback onConfirm) {
    return [
      MaterialButton(
        onPressed: onConfirm,
        child: const Text(
          "Confirm",
          //style: TextStyle(color: Colors.red),
        ),
      ),
      MaterialButton(
        child: const Text("Cancel"),
        onPressed: () {
          clearTextController();
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();
    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //backgroundColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //heading
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Notes',
              style: TextStyle(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          //list of notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];

                //list title ui
                return NoteTile(
                  key: ValueKey(note.id),
                  text: note.text,
                  onEditPressed: () => updateNote(note),
                  onDeletePressed: () => deleteNote(note.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
