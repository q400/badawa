<%
'************************************************************************************
'*  윈도우 명		: login_p.asp
'************************************************************************************
	preURL					= Request("preURL")
%>

<html>
<head>
<title>한스푸드에 오신 것을 환영합니다.</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="shortcut icon" href="/favicon.ico">
<link rel="icon" type="image/gif" href="/favicon1.gif">
<link rel="stylesheet" type="text/css" href="/_adm/inc/css/boss.css">
<script language="JavaScript" type="text/javascript" src="/inc/js/common.js"></script>
<script language="JavaScript">
<!--
function chkLogin() {
	if (document.fm1.memid.value == "") {
		alert("아이디를 입력하세요.       ");
		document.fm1.memid.focus();
		return;
	}
	if (document.fm1.passwd.value == "") {
		alert("비밀번호를 입력하세요.        ");
		document.fm1.passwd.focus();
		return;
	}
	fm1.action = "login_px.asp";
	fm1.submit();
}
function writeKeyDown3() {
	if (event.keyCode == 13)	chkLogin();
}
function init() {
	if (document.fm1.memid.value != "") {
		document.fm1.passwd.focus();
	} else {
		document.fm1.memid.focus();
	}
}
window.onload = init;
// -->
</script>
</head>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" align="center">
			<table width="450" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post">
<input type="hidden" name="preURL" value="<%=preURL%>">

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
											<td width="149"><input type="text" name="memid" maxlength="20" class="bx2" style="width:149;height:21;ime-mode:inactive;"></td>
											<td width="8"></td>
											<td rowspan="3"><a href="javascript:chkLogin();"><img src="/img/adm/btn_login.gif" width="46" height="46"></a></td>
										</tr>
										<tr>
											<td height="2"></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td><img src="/img/adm/login_pw.gif" width="85" height="22"></td>
											<td><input type="password" name="passwd" maxlength="20" class="bx2" style="width:149;height:21;" onKeyDown="writeKeyDown();"></td>
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
				</tr><!--
				<tr>
					<td height="45"></td>
				</tr>
				<tr>
					<td height="20"></td>
				</tr>
				<tr>
					<td align="center">
						<a href="/_adm/">취소</a>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr> -->
</form>
			</table>
		</td>
	</tr>
</table>
</body>
</html>