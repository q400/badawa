<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	nick					= SQLI(Request("nick"))
	If nick <> "" Then
		If Len(nick) > 20 Then
			Call JSalert("닉네임은 20글자 미만으로 입력하세요.        ")
			Response.End
		End If
	End If
%>

<script language="javascript">
function duplchk(){
	var f = document.fm1;
	if(f.nick.value == ""){
		alert("닉네임을 입력하세요.       ");
		f.nick.focus();
		return;
	}else{
		f.method = "post";
		f.action = "nickcheck.asp";
		f.submit();
	}
}
function appid(){
	var f = document.fm1;
	parent.parent.fm1.unamee.value = eval("f.nick.value");
	parent.parent.fm1.chknickflag.value = "Y";
	parent.parent.fm1.memid.focus();
//	parent.parent.fm1.pw01.focus();
	parent.document.getElementById("showimage").style.visibility = "hidden";
	parent.document.getElementById("overlay").style.visibility = "hidden";
}
</script>

<table width="460" border="0" cellspacing="0" cellpadding="0" style="margin:0px;">
<form name="fm1" method="post">
	<tr>
		<td align="center" valign="top" style="padding-top:5px;">
			<table width="446" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="/img/nickch_tle.gif" width="446" height="81"></td>
				</tr>
				<tr>
					<td height="140" valign="top" align="center" background="/img/zip_bx03.gif">
						<table width="397" border="0" cellspacing="0" cellpadding="0" align="center" class="ct cboth">
							<tr>
								<td height="140" bgcolor="E8F5FE" align="center">
									<table width="367" border="0" cellspacing="0" cellpadding="0" align="center">
										<tr>
											<td height="113" bgcolor="CCE6F7" align="center">
												<table width="357" border="0" cellspacing="0" cellpadding="0" align="center">
													<tr>
														<td height="23" bgcolor="#ffffff"></td>
													</tr>
<%
		If nick <> "" Then
			rso()
			SQL = "	SELECT * FROM _omemt010 WHERE unamee = '"& nick &"' "
			rs.open SQL, dbcon, 3
			i = 1
			If rs.eof Then
%>
													<tr height="24">
														<td class="ct" bgcolor="#ffffff">사용 가능한 닉네임입니다. </td>
													</tr>
													<tr>
														<td height="12" bgcolor="#ffffff"></td>
													</tr>
													<tr>
														<td class="ct" bgcolor="#ffffff"><a href="javascript:appid();"><img src="/img/btn_use.gif" width="78" height="22"></a></td>
													</tr>
<%			Else %>
													<tr height="60">
														<td class="ct" bgcolor="#ffffff">이미 존재하는 닉네임입니다.<br>다시 검색하여 주세요.</td>
													</tr>
<%			End If
			rsc()
		Else
%>
													<tr height="60">
														<td class="ct" bgcolor="#ffffff">닉네임을 입력하세요.</td>
													</tr>
<%		End If %>
													<tr>
														<td height="22" bgcolor="#ffffff"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="5"><!--<img src="/img/idch_id.gif" width="65" height="32">//--></td>
							</tr>
							<tr>
								<td height="1" bgcolor="dcdcdc"></td>
							</tr>
							<tr>
								<td height="43" background="/img/idch_id_bg01.gif">
									<table border="0" cellspacing="0" cellpadding="0" align="center">
										<tr>
											<td width="10"><img src="/img/idch_usernick.gif" width="59" height="18"></td>
											<td><input type="text" name="nick" value="<%=nick%>" class="bx1" style="width:120px;" maxlength="20"></td>
											<td width="10"></td>
											<td><a href="javascript:duplchk();"><img src="/img/btn_jungbok.gif" width="59" height="18" alt="닉네임중복검사"></a></td>
										</tr>
									</table>
							  </td>
							</tr>
							<tr>
								<td height="1" bgcolor="dcdcdc"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><img src="/img/zip_bx02.gif" width="446" height="12"></td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
</body>
</html>
<%	dbc() %>