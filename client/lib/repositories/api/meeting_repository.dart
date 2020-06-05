import 'dart:convert';
import 'package:Tempo/models/meeting.dart';
import 'package:dio/dio.dart';

//part 'meeting_repository.g.dart';

/*@RestApi(baseUrl: 'http://tempo.bartstasik.com:8090/meetings')*/
class MeetingRepository {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'http://tempo.bartstasik.com:8090/meetings',
      contentType: 'application/json'
    )
  );

  /*factory MeetingRepository(Dio dio, {String baseUrl}) => _MeetingRepository(dio);*/

  Future<List<Meeting>> getMeetings() => _dio.get('').then((value) {
    List<dynamic> data = jsonDecode(value.data);

    return data.map((dynamic i) => Meeting.fromJson(i as Map<String, dynamic>))
        .toList();
  });

  Future<void> addMeeting(Meeting meeting) => _dio.post('', data: meeting.toJson());



  Future<void> checkIn(String email, String qrHash) => _dio.post('/checkin', data: {
    'userEmail': email,
    'qrHash': qrHash
  });

  /*@GET('')
  Future<List<Meeting>> getMeetings();*/

  /*@POST('')
  Future<void> addMeeting(@Body() Meeting meeting);

  @GET('/checkin')
  Future<List<Meeting>> getCheckedInMeetings();

  @POST('/checkin')
  Future<List<Meeting>> checkInMeeting(@Body() CheckInDetails checkInDetails);*/
}