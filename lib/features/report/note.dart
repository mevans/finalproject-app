import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  final String note;
  final ValueChanged<String> onNoteUpdate;

  const Note({Key key, this.note, this.onNoteUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 2,
              color: Theme.of(context).accentColor,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notes",
                        style: TextStyle(fontSize: 32),
                      ),
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Done"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white54, width: 1.5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      initialValue: note,
                      onChanged: onNoteUpdate,
                      maxLines: 8,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
