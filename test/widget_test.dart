// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_login_screen/views/custom_widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_login_screen/main.dart';

//TODO - implement privacy click mocked test and layout tests.
void main() {
  String passwordEmpty = "Password field is needed!";
  String passwordShort = "Password is too short!";
  String passwordBig = "Password is too big!";
  String passwordSpace = "Password can't end with empty space!";
  String passwordSpecial = "Password can't have special characters!";
  String userEmpty = "User field is needed!";
  String userBig = "User is too big!";
  String userSpace = "User can't end with empty space!";

  testWidgets('correct Login test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: MyHomePage(title: 'Flutter Demo Home Page'))));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsExactly(2));

    await tester.enterText(find.byType(TextFormField).first, "hi");
    await tester.enterText(find.byType(TextFormField).last, " ");
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(microseconds: 100));

    expect(find.text("hi"), findsOne);
    expect(find.byType(MyTextError), findsAny);
    expect(find.text(passwordShort), findsAny);

    await tester.enterText(find.byType(TextFormField).first, "");
    await tester.enterText(find.byType(TextFormField).last, '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(microseconds: 100));
    expect(find.text(passwordEmpty), findsAny);
    expect(find.text(userEmpty), findsAny);

    await tester.enterText(find.byType(TextFormField).first, "user ");
    await tester.enterText(find.byType(TextFormField).last, 'senha ');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(microseconds: 100));
    expect(find.text(passwordSpace), findsAny);
    expect(find.text(userSpace), findsAny);

    await tester.enterText(
        find.byType(TextFormField).first, "userMuitoGrandeMesmoMaisde20Char");
    await tester.enterText(
        find.byType(TextFormField).last, 'senhaMuitoGrandeMesmoMaisde20Char');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(microseconds: 200));
    expect(find.text(passwordBig), findsAny);
    expect(find.text(userBig), findsAny);

    await tester.enterText(find.byType(TextFormField).first, "user");
    await tester.enterText(find.byType(TextFormField).last, 'senh@');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(microseconds: 100));
    expect(find.text(passwordSpecial), findsAny);
    expect(find.text(userBig), findsNothing);
  });

  testWidgets('text error Test', (WidgetTester tester) async {
    const String errorText = "Senha Inválida";
    await tester.pumpWidget(const Directionality(
        textDirection: TextDirection.ltr,
        child: MyTextError(errorText, Icons.error, Colors.red,
            style: TextStyle(color: Colors.white))));
    expect(find.text(errorText), findsOneWidget);
  });
}
