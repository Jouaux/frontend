import 'package:app/app.dart';
import 'package:app/widget/og_social_buttons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<OG> ogs;

  Future _loadData() async {
    ogs = await api.getOGs();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karte'),
      ),
      body: ogs == null
          ? LinearProgressIndicator()
          : FlutterMap(
              options: MapOptions(
                  center: LatLng(51.5167, 9.9167),
                  zoom: 5.7,
                  minZoom: 4,
                  maxZoom: 19),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        'https://mapcache.fridaysforfuture.de/{z}/{x}/{y}.png',
                    tileProvider: CachedNetworkTileProvider()),
                MarkerLayerOptions(
                  markers:
                      ogs.map<Marker>((item) => _generateMarker(item)).toList(),
                ),
              ],
            ),
    );
  }

  Marker _generateMarker(OG og) {
    return Marker(
        width: 45.0,
        height: 45.0,
        point: LatLng(og.lat, og.lon),
        builder: (context) => new Container(
              child: IconButton(
                icon: Icon(Icons.location_on),
                color: Hive.box('subscribed_ogs').containsKey(og.ogId)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).primaryColor,
                iconSize: 45.0,
                onPressed: () {
                  showOGDetails(og);
                },
              ),
            ));
  }

  showOGDetails(OG og) {
    bool subscribed = Hive.box('subscribed_ogs').containsKey(og.ogId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(og.name),
        content: OGSocialButtons(og, true),
        actions: <Widget>[
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Abbrechen'),
          ),
          subscribed
              ? FlatButton(
                  onPressed: () async {
                    await FirebaseMessaging()
                        .unsubscribeFromTopic('og_${og.ogId}');
                    Hive.box('subscribed_ogs').delete(og.ogId);
                    Navigator.of(context).pop();
                  },
                  child: Text('Deabonnieren'),
                )
              : FlatButton(
                  onPressed: () async {
                    await FirebaseMessaging().subscribeToTopic('og_${og.ogId}');
                    Hive.box('subscribed_ogs').put(og.ogId, og);
                    Navigator.of(context).pop();
                  },
                  child: Text('Abonnieren'),
                ),
        ],
      ),
    );
  }
}
