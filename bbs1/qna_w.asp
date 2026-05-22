<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 3

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"

	Set cx = New BsfCode

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, uname, pwd, hp, uip, cnt, secret, rsvcancel, ddate, contents, answer FROM _obbst030 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uname				= rs("uname")
			pwd0				= rs("pwd")
			hp					= rs("hp")
			uip					= rs("uip")
			cnt					= rs("cnt")
			secret				= rs("secret")
			rsvcancel			= rs("rsvcancel")
			ddate				= rs("ddate")
			contents			= rs("contents")
			answer				= rs("answer")
		End If
		rsc()
		flag = "M"
	End If
'	Response.Write "email : "& email &"<br>"
'	Response.Write "FID_EMAIL : "& FID_EMAIL &"<br>"

'	If email <> "" Then
'		email1					= Left(email, InStr(email, "@")-1)
'		email2					= Right(email, Len(email)-Len(email1)-1)
'	Else
'		If FID_ID = "" Then			'Not Login 상태
'			email1				= ""
'			email2				= ""
'		Else
'			email1				= Left(FID_EMAIL, InStr(FID_EMAIL, "@")-1)
'			email2				= Right(FID_EMAIL, Len(FID_EMAIL)-Len(email1)-1)
'		End If
'	End If

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
			unamee				= ""
			hp1					= ""
			hp2					= ""
			hp3					= ""
		Else						'Login 상태
			uno					= FID_NO
			unamee				= FID_NIC
			pwd					= cx.SetDecode(meminfo(FID_NO,"mempw"))
			hp1					= Left(FID_HP,3)
			hp2					= ontel(FID_HP,2)
			hp3					= Right(FID_HP,4)
		End If
	Else							'수정
		If FID_NO <> "" And FID_NO <> Trim(uno) Then			'로그인 상태이고 작성자가 아닌 경우
			If secret = "Y" Then								'비밀글일때 비밀번호 비교
				If inpwd <> pwd0 Then
					Call AlertGo("비밀번호가 다릅니다...1","qna_v.asp?seq="& seq &"&page="& page &"&cd1="& cd1 &"&cd2="& cd2)
					Response.End
				End If
			End If
		ElseIf FID_NO <> "" And FID_NO = Trim(uno) Then			'로그인 상태이고 작성자의 경우
		ElseIf FID_NO = "" Then									'Not Login 상태
			If secret = "Y" Then								'비밀글일때 비밀번호 비교
				If inpwd <> pwd0 Then
					Call AlertGo("비밀번호가 다릅니다...2","qna_v.asp?seq="& seq &"&page="& page &"&cd1="& cd1 &"&cd2="& cd2)
					Response.End
				End If
			End If
		End If
		If answer <> "" Then
			Call AlertGo("답변 후에는 수정하거나 삭제하실 수 없습니다.","qna.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
			Response.End
		End If
	End If

	If uname <> "" Then unamee = uname
	If pwd0 <> "" Then pwd = pwd0
%>

<script type="text/javascript">
<!--
$(document).ready(function(){
	/*
	if ($("#rsvcancel").is(':checked')==true){
		$("#title").val("456");
		$("#contents").val("123");
	}*/
});
function rsvCancel(){
	if ($("#rsvcancel").is(':checked')==true){
		$("#title").val("예약을 취소하고자 합니다.");
		$("#contents").val("예약을 취소하고자 합니다.");
	}else{
		$("#title").val("");
		$("#contents").val("");
	}
}
function goSave() {
	var f = document.fm1;
	if (f.uname.value == "") {
		alert("닉네임을 입력하세요.");
		f.uname.focus();
		return;
	}
	if (f.pwd.value == "") {
		alert("비밀번호를 입력하세요.");
		f.pwd.focus();
		return;
	}
//	if (!f.email1.value) {					//이메일 체크
//		alert("이메일 계정을 입력해 주세요.");
//		f.email1.focus();
//		return;
//	}
//	if (!f.email2.value) {					//이메일 체크
//		alert("이메일 도메인을 선택하여 입력하세요.");
//		f.email2.focus();
//		return;
//	}
	if (f.title.value == "") {
		alert("제목을 입력하세요.");
		f.title.focus();
		return;
	}
	if (f.contents.value == "") {
		alert("내용을 입력하세요.");
		f.contents.focus();
		return;
	}
	if (confirm("입력하시겠습니까?")) {
		f.action = "qna_x.asp";
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
		alert("비밀번호를 입력하세요.");
		f.pwd.focus();
		return;
	}
	if (confirm("삭제하시겠습니까?")) {
		f.flag.value = "D";
		f.action = "qna_x.asp";
		f.method = "post";
//		f.target = "nullframe";
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
function selectMail(form) {				//메일선택
	var index = form.email3.selectedIndex;
	if (form.email3.options[index].value == "") {
		alert("메일을 선택해 주세요.");
	} else if (form.email3.options[index].value == "직접입력") {
		form.email2.value = "";
		form.email2.focus();
	} else {
		form.email2.value = form.email3.options[index].value;
	}
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


<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
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
								<td bgcolor="#ffffff"><img src="/img/comu_qna_tle.gif" width="150" height="18" alt="문의게시판"></td>
							</tr>
							<tr>
								<td height="27" bgcolor="#ffffff"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/brd_w_sul.gif" width="542" height="57"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff"><img src="/img/bbs_line01.gif" width="710" height="1"></td>
							</tr>
							<tr>
								<td bgcolor="#ffffff">

<form name="fm1" method="post">
<input type="hidden" name="seq" id="seq" value="<%=seq%>" />
<input type="hidden" name="page" id="page" value="<%=page%>" />
<input type="hidden" name="cd1" id="cd1" value="<%=cd1%>" />
<input type="hidden" name="cd2" id="cd2" value="<%=cd2%>" />
<input type="hidden" name="flag" id="flag" value="<%=flag%>" />

									<table width="710" border="0" cellspacing="0" cellpadding="0">
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
														<td><input type="text" name="uname" id="uname" value="<%=unamee%>" maxlength="20" style="width:160px;"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td width="41" height="24">&nbsp;</td>
											<td width="82">&nbsp;</td>
											<td width="26">&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!--
													<tr>
														<td colspan=2>
															<input type="checkbox" name="rsvcancel" id="rsvcancel" value="1"<%If rsvcancel="1" Then%> checked<%End If%> onClick="rsvCancel();">
															<label for="rsvcancel">예약을 취소하고자 합니다.</label><!-- 취소여부 //--
														</td>
													</tr>
-->
													<tr>
														<td width="200">
															<input type="checkbox" name="secret" id="secret" value="1"<%If secret="1" Then%> checked<%End If%>>
															<label for="secret">이 글을 비밀글로 합니다.</label><!-- 비밀글 여부 FID_NO = Trim(uno) -->
														</td>
														<td>
<%		If FID_ID <> "" Then %>
															<input type="hidden" name="pwd" id="pwd" value="<%=pwd%>" alt="비밀번호" />
<%		Else %>
															<input type="password" name="pwd" id="pwd" maxlength="20" style="width:90px;" placeholder="비밀번호" alt="비밀번호" />
															로그인을 하면 비밀번호 입력은 없어집니다.
<%		End If %>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/hp.gif" width="82" height="24" alt="휴대전화"></td>
											<td>&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="180">
															<select name="hp1" style="width:55px;">
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
															<input type="text" name="hp2" maxlength="4" value="<%=hp2%>" style="width:40px;" onKeyUp="chkHp1();">
															-
															<input type="text" name="hp3" maxlength="4" value="<%=hp3%>" style="width:40px;" onKeyUp="chkHp2();">
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<!--
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_mail.gif" width="82" height="24" alt="이메일"></td>
											<td>&nbsp;</td>
											<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="160">
															<input type="text" name="email1" maxlength="20" value="<%=email1%>" style="width:100px; ime-mode:disabled;">
															@
															<input type="text" name="email2" maxlength="50" value="<%=email2%>" size="15">
															<select name="email3" style="width:120px;" onChange="selectMail(this.form);" align="absmiddle">
															<option value="">메일선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '이메일' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
															<option value="<%=rs("code_nm")%>"<%If email2 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
															</select>
														</td>
														<!-- <input type="text" name="email" value="<%=email%>" maxlength="20" style="width:160px; ime-mode:disabled;"> -->
														<!--
														<td width="15"></td>
														<td width="20"><input type="checkbox" name="checkbox" value="Y"></td>
														<td><img src="/img/b_t2_sul02.gif" width="131" height="24" alt="이 글을 공지사항으로 합니다."></td>

													</tr>
												</table>
											</td>
										</tr>
										//-->
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_subject.gif" width="82" height="24" alt="제목"></td>
											<td>&nbsp;</td>
											<td><input type="text" name="title" id="title" value="<%=title%>" maxlength="20" style="width:490px; ime-mode:active;"></td>
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
											<td><textarea name="contents" id="contents" class="tarea" style="width:490px; height:237px; ime-mode:active;"><%=contents%></textarea></td>
										</tr>
										<tr>
											<td height="3"></td>
											<td height="3"></td>
											<td height="3"></td>
											<td height="3"></td>
										</tr><!--
										<tr>
											<td height="24">&nbsp;</td>
											<td><img src="/img/b_t2_file.gif" width="82" height="24" alt="첨부파일"></td>
											<td>&nbsp;</td>
											<td><input type="file" name="file" id="fileField" style="width:490px;"></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td><img src="/img/file_sul.gif" width="170" height="22"></td>
										</tr> -->
										<tr>
											<td width="41" height="18"></td>
											<td width="82" height="11"></td>
											<td width="26" height="11"></td>
											<td height="11"></td>
										</tr>
									</table>
</form>
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
									<a href="qna.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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