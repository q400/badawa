<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 10							'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 1

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, uip, cnt, ddate, contents FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq = "& seq
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

		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _obbst011 WHERE seq = "& seq
		rs.open SQL, dbcon
			file_cnt = rs(0)
		rsc()
	End If

	If inpwd <> pwd0 Then
		Call AlertGo("비밀번호가 다릅니다.         ","notice_v.asp?seq="& seq &"&page="& page &"&cd1="& cd1 &"&cd2="& cd2 &"")
		Response.End
	End If
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
//	if (f.uname.value == "") {
//		alert("이름을 입력하세요.       ");
//		f.uname.focus();
//		return;
//	}
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
		f.action = "zbbst_x.asp";
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
		alert("비밀번호를 입력하세요.       ");
		f.pwd.focus();
		return;
	}
	if (confirm("삭제하시겠습니까?       ")) {
		f.flag.value = "D";
		f.action = "zbbst_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function make() {						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++) {
		txtbox = txtbox + "<input type='file' name='upFile' class='bx1' style='width:508;'><br>";
	}
	layer1.innerHTML = txtbox;
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
								<td bgcolor="#ffffff"><img src="/img/comu_gongji_tle.gif" width="150" height="18"></td>
							</tr>
							<tr>
								<td height="27" bgcolor="#ffffff"></td>
							</tr>
							<!--
							<tr>
								<td bgcolor="#ffffff"><img src="/img/brd_w_sul.gif" width="542" height="57"></td>
							</tr> -->
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">
									<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post" enctype="multipart/form-data" onsubmit="return goSave()">
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">

										<tr>
											<td height="11"></td>
											<td height="11"></td>
											<td height="11"></td>
											<td height="11"></td>
										</tr><!--
										<tr>
											<td width="41" height="24">&nbsp;</td>
											<td width="82"><img src="/img/b_t2_name.gif" width="82" height="24" alt="작성자"></td>
											<td width="26">&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160"><input type="text" name="uname" maxlength="20" class="bx1" style="width:160px;"></td>
														<td width="15"></td>
														<td width="20"><!-- <input type="checkbox" name="secret" value="1"></td>
														<td width="113"><!-- <img src="/img/b_t2_sul01.gif" width="113" height="24" alt="이 글을 비밀글로 합니다."></td>
														<td width="10">&nbsp;</td>
														<td><!-- <input type="password" name="secret" maxlength="4" class="bx1" style="width:70px;"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_mail.gif" width="82" height="24" alt="이메일"></td>
											<td>&nbsp;</td>
											<td>
												<table width="100%"  border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160"><input type="text" name="email" maxlength="20" class="bx1" style="width:160px;"></td>
														<td width="15"></td>
														<td width="20"><input type="checkbox" name="checkbox" value="checkbox"></td>
														<td><img src="/img/b_t2_sul02.gif" width="131" height="24" alt="이 글을 공지사항으로 합니다."></td>
													</tr>
												</table>
											</td>
										</tr> -->
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
											<td><textarea name="contents" id="contents" class="tarea" style="width:490px; height:167px; ime-mode:active;"><%=contents%></textarea></td>
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
											<td><input type="file" name="file" id="fileField" class="bx1" style="width:490px;"></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td><img src="/img/file_sul.gif" width="170" height="22"></td>
										</tr>
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
									<a href="notice.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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