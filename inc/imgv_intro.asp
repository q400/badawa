<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	idx							= SQLI(Request("idx"))
	op							= SQLI(Request("op"))
	flag						= SQLI(Request("flag"))

	If idx = "" Then
		Call AlertClose("문제가 있습니다.")
		Response.End
	End If

	rso()
	SQL = " SELECT	idx, gubn, fpath, fnm, comment FROM _ocmmt010 WHERE idx = "& idx
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		fpath					= rs("fpath")
		fnm						= rs("fnm")
		comment					= rs("comment")
	Else
		Call AlertClose("해당 이미지가 없습니다.")
		Response.End
	End If
	rsc()

	pvP = 0
	ntP = 0

	rso()
	SQL = " SELECT TOP 1 idx FROM _ocmmt010 WHERE gubn = 'photo' AND idx < "& idx &" ORDER BY idx DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
	End If
	rsc()

	rso()
	SQL = "	SELECT TOP 1 idx FROM _ocmmt010 WHERE gubn = 'photo' AND idx > "& idx &" ORDER BY idx "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
	End If
	rsc()
%>

<script language="javascript">
<!--
function goSave(){
	var f = document.fm1;
	f.action = "imgv_intro_x.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="idx" value="<%=idx%>">
<table width="700" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td class="ct">
			<table width="680" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="10"></td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td class="ct"><img src="/<%=fpath%>/<%=fnm%>" style="cursor:point;" onClick="window.close();"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="30">
					<td align="center">
						<input type="text" name="comment" value="<%=comment%>" style="width:500px;">
						<a href="javascript:goSave();" class="btn btn25"><span>설명저장</span></a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<%	dbc() %>