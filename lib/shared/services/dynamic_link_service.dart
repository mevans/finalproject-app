import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';

class DynamicLinkService {
  void initialise(ValueChanged<Uri> onOpen) async {
    FirebaseDynamicLinks.instance
        .onLink(onSuccess: (data) async => onOpen(data.link));
    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data == null) return;
    onOpen(data.link);
  }
}
