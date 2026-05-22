<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	ssid0						= session.sessionid
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	rdate						= SQLI(Request("rdate"))
	gubn						= SQLI(Request("gubn"))
	inwon						= SQLI(Request("inwon"))
	okinwon						= shipinfo(shipid,"capa") - guestCount(shipid,rdate)		'승선 가능 인원

	If inwon = "" Then inwon = 0

'	If ridx <> "" Then
'		rso()
'		SQL = " SELECT	ridx, uno, shipid, rdate, rname, hp, addr, ddate FROM _orsvt020 WHERE ridx = "& ridx
'		rs.open SQL, dbcon
'		If Not rs.eof Then
'			uno					= rs("uno")
'			shipid				= rs("shipid")
'			rdate				= rs("rdate")
'			rname				= rs("rname")
'			hp					= rs("hp")
'			addr				= rs("addr")
'			ddate				= rs("ddate")
'		End If
'		rsc()
'		rso()						'출항명부 인원수
'		SQL = " SELECT COUNT(*) FROM _orsvt020 WHERE ridx = "& ridx
'		rs.open SQL, dbcon
'			pcnt = CInt(rs(0))
'		rsc()
'	End If

'	man0 = man - pcnt
%>

<script type="text/javascript">
<!--
function goSave(){
	var f = document.fm1;
	if(f.inwon.value == ""){
		alert("승선인원을 입력하세요.");
		f.inwon.focus();
		return;
	}
//	if(confirm("그대로 입력하시겠습니까?")){
		f.action = "bookdiv_x.asp";
		f.method = "post";
		f.submit();
//	}else{
//		return;
//	}
}
function goDelete(vidx){
	var f = document.fm1;
	if(confirm("삭제하시겠습니까?")){
		f.idx.value = vidx;
		f.flag.value = "D";
		f.action = "bookdiv_x.asp";
		f.method = "post";
		f.submit();
	}
}
function goDeleteAll(){
	var f = document.fm1;
	if(confirm("전체 삭제하시겠습니까?")){
		f.flag.value = "DA";
		f.action = "bookdiv_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="ssid" value="<%=ssid0%>">
<input type="hidden" name="rdate" value="<%=rdate%>">
<input type="hidden" name="idx">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap2">
		<div id="poptitle2">
			<span class="tt">출항명부작성</span>
			<p class="rg">(<%=inwon%>명 선택)</p>
			<table width=700 id="list1">
				<colgroup>
				<col style="width:400px;" />
				<col width="*" />
				</colgroup>
				<tr>
					<td class="bdr-ds1">
						<select name="inwon" onChange="location='bookdiv.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&rdate=<%=rdate%>&inwon='+ this.options[this.selectedIndex].value +''" style="width:120px;">
						<option value="0"<%If inwon = 0 Then%> selected<%End If%>>승선인원 선택</option>
<%		For intLoop = 1 To shipinfo(shipid,"capa") %>
						<option value="<%=intLoop%>"<%If CInt(inwon) = intLoop Then%> selected<%End If%>>전체 <%=intLoop%>명</option>
<%		Next %>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="gubn" value="G"<%If gubn = "G" Or gubn = "" Then%> checked<%End If%>>
						<span onClick="changeBox('fm1.gubn[0]')" style="cursor:hand;">개인/합승</span>
						<input type="radio" name="gubn" value="D"<%If gubn = "D" Then%> checked<%End If%><%If flag1 = "noD" Then%> disabled<%End If%>>
						<span<%If flag1 <> "noD" Then%> onClick="changeBox('fm1.gubn[1]')" style="cursor:hand;"<%End If%>>독배</span></td>
					<td><span class="fright">추가예약 가능인원&nbsp;<b><%=okinwon%></b> 명</span></td>
				</tr>
			</table>
			<table width=700 id="list">
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
<%		For nn = 0 To inwon - 1 %>
				<tr>
					<td class="ct"><input type="text" name="rname" id="rname" class="bx1" style="width:80px;"></td>
					<td class="ct"><input type="text" name="hp" id="hp" class="bx1 f11 ff ls" style="width:100px;"></td>
					<td class="ct"><input type="text" name="addr" id="addr" class="bx1 f11 ls" style="width:380px;"></td>
					<td class="ct"><a href="#" onClick="Popup('friend.asp?nn=<%=nn%>',740,500,500,100,0,45);" class="btn btn18"><span>선택</span></a></td>
				</tr>
<%		Next %>
				</tbody>
			</table>
		</div>
		<div id="btnarea1">
			<a href="javascript:goSave();" class="btnr btn25"><span>최종등록</span></a>
			<a href="javascript:history.go(-1);" class="btnr btn25"><span>이전</span></a>
			<!-- <a href="javascript:goClose('0');" class="btn btn25"><span>닫기</span></a> -->
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	Set cx = Nothing %>
<%	dbc() %>
