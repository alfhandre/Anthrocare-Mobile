class ParentModel {
  final int id;
  final String nama_orangtua;
  final String tgl_lahir_orangtua;
  final String alamat;
  final String no_ktp;
  final String gol_darah;
  final String no_telp;
  final String created_at;
  final String updated_at;

  ParentModel(
      {required this.id,
      required this.nama_orangtua,
      required this.tgl_lahir_orangtua,
      required this.alamat,
      required this.no_ktp,
      required this.gol_darah,
      required this.no_telp,
      required this.created_at,
      required this.updated_at});

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['id'],
      nama_orangtua: json['nama_orangtua'],
      tgl_lahir_orangtua: json['tgl_lahir_orangtua'],
      alamat: json['alamat'],
      no_ktp: json['no_ktp'],
      gol_darah: json['gol_darah'],
      no_telp: json['no_telp'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_orantua': nama_orangtua,
      'tgl_lahir_orangtua': tgl_lahir_orangtua,
      'alamat': alamat,
      'no_ktp': no_ktp,
      'gol_darah': gol_darah,
      'no_telp': no_telp,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
