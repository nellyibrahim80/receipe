part of 'adv_cubit.dart';


abstract class AdvState {
 final List<Advs> advList=[];

}

class AdvInitial extends AdvState {}

// adv_state.dart



class AdvLoaded extends AdvState {
  final List<Advs> advList;

  AdvLoaded({required this.advList});
}

class AdvError extends AdvState {
  final String errorMessage;

  AdvError({required this.errorMessage});
}
