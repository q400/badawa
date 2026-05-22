<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	shipid						= SQLI(Request("shipid"))
	sdt							= SQLI(Request("sdt"))			'검색시작일
	edt							= SQLI(Request("edt"))			'검색종료일
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))

	setsize						= 10							'보여지는 페이지 수
	pgsize						= 15							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "rnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then
		If cd1 = "seq" Then
			param = " WHERE seq = '"& cd2 &"' "
		Else
			param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
		End If
	Else
		param = " WHERE status <> 'X' "
	End If
'	Response.Write "shipid : "& shipid &"<br>"
	If shipid <> "" Then
		param = param &" AND shipid = "& shipid
	End If

	If sdt <> "" Then
		param = param &" AND rdate >= '"& sdt &"' "
	End If

	If edt <> "" Then
		param = param &" AND rdate <= '"& edt &"' "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _orsvt010 "& param
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon, 3
		recordcount = rs(0)
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
	pageParam = "cd1="& cd1 &"&cd2="& cd2 &"&shipid="& shipid
%>

<!-- <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.8.20.custom.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery-ui-1.8.20.custom.min.js"></script>
<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "stat.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script>
<script>
$(document).ready(function(){
	var clareCalendar = {
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월' ],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yymmdd',			// 날짜형식 = 20130329
		autoSize: false,				// 자동리사이즈 (false 이면 상위 정의에 따름)
		changeMonth: true,				// 월변경 가능
		changeYear: true,				// 연변경 가능
		showMonthAterYear: false,		// 년 위에 월 표시
		//showOn: 'both',				// 엘리먼트와 이미지 동시사용 (both, button)
		//buttonImageOnly: true,		// 이미지 표시
		//buttonText: '달력',			// 버튼 텍스트 표시
		//buttonImage: '/images/new/icon_calendar.gif', // 이미지 주소
		yearRange: 'c-99:c+99',			// 1990~2020년 까지
		maxDate: '+6Y',					// 오늘 부터 6년 후까지만.  +0d 오늘 이전 날짜만 선택
		minDate: '-3000d'				// 3000일 이전까지만 선택 가능
	}

	$('#sdt').datepicker(clareCalendar);
	$('#edt').datepicker(clareCalendar);

	$('img.ui-datepicker-trigger').attr('style','margin-left:5px; vertical-align:middle; cursor:pointer;');
	$('#ui-datepicker-div').hide();
});
/*
$(function(){
	$("#datepicker").datepicker();
	$("#format").val("yy-mm");
	$("#format").change(function(){
		$("#datepicker").datepicker("<%=sdt%>", "dateFormat", "yy-mm");
		$(this).val()
	});
});
$(function(){
	$("#datepicker2").datepicker();
	$("#format").val("yy-mm-dd");
	$("#format").change(function(){
		$("#datepicker2").datepicker("<%=edt%>", "dateFormat", "yymmdd");
		$(this).val()
	});
});
*/
</script>


<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">
<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">
				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">출조현황표</span>
						<span class="ib fright">
							시작 <input type="text" name="sdt" id="sdt" class="ct" value="<%=sdt%>" style="width:80px;">
							&nbsp;
							종료 <input type="text" name="edt" id="edt" class="ct" value="<%=edt%>" style="width:80px;">
							<select name="shipid" id="shipid" class="vm" style="width:110px;">
								<option value=""<%If shipid = "" Then%> selected<%End If%>>선박선택</option>
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
								<option value="<%=rs("shipid")%>"<%If shipid = cstr(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
							</select>
							<select name="cd1" id="cd1" style="width:90px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="rnm"<%If cd1 = "rnm" Then%> selected<%End If%>>닉네임</option>
								<option value="hp"<%If cd1 = "hp" Then%> selected<%End If%>>휴대폰번호</option>
								<option value="rdate"<%If cd1 = "rdate" Then%> selected<%End If%>>예약일자</option>
							</select>
							<input type="text" name="cd2" id="cd2" style="width:100px;" />
							<a href="javascript:;" onClick="goSearch(); return false;" class="btng btn25 vt"><span>검색</span></a>
							<a href="excelStat02.asp?sdt=<%=sdt%>&edt=<%=edt%>&<%=pageParam%>" class="btnp btn25 vt"><span>엑셀저장</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:40px;" />
							<col style="width:120px;" /><!-- 선박명 -->
							<col style="width:150px;" /><!-- 이름 -->
							<col style="width:60px;" /><!-- 인원 -->
							<col style="width:120px;" /><!-- 연락처 -->
							<col style="width:80px;" /><!-- 예약금 -->
							<col style="width:80px;" /><!-- 실결제금 -->
							<col style="width:80px;" /><!-- 예약일자 -->
							<col /><!-- 포인트내역 -->
						</colgroup>
						<thead>
							<tr>
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">선박명</th>
								<th class="bdr-dash-r ct">이름</th>
								<th class="bdr-dash-r ct">인원</th>
								<th class="bdr-dash-r ct">연락처</th>
								<th class="bdr-dash-r ct">예약금</th>
								<th class="bdr-dash-r ct">실결제금</th>
								<th class="bdr-dash-r ct">예약일자</th>
								<th class="ct">포인트내역</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _orsvt010 "& param _
			& " AND rdate NOT IN (SELECT TOP "& ((page-1) * pgsize) &" rdate FROM _orsvt010 "& param _
			& " ORDER BY rdate DESC) ORDER BY rdate DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
%>
							<tr height="40" bgcolor="#f1f1f1">
								<td class="ff f11 ct"><%=j%></td>
								<td class="ct"><%=shipInfo(rs("shipid"),"shipnm")%></td>
								<td class="ct"><%=rs("rnm")%></td>
								<td class="ff ct"><%=rs("inwon")%></td>
								<td class="ff ct"><%=rs("hp")%></td>
								<td class="ff rg pr5"><%=FormatNumber(rs("rmoney"),0)%></td>
								<td class="ff rg pr5"><%=FormatNumber(rs("omoney"),0)%></td>
								<td class="ff ct"><%=rs("rdate")%></td>
								<td class="ff rg pr5"><%=FormatNumber(chkPoint(rs("uno"),"ship"),0)%></td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan=10>정보가 없습니다.</td>
							</tr>
<%
		End If
		rsc()
%>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
				</div>
				<div class="ct mt10"><%=fnPaging(totalpage, page, 10, pageParam)%></div>
				<div id="btnarea1"></div>
			</div>
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>

<form name="fm2">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="sdt" value="<%=sdt%>">
<input type="hidden" name="edt" value="<%=edt%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="page" value="<%=page%>">
</form>

<%	Set cx = Nothing %>
