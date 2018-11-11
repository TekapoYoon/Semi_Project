<%@page import="dao.CalendarDAO"%>
<%@page import="dao.CalendarDAOImpl"%>
<%@page import="dto.MemberDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp"%>
<%!public boolean nvl(String msg) {
      return msg == null || msg.trim().equals("") ? true : false;
   }

   // callist - 날짜를 클릭하면 그날짜의 일정을 모두 보이게 하는 callist.jsp로 이동 시키는 함수
   public String callist(int year, int month, int day) {

      String s = "";

      s += String.format("<a href='%s?year=%d&month=%d&day=%d'>", "calendarlist.jsp", year, month, day);
      s += String.format("%2d", day);
      s += "</a>";

      return s;
   }

   // 일정을 추가 하기 위해서 pen이미지를 클릭하면, calendarwrite.jsp로 이동시킬 함수
   public String showPen(int year, int month, int day) {

      String s = "";
      String url = "calendarwrite.jsp";
      String image = "<img src='https://user-images.githubusercontent.com/41100556/45011163-1b7d4e00-b04c-11e8-98dc-447a810526f3.gif'>";

      s = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", url, year, month, day, image);
      return s;
   }

   // 1 -> 01
   public String two(String msg) {
      return msg.trim().length() < 2 ? "0" + msg : msg.trim();
   }

   // 일정표시 -> 10자 이상이면, ...으로 표시되도록 하는 함수
   public String dot3(String msg) {
      String s = "";

      if (msg.length() >= 10) {
         s = msg.substring(0, 10);
         s += "...";
      } else {
         s = msg.trim();
      }
      return s;
   }

   // 각 날짜 별로 테이블을 생성하는 함수
   public String makeTable(int year, int month, int day, List<CalendarDto> list) {
      //달에 있는 일정들 중에 그 날에 해당되는것만 골라서 테이블로 쏴줌
      String s = "";
      String dates = (year + "") + two(month + "") + two(day + ""); // 20180827

      s = "<table width='100%'>";
      s += "<col width='98'>";

      for (CalendarDto dto : list) {

         if (dto.getRdate().substring(0, 8).equals(dates)) {

            s += "<tr bgcolor='FFF0F0'>";
            s += "<td width='100'>";

            s += "<a href='calendardetail.jsp?seq=" + dto.getSeq() + "'>";

            /* s += "<font style='font-size:8; color:red'>"; */
            s += dot3(dto.getTitle());
            /* s += "</font>"; */
            s += "</a>";
            s += "</td>";
            s += "</tr>";
         }
      }
      s += "</table>";

      return s;
   }
%>
<%
   request.setCharacterEncoding("utf-8");

   Calendar cal = Calendar.getInstance();
   int tmpday = cal.get(Calendar.DATE);
   cal.set(Calendar.DATE, 1);

   String syear = request.getParameter("year");
   String smonth = request.getParameter("month");

   int year = cal.get(Calendar.YEAR);
   if (!nvl(syear)) {
      year = Integer.parseInt(syear);
   }

   int month = cal.get(Calendar.MONTH) + 1;
   if (!nvl(smonth)) {
      month = Integer.parseInt(smonth);
   }

   if (month < 1) {
      month = 12;
      year--;
   }

   if (month > 12) {
      month = 1;
      year++;
   }

   cal.set(year, month - 1, 1); // 연월일 셋팅

   int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 요일 1 ~ 7

   //////////// 위에 날짜, 년도 화살표
   // <<
   String pp = String.format(
         "<a href='%s?year=%d&month=%d'><img src='https://user-images.githubusercontent.com/41100556/45011651-a101fd80-b04e-11e8-9118-20b11ea365bd.png' style='margin: 2px;'></a>",
         "calendar.jsp", year - 1, month);

   // <
   String p = String.format(
         "<a href='%s?year=%d&month=%d'><img src='https://user-images.githubusercontent.com/41100556/45011549-0a354100-b04e-11e8-9687-b557d362b0ad.png' style='margin: 2px;'></a>",
         "calendar.jsp", year, month - 1);
   // >
   String n = String.format(
         "<a href='%s?year=%d&month=%d'><img src='https://user-images.githubusercontent.com/41100556/45011539-00134280-b04e-11e8-9c15-591a577f8236.png' style='margin: 2px;'></a>",
         "calendar.jsp", year, month + 1);

   // >>
   String nn = String.format(
         "<a href='%s?year=%d&month=%d'><img src='https://user-images.githubusercontent.com/41100556/45011644-97789580-b04e-11e8-9a4c-70869021556f.png' style='margin: 2px;'></a>",
         "calendar.jsp", year + 1, month);

   CalendarDAOImpl dao = CalendarDAO.getInstance();

   List<CalendarDto> list = dao.getCalendarList(mem.getId(), year + two(month + ""));
