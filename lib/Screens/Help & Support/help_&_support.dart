import 'package:flutter/material.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Color(0xFF6F35A5),
        ),
      ),

      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,  // For empty space after all lists, tells where the 'white' body starts
      ),
      
    );
  }
}


// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'What is DoorStep?',
    <Entry>[
      Entry('DoorStep is an innovative app, which redefines the way of smart living. Everyday items of your neighbourhood is integrated in this app flawlessly. Experience modern ay of living, first hand here at DoorStep! '),
    ],
  ),
  Entry(
    'How can I generate QR code?',
    <Entry>[
      Entry('In main menu, go to Access control. QR code will be generated automatically, you simply need to send the QR Code to the guests you are expecting by either saving it, or sending them directly by Share button.  '),
    ],
  ),
  Entry(
    'What to do with the QR code?',
    <Entry>[
      Entry('You just have to simply send the code to the guest you are expecting. The security team will do the rest.'),
    ],
  ),
  Entry(
    'How can I participate into the surveys?',
    <Entry>[
      Entry('By checking the "Survey" in dashboard, you can check all the latest surveys being conducted by the administration of the society. You can express your opinion by voting on them.'),
    ],
  ),
  Entry(
    'How can I use services?',
    <Entry>[
      Entry('The services provided by your neighbourhood administration will be listed in "Services" section in dashboard. You can contact different services at touch of your screen.'),
    ],
  ),
  Entry(
    'Can I reserve a place in the neighbourhood? ?',
    <Entry>[
      Entry('Yes, by going into the "Reservations" tab in dashboard, you can see the list of all available places that can be reserved. You can choose your desired place and the owner will be informed.  '),
    ],
  ),
];

//Displays extension tile if it exists (as children)
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
