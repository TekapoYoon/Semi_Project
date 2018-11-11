package dao;

import java.util.List;

import dto.CalendarDto;

public interface CalendarDAOImpl {
   
   public List<CalendarDto> getCalendarList(String id, String yyyyMM);
   boolean addCalendar(CalendarDto cal);
   
   //일정 수정
   boolean updateDay(CalendarDto dto, int seq);
   
   boolean deleteDay(int seq);
   
   CalendarDto getDay(int seq); //일정 상세 보기
   List<CalendarDto> getDayList(String dates); //일정 리스트로 상세보기

   // index화면 일정 불러오기
   public List<CalendarDto> indexCalList(int page);
   public int getcountlist ();
}