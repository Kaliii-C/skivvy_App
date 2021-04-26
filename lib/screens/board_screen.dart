import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/models/plan.dart';
import 'package:skivvy_app/providers/plans.dart';

class BoardScreen extends StatelessWidget {
  static const routeName = '/board';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Board',
          style: GoogleFonts.poppins(),
        ),
      ),
      /*  body: FutureBuilder<UserPlans>(
        future: Provider.of<Plans>(context, listen: false).fetchPlans(),
        builder: (context, snapshot) {
          final eventData = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: eventData.plans.length,
              itemBuilder: (context, index) {
                final userEvents = eventData.plans[index];
                return Text(userEvents.title);
              },
            );
          }
        },
      ), */
    );
  }
}
