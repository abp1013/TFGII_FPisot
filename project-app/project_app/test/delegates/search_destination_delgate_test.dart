import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_app/blocs/tour/tour_bloc.dart';
import 'package:project_app/blocs/map/map_bloc.dart';
import 'package:project_app/delegates/delegates.dart';
import 'package:project_app/services/places_service.dart';

class MockTourBloc extends Mock implements TourBloc {}
class MockMapBloc extends Mock implements MapBloc {}
class MockPlacesService extends Mock implements PlacesService {}

void main() {
  late MockTourBloc mockTourBloc;
  late MockMapBloc mockMapBloc;
  late MockPlacesService mockPlacesService;
  late SearchDestinationDelegate searchDelegate;

  setUp(() {
    mockTourBloc = MockTourBloc();
    mockMapBloc = MockMapBloc();
    mockPlacesService = MockPlacesService();

    searchDelegate = SearchDestinationDelegate(
      tourBloc: mockTourBloc,
      mapBloc: mockMapBloc,
      placesService: mockPlacesService,
    );
  });

  group('SearchDestinationDelegate Tests', () {
    testWidgets('Cierra el buscador cuando se presiona el botón de limpiar (X)',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearch(
                  context: context,
                  delegate: searchDelegate,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      expect(find.byType(SearchDestinationDelegate), findsNothing);
    });

    testWidgets('Cierra el buscador cuando se presiona el botón de retroceso',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => showSearch(
                  context: context,
                  delegate: searchDelegate,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(SearchDestinationDelegate), findsNothing);
    });
  });
}
