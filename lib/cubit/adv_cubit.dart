import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adv_state.dart';

class AdvCubit extends Cubit<AdvState> {
  AdvCubit() : super(AdvInitial());
}
