<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))

	rso()
	SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
	rs.open SQL, dbcon
		rcnt = CInt(rs(0))
	rsc()
'	Response.Write "rcnt : "& rcnt &"<br>"


	title = shipinfo(shipid,"shipnm") &"_"& yy & mm & dd &"_출입항명단"

	rso()
	SQL = " SELECT	* FROM _orsvt020 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' ORDER BY ddate "
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon, 3
	iCnt = rs.recordcount
	If Not rs.Bof Or Not rs.Eof Then
		arrRs = rs.GetRows(iCnt)
		intFlds = UBound(arrRs, 1)
		intRows = UBound(arrRs, 2)
	Else
		JSalert("출항자로 등록된 인원이 없습니다.")
	End If
	rsc()

	Response.Buffer = True
	Response.ContentType = "application/vnd.ms-excel"
	Response.AddHeader "Content-disposition","attachment;filename="& Server.URLPathEncode(title) &".xls"
%>

<html>
<head>
<title>출입항 보고서</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link rel="stylesheet" type="text/css" href="http://www.unoweb.co.kr/inc/css/basic01.css"> -->
<style type="text/css">
<!--
body {}
th {font-family:돋움; font-weight:bold; margin:0px; color:#000; font-size:15px; line-height:18px; text-align:center;}
td {font-family:돋움; font-weight:bold; margin:0px; color:#000; font-size:15px; line-height:18px; text-align:center;}
.lf {text-align:left;}
.ct {text-align:center;}
.rg {text-align:right;}
-->
</style>
</head>

<body style="margin-left:-20px; margin-top:-10px; margin-right:-20px; margin-bottom:0px; mso-header-margin:-30pt; mso-paper-source:0;">
<table width="690" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<th rowspan="2" colspan="5" style="font-size:19px;line-height:21px;">낚시어선 출입항 보고서</th>
		<th height="23">처리기관</th>
	</tr>
	<tr>
		<th height="23">즉시</th>
	</tr>
	<tr height="23">
		<th colspan="3">낚시어선 신고번호</th>
		<th>&nbsp;</th>
		<th>보고기관</th>
		<th>&nbsp;</th>
	</tr>
	<tr height="23">
		<th colspan="3">어선번호</th>
		<th style="font-size:12px;">&nbsp;<%=shipinfo(shipid,"shipno")%></th>
		<th>어선명칭</th>
		<th><%=shipinfo(shipid,"shipnm")%></th>
	</tr>
	<tr height="23">
		<th colspan="3">영업구역</th>
		<th>충남해상일원</th>
		<th>낚시장소</th>
		<th>충남해상일원</th>
	</tr>
	<tr height="23">
		<th colspan="3">출항예정일시</th>
		<th><%=yy%>-<%=mm%>-<%=dd%></th>
		<th>입항예정일시</th>
		<th>&nbsp;</th>
	</tr>
	<tr height="24">
		<th colspan="6">낚시어선 승선인 명단</th>
	</tr>
	<tr height="24" style="font-size:11px;">
		<th width="40">순번</th>
		<th width="60">성별</th>
		<th width="90">성명</th>
		<th width="140">생년월일</th>
		<th width="210">주소</th>
		<th width="150">전화</th>
	</tr>
<%
'Response.Write "intRows : "& intRows &"<br>"
'idx(0), ssid(1), ridx(2), uno(3), shipid(4), rdate(5), rname(6), hp(7), addr(8), ddate(9), gubn(10)

	For intLoop = 0 To intRows
%>
	<tr height="23" style="font-size:11px;">
		<td style="mso-number-format:\@"><%=intLoop + 1%></td><!-- 순번 -->
		<td>&nbsp;</td><!-- 성별 -->
		<td><%=arrRs(6,intLoop)%></td><!-- 성명 -->
		<td>&nbsp;</td><!-- 생년월일 -->
		<td class="lf"><font style="font-size:11px; letter-spacing:-1;"><%=arrRs(8,intLoop)%></font></td><!-- 주소 -->
		<td style="mso-number-format:\@"><%=ontel(arrRs(7,intLoop),1)%>-<%=ontel(arrRs(7,intLoop),2)%>-<%=ontel(arrRs(7,intLoop),3)%></td><!-- 전화번호 -->
	</tr>
<%
	Next

	For intLoop = rcnt To 19
%>
	<tr height="23" style="font-size:11px;">
		<td style="mso-number-format:\@"><%=intLoop + 1%></td><!-- 순번 -->
		<td>&nbsp;</td><!-- 구분 -->
		<td>&nbsp;</td><!-- 성명 -->
		<td>&nbsp;</td><!-- 주민등록번호 -->
		<td>&nbsp;</td><!-- 주소 -->
		<td>&nbsp;</td><!-- 전화번호 -->
	</tr>
<%	Next %>
	<tr height="23" style="font-size:11px;">
		<td>&nbsp;</td><!-- 순번 -->
		<td>선장</td><!-- 구분 -->
		<td>&nbsp;<%=shipinfo(shipid,"captain")%></td><!-- 성명 -->
		<td>&nbsp;</td><!-- 주민등록번호 -->
		<td>&nbsp;</td><!-- 주소 -->
		<td>&nbsp;</td><!-- 전화번호 -->
	</tr>
	<tr height="23" style="font-size:11px;">
		<td>&nbsp;</td><!-- 순번 -->
		<td>부선장</td><!-- 구분 -->
		<td>&nbsp;<%=shipinfo(shipid,"captain_sub")%></td><!-- 성명 -->
		<td>&nbsp;</td><!-- 주민등록번호 -->
		<td>&nbsp;</td><!-- 주소 -->
		<td>&nbsp;</td><!-- 전화번호 -->
	</tr>
	<tr height="25">
		<td colspan="6" style="font-size:13px;">낚시 어선어법 제11조 6항 및 동법시행규칙 제6조 3항의 규정에 의하여 같이 보고합니다.</td>
	</tr>
	<tr height="25">
		<td colspan="6" class="rg" style="font-size:13px;">
			년&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			월&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			일&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<tr height="25">
		<td colspan="6" class="rg" style="font-size:13px;">
			보고인 :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=shipinfo(shipid,"captain")%>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="#999999">(서명날인)</font>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<th rowspan="2" colspan="2">구비서류</th>
		<th rowspan="2" colspan="3" style="font-size:12px;">주민등록 또는 확인할 수 있는 증명서</th>
		<th height="21">수수료</th>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
	</tr>
</table>
<%	dbc() %>
