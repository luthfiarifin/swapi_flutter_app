import 'package:equatable/equatable.dart';

class CinemaModel extends Equatable {
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  const CinemaModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        name,
        address,
        latitude,
        longitude,
      ];
}

const cinemaList = [
  CinemaModel(
    name: 'Cinema XXI',
    address:
        'Jl. Prof. DR. Satrio No.18, RT.14/RW.4, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940',
    latitude: -6.2247223,
    longitude: 106.826039,
  ),
  CinemaModel(
    name: 'Lotte XXI',
    address:
        'Jl. Prof. DR. Satrio No.3-5 18, RT.18/RW.4, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12950',
    latitude: -6.2239744,
    longitude: 106.8179499,
  ),
  CinemaModel(
    name: 'Epicentrum XXI',
    address:
        'Jl. H. R. Rasuna Said, RT.2/RW.5, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12940',
    latitude: -6.2164896,
    longitude: 106.8299354,
  ),
  CinemaModel(
    name: 'Setiabudi XXI',
    address:
        'Setiabudi One, Lt.2 Office 2000, Jl. H. R. Rasuna Said No.Kav. 32 18, RT.18/RW.2, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12920',
    latitude: -6.2155651,
    longitude: 106.8252252,
  ),
  CinemaModel(
    name: 'Kota Kasablanka XXI',
    address:
        'Jl. Prof. DR. Satrio No.3-5 18, RT.18/RW.4, Kuningan, Karet Kuningan, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12950',
    latitude: -6.2240912,
    longitude: 106.8385166,
  ),
  CinemaModel(
    name: 'Hollywood XXI',
    address:
        'Jl. Gatot Subroto No.Kav. 19 8, RT.8/RW.2, Karet Semanggi, Kecamatan Setiabudi, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12190',
    latitude: -6.227577,
    longitude: 106.8135406,
  ),
  CinemaModel(
    name: 'Plaza Senayan XXI',
    address:
        'Plaza Senayan Lantai 5 Jl. Asia Afrika No. 8 Gelora Tanah Abang 1 3, RT.1/RW.3, Gelora, Kecamatan Tanah Abang, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10270',
    latitude: -6.2253279,
    longitude: 106.7952975,
  ),
];
