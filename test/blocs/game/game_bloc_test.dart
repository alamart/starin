import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starin/blocs/game/game_bloc.dart';
import 'package:starin/blocs/game/game_event.dart';
import 'package:starin/blocs/game/game_state.dart';
import 'package:starin/models/movie.dart';
import 'package:starin/models/person.dart';
import 'package:starin/repositories/movie_repository.dart';

class MockMovieRepository extends Mock implements GenericMovieRepository {}

void main() {
  MockMovieRepository mockMovieRepository;
  Person firstActor = Person(id: 258, name: "Gael García Bernal", occupation: "Acting", profilePath: "/7mq3EQN1oJfYNXkv9xKXKu6Ccw5.jpg");
  Person secondActor = Person(id: 259, name: "Vanessa Bauche", occupation: "Acting", profilePath: "/1WQaHygZ1AsRxDBcPmxL0fSLNri.jpg");
  Person thirdActor = Person(id: 260, name: "Goya Toledo", occupation: "Acting", profilePath: "/l6MLWQFo6F3eQOpZ7H1eM3UhDq5.jpg");
  Movie firstMovie = Movie(1, "Movie title", "img_path", "This is an overview", DateTime.now(), [firstActor]);
  Movie secondMovie = Movie(2, "Movie title 2", "img_path2", "Lorem Ipsum", DateTime.now(), [secondActor]);

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  blocTest("should go through the right states when bloc is successful",
      build: (){
        when(mockMovieRepository.fetchPopularMovies())
            .thenAnswer((_) async => [firstMovie, secondMovie]);
        when(mockMovieRepository.fetchMovieActors(any))
            .thenAnswer((_) async => [firstActor, secondActor]);
        return GameBloc(mockMovieRepository);
      },
      act: (bloc) => bloc.add(InitGame()),
      expect: [GameLoading(), GameLoaded([firstMovie, secondMovie], [firstActor, secondActor])]
  );

  blocTest("should throw an error if the Network is down",
      build: (){
        when(mockMovieRepository.fetchPopularMovies())
            .thenThrow(NetworkError());
        return GameBloc(mockMovieRepository);
      },
      act: (bloc) => bloc.add(InitGame()),
      expect: [GameLoading(), GameError("It seems you are offline")]
  );
}
