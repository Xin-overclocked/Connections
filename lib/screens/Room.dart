import 'package:flutter/material.dart';
import 'package:vhack/main.dart';

class Room extends StatefulWidget {
  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  List<Person> audienceList = [];
  bool micRequested = false;

  @override
  void initState() {
    super.initState();
    audienceList.add(people.firstWhere(
      (person) => person.name == 'Bob Johnson',
      orElse: () => Person('', '', '', AssetImage(''), []),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Person> coordinators = people
        .where((person) =>
            person.name == 'John Doe' || person.name == 'Alice Smith')
        .toList();

    // Placeholder image for the presented slides widget
    AssetImage slideImage = AssetImage('./assets/profile.jpeg');

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
          child: Text(
            dummyRoomDetails[1].title,
            style: TextStyle(
              fontFamily: "Madimi",
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Leave',
                style: TextStyle(
                  fontFamily: 'Madimi',
                  color: Colors.amber, // Adjust colors
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Coordinators
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...coordinators.map((coordinator) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        backgroundImage: coordinator.image,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Show option to view profile
                          _showProfileOptionDialog(context, coordinator);
                        },
                        child: Row(
                          children: [
                            Text(
                              coordinator.name,
                              style: TextStyle(
                                fontFamily: 'Madimi',
                              ),
                            ),
                            Icon(Icons.star, color: Colors.yellow),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          SizedBox(height: 20), // Spacer between coordinators and audience
          // Slide widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  // Navigate to fullscreen slide view
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenSlidePage(slideImage),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: slideImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Spacer between slides and audience list
          // Audience list
          Expanded(
            child: ListView.builder(
              itemCount: audienceList.length,
              itemBuilder: (context, index) {
                final person = audienceList[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    backgroundImage: person.image,
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontFamily: 'Madimi',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    person.hashtag,
                    style: TextStyle(
                      fontFamily: 'Madimi',
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    // Show option to view profile
                    _showProfileOptionDialog(context, person);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !micRequested,
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  audienceList.add(
                    Person(
                      'JiaXin',
                      'jiaxin@example.com',
                      '#UM',
                      AssetImage('assets/jiaxin_profile.jpg'),
                      [],
                    ),
                  );
                });
                setState(() {
                  micRequested = true;
                });
              },
              icon: Icon(Icons.add),
              label: Text('Enter Room'),
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 10), // Spacer between buttons
          Visibility(
            visible: micRequested,
            child: FloatingActionButton(
              onPressed: () {
                _showMicRequestDialog(context);
              },
              child: Icon(Icons.mic_off_rounded),
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileOptionDialog(BuildContext context, Person person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Options'),
          content: Text('Do you want to view ${person.name}\'s profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SimpleProfilePage(person)),
                );
              },
              child: Text('View Profile'),
            ),
          ],
        );
      },
    );
  }

  void _showMicRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(20),
            child: Text(
              'You had requested the moderator to open your mic',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Madimi',
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FullScreenSlidePage extends StatelessWidget {
  final AssetImage slideImage;

  const FullScreenSlidePage(this.slideImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Optionally, you can include an app bar in fullscreen mode
        title: Text('Full Screen Slide'),
      ),
      body: Center(
        child: Image(
          image: slideImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
