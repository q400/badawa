<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))

	rso()
	SQL = " SELECT COUNT(*) FROM _orsvt010 WHERE rdate = '"& yy & mm & dd &"' AND status <> 'X' "
	rs.open SQL, dbcon

	rcnt = CInt(rs(0))
	rsc()
'	Response.Write "rcnt : "& rcnt &"<br>"

	rso()
	SQL = " SELECT SUM(inwon) FROM _orsvt010 WHERE rdate = '"& yy & mm & dd &"' AND status <> 'X' "
	rs.open SQL, dbcon

	If Not rs.Bof Or Not rs.Eof Then
		rsum = CInt(rs(0))
	End If
	rsc()
'	Response.Write "rsum : "& rsum &"<br>"

	rso()
	SQL = " SELECT ridx, rnm, inwon, hp, shipid, rmoney, uno "_
		& " FROM _orsvt010 "_
		& " WHERE rdate = '"& yy & mm & dd &"'"_
		& " AND status <> 'X' "_
		& " ORDER BY shipid, ddate "
	rs.open SQL, dbcon, 3

	iCnt = rs.recordcount

	If Not rs.Bof Or Not rs.Eof Then
		arrRs = rs.GetRows(iCnt)
		intFlds = UBound(arrRs, 1)
		intRows = UBound(arrRs, 2)
	End If
	rsc()

	title = yy &"_"& mm & dd &"_출조예약_현황표"
'	Response.Write & Server.URLPathEncode(title) &"<br>"

	Response.Buffer = True
	Session.CodePage = 65001
	Response.Charset = "utf-8"
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-disposition","attachment;filename="& Server.URLPathEncode(title) &".xls"
%>

<html>
<head>
<title>출조예약 현황표</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
	body {font-family:돋움; margin-left:0px; margin-top:0px; margin-right:0px; margin-bottom:0px; color:#000; font-size:14px; letter-spacing:-1px !important;}
	th {font-family:돋움; font-weight:bold; margin:0px; color:#000; font-size:14px; line-height:19px; text-align:center; letter-spacing:-1px !important;}
	td {font-family:돋움; font-weight:bold; margin:0px; color:#000; font-size:14px; line-height:19px; text-align:center; letter-spacing:-1px !important;}
	div {height:50px;}
	.lf {text-align:left;}
	.ct {text-align:center;}
	.rg {text-align:right;}
-->
</style>
</head>

<body style="margin-left:0px; margin-top:0px; margin-right:0px; margin-bottom:0px;">
<!-- <p width="700" style="font-size:21px; line-height:10px; text-align:center;">&nbsp;</p> -->
<p width="700" style="font-size:21px; line-height:50px; text-align:center;"><b>안흥낚시 출조예약 현황표</b></p>
<p width="700" style="font-size:15px; line-height:40px;" class="rg"><%=yy%> 년 <%=mm%>월 <%=dd%>일&nbsp;&nbsp;(<%=WeekDayName(WeekDay(yy &"-"& mm &"-"& dd))%>)&nbsp;&nbsp;</p>
<table border="1" cellpadding="0" cellspacing="0">
	<tr height="27">
		<th width="40">번호</th>
		<th width="110">성명</th>
		<th width="60">인원</th>
		<th width="150">연락처</th>
		<th width="90">예약금</th>
		<th width="100">선박명</th>
		<th width="50">회원</th>
		<th width="90">포인트내역</th>
	</tr>
<%
'Response.Write "intRows : "& intRows &"<br>"
'ridx(0), rdate, uno(6), rnm(1), inwon(2), tel, hp(3), email, shipid(4), gubn, status, rmoney(5), pwd, uip, ddate, memo

	For intLoop = 0 To intRows
%>
	<tr height="24">
		<td style="mso-number-format:\@"><%=intLoop + 1%></td><!-- 순번 -->
		<td style="font-size:15px; letter-spacing:-3px !important;"><%=arrRs(1,intLoop)%></td><!-- 성명 -->
		<td style="font-size:13px;"><%=arrRs(2,intLoop)%></td><!-- 인원 -->
		<td style="mso-number-format:\@"><%=arrRs(3,intLoop)%></td><!-- 연락처 -->
		<td style="font-size:13px;"><%=FormatNumber(arrRs(5,intLoop),0)%></td><!-- 예약금 -->
		<td><%=shipinfo(arrRs(4,intLoop),"shipnm")%></td><!-- 선박명 -->
		<td style="font-size:13px;"><%=arrRs(6,intLoop)%></td><!-- 회원번호 -->
		<td style="font-size:13px;">&nbsp;<%If arrRs(6,intLoop) <> "3" Then%><%=FormatNumber(chkPoint(arrRs(6,intLoop),"ship"),0)%><%Else%>-<%End If%></td><!-- 포인트내역 -->
	</tr>
<%
	Next

	For intLoop = rcnt To 23
%>
	<tr height="24">
		<td style="mso-number-format:\@"><%=intLoop + 1%></td><!-- 순번 -->
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
<%	Next %>
	<tr height="24">
		<td>계</td>
		<td>&nbsp;</td>
		<td style="mso-number-format:\@"><%=rsum%></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</html>
<%	dbc() %>