import 'package:firebase_messaging/firebase_messaging.dart';

class HandleMessagingFirebase {
  static Future<void> receiveMessagingFromServer(String username) async {
    await FirebaseMessaging.instance.subscribeToTopic(username);
    print('subscribeToTopic ' + username);
  }

  static Future<void> unReceiveMessagingFromServer(String username) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(username);
    print('unSubscribeFromTopic ' + username);
  }
}
