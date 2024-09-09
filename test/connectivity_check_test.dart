import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  test('should detect no internet connection', () async {
    final result = await mockConnectivity.checkConnectivity();
    expect(result, ConnectivityResult.none);
  });

  test('should detect wifi internet connection', () async {
    final result = await mockConnectivity.checkConnectivity();
    expect(result, ConnectivityResult.wifi);
  });
}
