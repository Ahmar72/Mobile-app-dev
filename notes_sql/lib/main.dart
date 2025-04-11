import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(NoteApp());
}

// Note model
class Note {
  final int? id;
  final String content;
  final String dateTime;

  Note({this.id, required this.content, required this.dateTime});

  Map<String, dynamic> toMap() {
    return {'id': id, 'content': content, 'dateTime': dateTime};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      content: map['content'],
      dateTime: map['dateTime'],
    );
  }
}

// Database helper
class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._internal();
  static Database? _db;
  NoteDatabase._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'notes.db');
    _db = await openDatabase(path, version: 1, onCreate: _createDB);
    return _db!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update('notes', note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final result = await db.query('notes', orderBy: 'dateTime DESC');
    return result.map((e) => Note.fromMap(e)).toList();
  }
}

// Main app
class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: NoteHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoteHomePage extends StatefulWidget {
  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  List<Note> _notes = [];
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await NoteDatabase.instance.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _showNoteDialog(BuildContext context, {Note? note}) async {
    if (note != null) {
      _controller.text = note.content;
      _selectedDateTime = DateTime.parse(note.dateTime);
    } else {
      _controller.clear();
      _selectedDateTime = DateTime.now();
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(note == null ? 'Add Note' : 'Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Note'),
              ),
              SizedBox(height: 10),
              TextButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text(_selectedDateTime == null
                    ? 'Pick Date & Time'
                    : _formatDateTime(_selectedDateTime!)),
                onPressed: () => _pickDateTime(context),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                if (_controller.text.trim().isEmpty ||
                    _selectedDateTime == null) return;

                final newNote = Note(
                  id: note?.id,
                  content: _controller.text.trim(),
                  dateTime: _selectedDateTime!.toIso8601String(),
                );

                if (note == null) {
                  await NoteDatabase.instance.insertNote(newNote);
                } else {
                  await NoteDatabase.instance.updateNote(newNote);
                }

                Navigator.pop(context);
                _loadNotes();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _deleteNote(int id) async {
    await NoteDatabase.instance.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Notes'),
        centerTitle: true,
      ),
      body: _notes.isEmpty
          ? Center(child: Text('No notes available.'))
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (_, index) {
          final note = _notes[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            elevation: 4,
            child: ListTile(
              title: Text(note.content),
              subtitle: Text(_formatDateTime(DateTime.parse(note.dateTime))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () => _showNoteDialog(context, note: note),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteNote(note.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
