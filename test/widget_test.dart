import 'package:flutter_test/flutter_test.dart';
import 'package:my_shop_app/main.dart';

void main() {
  testWidgets('shows the shop dashboard', (tester) async {
    await tester.pumpWidget(const MyShopApp());

    expect(find.byType(MyShopApp), findsOneWidget);
  });
}
