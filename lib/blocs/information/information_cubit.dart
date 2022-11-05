import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:museum/services/service.dart';
import 'package:museum/models/models.dart';

part 'information_state.dart';

class InformationCubit extends Cubit<InformationState> {
  InformationCubit() : super(InformationInitial());

  void fetchInformation() async {
    try {
      emit(InformationLoading());

      List<InformationModel> _isiMuseum = [
        InformationModel(
          theme: 7,
          // theme_data: {
          //   'id': 7,
          //   'name': ''
          // },
          title: 'Lukisan “Holy Colours"',
          thumbnail: 'assets/images/temp-1.png',
          active: true,
          description:
              'Rhoncus feugiat viverra sit eget cras donec quam bibendum. Lorem dictum eu praesent.',
          image: 'assets/images/temp-1.png',
        ),
        InformationModel(
          theme: 7,
          // theme_data: {
          //   'id': 7,
          //   'name': ''
          // },
          title: 'Perhiasan Kuno',
          thumbnail: 'assets/images/temp-2.png',
          active: true,
          description: 'Perhisan Kuno.',
          image: 'assets/images/temp-2.png',
        ),
      ];

      // var information = InformationService.getInformationList();
      var information = _isiMuseum;

      emit(InformationFetch(information: information));
    } catch (e) {
      emit(InformationException(e: e));
    }
  }

  void fetchInformationSearch({required term}) async {
    try {
      emit(InformationLoading());

      var information = InformationService.getInformationSearch(term: term);

      // emit(InformationFetch(information: information));
    } catch (e) {
      emit(InformationException(e: e));
    }
  }
}
