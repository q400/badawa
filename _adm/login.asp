<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	If FID_ID <> "" And FID_AUTH <= 10 Then
		Call noAlertGo("/_adm/mem/mem.asp")
		Response.End
	End If

	preURL					= SQLI(Request("preURL"))
%>

<script language="JavaScript">
<!--
function chkLogin() {
	if (document.fm1.memid.value == "") {
		alert("아이디를 입력하세요.");
		document.fm1.memid.focus();
		return;
	}
	if (document.fm1.passwd.value == "") {
		alert("비밀번호를 입력하세요.");
		document.fm1.passwd.focus();
		return;
	}
	fm1.action = "login_x.asp";
	fm1.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	chkLogin();
}
function init() {
	document.fm1.memid.focus();
}
window.onload = init;
function pop_find() {
	var sw = screen.width / 2;
	var sh = screen.height / 2;
	var ww = 300;
	var wh = 130;
	var px = sw - (ww / 2);
	var py = sh - (wh / 2);
	window.open('checkPassword.asp','','width='+ww+',height='+wh+',left='+px+',top='+py+',resizable=no,scrollbars=no,status=no,width=500,height=190')
}
// -->
</script>


<form name="fm1" method="post">
<input type="hidden" name="preURL" value="<%=preURL%>">
<div id="wrap">
	<div><!-- #include virtual = "/_adm/inc/top.asp" --></div>
	<div style="margin:auto 0;">
		<center>
			<table width="450" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="/img/adm/login_tle.gif" width="450" height="70"></td>
				</tr>
				<tr>
					<td><img src="/img/adm/login_bx01.gif" width="450" height="15"></td>
				</tr>
				<tr>
					<td height="170" align="center" valign="middle" background="/img/adm/login_bx03.gif">
						<table width="288" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><img src="/img/adm/login_tle01.gif" width="347" height="17"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="BFBFBF"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="ffffff"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td height="46" align="center">
									<table width="288" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="85"><img src="/img/adm/login_id.gif" width="85" height="22"></td>
											<td width="149"><input type="text" name="memid" maxlength="20" class="bx2" value="<%=Request.Cookies("MEM_ID")%>" style="width:140px; ime-mode:inactive;" tabindex="1"></td>
											<td width="8"></td>
											<td rowspan="3"><a href="javascript:chkLogin();"><img src="/img/adm/btn_login.gif" width="46" height="46" tabindex="3"></a></td>
										</tr>
										<tr>
											<td height="2"></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td><img src="/img/adm/login_pw.gif" width="85" height="22"></td>
											<td><input type="password" name="passwd" maxlength="20" class="bx2" style="width:140px;" onKeyDown="writeKeyDown();" tabindex="2"></td>
											<td></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="8"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><img src="/img/adm/login_bx02.gif" width="450" height="15"></td>
				</tr>
				<tr>
					<td height="45"></td>
				</tr>
			</table>
		</center>
	</div>
	<div style="bottom:0px; height:50px;" class="vb"><!-- #include virtual = "/_adm/inc/footer.asp" --></div>
</div>
</form>
