<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	chk							= SQLI(Request("chk"))
	arrChk						= Split(Trim(chk), ",")
	flag						= SQLI(Request("flag"))
	tag							= 11
%>

<script language="JavaScript">
<!--
function goSave() {
	var f = document.fm1;
	if (confirm("사진인화/액자를 신청 하시겠습니까?       ")) {
		f.action = "album_x.asp";
//		f.target = "_blank";
		f.method = "post";
		f.submit();
	} else {
		return;
	}
}
function sam(op1,op2,op3) {				//계산
	var f = document.fm1;
//	alert(op1);
//	alert(op2);
//	alert(op3);
	f.ssize.value = op1;
	f.ccnt.value = op2;
	f.oz.value = op3;
	f.action = "album_s.asp";
	f.method = "post";
	f.target = "nullframe";
	f.submit();
}
function sum(op) {						//전체계산
	var f = document.fm1;
	var total = 0;
	for (var i = 1; i < op; i++) {
//		total = total + parseInt(f.cost1.value);
		total = total + parseInt(document.getElementById("cost"+i).value);
//		alert(total);
	}
	f.total.value = total;
}
//-->
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/my.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="ssize">
<input type="hidden" name="ccnt">
<input type="hidden" name="oz">

							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/my_album.gif" width="180" height="18" alt="나의앨범" title="나의앨범"></td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td>
<%	If flag = "inhwa" Then %>
									<div class="gbox01">
										<dl>* 8×10 size는 장당 <b class="fcr">2,500원</b>, 11×14 size는 장당 <b class="fcr">5,000원</b>, 기타 대형 size는 전화로 문의하세요.</dl>
										<dl>* 각각 사진의 사이즈를 선택하시면 됩니다.</dl>
										<dl>* 사진인화에 따른 택배 비용은 <b class="fcr">착불</b>입니다.</dl>
									</div>
<%	Else %>
									<div class="gbox01">
										<dl>* 액자를 포함하여 8×10 size는 개당 <b class="fcr">15,000원</b>, 11×14 size는 개당 <b class="fcr">20,000원</b>, 기타 대형 size는 전화로 문의하세요.</dl>
										<dl>* 각각 사진의 사이즈를 선택하시면 됩니다.</dl>
										<dl>* 액자신청에 따른 택배 비용은 <b class="fcr">착불</b>입니다.</dl>
									</div>
<%	End If %>
								</td>
							</tr>
							<tr>
								<td height="20"></td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td height="8"></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td height="30">
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<th width="30"></th>
											<th width="100" class="fz f13 fc9">사진</th>
											<th width="120" class="fz f13 fc9">상태</th>
											<th width="170" class="fz f13 fc9">규격선택</th>
											<th width="100" class="fz f13 fc9">장수선택</th>
											<th width="190" class="fz f13 fc9">예상가격</th>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
<%
		rso()
		SQL = " SELECT	idx, uno, op, photo, status, wdate, ddate FROM _oalbt010 WHERE idx IN ("& chk &") ORDER BY ddate DESC "
		rs.open SQL, dbcon, 0, 3
		If Not (rs.eof And rs.bof) Then
			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				Select Case flag
					Case "inhwa"			: stat = "인화신청"
					Case "frame"			: stat = "액자신청"
				End Select
%>
<input type="hidden" name="chk" value="<%=rs("idx")%>">

										<tr height="31">
											<td width="30"></td>
											<td width="100" class="ct">
												<a href="javascript:Popup('/inc/imgv_album.asp?idx=<%=rs("photo")%>&op=<%=rs("op")%>',820,770,100,50,1,1,1);"><img src="<%=photoInfo(rs("photo"),rs("op"))%>" width="60"></a></td>
											<td width="120" class="ct ls ff"><%=stat%></td>
											<td width="170" class="ct">
												<select name="size<%=rs("idx")%>" id="size<%=rs("idx")%>" class="bx1" style="width:100px;" onChange="sam(''+ this.options[this.selectedIndex].value +'',''+ document.fm1.cnt<%=rs("idx")%>.value +'',<%=rs("idx")%>);">
												<option value="0" selected>선택</option>
												<option value="1">8×10 size</option>
												<option value="2">11×14 size</option>
												<option value="3">기타</option>
												</select>
											</td>
											<td width="100" class="ct">
												<select name="cnt<%=rs("idx")%>" id="cnt<%=rs("idx")%>" class="bx1" style="width:50px;" onChange="sam(''+ document.fm1.size<%=rs("idx")%>.value +'',''+ this.options[this.selectedIndex].value +'',<%=rs("idx")%>);">
												<option value="0" selected>선택</option>
												<option value="1">1장</option>
												<option value="2">2장</option>
												<option value="3">3장</option>
												<option value="4">4장</option>
												<option value="5">5장</option>
												<option value="6">6장</option>
												<option value="7">7장</option>
												<option value="8">8장</option>
												<option value="9">9장</option>
												<option value="10">10장</option>
												</select>
											</td>
											<td class="ct">￦ <input type="text" name="cost<%=rs("idx")%>" id="cost<%=i%>" value="0" class="bx1 rg ff f11 fc7 ls fb" style="width:90px;"></td>
										</tr>
										<tr>
											<td height="1" bgcolor="#d8d8d8" colspan="10"></td>
										</tr>
<%
				rs.MoveNext
				i = i + 1
			Loop
		Else
%>
										<tr height="200">
											<td class="ct" colspan="10">등록된 사진이 없습니다.</td>
										</tr>
<%
		End If
		rsc()
%>
										<tr height="40">
											<td class="rg pr20" colspan="10">
												<b class="fz f13 fc9">예상 전체 금액(기타 항목 제외)</b>&nbsp;&nbsp;
												<a href="javascript:sum(<%=i%>);" class="btn btn18"><span>전체계산</span></a>&nbsp;&nbsp;
												￦ <input type="text" name="total" id="total" class="bx1 rg ff f11 fc7 ls fb" value="0" style="width:90px;">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="710" height="5"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
							<tr>
								<td class="rg">
<%		If FID_AUTH <> "" Then %>
									<a href="javascript:goSave();" class="btn btn25"><span>신청하기</span></a>
									<a href="album.asp" class="btnr btn25"><span>앨범으로</span></a>
<%		End If %>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
</form>
						</table>
					</td>
					<td width="140" valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>

		</td>
	</tr>
</table>
<!-- #include virtual = "/inc/footer.asp" -->