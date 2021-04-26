import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/models/http_exception.dart';
import 'package:skivvy_app/providers/plans.dart';
import 'package:skivvy_app/screens/calendar_screen.dart';
import 'package:skivvy_app/store/size_config.dart';
import 'package:skivvy_app/widgets/default_button.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  static const routeName = '/add-event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Event',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: EventForm(),
    );
  }
}

class EventForm extends StatefulWidget {
  const EventForm({
    Key key,
  }) : super(key: key);

  @override
  EventFormState createState() => EventFormState();
}

class EventFormState extends State<EventForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> _eventData = {'title': '', 'note': ''};
  DateTime dueDate;
  DateTime _dateTime;
  var _isLoading = false;

  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: getPropScreenHeight(30)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                  hintText: 'Type the title of the vent',
                ),
                onSaved: (value) {
                  _eventData['title'] = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                  hintText: 'Type some note or details',
                ),
                onSaved: (value) {
                  _eventData['note'] = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                keyboardType: TextInputType.datetime,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2022),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                    });
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Date",
                  //hintText: _dateTime == null ? 0 : ' yyyy / mm / dd',
                ),
                onSaved: (value) {
                  dueDate = DateTime.tryParse(value);
                },
              ),
            ),
            SizedBox(height: getPropScreenHeight(20)),
            DefaultBtn(
              text: 'Add',
              click: _submit,
            )
          ],
        ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Plans>(context, listen: false)
          .addEvent(_eventData['title'], _eventData['note'], dueDate);
      Navigator.pushNamed(context, CalendarScreen.routeName);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('User already exist')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('User does not exist')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('Invalid password')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Error! Adding event failed';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
