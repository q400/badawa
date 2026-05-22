<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"

	Set cx = New BsfCode

	If seq <> "" Then
		rso()
		SQL = " SELECT	seq, shipid, title, uno, uip, cnt, rdate, ddate FROM _obbst050 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			title				= rs("title")
			uno					= rs("uno")
			uip					= rs("uip")
			cnt					= rs("cnt")
			rdate				= rs("rdate")
			ddate				= rs("ddate")
		End If
		rsc()

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst051 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = rs(0)
		rsc()
	End If
%>

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<link rel="stylesheet" href="/lib/css/demos.css">

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	if (f.uname.value == "") {
		alert("이름을 입력하세요.");
		f.uname.focus();
		return;
	}
	if (f.title.value == "") {
		alert("제목을 입력하세요.");
		f.title.focus();
		return;
	}
	if (confirm("입력하시겠습니까?")) {
		upload();
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	} else {
		return;
	}
}
function goDelete() {
	var f = document.fm1;
	if (f.pwd.value == "") {
		alert("비밀번호를 입력하세요.");
		f.pwd.focus();
		return;
	}
	if (confirm("삭제하시겠습니까?")) {
		f.flag.value = "D";
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function delPhoto(xidx) {
	var f = document.fm1;
	if (confirm("이미지를 삭제하겠습니까?")) {
		f.idx.value = xidx;
		f.flag.value = "DP";
		f.action = "ps_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function upload() {
//	document.all.upload.style.visibility = "visible";
	mpop7('/inc/loader.html','ev','center',50,50,0);
}
function make() {						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++) {
		txtbox = txtbox + "<div class='pt5'>사진 : <input type='file' name='upFile' class='bx1' style='width:485px;'></div>";
		txtbox = txtbox + "<div class='pb5'>설명 : <input type='text' name='upText' class='bx1' style='width:480px;'></div>";
	}
	layer17.innerHTML = txtbox;
}
function chkHp0() {
	if (document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp1() {
	if (document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function chkHp2() {
	if (document.fm1.hp3.value.length == 4)
		document.fm1.title.focus();
}
//-->
</script>
<script>
$(function() {
	$("#datepicker").datepicker();
//	$("#format").val("yy-mm-dd");
//	$("#format").change(function() {
//	$("#datepicker").datepicker("<%=rdate%>", "dateFormat", "yy-mm-dd");//$(this).val()
//	});
});
</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/fish.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/commu_tle.gif" width="195" height="24"></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/fish_myps.gif" width="180" height="18" alt="나의 조황후기" /></td>
							</tr>
							<tr>
								<td height="27" bgcolor="#ffffff"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/brd_w_sul.gif" width="542" height="57" alt="설명문구"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">
									<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post" enctype="multipart/form-data" onsubmit="return goSave()">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">

										<tr>
											<td height="11"></td>
											<td height="11"></td>
											<td height="11"></td>
											<td height="11"></td>
										</tr>
										<tr>
											<td width="41" height="24">&nbsp;</td>
											<td width="82"><img src="/img/b_t2_name.gif" width="82" height="24" alt="작성자"></td>
											<td width="26">&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160"><input type="text" name="uname" value="<%=FID_NIC%>" maxlength="20" class="bx1" style="width:160px;"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/ship.gif" width="82" height="24" alt="선박선택"></td>
											<td>&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160">
															<select name="shipid" style="width:120px;">
															<option value="">선택</option>
<%
	rso()
	SQL = " SELECT shipid, shipnm FROM _oshpt010 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
															<option value="<%=rs("shipid")%>"<%If CInt(shipid) = rs("shipid") Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
															</select>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/selectday.gif" width="82" height="24" alt="날짜선택"></td>
											<td>&nbsp;</td>
											<td><input type="text" name="rdate" id="datepicker" value="<%=rdate%>" class="bx1" style="width:90px;"/></td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_subject.gif" width="82" height="24" alt="제목"></td>
											<td>&nbsp;</td>
											<td><input type="text" name="title" value="<%=title%>" maxlength="20" class="bx1" style="width:500px;"></td>
										</tr>
										<tr>
											<td height="2"></td>
											<td height="2"></td>
											<td height="2"></td>
											<td height="2"></td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td></td>
											<td>&nbsp;</td>
											<td>
<%
		If seq <> "" Then
			rso()
			SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _obbst051 WHERE seq = "& seq
			rs.open SQL, dbcon
			k = 1
			While Not rs.eof
%>
												<a href="javascript:Popup('/inc/imgv_ps.asp?seq=<%=seq%>&idx=<%=rs("idx")%>&op=ps',820,770,100,50,1,1,1);">
												<img src="<%=rs("fpath") &"/"& rs("fnm")%>" width="100" align="absmiddle"<%If rs("best") Then%> style="background-color:#cc0000; padding:3px;"<%End If%>></a>
												<input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="delPhoto(<%=rs("idx")%>)">
												<%If k Mod 5 = 0 Then%><br><%End If%>
<%
				k = k + 1
				rs.MoveNext
			Wend
			rsc()
		End If
%>
											</td>
										</tr>
										<tr>
											<td height="3"></td>
											<td height="3"></td>
											<td height="3"></td>
											<td height="3"></td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_file.gif" width="82" height="24" alt="첨부파일"></td>
											<td>&nbsp;</td>
											<td>
												<select name="filecnt" onChange="make();" style="width:60px;">
												<option value="0">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												</select>&nbsp;&nbsp;<font class="f11 fc8"><b>1MB 이하</b>의 사진 파일만, 사진설명과 함께 등록하세요.</font>
												<br>
												<span id="layer17"></span>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td></td>
										</tr>
</form>
									</table>
								</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line02.gif" width="710" height="5"></td>
							</tr>
							<tr>
								<td height="6" bgcolor="#ffffff"></td>
							</tr>
							<tr>
								<td class="rg" bgcolor="#ffffff">
									<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%	If flag <> "W" Then %>
									<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%	End If %>
									<a href="ps.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
								</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">&nbsp;</td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">&nbsp;</td>
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