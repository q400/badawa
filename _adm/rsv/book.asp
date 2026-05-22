<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	ssid0						= session.sessionid
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	man							= SQLI(Request("man"))

	If man = "" Then
		AlertClose("승선인원을 먼저 선택해 주세요.")
		Response.End
	End If

	Set cx = New BsfCode

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, uno, shipid, rdate, rname, hp, addr, ddate FROM _orsvt020 WHERE ridx = "& ridx
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno					= rs("uno")
			shipid				= rs("shipid")
			rdate				= rs("rdate")
			rname				= rs("rname")
			hp					= rs("hp")
			addr				= rs("addr")
			ddate				= rs("ddate")
		End If
		rsc()
		rso()	'출항명부 인원수
		SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE ridx = "& ridx
		rs.open SQL, dbcon
			pcnt = CInt(rs(0))
		rsc()
	End If

	man0 = man - pcnt
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	if (confirm("그대로 입력하시겠습니까?")) {
		f.action = "book_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	} else {
		return;
	}
}
function goDelete(vidx) {
	var f = document.fm1;
	if (confirm("삭제하시겠습니까?")) {
		f.idx.value = vidx;
		f.flag.value = "D";
		f.action = "book_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function goDeleteAll() {
	var f = document.fm1;
	if (confirm("전체 삭제하시겠습니까?")) {
		f.flag.value = "DA";
		f.action = "book_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="ssid" value="<%=ssid0%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="man" value="<%=man%>">
<input type="hidden" name="idx">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap2">
		<div id="poptitle2">
			<span><p class="tt">출항명부작성</p></span>
			<!--
			<div class="gbox01">
				<dl>로그인 후 "선택"을 눌러 마이페이지의 "일행관리"에 등록된 정보를 가져 올 수 있습니다.</dl>
			</div>
			-->
			<table width=700 id="list3">
				<colgroup>
					<col style="width:100px;" />
					<col style="width:120px;" />
					<col width="*" />
					<col style="width:60px;" />
				</colgroup>
				<thead>
					<tr>
						<td class="bdr-ds1 ct">이름</td>
						<td class="bdr-ds1 ct">연락처</td>
						<td class="bdr-ds1 ct">주소지</td>
						<td class="ct">선택</td>
					</tr>
				</thead>
				<tbody>
<%
		For nn = 0 To man0 - 1
%>
					<tr>
						<td class="ct"><input type="text" name="rname" id="rname" style="width:80px;"></td>
						<td class="ct"><input type="text" name="hp" id="hp" class="f11 ff ls" style="width:100px;"></td>
						<td class="ct"><input type="text" name="addr" id="addr" class="f11 ls" style="width:380px;"></td>
						<td class="ct"><a href="#" onClick="Popup('friend.asp?nn=<%=nn%>',730,504,500,100,0,45);" class="btn btn18"><span>선택</span></a></td>
					</tr>
<%
		Next

		If ridx <> "" Then
			rso()
			SQL = " SELECT	* FROM _orsvt020 WHERE ridx = "& ridx &" ORDER BY ddate DESC "
'			Response.Write SQL &"<br>"
			rs.open SQL, dbcon

			j = recordcount

			If Not (rs.eof And rs.bof) Then
				i = 1
				rs.MoveFirst
				Do Until rs.EOF
%>
					<tr height="23">
						<td><input type="text" name="rname" id="rname" style="width:75px;" value="<%=rs("rname")%>"></td>
						<td><input type="text" name="hp" id="hp" class="f11 ff ls" style="width:95px;" value="<%=rs("hp")%>"></td>
						<td><input type="text" name="addr" id="addr" class="f11 ls" style="width:330px;" value="<%=rs("addr")%>"></td>
						<td class="ct"><input type="checkbox" name="cbox" id="cbox" value="<%=rs("idx")%>" onClick="goDelete(<%=rs("idx")%>)"></td>
					</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
				Loop
			End If
			rsc()
		End If
%>
				</tbody>
			</table>
		</div>
		<div class="mb50">
			<b><%=man%></b>명 선택
			<div id="btnarea1">
				<a href="javascript:goSave();" class="btnr btn25"><span>저장</span></a>
				<a href="javascript:window.close();" class="btn btn25"><span>닫기</span></a>
			</div>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	Set cx = Nothing %>
<%	dbc() %>
