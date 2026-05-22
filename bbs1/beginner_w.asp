<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 60							'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	pg							= SQLI(Request("pg"))
	flag						= SQLI(Request("flag"))
	vw							= SQLI(Request("vw"))			'list/thumb
	inpwd						= SQLI(Request("pwd"))
	tag							= 5

	If pg = "" Then pg = 1
	If flag = "" Then flag = "W"

	Set cx = New BsfCode

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, nicknm, uip, cnt, ddate, contents FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			nicknm				= rs("nicknm")
			uip					= rs("uip")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = rs(0)
		rsc()
	End If

	If hp <> "" Then
		hp1						= Left(hp,3)
		hp2						= ontel(hp,2)
		hp3						= Right(hp,4)
	Else
		If FID_ID = "" Then			'Not Login 상태
			hp1					= ""
			hp2					= ""
			hp3					= ""
		Else
			hp1					= Left(FID_HP,3)
			hp2					= ontel(FID_HP,2)
			hp3					= Right(FID_HP,4)
		End If
	End If

	If flag = "W" Then
		If FID_ID = "" Then			'Not Login 상태
			uno					= ""
			nicknm				= ""
			hp1					= ""
			hp2					= ""
			hp3					= ""
		Else						'Login 상태
			uno					= FID_NO
			nicknm				= FID_NIC
			pwd					= cx.SetDecode(meminfo(FID_NO,"mempw"))
			hp1					= Left(FID_HP,3)
			hp2					= ontel(FID_HP,2)
			hp3					= Right(FID_HP,4)
		End If
	Else							'수정
		If FID_NO <> "" And CInt(FID_NO) <> uno Then			'로그인 상태이고 작성자가 아닌 경우
			If FID_AUTH = 10 Then
			Else
				Call AlertGo("글쓴이만 수정 가능합니다.         ","beginner_v.asp?seq="& seq &"&pg="& pg &"&cd1="& cd1 &"&cd2="& cd2)
				Response.End
			End If
		End If
	End If
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	if (f.nicknm.value == "") {
		alert("별명(닉네임)을 입력하세요.       ");
		f.nicknm.focus();
		return;
	}
//	if (f.pwd.value == "") {
//		alert("비밀번호를 입력하세요.       ");
//		f.pwd.focus();
//		return;
//	}
	if (f.title.value == "") {
		alert("제목을 입력하세요.       ");
		f.title.focus();
		return;
	}
	if (f.contents.value == "") {
		alert("내용을 입력하세요.       ");
		f.contents.focus();
		return;
	}
	if (confirm("입력하시겠습니까?")) {
		upload();
		f.action = "zbbs_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	} else {
		return;
	}
}
function goDelete() {
	var f = document.fm1;
	if (f.pwd.value == "") {
		alert("비밀번호를 입력하세요.       ");
		f.pwd.focus();
		return;
	}
	if (confirm("삭제하시겠습니까?       ")) {
		f.flag.value = "D";
		f.action = "zbbs_x.asp";
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
function delPhoto(xidx) {
	var f = document.fm1;
	if (confirm("이미지를 삭제하겠습니까?")) {
		f.idx.value = xidx;
		f.flag.value = "DP";
		f.action = "zbbs_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>

<table width="100%"  border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/comu.asp" --></td>
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
								<td bgcolor="#ffffff"><img src="/img/comu_beginner_tle.gif" width="179" height="18"></td>
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
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="pg" value="<%=pg%>">
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
														<td width="160"><input type="text" name="nicknm" value="<%=FID_NIC%>" maxlength="20" class="bx1" style="width:160px;"></td>
													</tr>
												</table>
											</td>
										</tr>
										<!--
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/hp.gif" width="82" height="24" alt="휴대전화"></td>
											<td>&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160">
															<select name="hp1" style="width:50px;">
															<option value="">선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '휴대전화' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
															<option value="<%=rs("code_nm")%>"<%If hp1 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
															</select>
															-
															<input type="text" name="hp2" maxlength="4" value="<%=hp2%>" class="bx1" style="width:40px;" onKeyUp="chkHp1();">
															-
															<input type="text" name="hp3" maxlength="4" value="<%=hp3%>" class="bx1" style="width:40px;" onKeyUp="chkHp2();">
															&nbsp;&nbsp;<font class="fc7 f11">※ 안내문자가 발송됩니다.</font>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										//-->
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_subject.gif" width="82" height="24" alt="제목"></td>
											<td>&nbsp;</td>
											<td><input type="text" name="title" value="<%=title%>" maxlength="20" class="bx1" style="width:490px;"></td>
										</tr>
										<tr>
											<td height="2"></td>
											<td height="2"></td>
											<td height="2"></td>
											<td height="2"></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td valign="top"><img src="/img/b_t2_content.gif" width="82" height="24" alt="내용"></td>
											<td>&nbsp;</td>
											<td><textarea name="contents" id="contents" class="tarea" style="width:490px; height:137px; ime-mode:active;"><%=contents%></textarea></td>
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
			SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext, best, comment FROM _obbst011 WHERE seq = "& seq
			rs.open SQL, dbcon
			k = 1
			While Not rs.eof
%>
<script type="text/javascript">
$(function(){
	// Dialog
	$('#dialog<%=k%>').dialog({
			autoOpen: false
		,	width: 830
		,	height: 700
//		,	buttons: {
//				"Ok": function() {
//					$(this).dialog("close");
//				}
//		,
//				"Cancel": function() {
//					$(this).dialog("close");
//				}
//			}
	});
	// Dialog Link
	$('#dialog_link<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('open');
		return false;
	});
	$('#dialog<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('close');
		return false;
	});
	//hover states on the static widgets
//	$('#dialog_link, ul#icons li').hover(
//		function() { $(this).addClass('ui-state-hover'); },
//		function() { $(this).removeClass('ui-state-hover'); }
//	);
});
</script>
												<a href="#" id="dialog_link<%=k%>" class="">
												<img src="<%=rs("fpath") &"/"& rs("fnm")%>" width="100"<%If rs("best") Then%> style="background-color:#cc0000; padding:3px;"<%End If%>></a>
												<input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="delPhoto(<%=rs("idx")%>)">
												<!-- ui-dialog -->
												<div id="dialog<%=k%>" title="이미지 크게보기" style="display:none;">
													<p class="ct"><img src="<%=rs("fpath") &"/"& rs("fnm")%>" class="ct" style="cursor:pointer;"></p>
												</div>
												<%If k Mod 5 = 0 Then%><br><%End If%>
<%
				k = k + 1
				rs.MoveNext
			Wend
			rsc()
		End If
%>
											</td>
										</tr><!--
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
												</select>&nbsp;&nbsp;<font class="f11 fc8"><b>1MB 이하</b>의 사진 파일만, <b>800Ⅹ600 사이즈</b>에 맞춰 사진설명과 함께 등록하세요.</font>
												<br>
												<span id="layer17"></span>
											</td>
										</tr> -->
										<tr>
											<td width="41" height="18"></td>
											<td width="82" height="11"></td>
											<td width="26" height="11"></td>
											<td height="11"></td>
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
									<a href="beginner.asp?pg=<%=pg%>&cd1=<%=cd1%>&cd2=<%=cd2%>&vw=<%=vw%>" class="btn btn25"><span>목록</span></a>
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
<!-- #include virtual = "/inc/footer.asp" -->