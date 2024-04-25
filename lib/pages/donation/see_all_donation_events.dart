import 'package:fends_mobile/pages/donation/donation_event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:fends_mobile/models/event.dart';
import 'package:fends_mobile/networks/event_request.dart';

import '../../app_config.dart';

class SeeAllDonationEvents extends StatefulWidget {
  late bool myEvent;
  SeeAllDonationEvents({Key? key, required this.myEvent}) : super(key: key);

  @override
  _SeeAllDonationEventsState createState() => _SeeAllDonationEventsState();
}

class _SeeAllDonationEventsState extends State<SeeAllDonationEvents> {
  late double screenHeight;
  late double screenWidth;
  late List<MyEvent> events = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getMoreData(currentPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData(currentPage);
    }
  }

  Future<void> _getMoreData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await EventRequest.getEvents(page: page);

      setState(() {
        isLoading = false;
        events.addAll(response);
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: headerForDetail("Danh sách sự kiện"),
      body: Container(
        width: screenWidth,
        height: screenHeight,
        alignment: Alignment.center,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: events.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DonationEventDetailPage(event: events[index])));
              },
                child: _buildEventItem(events[index]));
          },
        ),
      ),
    );
  }

  Widget _buildEventItem(MyEvent event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: event.image != null && event.image!.isNotEmpty
                    ? NetworkImage('${AppConfig.IMAGE_API_URL}${event.image}')
                    : NetworkImage(
                        "https://product.hstatic.net/1000178779/product/v61w23t010_40774588_0_09600769fda74cf78243b8bd7adfa18b_master.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name ?? 'Sự kiện',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  event.user.toString(),
                  style: TextStyle(
                    color: Color(0xFF727272),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Còn lại ${DateTime.parse(event.endAt!).difference(DateTime.now()).inDays} ngày',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(width: 10),
                Text(
                  event.description.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar headerForDetail([String? title]) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
