<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, rmoney, pwd, uip, ddate, memo FROM _orsvt010 WHERE ridx = "& ridx
		rs.open SQL, dbcon
		If Not rs.eof Then
			rdate				= rs("rdate")
			uno					= rs("uno")
			rnm					= rs("rnm")
			inwon				= rs("inwon")
			tel					= rs("tel")
			hp					= rs("hp")
			email				= rs("email")
			ship0				= rs("shipid")
			gubn				= rs("gubn")				'D-독선/G-개인(합승)
			rmoney				= rs("rmoney")
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
		End If
		rsc()
	End If

	email0						= email
	email1						= Left(email0, InStr(email0, "@")-1)
	email2						= Right(email0, Len(email0)-Len(email1)-1)

	hp1							= onTel(hp,1)
	hp2							= onTel(hp,2)
	hp3							= onTel(hp,3)
%>

<script language="javascript">
$(document).ready(function(){
	$("#pwd").focus();
});
function chkPwd(){
<%	If OVE_ID = "" Or OVE_AUTH > 10 Then %>
	if ($.trim($("#pwd").val()) == ""){
		alert("비밀번호를 입력하세요.");
		$("#pwd").focus();
		return;
	}
<%	End If %>
	unoRequest("fm1", "rsv_pwdchk.asp");
}
function writeKeyDown(){
	if (event.keyCode == 13)	chkPwd();
}
</script>


<form name="fm1" id="fm1" method="post">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="flag" value="<%=flag%>">
<div id="wrap">
	<div class="mt10 mb10 ml20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약" /></div>
	<hr style="border:1px dotted #ccc;">
	<div class="mt10 mb10">
		<ul>
			<li style="width:400px;" class="pl35 pt3 pb3">비회원으로 한 예약입니다.</li>
			<li style="width:400px;" class="pl35 pt3 pb15">예약시 입력했던 비밀번호를 입력하세요!</li>
		</ul>
		<ul>
			<li class="pl35 pt3 pb3 ib"><input type="password" name="pwd" id="pwd" style="width:120px;" onkeydown="writeKeyDown();"></li>
			<li class="pl35 pt3 pb3 ib">
				<a href="javascript:;" onClick="chkPwd();" class="btnr btn25"><span>확인</span></a>
				<a href="javascript:history.go(-1);" class="btn btn25"><span>뒤로</span></a>
			</li>
		</ul>
	</div>
	<hr style="border:1px dotted #ccc;">
</div>
</form>
</table>
<%	dbc() %>
