<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 4
	yy							= year(Date)
	mm							= setp(month(Date))
	dd							= setp(day(Date))
	op							= Request("op")

	If op = "" Then op = "04"

	opprev						= CInt(op) - 2
	opnext						= CInt(op) + 2

	If opprev < -2 Or opnext > 26 Then
		JSalert("정보가 없습니다.")
		Response.End
	End If
'	Response.Write "<font color=#ffffff>date : "& hour(now) &"</font><br>"
%>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#FFFFFF">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/data.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border=0 cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/data_tle.gif"></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/data_weather02_tle.gif" title="일본기상정보"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td><a href="?op=<%=setp(opprev)%>">이전</a> | <a href="?op=<%=setp(opnext)%>">다음</a></td>
							</tr>
							<tr>
								<td class="pl20 pt10 pb10 rg">
									<input type="text" id=divTime size=46 style="border-width:0px;">
<script language="JavaScript">
function getFullToday() {
	var yIdx = "일월화수목금토";
	var today = new Date();
	var buf = "";

	mm = today.getMonth() + 1;
	dd = today.getDate();
	h = today.getHours(); if(h>12){h-=12;ap='오후';}else{ap='오전';}
	m = today.getMinutes();
	s = today.getSeconds();

	yo = yIdx.charAt(today.getDay())+'요일';

	buf = "<%=yy%>년 "+mm+"월 "+dd+"일 "+yo+" "+ap+" "+h+"시 "+m+"분 "+s+"초";
	return buf;
}
function putsTime() {
	if (typeof(document.all.divTime) == "object") {
		//document.all.divTime.innerHTML = "" + getFullToday() + " ";
		document.all.divTime.value= "" + getFullToday() + " ";
	}
	setTimeout("putsTime()", 1000);
}
putsTime();
</script>
								</td>
							</tr>
							<tr>
								<td class="ct"><img src="http://www.imocwx.com/cwm/cwmsjp_<%=op%>.gif" width="640" height="640"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="140" valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>

		</td>
	</tr>
</table>

</body>
</html>
<!-- #include virtual = "/inc/footer.asp" -->