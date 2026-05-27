<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	op							= SQLI(Request("op"))
	flag						= SQLI(Request("flag"))

	If op = "" Then op = "gallery"

	If idx = "" Then
		Call AlertClose("문제가 있습니다.        ")
		Response.End
	End If

	Select Case op
		Case "gallery"			: tbl = "_obbst021"
		Case "ps"				: tbl = "_obbst051"
	End Select

	rso()
	SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext FROM "& tbl &" WHERE idx = "& idx
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		seq						= rs("seq")
		fpath					= rs("fpath")
		fnm						= rs("fnm")
		fsz						= rs("fsz")
		fwd						= rs("fwd")
		ext						= rs("ext")
	Else
		Call AlertClose("해당 이미지가 없습니다.        ")
		Response.End
	End If
	rsc()
%>

<script language="JavaScript">
<!--
function chkPhoto(vflag) {
	var f = document.fm1;
//	if (confirm("대표 이미지로 지정하겠습니까?")) {
		f.action = "imgv_album_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
//	}
}
function goSave() {
	var f = document.fm1;
	f.action = "imgv_album_x.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>

<table width="800" border="0" cellpadding="0" cellspacing="0" align="center">
<form name="fm1" method="post">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="op" value="<%=op%>">
	<tr>
		<td align="center">
			<table width="680" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="ct"><img src="<%=fpath &"/"& fnm%>" style="cursor:hand;" onClick="window.close();"></td><!-- onClick="goClose(0)" -->
							</tr>
						</table>
					</td>
				</tr>
				<tr height="30">
					<td class="ct">
						<!--
						<input type="text" name="comment" value="<%=comment%>" class="bx1" style="width:560px; ime-mode:active;">
						<a href="javascript:goSave();" class="btn btn21"><span>설명저장</span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;
						대표사진지정&nbsp;&nbsp;<input type="checkbox" name="cbox" value="Y" onClick="chkPhoto()"<%If best Then%> checked<%End If%>>
						//-->
					</td>
				</tr>
			</table>
		</td>
	</tr>
</form>
</table>
</body>
</html>
<%	dbc() %>