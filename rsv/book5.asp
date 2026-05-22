<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	ssid0						= Session.SessionId
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	man							= SQLI(Request("man"))

	rso()						'출항명부 인원수
	SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE uno = '"& FID_NO &"' AND ssid = "& Session.SessionId
	rs.open SQL, dbcon
		icnt = CInt(rs(0))
	rsc()

	If man = "" Then
		If icnt = 0 Then
			Call layerClose("승선인원을 먼저 선택하세요.")
			Response.End
		Else
			man = 1
		End If
	End If

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, uno, shipid, rdate, rname, hp, addr, ddate FROM _orsvt020 WHERE uno = '"& FID_NO &"' AND ssid = "& Session.SessionId
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			rdate				= rs("rdate")
			rname				= rs("rname")
			hp					= rs("hp")
			addr				= rs("addr")
			ddate				= rs("ddate")
		End If
		rsc()
	End If

	'man0 = man - pcnt
%>

<script language="javascript">
<!--
function goSave(){
	if ($.trim($("#rname").val()) == ""){
		alert("이름은 필수입니다.");
		$("#rname").focus();
		return;
	}
	if (confirm("그대로 입력하시겠습니까?")){
		unoRequest("fm1", "book5_x.asp");
	} else {
		return;
	}
}
function goDelete(vidx){
	if (confirm("삭제하시겠습니까?")){
		unoRequest("fm1", "book5_x.asp?flag=D&idx="+ vidx);
	} else {
		return;
	}
}
function goDeleteAll(){
	if (confirm("전체 삭제하시겠습니까?")){
		unoRequest("fm1", "book5_x.asp?flag=DA");
	} else {
		return;
	}
}
//-->
</script>


<form name="fm1" id="fm1" method="post">
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
	<center>
	<div>
		<ul>
			<li class="rg mt10 mb10 pr20"><%=ssid0%> (<%=man%>명 선택)</li>
			<li>
				<div class="gbox01" style="width:580px;">
					<dl class="mt10"><b>출항명부</b>(새벽 출항 전 작성)에 기록될 사람들의 명단을 미리 작성할 수 있습니다.</dl>
					<dl class="mt5 mb10">로그인 후 "선택"을 눌러 마이페이지의 "일행관리"에 등록된 정보를 가져 올 수 있습니다.</dl>
				</div>
			</li>
			<li class="mt20">
				<center>
					<div style="width:580px; border:1px solid #eee;">
						<ul>
							<li style="width:80px;" class="ct ib"><font class="fc3">이름</font></li>
							<li style="width:100px;" class="ct ib"><font class="fc3">전화번호</font></li>
							<li style="width:380px;" class="ct ib"><font class="fc3">주소</font></li>
						</ul>
						<ul>
<%
		For nn = 0 To man - 1
			If nn = 0 Then
%>
							<li style="width:80px;" class="ct ib"><input type="text" name="rname" id="rname" value="<%=Trim(FID_NAME)%>" style="width:75px; ime-mode:active;" maxlength="15"></li>
							<li style="width:100px;" class="ct ib"><input type="text" name="hp" id="hp" value="<%=FID_HP%>" style="width:95px;" maxlength="14"></li>
							<li style="width:310px;" class="ct ib"><input type="text" name="addr" id="addr" value="<%=Trim(memInfo(FID_NO,"addr1") &" "& memInfo(FID_NO,"addr2"))%>" class="ls" style="width:320px;" maxlength="300"></li>
							<li style="width:70px;" class="ct ib"><a href="javascript:;" onClick="Popup('friendList.asp?nn=<%=nn%>',643,504,500,100,0,45);" class="btn btn21"><span>선택</span></a></li>
<%			Else %>
							<li style="width:80px;" class="ct ib"><input type="text" name="rname" id="rname" style="width:75px;ime-mode:active;" maxlength="15"></li>
							<li style="width:100px;" class="ct ib"><input type="text" name="hp" id="hp" style="width:95px;" maxlength="14"></li>
							<li style="width:310px;" class="ct ib"><input type="text" name="addr" id="addr" class="ls" style="width:320px;" maxlength="300"></li>
							<li style="width:70px;" class="ct ib"><a href="javascript:;" onClick="Popup('friendList.asp?nn=<%=nn%>',643,504,500,100,0,45);" class="btn btn21"><span>선택</span></a></li>
<%
			End If
		Next

		'If ridx <> "" Then
			rso()
			SQL = " SELECT	* FROM _orsvt020 WHERE uno = '"& FID_NO &"' AND ssid = "& Session.SessionId &" ORDER BY ddate DESC "
'			Response.Write SQL &"<br>"
			rs.open SQL, dbcon

			j = recordcount

			If Not (rs.eof And rs.bof) Then
				i = 1
				rs.MoveFirst
				Do Until rs.EOF
%>
						<ul>
							<li style="width:80px;" class="ct ib"><%=rs("rname")%></li>
							<li style="width:100px;" class="ct ib"><%=rs("hp")%></li>
							<li style="width:310px;" class="lf ib">&nbsp;&nbsp;<%=rs("addr")%></li>
							<li style="width:70px;" class="ct ib"><input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="goDelete(<%=rs("idx")%>)"></li>
						</ul>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
				Loop
			End If
			rsc()
		'End If
%>
					</div>
				</center>
			</li>
		</ul>
	</div>
	<div>
		<center class="mt10">
			<a href="javascript:;" onClick="goSave();" class="btnr btn25"><span>저장</span></a>
			<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>닫기</span></a>
		</center>
	</div>
	</center>
</div>
</form>
<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;">
<table width="430" border="0" cellspacing="0" cellpadding="0">
	<tr height="300" bgcolor="#ffffff">
		<td align="center"><img src="/img/icon/loader05.gif"></td>
	</tr>
</table>
</div>
<%	dbc() %>
