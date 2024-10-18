import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';

class AppLinkHandler {
  final GoRouter router;
  final AppLinks _appLinks = AppLinks();
  bool _initialUriHandled = false;

  AppLinkHandler({required this.router});

  void initLinkHandling() {
    _handleIncomingLinks();
    _handleInitialUri();
  }

  void _handleIncomingLinks() {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri, initial: false);
      }
    }, onError: (Object err) {
      print('Error occurred: $err');
    });
  }

  Future<void> _handleInitialUri() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (!_initialUriHandled) {
        _initialUriHandled = true;
        _handleLink(uri, initial: true);
      }
    } on FormatException catch (err) {
      print('Error parsing initial link: $err');
    }
  }

  void _handleLink(Uri? uri, {required bool initial}) {
    if (uri == null) {
      if (initial) {
        router.go('/splash');
      }
      return;
    }
    String nextRoute = '/';
    if (uri.host == 'allevents.in' &&
        uri.pathSegments.length >= 2 &&
        uri.pathSegments[0] == 'profile') {
      final profileId = uri.pathSegments[1];
      nextRoute = '/profile/$profileId';
    }
    router.go(nextRoute);
  }
}
