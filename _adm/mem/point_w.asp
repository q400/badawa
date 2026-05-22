<!-- #include virtual = "/inc/header_pop.asp" -->

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<!-- <link rel="stylesheet" href="/lib/css/demos.css"> -->

<%
	idx							= SQLI(Request("idx"))
	gubn						= SQLI(Request("gubn"))				'ship/talk
'	Response.Write "idx : "& idx &"<br>"

	If idx <> "" Then
		rso()
		If gubn = "ship" Then
			SQL = " SELECT	idx, uno, op, shipid, rsvid, point, note, ddate FROM _opntt020 WHERE idx = "& idx
			rs.open SQL, dbcon
			If Not rs.eof Then
				uno					= rs("uno")
				op					= rs("op")
				shipid				= rs("shipid")
				rsvid				= rs("rsvid")
				point				= rs("point")
				note				= rs("note")
				ddate				= rs("ddate")
			End If
		Else
			SQL = " SELECT	idx, uno, op, seq, point, note, ddate FROM _opntt010 WHERE idx = "& idx
			rs.open SQL, dbcon
			If Not rs.eof Then
				uno					= rs("uno")
				op					= rs("op")
				seq					= rs("seq")
				point				= rs("point")
				note				= rs("note")
				ddate				= rs("ddate")
			End If
		End If
		rsc()
	End If
%>

<script language="javascript">
<!--
function upload(){
	document.all.upload.style.visibility = "visible";
}
function goSave(){
	var f = document.fm1;
	if(confirm("처리합니까?")){
//		upload();
		f.flag.value = "M";
		f.action = "point_x.asp";
		f.method = "post";
		f.submit();
	}else{
		return;
	}
}
//-->
</script>
<script>
$(function(){
	$("#datepicker").datepicker();
});
</script>


<form name="fm1" method="post">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="uno" value="<%=uno%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="rsvid" value="<%=rsvid%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="gubn" value="<%=gubn%>">
<input type="hidden" name="flag">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="430" border="0" align="center" cellspacing="0" cellpadding="0">
				<tr height="30">
					<td colspan="3"></td>
				</tr>
				<tr height="30">
					<td colspan="3" class="fc8 ct">※ 회원들이 보유한 포인트를 관리합니다.</td>
				</tr>
				<tr height="30">
					<td width="100" class="rg">회원이름</td>
					<td width="30"></td>
					<td>
						<b class="fcb"><%=meminfo(uno,"uname")%></b>
					</td>
				</tr>
				<tr height="30">
					<td class="rg">구분</td>
					<td width="30"></td>
					<td>
						<b class="fcr f15"><%=op%></b>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;변경&nbsp;
						<input type="radio" name="op" value="+"<%If op = "+" Then%> checked<%End If%>> 적립
						<input type="radio" name="op" value="-"<%If op = "-" Then%> checked<%End If%>> 차감
					</td>
				</tr>
				<tr height="30">
					<td class="rg">포인트</td>
					<td width="30"></td>
					<td>
						<b class="fcr ff f11 ls"><%=FormatNumber(point,0)%></b> 포인트
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;변경&nbsp;
						<input type="text" name="point" maxlength="7" class="bx1 ff rg" style="width:50px;"> 포인트
					</td>
				</tr>
<%	If gubn = "ship" Then %>
				<tr height="30">
					<td class="rg">해당 선박</td>
					<td width="30"></td>
					<td><%=shipinfo(shipid,"shipnm")%>&nbsp;&nbsp;(출조일자 : <b class="fcr ff f11 ls"><%=setd(rsvinfo3(rsvid,"rdate"))%></b>)</td>
				</tr>
<%	End If %>
				<tr height="30">
					<td class="rg">내역</td>
					<td width="30"></td>
					<td>
						<%=note%>
					</td>
				</tr>
				<tr height="30">
					<td class="rg">처리사유</td>
					<td width="30"></td>
					<td>
						<input type="text" name="note" class="bx1" style="width:200px; ime-mode:active;">
					</td>
				</tr>
				<tr height="30">
					<td class="rg"></td>
					<td width="30"></td>
					<td></td>
				</tr>
				<tr>
					<td class="ct" colspan="3">
						<a href="javascript:goSave();" class="btn btn25"><span>수정</span></a>
						<a href="javascript:goClose(0);" class="btn btn25"><span>창닫기</span></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;">
<table width="700" border="0" cellspacing="0" cellpadding="0">
	<tr height="600" bgcolor="#ffffff">
		<td align="center"><img src="/img/icon/loader05.gif"></td>
	</tr>
</table>
</div>
<%	Set cx = Nothing %>
<%	dbc() %>
