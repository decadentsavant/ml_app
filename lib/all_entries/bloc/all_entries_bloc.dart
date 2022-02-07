import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_entries_event.dart';
part 'all_entries_state.dart';

class AllEntriesBloc extends Bloc<AllEntriesEvent, AllEntriesState> {
  AllEntriesBloc() : super(AllEntriesInitial()) {
    on<AllEntriesEvent>((event, emit) {

    });
  }
}
