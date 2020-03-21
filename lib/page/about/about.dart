import 'dart:io';

import 'package:app/app.dart';
import 'package:app/page/about/about_subpage/about_subpage.dart';
import 'package:app/page/about/about_subpage/demo.dart';

//import 'package:url_launcher/url_launcher.dart';

/*
The About Page
 */
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  /*
  The style of the Sub Headings.
   */
  final TextStyle _styleSubHeading = TextStyle(
    letterSpacing: 3,
    color: Colors.black54,
  );

  /*
  The Background of the Sub headings
   */
  final Color _colorSubHeadingBackground = Colors.grey[100];

  Widget _buildTitle(String title) {
    return Platform.isIOS
        ? Material(
            color: _colorSubHeadingBackground,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(
                title,
                style: _styleSubHeading,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          );
  }

  @override
  /* _launchURL() async {
    const url = 'https://flutter.io';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Über uns'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            _buildTitle('Die Bewegung'),
            ListTile(
              title: Text('Demosprüche 🗣'),
              onTap: () {
                Navigator.push(
                  context,
                  //Pushes the Sub Page on the Stack
                  MaterialPageRoute(builder: (context) => DemoPage()),
                );
              },
            ),
            ListTile(
              title: Text('Forderungen ✊'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutSubpage(
                          'Forderungen', Text('Unsere Forderungen'))),
                );
              },
            ),
            ListTile(
              title: Text('Selbstverständnis 🥰'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutSubpage('Selbstvertändnis',
                          Text('Selbstverständnissssssss'))),
                );
              },
            ),
            ListTile(
              title: Text('Verhalten auf Demos 📣'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutSubpage('Verhalten auf Demos',
                          Text('Hier kommt ein toller Text über tolle Demos'))),
                );
              },
            ),
            _buildTitle('Wichtige Links'),
            ListTile(
              title: Text('Website 🌐'),
            ),
            ListTile(
              title: Text('Spenden 💵'),
            ),
            _buildTitle('Sonstiges'),
            ListTile(
              title: Text('Impressum 📖'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutSubpage(
                          'Impressum', Text('Gaaaaanz viel Impressum .... '))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
