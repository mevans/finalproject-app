import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Note extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onSubmit;

  const Note({
    Key key,
    this.initialValue,
    this.onSubmit,
  }) : super(key: key);

  _onSubmit(FormGroup form) {
    onSubmit(form.control('note').value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ReactiveFormBuilder(
          form: () => FormGroup({
            'note': FormControl(value: initialValue),
          }),
          builder: (ctx, form, child) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 1,
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
                          onPressed: () => _onSubmit(form),
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
                      child: ReactiveTextField(
                        formControlName: 'note',
                        maxLines: 8,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
