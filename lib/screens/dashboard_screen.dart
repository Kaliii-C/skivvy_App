import 'package:flutter/material.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:skivvy_app/models/screen_options.dart';
import 'package:skivvy_app/screens/add_event_screen.dart';
import 'package:skivvy_app/screens/calendar_screen.dart';
import 'package:skivvy_app/screens/lists_screen.dart';
import 'package:skivvy_app/screens/mates_screen.dart';
import 'package:skivvy_app/widgets/dashboard_options.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Option> loadOptions = [
    Option(
      id: 'o1',
      title: 'Calendar',
      icon: Image.asset("assets/icons/calendar.png", fit: BoxFit.cover),
    ),
    Option(
      id: 'o2',
      title: 'Lists',
      icon: Image.asset("assets/icons/list.png", fit: BoxFit.cover),
    ),
    Option(
      id: 'o3',
      title: 'My Mates',
      icon: Image.asset("assets/icons/my_mates.png", fit: BoxFit.cover),
    ),
    Option(
      id: 'o4',
      title: 'My Board',
      icon: Image.asset("assets/icons/my_board.png", fit: BoxFit.cover),
    ),
  ];

  void _navigateTo(String screen) {
    switch (screen) {
      case "calendar":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalendarScreen()),
        );
        break;
      case "back":
        Navigator.pop(context);
        break;

      case "lists":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListsScreen()),
        );
        break;
      case "back":
        Navigator.pop(context);
        break;

      case "mates":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MatesScreen()),
        );
        break;
      case "back":
        Navigator.pop(context);
        break;

      case "add_event":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEventScreen()),
        );
        break;
      case "back":
        Navigator.pop(context);
        break;
      default:
        print("Unknown screen: $screen");
    }
  }

  @override
  void initState() {
    super.initState();
    setupAlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadOptions.length,
        itemBuilder: (ctx, i) => DashboardOptions(
            loadOptions[i].id, loadOptions[i].title, loadOptions[i].icon),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }

  setupAlan() {
    AlanVoice.addButton(
        "3ea191277139f6c05f1813a498b661e42e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "calendar":
        _navigateTo(response["route"]);
        break;
      case "lists":
        _navigateTo(response["route"]);
        break;
      case "mates":
        _navigateTo(response["route"]);
        break;
      case "add_event":
        _navigateTo(response["route"]);
        debugPrint("${response}");
        break;
      default:
        debugPrint("Unknown command: ${response}");
    }
  }
}

/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadOptions.length,
        itemBuilder: (ctx, i) => DashboardOptions(
            loadOptions[i].id, loadOptions[i].title, loadOptions[i].icon),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
} */
