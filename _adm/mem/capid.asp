<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	sValue					= SQLI(Request("cValue"))

	If sValue <> "" Then
		If Len(sValue) > 20 Then
			Call JSalert("아이디는 20글자 미만으로 입력하세요.        ")
			Response.End
		End If
	End If
%>

<script language="JavaScript">
<!--
function goSearch() {
	var f = document.fm1;
	if (f.cValue.value == "") {
		alert("회원 이름을 입력하세요.       ");
		f.cValue.focus();
		return;
	} else {
		f.method = "post";
		f.action = "capid.asp";
		f.submit();
	}
}
//-->
</script>

<table width="446" border="0" cellspacing="0" cellpadding="0">
<form name="fm1" method="post">
	<tr>
		<td height="409" valign="top">
			<table width="446" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><img src="/img/capid_tle.gif" width="446" height="81"></td>
				</tr>
				<tr>
					<td height="310" align="center" valign="top" background="/img/zip_bx03.gif">
						<table width="397" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td height="78" bgcolor="#e8f5fe">
									<table width="367" border="0" cellspacing="0" cellpadding="0" align="center">
										<tr>
											<td height="53" bgcolor="#cce6f7" class="ct">
												<table width="357" border="0" cellspacing="0" cellpadding="0" align="center">
													<tr>
														<td height="12" bgcolor="#ffffff"></td>
													</tr>
													<tr>
														<td bgcolor="#ffffff">
															<!-- 이름 입력 부분 -->
															<table border="0" cellspacing="0" cellpadding="0" align="center">
																<tr>
																	<td class="p20">이름입력&nbsp;&nbsp;</td>
																	<td><input type="text" name="cValue" class="bx1" value="<%=sValue%>" style="width:90px;ime-mode:active;" maxlength="20"></td>
																	<td width="7"></td>
																	<td><a href="javascript:goSearch();"><img src="/img/btn_src.gif" alt="ID검색"></a></td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="11" bgcolor="#ffffff"></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<!-- ID 검색결과 -->
								<td height="102"><iframe src="capid_sub.asp?cValue=<%=sValue%>" width="397" height="210" frameborder="0" style="border:1 solid #dcdcdc;" class="box"></iframe></td>
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
</table>
</body>
</html>
<%	dbc() %>