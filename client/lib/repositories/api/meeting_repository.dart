import 'package:Tempo/models/meeting.dart';
import 'package:Tempo/services/api/details/check_in_details.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'meeting_repository.g.dart';

@RestApi(baseUrl: 'http://tempo.bartstasik.com:8090/meetings/')
abstract class MeetingRepository {
  factory MeetingRepository(Dio dio, {String baseUrl}) = _MeetingRepository;

  @GET('/')
  Future<List<Meeting>> getMeetings();

  @POST('/')
  Future<void> addTask(@Body() Meeting meeting);

  @GET('/checkin')
  Future<List<Meeting>> getCheckedInMeetings();

  @POST('/checkin')
  Future<List<Meeting>> checkInMeeting(@Body() CheckInDetails checkInDetails);
}