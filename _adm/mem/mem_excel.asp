<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()

	rso()
	SQL = " SELECT COUNT(*) FROM _omemt010 "
	rs.open SQL, dbcon
		rcnt = CInt(rs(0))
	rsc()
'	Response.Write "rcnt : "& rcnt &"<br>"

	title = Date() &"_회원명단"

	rso()
	SQL = " SELECT * FROM _omemt010 ORDER BY ddate "
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon, 3

	iCnt = rs.recordcount

	If Not rs.Bof Or Not rs.Eof Then
		arrRs = rs.GetRows(iCnt)
		intFlds = UBound(arrRs, 1)
		intRows = UBound(arrRs, 2)
	End If
	rsc()

	Set cx = New BsfCode

	Response.Buffer = True
	'Session.CodePage = 65001
	'Response.Charset = "UTF-8"
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-disposition","attachment;filename="& Server.URLPathEncode(title) &".xls"
%>

<html>
<head>
<title>회원명단</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" type="text/css" href="http://www.unoweb.co.kr/inc/css/basic01.css"> -->
<style type="text/css">
<!--
	body {}
	th {font-family:verdana; font-size:12px; margin:0px; color:#000; line-height:17px; text-align:center; font-weight:bold;}
	td {font-family:verdana; font-size:11px; margin:0px; color:#000; line-height:17px; text-align:center; letter-spacing:-1;}
	.lf {text-align:left;}
	.ct {text-align:center;}
	.rg {text-align:right;}
-->
</style>
</head>


<body style="margin-left:0px; margin-top:0px; margin-right:0px; margin-bottom:0px;">
<table width="1840" border="1" cellpadding="0" cellspacing="0">
	<tr height="22">
		<th width="50">번호</th>
		<th width="100">아이디</th>
		<th width="100">이름</th>
		<th width="120">닉네임</th>
		<th width="100">일반전화</th>
		<th width="100">휴대전화</th>
		<th width="250">이메일</th>
		<th width="60">우편번호</th>
		<th width="350">주소1</th>
		<th width="350">주소2</th>
		<th width="200">가입일자</th>
		<th width="60">로그인수</th>
	</tr>
<%
'Response.Write "intRows : "& intRows &"<br>"
'seq(0), memid(1), mempw(2), uname(3), unamee(4), tel(5), hp(6), email(7), memtype(8), zip(9), addr1(10), addr2(11), ddate(12), point(13), cnt(14), ldate(15)

	For intLoop = 0 To intRows
%>
	<tr height="22">
		<td style="mso-number-format:\@"><%=arrRs(0,intLoop)%></td><!-- 순번 -->
		<td><%=arrRs(1,intLoop)%></td><!-- 구분 -->
		<td><%=arrRs(3,intLoop)%></td><!-- 성명 -->
		<td><%=arrRs(4,intLoop)%></td><!-- 닉네임 -->
		<td style="mso-number-format:\@"><%=arrRs(5,intLoop)%></td><!-- 일반전화 -->
		<td style="mso-number-format:\@"><%=arrRs(6,intLoop)%></td><!-- 휴대전화 -->
		<td class="lf"><%=cx.SetDecode(arrRs(7,intLoop))%></td><!-- 이메일 -->
		<td style="mso-number-format:\@"><%=arrRs(9,intLoop)%></td><!-- 우편번호 -->
		<td class="lf"><%=arrRs(10,intLoop)%></td><!-- 주소1 -->
		<td class="lf"><%=arrRs(11,intLoop)%></td><!-- 주소2 -->
		<td><%=arrRs(12,intLoop)%></td><!-- 가입일자 -->
		<td style="mso-number-format:\@"><%=arrRs(14,intLoop)%></td><!-- 로그인횟수 -->
	</tr>
<%	Next %>
</table>
<%
	Set cx = Nothing
	dbc()
%>
