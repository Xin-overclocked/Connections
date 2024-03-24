import 'dart:html';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:vhack/screens/Room.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(100, 50),
  backgroundColor: Colors.amber.shade400, // Change the primary color to yellow
  foregroundColor: Colors.white,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Enrollment(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connections',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Madimi',
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade400, Colors.orange.shade300],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Connections',
                    style: TextStyle(
                      fontFamily: 'Madimi',
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Ink(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.orange[300],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    SearchWidget(),
    ContactWidget(),
    MessagesWidget(),
  ];

  List<String> _appBarTitles = [
    'Connections',
    'find connects & events',
    'make connections',
    'messages'
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 0),
          child: Text(
            _appBarTitles[_selectedIndex],
            style: TextStyle(
              fontFamily: "Madimi",
              fontWeight: FontWeight.bold,
              fontSize: 35.0,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            color: Colors.amber,
            icon: Icon(Icons.notifications_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            iconSize: 30.0,
            color: Colors.amber,
            icon: Icon(Icons.account_circle_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_rounded),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'Messages',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Enrollment extends ChangeNotifier {
  bool _isEnrolled = false;

  bool get isEnrolled => _isEnrolled;

  void toggleEnrollment() {
    _isEnrolled = !_isEnrolled;
    notifyListeners();
  }
}

class EnrollButton extends StatelessWidget {
  const EnrollButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enrollment = Provider.of<Enrollment>(context);

    return ElevatedButton(
      onPressed:
          enrollment.isEnrolled ? null : () => enrollment.toggleEnrollment(),
      style: ElevatedButton.styleFrom(
        backgroundColor: enrollment.isEnrolled ? Colors.blue : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
      ),
      child: Text(
        enrollment.isEnrolled ? 'Enrolled' : 'Enroll',
        style: TextStyle(
          fontFamily: 'Madimi',
          color: enrollment.isEnrolled ? Colors.grey : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Maintain Scaffold for overall structure
      body: Column(
        // Use Column for vertical layout
        children: [
          // Title row (optional)
          Container(
            padding: EdgeInsets.fromLTRB(
                20.0, 0.0, 0.0, 30.0), // Adjust padding as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  // Wrap Text and potentially other left-aligned widgets
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        "Welcome, Jia Xin",
                        style: TextStyle(
                          fontFamily: 'Madimi',
                          color: Colors.amber,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Add any other left-aligned widgets here (optional)
                  ],
                ),
              ],
            ),
          ),
          // Room list
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align at top
              children: [
                // RoomTile for Room 1
                RoomTile(
                  roomDetails: dummyRoomDetails[0], // Access Room 1 details
                  width: MediaQuery.of(context).size.width * 0.95,
                  showEnrollButton: true, // Show button for Room 1
                ),

                SizedBox(height: 20), // Add space between RoomTiles
                // RoomTile for Room 2
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Room()),
                    );
                  },
                  child: RoomTile(
                    roomDetails: dummyRoomDetails[1], // Access Room 2 details
                    width: MediaQuery.of(context).size.width * 0.95,
                    showEnrollButton: false, // Show button for Room 2
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoomTile extends StatelessWidget {
  final RoomDetails roomDetails; // Use the RoomDetails class
  final double width; // New property to control the width of the card
  final bool showEnrollButton; // Flag to control button visibility

  const RoomTile({
    required this.roomDetails,
    required this.width,
    required this.showEnrollButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Set width of the card
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.orange
            .shade50, // Set background color to yellow// Optional: Black border
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            offset: Offset(5.0, 5.0), // Shadow offset
            blurRadius: 10.0, // Shadow blur radius
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Text(
            roomDetails.title, // Access title from RoomDetails
            style: TextStyle(
              fontFamily: 'RoundBlack',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            roomDetails.dateTime, // Access dateTime from RoomDetails
            style: TextStyle(
                fontFamily: 'RoundBold', fontSize: 15, color: Colors.grey),
          ),
          SizedBox(height: 10),
          // Add space before button
          if (showEnrollButton) // Only show for Room 1
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EnrollButton(),
              ],
            ),
        ],
      ),
    );
  }
}

class RoomDetails {
  final String title;
  final String dateTime;
  final String details;
  final List<String> hashtags;

  const RoomDetails({
    required this.title,
    required this.dateTime,
    required this.details,
    required this.hashtags,
  });
}

// Dummy room details
final List<RoomDetails> dummyRoomDetails = [
  RoomDetails(
    title: 'Ethical AI and Data Ethics',
    dateTime: 'March 20, 2024 10:00 AM',
    details:
        'This is a meeting room for team A. The agenda includes project brainstorming and task allocation.',
    hashtags: ['AI'], // Hashtags for Room 1
  ),
  RoomDetails(
    title: 'A Brief to Artificial Intelligence',
    dateTime: 'Happening Now...',
    details:
        'This is a client meeting room. The agenda includes presenting our latest proposal and discussing next steps.',
    hashtags: ['AI'], // Hashtags for Room 2
  ),
];

//SearchWidget
class SearchWidget extends StatefulWidget {
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Person> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _search,
            decoration: InputDecoration(
              iconColor: Colors.amber,
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SimpleProfilePage(_searchResults[index])),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(_searchResults[index].name[0]),
                  ),
                  title: Text(
                    _searchResults[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _search(String query) {
    setState(() {
      _searchResults.clear();
      for (Person person in people) {
        if (person.name.toLowerCase().contains(query.toLowerCase())) {
          _searchResults.add(person);
        }
      }
    });
  }
}

class SimpleProfilePage extends StatelessWidget {
  final Person person;

  SimpleProfilePage(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          person.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber, // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.amber,
                child: Text(
                  person.name[0].toUpperCase(),
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                person.name,
                style: TextStyle(
                    fontSize: 20, color: Colors.amber), // Set text color
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: TextButton(
                // Change ElevatedButton to TextButton
                onPressed: () {
                  // Navigate to the chat screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(person)),
                  );
                },
                child: Text(
                  'Message',
                  style: TextStyle(color: Colors.amber), // Set text color
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Email: ${person.email}',
                style: TextStyle(
                    fontSize: 16, color: Colors.amber), // Set text color
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Hashtag: ${person.hashtag}',
                style: TextStyle(
                    fontSize: 16, color: Colors.amber), // Set text color
              ),
            ),
            // Wrap(
            //   spacing: 4.0, // gap between lines
            //   children: <Widget>[
            //     Chip(
            //       avatar: CircleAvatar(
            //         backgroundColor: Colors.orange,
            //         child: Text('C', style: TextStyle(color: Colors.white)),
            //       ),
            //       label: Text('Cupcake'),
            //       backgroundColor: Colors.white,
            //     ),
            //     Chip(
            //       avatar: CircleAvatar(
            //         backgroundColor: Colors.cyanAccent,
            //         child: Text('D', style: TextStyle(color: Colors.black45)),
            //       ),
            //       label: Text('Donut'),
            //       backgroundColor: Colors.white,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatefulWidget {
  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  int hasCards = 0; // Track the number of remaining cards
  List<bool> isConnectedList = []; // Track connection state for each card

  @override
  void initState() {
    super.initState();
    // Calculate the number of cards excluding "Universiti Malaya" and "Universiti Sains Malaysia"
    hasCards = people
        .where((person) =>
            person.name != 'Universiti Malaya' &&
            person.name != 'Universiti Sains Malaysia')
        .length;
    // Initialize isConnectedList with false for each card
    isConnectedList = List<bool>.generate(hasCards, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Filter out the "Universiti Malaya" and "Universiti Sains Malaysia" cards
    final List<Person> displayedPeople = people
        .where((person) =>
            person.name != 'Universiti Malaya' &&
            person.name != 'Universiti Sains Malaysia')
        .toList();

    return CupertinoPageScaffold(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: MediaQuery.of(context).size.height * 0.75,
            child: Stack(
              children: [
                Container(
                  decoration: hasCards > 0
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                            ),
                          ],
                        )
                      : BoxDecoration(),
                ),
                hasCards > 0
                    ? AppinioSwiper(
                        cardCount: displayedPeople.length,
                        swipeOptions: const SwipeOptions.all(),
                        onSwipeEnd:
                            (int index, int index2, SwiperActivity direction) {
                          setState(() {
                            hasCards--;
                          });
                        },
                        cardBuilder: (BuildContext context, int index) {
                          final person = displayedPeople[index];

                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor: Colors.red,
                                  backgroundImage: person.image,
                                ),
                                SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to the profile screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SimpleProfilePage(person)),
                                    );
                                  },
                                  child: Text(
                                    person.name, // Display the person's name
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      // Customize text style (optional)
                                      fontFamily: 'Madimi',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 10),
                                    Text(person.email),
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.back_hand_rounded,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 10),
                                    Text(person.hashtag),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                  style: buttonPrimary,
                                  onPressed: isConnectedList[index]
                                      ? null
                                      : () {
                                          setState(() {
                                            isConnectedList[index] =
                                                true; // Mark as connected
                                          });
                                        },
                                  child: isConnectedList[index]
                                      ? Icon(Icons.check)
                                      : Text('Connect Now'),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('Waiting for next connections...'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (BuildContext context, int index) {
        if (people[index].name != 'Universiti Sains Malaysia' &&
            people[index].name != 'Universiti Malaya') {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(people[index])),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(people[index].name[0]),
              ),
              title: Text(
                people[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Last message: ${people[index].messages.last.text}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> hashtags = []; // Initial empty list of hashtags

  @override
  Widget build(BuildContext context) {
    String userName = 'Low Jia Xin';
    String firstLetter = userName.isNotEmpty ? userName[0] : '';
    final enrollment = Provider.of<Enrollment>(context);

    if (enrollment.isEnrolled) {
      // If enrolled, gather hashtags for the enrolled room
      final enrolledRoom = dummyRoomDetails.firstWhere(
        (room) =>
            room.title ==
            'Ethical AI and Data Ethics', // Change to the desired room title
        orElse: () =>
            RoomDetails(title: '', dateTime: '', details: '', hashtags: []),
      );

      hashtags = enrolledRoom.hashtags;
    } else {
      // If not enrolled, reset hashtags
      hashtags = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Madimi',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text(
                firstLetter.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'Madimi', fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                      fontFamily: 'Madimi',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Username: jiaxin123',
                  style: TextStyle(
                      fontFamily: 'Madimi', fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: jiaxin@example.com',
                  style: TextStyle(
                      fontFamily: 'Madimi', fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  'Hashtags:', // Displaying hashtags
                  style: TextStyle(
                      fontFamily: 'Madimi', fontSize: 16, color: Colors.grey),
                ),
                // Display hashtags dynamically
                Wrap(
                  spacing: 4.0,
                  children: hashtags
                      .map((hashtag) => Chip(
                            label:
                                Text('#$hashtag'), // Display hashtags as chips
                          ))
                      .toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for editing profile
                  },
                  child: Text('Edit Profile'),
                ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add functionaliy for editing profile
                //   },
                //   child: Text('Add Bio'),
                // ),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add functionality for editing profile
                //   },
                //   child: Text('Add Hashtag'),
                // ),
                // SizedBox(height: 20),
                // // Button to add hashtags
                // ElevatedButton(
                //   onPressed: () {
                //     // Add functionality to add hashtags
                //   },
                //   child: Text('Add Hashtag'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'No Notification',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Person person;

  ChatScreen(this.person);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.person.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'View Profile':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SimpleProfilePage(widget.person)),
                  );
                case 'Video Call':
                  // Implement video call functionality
                  break;
                case 'Report':
                  // Implement report functionality
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'View Profile',
                child: Text('View Profile'),
              ),
              PopupMenuItem<String>(
                value: 'Video Call',
                child: Text('Video Call'),
              ),
              PopupMenuItem<String>(
                value: 'Report',
                child: Text('Report'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.person.messages.length,
              itemBuilder: (BuildContext context, int index) {
                Message message = widget.person.messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.sentByCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: message.sentByCurrentUser
                            ? Colors.blue[200]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(message.text),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_textController.text.isNotEmpty) {
                    setState(() {
                      widget.person.messages
                          .add(Message(_textController.text, true));
                      _textController.clear();
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  final String name;
  final String email;
  final String hashtag;
  final List<Message> messages;
  final ImageProvider image;

  Person(this.name, this.email, this.hashtag, this.image, this.messages);
}

class Message {
  final String text;
  final bool sentByCurrentUser;

  Message(this.text, this.sentByCurrentUser);
}

final AssetImage johnDoeImage = AssetImage('assets/profile.jpeg');
final AssetImage aliceSmithImage = AssetImage('assets/profile1.png');

List<Person> people = [
  Person(
    'John Doe',
    'john@example.com',
    '#AI #UKM',
    johnDoeImage,
    [
      Message('Hello!', false),
      Message('How are you?', false),
      Message('I\'m fine, thank you!', true),
    ],
  ),
  Person(
    'Eve Johnson',
    'eve@example.com',
    '#UM',
    johnDoeImage,
    [
      Message('Hi there!', false),
      Message('How are you?', false),
      Message('I\'m doing great, thanks!', true),
    ],
  ),
  Person(
    'Alice Smith',
    'alice@example.com',
    '#AI #USM',
    aliceSmithImage,
    [
      Message('Hi!', false),
      Message('Nice to meet you!', false),
    ],
  ),
  Person(
    'Bob Johnson',
    'bob@example.com',
    '#AI #UM',
    aliceSmithImage,
    [
      Message('Hello!', false),
      Message('I\'m doing great, thanks!', false),
      Message('How about you?', true),
    ],
  ),
  Person(
    'Universiti Sains Malaysia',
    'usm@example.com',
    '#USM',
    aliceSmithImage,
    [],
  ),
  Person(
    'Universiti Malaya',
    'um@example.com',
    '#UM',
    aliceSmithImage,
    [],
  ),
];
