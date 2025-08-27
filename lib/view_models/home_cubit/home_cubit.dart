import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getHomeData() {
    emit(HomeLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(
        HomeLoaded(
          arrivalProducts: dummyProducts,
          carouselItems: dummyHomeCarouselItems,
        ),
      );
    });
  }
}
