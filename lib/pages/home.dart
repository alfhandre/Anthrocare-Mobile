import 'package:flutter/material.dart';
import 'package:to_do_list/models/parentsModel.dart';
import 'package:to_do_list/pages/createParent.dart';
import 'package:to_do_list/pages/detailParent.dart';
import 'package:to_do_list/services/parentsService.dart';

class ParentsList extends StatefulWidget {
  @override
  _ParentsListState createState() => _ParentsListState();
}

class _ParentsListState extends State<ParentsList> {
  late Future<List<ParentModel>> futureParent;
  List<Map<String, dynamic>> parentData = [];
  List<ParentModel> parentList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchParentData();
    futureParent = ParentService().getParentData();
    futureParent.then((list) {
      parentList = list;
    });
  }

  Future<void> _fetchParentData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final parentService = ParentService();
      final data = await parentService.getParentData();
      setState(() {
        parentData = parentData;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching parent data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> _fetchParentData1() async {
  //   try {
  //     final parentService = ParentService();
  //     final data = await parentService.getProgramDonasi();
  //     setState(() {
  //       parentData = parentData;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     // Handle error
  //     print('Error fetching parent data: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double circleAvatarRadius = MediaQuery.of(context).size.width * 0.1;

    // tinggi(height) hp fullnya
    final MediaQueryHeight = MediaQuery.of(context).size.height;

    // lebar(width) hp fullnya
    final MediaQueryWidth = MediaQuery.of(context).size.width;

    // tinggi app bar
    final myAppBar = AppBar(title: Text("Media Query"));

    // untuk mencari tinggi bodynya
    final bodyHeight = MediaQueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Data Orang Tua'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CreateParent();
                }));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : parentData.length > 0
              ? Center(
                  child: Text('Tidak ada data.'),
                )
              : Center(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: FutureBuilder<List<ParentModel>>(
                          future: futureParent,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              return SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(children: [
                                    ...parentList.map((parent) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return DetailParent(
                                                    parent: parent);
                                              }));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, right: 8, bottom: 4),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius:
                                                          circleAvatarRadius, // Menggunakan nilai radius responsif
                                                      child: ClipOval(
                                                        child: Icon(
                                                          Icons
                                                              .account_circle_rounded,
                                                          size: circleAvatarRadius *
                                                              2, // Ukuran ikon sesuai radius
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Title(
                                                            color: Colors.grey,
                                                            child: Text(parent
                                                                .nama_orangtua)),
                                                        Text(
                                                          'Tanggal Lahir: ${parent.tgl_lahir_orangtua}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          'Alamat: ${parent.alamat}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          'No KTP: ${parent.no_ktp}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          'Golongan Darah: ${parent.gol_darah}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        Text(
                                                          'No Telepon: ${parent.no_telp}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                        ],
                                      );
                                    }).toList(),
                                  ]));
                            }
                          })),
                ),
    );
  }
}


// isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : parentData.isEmpty
//               ? Center(
//                   child: Text('Tidak ada data.'),
//                 )
//               : ListView.builder(
//                   itemCount: parentData.length,
//                   itemBuilder: (context, index) {
//                     final data = parentData[index];
//                     return InkWell(
//                       onTap: () {
//                         // Navigator.of(context)
//                         //     .push(MaterialPageRoute(builder: (context) {
//                         //   return DetailParent(parent: data);
//                         // }));
//                         print('memek');
//                       },
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               // decoration: BoxDecoration(
//                               //     border: Border.all(),
//                               //     borderRadius: BorderRadius.circular(4)),
//                               child: Row(
//                                 children: [
//                                   CircleAvatar(
//                                     backgroundColor: Colors.transparent,
//                                     radius:
//                                         circleAvatarRadius, // Menggunakan nilai radius responsif
//                                     child: ClipOval(
//                                       child: Icon(
//                                         Icons.account_circle_rounded,
//                                         size: circleAvatarRadius *
//                                             2, // Ukuran ikon sesuai radius
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Title(
//                                           color: Colors.grey,
//                                           child: Text(
//                                               'Nama Ortu : ${data['nama_orangtua']}')),
//                                       Text(
//                                         'Tanggal Lahir: ${data['tgl_lahir_orangtua']}',
//                                         style: TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                       Text(
//                                         'Alamat: ${data['alamat']}',
//                                         style: TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                       Text(
//                                         'No KTP: ${data['no_ktp']}',
//                                         style: TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                       Text(
//                                         'Golongan Darah: ${data['gol_darah']}',
//                                         style: TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                       Text(
//                                         'No Telepon: ${data['no_telp']}',
//                                         style: TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Divider()
//                         ],
//                       ),
//                     );
//                   },
//                 ),