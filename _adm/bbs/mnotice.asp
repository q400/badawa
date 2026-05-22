<!-- #include virtual = "/inc/header_pop.asp" -->
<%
		rso()
		SQL = " SELECT seq, title, uno, uip, cnt, ddate, contents " _
			& "	FROM _obbst010 " _
			& " WHERE bbs_id = 10 AND seq = 59 "
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uip					= rs("uip")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()
%>

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<script language="javascript">
<!--
function goSave(){
	var f = document.fm1;
	f.action = "mnotice_x.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>
<script>
$(function(){
	$("#datepicker").datepicker();
});
function textCounter(field, countfield, maxlimit){
	if(field.value.length > maxlimit)
		alert("글자 수 초과입니다.        ");
		//field.value = field.value.substring(0, maxlimit);
	else
		countfield.value = maxlimit - field.value.length;
}
</script>


<form name="fm1" method="post">
<table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td class="ct">
			<table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class="ct">
						<table width="550" border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td height=30>
									<input type="text" name="title" value="<%=title%>" class="bx1" style="width:530px;">
								</td>
							</tr>
							<tr>
								<td height=30>
									등록일자 : <%=ddate%>
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td class="ct">
									<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
									<a href="javascript:goClose(0);" class="btn btn25"><span>닫기</span></a>
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
<%	dbc() %>
