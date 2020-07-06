import 'package:app/model/post.dart';
import 'package:app/page/about/about_subpage/socialmedia.dart';
import 'package:app/page/about/settings.dart';
import 'package:app/page/feed/post.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/app.dart';
import 'package:app/widget/title.dart';

/*
The About Page
 */
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildListTile(String name, String slug) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(
                Post.slug(slug),
                isPost: false,
                name: name,
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Über uns'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Einstellungen',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              })
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            TitleWidget('Die Bewegung'),
            _buildListTile('✊ Forderungen', 'forderungen'),
            _buildListTile('🌍 Selbstverständnis', 'selbstverstaendnis'),
            _buildListTile(
                '✍️ Bundesweite Arbeitsgruppen', 'bundesweite-arbeitsgruppen'),
            _buildListTile('🗣 Demosprüche', 'demospruche'),
            _buildListTile('📣 Verhalten auf Demos', 'verhalten-auf-demos'),
            TitleWidget('Wichtige Links'),
            ListTile(
              title: Text('🌐 Website'),
              onTap: () {
                _launchURL('https://fridaysforfuture.de');
              },
            ),
            ListTile(
              title: Text('👤 Social Media'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialMediaPage()),
                );
              },
            ),
            TitleWidget('Sonstiges'),
            _buildListTile('📖 Impressum', 'impressum'),
            _buildListTile('📑 Datenschutz', 'datenschutz'),
            Center(
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, result) {
                  if (!result.hasData) return SizedBox();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Dies ist die offizielle App von Fridays for Future Deutschland in der Version ${result.data.version}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
