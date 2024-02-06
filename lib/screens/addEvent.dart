import 'package:flutter/material.dart';

class addEvent extends StatefulWidget {
  @override
  State<addEvent> createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  final TextEditingController time = TextEditingController();

  final TextEditingController guest = TextEditingController();

  final TextEditingController date = TextEditingController();

  final TextEditingController name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Event"),
          BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye), label: "View Event")
        ],
      ),
      appBar: AppBar(
        title: Text("Add Events"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          InputDecoration(filled: true, hintText: "Event Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The input should not be empty";
                        }
                        return null;
                      },
                      controller: name,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          focusColor: Colors.white,
                          prefixIcon: Icon(Icons.calendar_today),
                          hintText: "Event Date"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The input should not be empty";
                        }
                        return null;
                      },
                      readOnly: true,
                      controller: date,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            lastDate: DateTime(2100));
                        if (picked != null) {
                          setState(() {
                            date.text = picked
                                .toString()
                                .split(" ")[0]
                                .replaceAll("-", "/");
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      controller: time,
                      decoration:
                          InputDecoration(filled: true, hintText: "Event Time"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The input should not be empty";
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? timePicked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (timePicked != null) {
                          setState(() {
                            time.text = timePicked.format(context);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true, hintText: "Number of guest"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The input should not be empty";
                        }
                        return null;
                      },
                      controller: guest,
                    ),
                    SizedBox(
                      height: 21.0,
                    ),
                    DropdownButton(
                      items: ["Wedding", "Birthday Party", "Conference"]
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          print('Form data validated');
                          _formKey.currentState!.save();
                          print('Form data saved');
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