%>
<html>
<head>
<style type="text/css">
#calendar .bor {
   border: 1px solid #ccc;
   margin-right: -1px;
   margin-bottom: -1px;
}
/* 요일  */
#calendar tr.weekdays {
   height: 40px;
   background: #fff5ee;
}

#calendar tr.weekdays td {
   text-align: center;
   text-transform: uppercase;
   line-height: 20px;
   border: none !important;
   padding: 10px 6px;
   color: black;
   font-size: 13px;
}
</style>
</head>
<body>

   <div class="container" style="margin-bottom: 20px">
      <h3 align="center">Event</h3><hr>
      <div id="calendar-wrap">
         <div align="center" id="calendar">
            <table border="1" class="bor" align="center">
               <col width="200">
               <col width="200">
               <col width="200">
               <col width="200">
               <col width="200">
               <col width="200">
               <col width="200">

               <!-- <<날짜 있는 부분>> -->

               <%=pp%><%=p%>

               <font color="black"> <%=String.format("%d년&nbsp;&nbsp;%d월", year, month)%>
               </font>
               <%=n%><%=nn%>
               <br>
               <br>

               <!--요일  -->
               <tr height="80" class="weekdays">
                  <td align="center">일</td>
                  <td align="center">월</td>
                  <td align="center">화</td>
                  <td align="center">수</td>
                  <td align="center">목</td>
                  <td align="center">금</td>
                  <td align="center">토</td>
               </tr>

               <tr height="100" align="left" valign="top">

                  <%
                     for (int i = 1; i < dayOfWeek; i++) { //처음에 빈칸들
                  %>
                  <td>&nbsp;</td>
                  <%
                     }

                     int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

                     for (int i = 1; i <= lastDay; i++) { //달에 있는 일수 만큼
                  %>
                  <td class="hoverable"><%=callist(year, month, i)%>&nbsp; <%
                      if (mem.getAuth() == 1) {
                   %> <%=showPen(year, month, i)%> <%
                      }
                   %> <%=makeTable(year, month, i, list)%></td>

                  <%
                     if ((i + dayOfWeek - 1) % 7 == 0 && i != lastDay) {//줄바꿈
                  %>
               </tr>
               <tr height="100" align="left" valign="top">
                  <%
                     }
                     }

                     for (int i = 0; i < (7 - (dayOfWeek + lastDay - 1) % 7) % 7; i++) {
                        //                  마지막날 7로 나누고 남은거
                  %>
                  <td>&nbsp;</td>
                  <%
                     }
                  %>
               </tr>
            </table>
         </div>
      </div>
   </div>
   <script type='text/javascript'>
      $(document).ready(function() {

         var date = new Date();
         var d = date.getDate();
         var m = date.getMonth();
         var y = date.getFullYear();

         $('#calendar').fullCalendar({
            header : {
               left : 'prev,next today',
               center : 'title',
               right : 'month,basicWeek,basicDay'
            },
            editable : true,
            events : []
         });
      });
   </script>
   <%@ include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>