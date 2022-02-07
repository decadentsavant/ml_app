import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_entry_event.dart';
part 'edit_entry_state.dart';

class EditEntryBloc extends Bloc<EditEntryEvent, EditEntryState> {
  EditEntryBloc() : super(EditEntryInitial()) {
    on<EditEntryEvent>((event, emit) {

    });
  }
}
