import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:provider/provider.dart';
import 'package:skivvy_app/models/user_list.dart';
import 'package:skivvy_app/providers/lists.dart';
import 'package:skivvy_app/theme.dart';

/* class ListsScreen extends StatelessWidget {
  static const routeName = '/lists';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lists',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
} */

class ListsScreen extends StatefulWidget {
  static const routeName = '/lists';
  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  List<String> cards = ["ToDo", "Grocery"];
  List<List<String>> childres = [
    ["ToDo 1", "ToDo 2"],
    ["Butter", "Milk", "Bread"],
  ];
  //List<ListElement> cards = userLists;
  var _isInit = true;
  var _isLoading = false;
  List<ListElement> userLists;
  Lists list;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      list = await Provider.of<ListData>(context, listen: false).fetchList();
      print("form screen: $list");
      userLists = list.lists;
      print(userLists.length);
      List<Item> userTasks;
      setState(() {
        _isLoading = true;
      });

      //list = userLists.lists as List;
      //print("userList: $userLists");
      //print("list: $list");

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
          "Lists",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: _buildBody(),
    );
  }

  TextEditingController _cardTextController = TextEditingController();
  TextEditingController _taskTextController = TextEditingController();

  _showAddCard() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Card",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Card Title"),
                    controller: _cardTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCard(_cardTextController.text.trim());
                    },
                    child: Text("Add Card"),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCard(String text) {
    cards.add(text);
    childres.add([]);
    _cardTextController.text = "";
    setState(() {});
  }

  _showAddCardTask(int index) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Card task",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Task Title"),
                    controller: _taskTextController,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _addCardTask(index, _taskTextController.text.trim());
                    },
                    child: Text("Add Task"),
                  ),
                )
              ],
            ),
          );
        });
  }

  _addCardTask(int index, String text) {
    childres[index].add(text);
    _taskTextController.text = "";
    setState(() {});
  }

  _handleReOrder(int oldIndex, int newIndex, int index) {
    var oldValue = childres[index][oldIndex];
    childres[index][oldIndex] = childres[index][newIndex];
    childres[index][newIndex] = oldValue;
    setState(() {});
  }

  _buildBody() {
    List<ListElement> cards = userLists;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: cards.length + 1,
      itemBuilder: (context, index) {
        ListElement userCards = cards[index];
        if (index == cards.length)
          return _buildAddCardWidget(userCards.title);
        else
          return _buildCard(context, index);
      },
    );
  }

  Widget _buildAddCardWidget(context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            _showAddCard();
          },
          child: Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.add,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text("Add Card"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCardTaskWidget(context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          _showAddCardTask(index);
        },
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
            ),
            SizedBox(
              width: 16.0,
            ),
            Text("Add Card Task"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    // return Container(
    //         width: 300.0,
    //   child: ,
    // );
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: 300.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    cards[index],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: DragAndDropList<String>(
                      childres[index],
                      itemBuilder: (BuildContext context, item) {
                        return _buildCardTask(
                            index, childres[index].indexOf(item));
                      },
                      onDragFinish: (oldIndex, newIndex) {
                        _handleReOrder(oldIndex, newIndex, index);
                      },
                      canBeDraggedTo: (one, two) => true,
                      dragElevation: 8.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                print(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                if (data['from'] == index) {
                  return;
                }
                childres[data['from']].remove(data['string']);
                childres[index].add(data['string']);
                print(data);
                setState(() {});
              },
              builder: (context, accept, reject) {
                print("--- > $accept");
                print(reject);
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCardTask(int index, int innerIndex) {
    return Container(
      width: 300.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Draggable<dynamic>(
        feedback: Material(
          elevation: 5.0,
          child: Container(
            width: 284.0,
            padding: const EdgeInsets.all(16.0),
            color: skivvySecondaryColor,
            child: Text(
              childres[index][innerIndex],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        childWhenDragging: Container(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: skivvySecondaryColor,
          child: Text(
            childres[index][innerIndex],
            style:
                GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
          ),
        ),
        data: {"from": index, "string": childres[index][innerIndex]},
      ),
    );
  }
}
