<!-- #include virtual = "/inc/header_pop.asp" -->

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	f.action = "sms_x.asp";
	f.method = "post";
	f.submit();
}
//-->
</script>
<script>
$(function() {
	$("#datepicker").datepicker();
});
function textCounter(field, countfield, maxlimit) {
	if (field.value.length > maxlimit)
		alert("글자 수 초과입니다.        ");
		//field.value = field.value.substring(0, maxlimit);
	else
		countfield.value = maxlimit - field.value.length;
}
</script>

<table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">

<form name="fm1" method="post" onSubmit="return goSave()">

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
								<td>
									일자선택 : <input type="text" name="rdate" id="datepicker" value="" class="bx1" style="width:90px;"/>
								</td>
							</tr>
							<tr>
								<td height="9"></td>
							</tr>
							<tr>
								<td>
									<input type="text" name="note" value="<%=note%>" maxlength="100" class="bx1" style="width:530px; ime-mode:active;" onKeyDown="textCounter(this.form.note, this.form.remLen, 50);" onKeyUp="textCounter(this.form.note, this.form.remLen, 50);">
									<input type="text" readonly name="remLen" size="3" maxlength="2" value="50" class="bx1"> 글자가 남았습니다.
								</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td class="fc7">※ 선택일자에 예약한 사람들 모두에게 문자가 발송됩니다. (취소자 제외)</td>
							</tr>
							<tr>
								<td class="fc7">※ 건당 20원씩 비용이 발생되므로 신중하게 발송하세요.</td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td class="ct">
									<a href="javascript:goSave();" class="btn btn25"><span>문자보내기</span></a>
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
