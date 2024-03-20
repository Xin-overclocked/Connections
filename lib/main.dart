import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(100, 50),
  foregroundColor: Colors.black,
  elevation: 0,
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50))),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor-Mentee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: 'Roboto',
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
            colors: [Colors.blue.shade400, Colors.blue.shade900],
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
                    'Login',
                    style: TextStyle(
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
                          color: Colors.blue,
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
    'mentor-mentee',
    'find connections & events',
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
        title: Text(
          _appBarTitles[_selectedIndex],
          style: TextStyle(
            fontFamily: 'Madimi',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
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

class EnrollButton extends StatefulWidget {
  const EnrollButton({Key? key}) : super(key: key);
  @override
  State<EnrollButton> createState() => _EnrollButtonState();
}

class _EnrollButtonState extends State<EnrollButton> {
  bool isButtonActive = true;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isButtonActive
          ? () {
              setState(() => isButtonActive = false);
              // Handle enrollment logic (potentially using setState)
              // You can optionally show a snackbar or dialog here
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isButtonActive ? Colors.white : Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
      ),
      child: Text(
        isButtonActive ? 'Enroll' : 'Enrolled',
        style: TextStyle(
          color: isButtonActive ? Colors.black : Colors.grey, // Adjust colors
          fontSize: 16,
        ),
      ),
    );
  }
}

class RoomDetails {
  final String title;
  final String dateTime;
  final String details;

  const RoomDetails({
    required this.title,
    required this.dateTime,
    required this.details,
  });
}

// Dummy room details
final List<RoomDetails> dummyRoomDetails = [
  RoomDetails(
    title: 'Room 1',
    dateTime: 'March 20, 2024 10:00 AM',
    details:
        'This is a meeting room for team A. The agenda includes project brainstorming and task allocation.',
  ),
  RoomDetails(
    title: 'Room 2',
    dateTime: 'March 21, 2024 11:00 AM',
    details:
        'This is a client meeting room. The agenda includes presenting our latest proposal and discussing next steps.',
  ),
];

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
                20.0, 10.0, 20.0, 10.0), // Adjust padding as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Add notification and profile icons here (optional)
              ],
            ),
          ),
          // Room list
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align at top
              children: dummyRoomDetails
                  .map((room) => Column(
                        children: [
                          RoomTile(
                            roomDetails: room,
                            width: MediaQuery.of(context).size.width * 0.95,
                            showEnrollButton: room.title ==
                                'Room 1', // Set flag based on title
                          ),
                          SizedBox(height: 20), // Add space between RoomTiles
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomTile extends StatefulWidget {
  final RoomDetails roomDetails; // Use the RoomDetails class
  final double width; // New property to control the width of the card
  final bool showEnrollButton; // Flag to control button visibility

  const RoomTile({
    required this.roomDetails,
    required this.width,
    required this.showEnrollButton,
  });

  @override
  _RoomTileState createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  bool _isEnrolled = false; // Internal state for enrollment

  @override
  void initState() {
    super.initState();
    _isEnrolled = widget.showEnrollButton
        ? false
        : true; // Set initial enrollment based on flag
  }

  void _toggleEnrollment() {
    setState(() {
      _isEnrolled = !_isEnrolled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  widget.roomDetails.title), // Access details from RoomDetails
              content: Text(widget.roomDetails.details),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: widget.width, // Set width of the card
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomDetails.title, // Access title from RoomDetails
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              widget.roomDetails.dateTime, // Access dateTime from RoomDetails
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10), // Add space before button
            if (widget.showEnrollButton) // Only show for Room 1
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  EnrollButton(
                      // enrolled: _isEnrolled,
                      ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
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
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the chat screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(person)),
                  );
                },
                child: Text('Message'),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Email: ${person.email}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Hashtag: ${person.hashtag}',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Wrap(
              spacing: 4.0, // gap between lines
              children: <Widget>[
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('C', style: TextStyle(color: Colors.white))),
                  label: Text('Cupcake'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.cyanAccent,
                      child:
                          Text('D', style: TextStyle(color: Colors.black45))),
                  label: Text('Donut'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Text('E', style: TextStyle(color: Colors.white))),
                  label: Text('Eclair'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.yellowAccent,
                      child:
                          Text('F', style: TextStyle(color: Colors.black45))),
                  label: Text('Froyo'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text('G', style: TextStyle(color: Colors.white))),
                  label: Text('Gingerbread'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text('H', style: TextStyle(color: Colors.white))),
                  label: Text('Honeycomb'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child:
                          Text('I', style: TextStyle(color: Colors.black45))),
                  label: Text('Ice cream Sandwich'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.deepOrangeAccent,
                      child: Text('J', style: TextStyle(color: Colors.white))),
                  label: Text('Jelly Bean'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      child: Text('K', style: TextStyle(color: Colors.white))),
                  label: Text('Kit Kat'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.tealAccent,
                      child:
                          Text('L', style: TextStyle(color: Colors.black45))),
                  label: Text('Lollipop'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.amberAccent,
                      child: Text('M', style: TextStyle(color: Colors.white))),
                  label: Text('Marshmallow'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      child: Text('N', style: TextStyle(color: Colors.white))),
                  label: Text('Nougat'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('O', style: TextStyle(color: Colors.white))),
                  label: Text('Oreo'),
                  backgroundColor: Colors.white,
                ),
                Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.greenAccent,
                      child:
                          Text('P', style: TextStyle(color: Colors.black45))),
                  label: Text('Pie'),
                  backgroundColor: Colors.white,
                ),
              ],
            )
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
  bool cardsDisplayed = false; // Track card display state

  @override
  void initState() {
    super.initState();
    cardsDisplayed = true; // Initialize to false
    hasCards = people.length; // Set initial hasCards value
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.75,
          child: cardsDisplayed
              ? Stack(
                  // Use Stack for layering
                  children: [
                    // Background container with slight offset for shadow effect
                    Container(
                        decoration: hasCards > 0
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Match card corners
                                boxShadow: [
                                  BoxShadow(
                                    // Define the shadow
                                    color: Colors.grey.withOpacity(
                                        0.3), // Shadow color (optional)
                                    offset: Offset(
                                        5.0, 5.0), // Shadow offset (optional)
                                    blurRadius:
                                        10.0, // Shadow blur radius (optional)
                                  ),
                                ],
                              )
                            : BoxDecoration()),
                    AppinioSwiper(
                      cardCount:
                          people.length, // Use the length of the people list
                      swipeOptions: const SwipeOptions.all(),
                      onSwipeEnd:
                          (int index, int index2, SwiperActivity direction) {
                        setState(() {
                          hasCards--; // Decrement hasCards
                          cardsDisplayed =
                              hasCards > 0; // Mark cards as displayed
                        });
                      },
                      cardBuilder: (BuildContext context, int index) {
                        final person =
                            people[index]; // Get the Person object at index
                        return Container(
                          alignment: Alignment.center, // Center the content
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255,
                                  1), // Maintain container color),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            // Arrange text vertically
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content within column
                            children: [
                              CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor: Colors.red,
                                  backgroundImage: person.image),
                              Text(
                                person.name, // Display the person's name
                                style: TextStyle(
                                  // Customize text style (optional)
                                  fontFamily: 'Pacifico',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  height: 10.0), // Add spacing between lines
                              SizedBox(
                                height: 20.0,
                                width: 150.0,
                                child: Divider(
                                  color: const Color.fromARGB(255, 39, 41, 41),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Display email and hashtag
                                children: [
                                  Text(
                                    'Email: ',
                                    style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      color: Colors
                                          .grey, // Differentiate label text
                                      letterSpacing: 2.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(person.email),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      5.0), // Add spacing between email and hashtag
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // Display hashtag
                                children: [
                                  Text(
                                    'Hashtag: ',
                                    style: TextStyle(
                                      fontFamily: 'Source Sans Pro',
                                      color: Colors
                                          .grey, // Differentiate label text
                                      letterSpacing: 2.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(person.hashtag),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                                width: 150.0,
                                child: Divider(
                                  color: const Color.fromARGB(255, 39, 41, 41),
                                ),
                              ),

                              ElevatedButton(
                                  style: buttonPrimary,
                                  onPressed: () {},
                                  child: Text('Connect Now'))
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )
              : Center(child: Text('No contacts to display')),
        ),
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

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = 'Low Jia Xin';
    String firstLetter = userName.isNotEmpty ? userName[0] : '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
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
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Username: jiaxin123',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: jiaxin@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  'Hashtag: #UM',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for editing profile
                  },
                  child: Text('Edit Profile'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for editing profile
                  },
                  child: Text('Add Bio'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for editing profile
                  },
                  child: Text('Add Hashtag'),
                ),
                SizedBox(height: 20),
                Wrap(
                  spacing: 4.0, // gap between lines
                  children: <Widget>[
                    Chip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child:
                              Text('C', style: TextStyle(color: Colors.white))),
                      label: Text('Cupcake'),
                      backgroundColor: Colors.white,
                    ),
                    Chip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.cyanAccent,
                          child: Text('D',
                              style: TextStyle(color: Colors.black45))),
                      label: Text('Donut'),
                      backgroundColor: Colors.white,
                    ),
                    Chip(
                      avatar: CircleAvatar(
                          backgroundColor: Colors.indigoAccent,
                          child:
                              Text('E', style: TextStyle(color: Colors.white))),
                      label: Text('Eclair'),
                      backgroundColor: Colors.white,
                    ),
                  ],
                )
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

final AssetImage johnDoeImage = AssetImage(
    '/Users/lowyinyin/Documents/JX/VHack_Interview_Assistant-1/images/profile.jpeg');
final AssetImage aliceSmithImage = AssetImage(
    '/Users/lowyinyin/Documents/JX/VHack_Interview_Assistant-1/images/profile1.jpeg');

List<Person> people = [
  Person(
    'John Doe',
    'john@example.com',
    '#UKM',
    johnDoeImage,
    [
      Message('Hello!', false),
      Message('How are you?', false),
      Message('I\'m fine, thank you!', true),
    ],
  ),
  Person(
    'Alice Smith',
    'alice@example.com',
    '#USM',
    aliceSmithImage,
    [
      Message('Hi!', false),
      Message('Nice to meet you!', false),
    ],
  ),
  Person(
    'Bob Johnson',
    'bob@example.com',
    '#UM',
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
