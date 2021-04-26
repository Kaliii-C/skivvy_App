import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/providers/plans.dart';
import 'package:skivvy_app/screens/add_event_screen.dart';
import 'package:skivvy_app/theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:skivvy_app/models/plan.dart';
import 'package:skivvy_app/utils/calendar_utils.dart';

import 'dart:collection';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;

  List<Plan> userPlans;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      userPlans = await Provider.of<Plans>(context, listen: false).fetchPlans();
      print("from calendar screen: $userPlans");

      print(userPlans);

      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar', style: GoogleFonts.poppins()),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddEventScreen.routeName);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                /* ListView.builder(
                  itemCount: userPlans.length,
                  itemBuilder: (context, index) {
                    Plan plans = userPlans[index];
                    return ListTile(
                      leading: Text(DateFormat('yyyy-MM-dd – kk:mm')
                          .format(plans.dueDate)),
                      title: Text(
                        plans.title,
                        style: GoogleFonts.poppins(),
                      ),
                      subtitle: Text(
                        plans.note,
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  },
                ) */
              ]),
        ));
  }
}

/* class CalendarScreen extends StatefulWidget {
  static const routeName = '/calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  List<Plan> userPlans;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      userPlans = await Provider.of<Plans>(context, listen: false).fetchPlans();
      print("from calendar screen: $userPlans");

      print(userPlans);

      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calendar',
            style: GoogleFonts.poppins(textStyle: TextStyle()),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddEventScreen.routeName);
              },
            ),
          ],
        ),
        body: Column(children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              //padding: EdgeInsets.all(20),
              //decoration: BoxDecoration(
              //borderRadius: BorderRadius.only(
              //topLeft: Radius.circular(40),
              //topRight: Radius.circular(40)),
              //color: Colors.white),
              child: Container(
                  child: SingleChildScrollView(
                      child: ListView.builder(
                          itemCount: null == userPlans ? 0 : userPlans.length,
                          itemBuilder: (context, index) {
                            Plan plan = userPlans[index];
                            return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                    leading: Text(
                                      plan.dueDate.toString(),
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: skivvyAccentColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    title: Text(
                                      plan.title,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: skivvyAccentColor)),
                                    ),
                                    subtitle: Text(plan.note,
                                        style: GoogleFonts.poppins(
                                            textStyle:
                                                TextStyle(color: textColor)))));
                          }))),
            ),
          ),
        ]));
  }
}
 */
