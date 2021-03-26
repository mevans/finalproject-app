import 'package:tracker/shared/models/auth_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

class TokenRepository implements TokenStorage<AuthData> {
  final FlutterSecureStorage secureStorage;

  final String accessTokenKey = 'access-token';
  final String refreshTokenKey = 'refresh-token';

  TokenRepository() : secureStorage = FlutterSecureStorage();

  @override
  Future<void> delete() async {
    var delete = (String key) => this.secureStorage.delete(key: key);
    await Future.wait([
      delete(this.accessTokenKey),
      delete(this.refreshTokenKey),
    ]);
  }

  @override
  Future<AuthData> read() {
    var read = (String key) => this.secureStorage.read(key: key);
    return Future.wait([
      read(this.accessTokenKey),
      read(this.refreshTokenKey),
    ]).then((values) {
      return AuthData(access: values[0], refresh: values[1]);
    });
  }

  @override
  Future<void> write(AuthData data) async {
    var write = (String key, String value) =>
        this.secureStorage.write(key: key, value: value);
    await Future.wait([
      write(this.accessTokenKey, data.access),
      write(this.refreshTokenKey, data.refresh),
    ]);
  }
}
