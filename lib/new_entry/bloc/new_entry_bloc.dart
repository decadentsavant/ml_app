import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'new_entry_event.dart';
part 'new_entry_state.dart';

class NewEntryBloc extends Bloc<NewEntryEvent, NewEntryState> {
  NewEntryBloc() : super(NewEntryInitial()) {
    on<NewEntryEvent>((event, emit) {

    });
  }
}
