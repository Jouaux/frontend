import 'package:share/share.dart';

import 'package:app/model/post.dart';

class ShareUtil {
  static sharePost(Post post) {
    // TODO Teilen-Text ändern
    Share.share('Lese "${post.title}" jetzt in der neuen FFFApp! <link>');
  }
}