<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	bbs_id						= SQLI(Request("bbs_id"))
	idx							= SQLI(Request("idx"))
	op							= SQLI(Request("op"))
	flag						= SQLI(Request("flag"))

	If idx = "" Then
		Call AlertClose("문제가 있습니다.")
		Response.End
	End If

	title						= "갤러리사진"

	rso()
	SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _ogalt021 WHERE idx = "& idx
'	Response.Write SQL &"<br>"
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		seq						= rs("seq")
		fpath					= rs("fpath")
		fnm						= rs("fnm")
		fsz						= rs("fsz")
		fwd						= rs("fwd")
		ext						= rs("ext")
		best					= rs("best")
	Else
		Call AlertClose("해당 이미지가 없습니다.")
		Response.End
	End If
	rsc()

	pvP = 0
	ntP = 0

	rso()
	SQL = " SELECT TOP 1 idx FROM _ogalt021 WHERE seq = "& seq &" AND idx < "& idx &" ORDER BY idx DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
	End If
	rsc()

	rso()
	SQL = "	SELECT TOP 1 idx FROM _ogalt021 WHERE seq = "& seq &" AND idx > "& idx &" ORDER BY idx "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
	End If
	rsc()
%>

<script type="text/javascript">
<!--
function chkPhoto(vflag){
	var f = document.fm1;
//	if (confirm("대표 이미지로 지정하겠습니까?")) {
		f.action = "imgv_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
//	}
}
function goSave(){
	var f = document.fm1;
	f.action = "imgv_xx.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>

<table width="800" border="0" cellpadding="0" cellspacing="0" align="center">
<form name="fm1" method="post">
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
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
					<td align="center">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td class="ct">
									<input type="checkbox" name="cbox" id="cbox" value="Y" onClick="chkPhoto()"<%If best Then%> checked<%End If%>> <label for="cbox">대표사진지정</label>
								</td>
							</tr>
						</table>
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