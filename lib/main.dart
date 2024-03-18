import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentor-Mentee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
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
    'Home',
    'Find Friends & Events',
    'Contact',
    'Messages'
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
            fontWeight: FontWeight.bold,
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 24),
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
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.75,
        child: AppinioSwiper(
          cardCount: 10,
          swipeOptions: const SwipeOptions.all(),
          cardBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              // child: const Text(index.toString()),
              color: CupertinoColors.activeBlue,
            );
          },
        ),
      ),
    )
    );
  }
}

// class ContactWidget extends StatelessWidget {
//   List<Container> cards = [
//     Container(
//       alignment: Alignment.center,
//       child: const Text('1'),
//       color: Colors.blue,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: const Text('2'),
//       color: Colors.red,
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: const Text('3'),
//       color: Colors.purple,
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Flexible(
//         child: CardSwiper(
//           cardsCount: cards.length,
//           cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
//               cards[index],
//         ),
//       ),
//     );
//   }
// }

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

  Person(this.name, this.email, this.hashtag, this.messages);
}

class Message {
  final String text;
  final bool sentByCurrentUser;

  Message(this.text, this.sentByCurrentUser);
}

List<Person> people = [
  Person(
    'John Doe',
    'john@example.com',
    '#UKM',
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
    [
      Message('Hi!', false),
      Message('Nice to meet you!', false),
    ],
  ),
  Person(
    'Bob Johnson',
    'bob@example.com',
    '#UM',
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
    [],
  ),
  Person(
    'Universiti Malaya',
    'um@example.com',
    '#UM',
    [],
  ),
];
