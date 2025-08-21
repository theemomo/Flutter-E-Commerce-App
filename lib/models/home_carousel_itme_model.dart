class HomeCarouselItemModel {
  final String id;
  final String imgUrl;

  HomeCarouselItemModel({
    required this.id,
    required this.imgUrl,
  });

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
  
//     result.addAll({'id': id});
//     result.addAll({'imgUrl': imgUrl});
  
//     return result;
//   }

//   factory HomeCarouselItemModel.fromMap(Map<String, dynamic> map) {
//     return HomeCarouselItemModel(
//       id: map['id'] ?? '',
//       imgUrl: map['imgUrl'] ?? '',
//     );
//   }
}

List<HomeCarouselItemModel> dummyHomeCarouselItems = [
  HomeCarouselItemModel(
    id: 'btgMW23JED1zRsxqdKms',
    imgUrl:
        'https://dfcdn.defacto.com.tr/Mobile/eg_ar_slider_b4b66e4d-ba40-47f0-9648-558841f08ef8_1c4ca4f7-0793-4a71-9d55-f13c74be2d1f_DI_542.jpg',
  ),
  HomeCarouselItemModel(
    id: 'jf385EsSP2RzdIKucgW7',
    imgUrl:
        'https://dfcdn.defacto.com.tr/Mobile/ar_eg_slider_0d7bfec2-d2d3-4f09-9c36-b3abd08f1f64_347d1f7c-adf6-4fb6-98b5-496983e66f8b_DI_542.jpg',
  ),
  HomeCarouselItemModel(
    id: 'XjZBor795dLTO2ErQGi3',
    imgUrl:
        'https://dfcdn.defacto.com.tr/Mobile/ar_eg_slider_6b8516b5-4e0d-4681-a3a9-74f0ee622d96_7400bcc7-5cd3-4ea7-8ccb-5f0ff3f5cb93_DI_542.jpg',
  ),
  HomeCarouselItemModel(
    id: '8u3jP9mBZYVSGq7JGoc6',
    imgUrl:
        'https://marketplace.canva.com/EAFMdLQAxDU/1/0/1600w/canva-white-and-gray-modern-real-estate-modern-home-banner-NpQukS8X1oo.jpg',
  ),
];