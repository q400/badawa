<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	Call dbo()
	seq						= SQLI(Request("seq"))
	cd1						= SQLI(Request("cd1"))
	cd2						= SQLI(Request("cd2"))
	page					= SQLI(Request("page"))
	flag					= SQLI(Request("flag"))			'M:수정/R:답글/NULL:입력
	prevURL					= SQLI(Request("prevURL"))
%>

<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>비밀번호입력</title>
<link rel="stylesheet" type="text/css" href="/inc/css/base.css">
<script type="text/JavaScript" src="/inc/js/shared.js"></script>
<script>
function checkpwd() {
	document.fm2.action = "pwd_x.asp";
	document.fm2.method = "post";
	document.fm2.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	checkpwd();
}
</script>
</head>


<body onLoad="document.fm2.pwd.focus();" style="background-color:#fff;">
<div id="bxView">
<table class="view">
	<tr>
		<td height="10" colspan="2"></td>
	</tr>
	<tr>
		<td class="ct" colspan="2">비밀번호를 입력하세요!</td>
	</tr>

<form name="fm2">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="prevURL" value="<%=prevURL%>">

	<tr>
		<td width="160" class="rg"><span style="fb">비밀번호</span>&nbsp;&nbsp;&nbsp;</td>
		<td>&nbsp;<input type="password" name="pwd" size="15" class="bx1" onKeyDown="writeKeyDown();"></td>
	</tr>
	<tr>
		<td class="ct" colspan="2">
			<a href="javascript:checkpwd();" class="btn btn25"><span>확인</span></a>
			<a href="javascript:goClose(0);" class="btn btn25"><span>닫기</span></a>
			<!-- <a href="javascript:checkpwd();"><img src="/img/btn/btn_ok.gif" align="absmiddle"></a><a href="javascript:parent.document.all.showimage.style.visibility='hidden';">
			<img src="/img/btn/btn_no.gif" align="absmiddle"></a> -->
		</td>
	</tr>
</form>
</table>
</div>

</body>
</html>
<%	Call dbc() %>