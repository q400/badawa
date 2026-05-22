<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
'	Call checkLevel(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 3

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1

	If seq <> "" Then
		rso()
		SQL = " SELECT	title, uno, uname, pwd, uip, cnt, secret, ddate, contents, answer FROM _obbst030 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uname				= rs("uname")
			pwd					= rs("pwd")
			uip					= rs("uip")
			cnt					= rs("cnt")
			secret				= rs("secret")
			ddate				= rs("ddate")
			contents			= rs("contents")
			answer				= rs("answer")
		End If
		rsc()
'		If answer = "" Then answer = "<font class='fc9'>답변 준비중입니다.</font>"
	End If
'	Response.Write "FID_NO : "& FID_NO &"<br>"
'	Response.Write "uno : "& uno &"<br>"

	If secret Then
		If FID_NO <> "" And CInt(FID_NO) <> uno Then				'로그인 상태이고 작성자가 아닌 경우
			If pwd <> inpwd Then
				Call directGo("비밀글입니다...1        ","qna.asp?page="& page &"&cd1="& cd1 &"&cd2="& cd2)
				Response.End
			End If
		End If
	End If

	pvP = 0
	ntP = 0

	rso()					'이전글
	SQL = " SELECT TOP 1 seq, title FROM _obbst030 WHERE seq < "& seq &" ORDER BY seq DESC "
	rs.open SQL, dbcon
	If Not rs.eof Then
		pvP = rs(0)
		pvTitle = rs(1)
	End If
	rsc()

	rso()					'다음글
	SQL = "	SELECT TOP 1 seq, title FROM _obbst030 WHERE seq > "& seq &" ORDER BY seq "
	rs.open SQL, dbcon
	If Not rs.eof Then
		ntP = rs(0)
		ntTitle = rs(1)
	End If
	rsc()

	SQL = " UPDATE _obbst030 SET cnt = cnt + 1 WHERE seq = "& seq
	dbcon.Execute SQL
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td>
			<table width="1190" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/comu.asp" --></td>
					<td width="800" valign="top">
						<table width="800" border="0" cellspacing="0" cellpadding="0">
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
								<td><img src="/img/comu_qna_tle.gif" width="150" height="18" alt="문의게시판"></td>
							</tr>
							<tr>
								<td height="35"></td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="800" height="1"></td>
							</tr>
							<tr>
								<td>
									<table width="800" border="0" cellspacing="0" cellpadding="0">
										<tr height="28">
											<td width="90"><img src="/img/b_t1_subject.gif" width="90" height="14"></td>
											<td style="padding-left:14px;"><b><%=title%></b></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="d8d8d8"></td>
							</tr>
							<tr>
								<td>
									<table width="800" border="0" cellspacing="0" cellpadding="0">
										<tr height="28">
											<td width="90"><img src="/img/b_t1_name.gif" width="90" height="14"></td>
											<td style="padding-left:14px;"><%=uname%></td>
											<td width="90" class="rg"><img src="/img/b_t1_date.gif" width="73" height="14"></td>
											<td width="230" style="padding-left:14px;"><%=ddate%></td>
											<td width="73"><img src="/img/b_t1_read.gif" width="73" height="14"></td>
											<td style="padding-left:14px;"><%=cnt%></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="800" height="1"></td>
							</tr>
							<tr>
								<td>
									<table width="700" border="0" cellspacing="10" cellpadding="0">
										<tr height="100">
											<td width="40" class="vt"><img src="/img/bbs/q.gif"></td>
											<td class="vt"><%=db2html(contents)%></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="1" bgcolor="d8d8d8"></td>
							</tr>
							<tr>
								<td>
									<table width="700" border="0" cellspacing="10" cellpadding="0">
										<tr height="100">
											<td width="40" class="vt"><img src="/img/bbs/a.gif"></td>
											<td class="vt">
<%		If answer = "" Then %>
												<font class="fc9">답변 준비중입니다.</font>
<%		Else %>
												<%=db2html(answer)%>
<%		End If %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line02.gif" width="800" height="5"></td>
							</tr>
							<tr>
								<td height="6"></td>
							</tr>
							<tr>
								<td class="rg">
<%		If answer = "" Then %>
<script type="text/javascript">
	$(function(){		// Dialog
		$('#dialog').dialog({
				autoOpen: false
			,	width: 300
			,	height: 270
			,	buttons: {
					"확인": function() {
								checkpwd();
					}
			,
					"취소": function() {
								$(this).dialog("close");
					}
				}
		});
		// Dialog Link
		$('#dialog_link3').click(function(){
			$('#dialog').dialog('enable').dialog('open');
			return false;
		});
		$('#dialog').click(function(){
//			$('#dialog').dialog('enable').dialog('close');
			return false;
		});
		//hover states on the static widgets
//		$('#dialog_link3, ul#icons li').hover(
//			function() { $(this).addClass('ui-state-hover'); },
//			function() { $(this).removeClass('ui-state-hover'); }
//		);
	});
</script>
									<a href="#" id="dialog_link3" class="btn btn25"><span>수정/삭제</span></a>
									<!-- ui-dialog -->
									<div id="dialog" title="비밀번호 확인" style="display:none;">
<script>
function checkpwd() {
	document.fm2.action = "pwd_x.asp";
	document.fm2.method = "post";
	document.fm2.submit();
}
function writeKeyDown() {
	if (event.keyCode == 13)	checkpwd();
}
</script>

<form name="fm2" action="pwd_x.asp">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="prevURL" value="<%=prevURL%>">

										<p class="ct mt20">
											<p><b>비밀번호를 입력하세요!</b></p>
											<p><b>비밀번호</b>&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="pwd" size="15" class="btn_input" onKeyDown="writeKeyDown();"></p>
											<!--<p class="ct"><a href="javascript:checkpwd();" class="btn btn25"><span>확인</span></a></p>-->
										</p>
</form>
									</div>
<%		End If %>
									<a href="qna.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
								</td>
							</tr>
							<tr>
								<td height="35">&nbsp;</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="800" height="1"></td>
							</tr>
							<!-- 이전글 다음글 시작 -->
							<tr>
								<td>
									<table width="800" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="90"><img src="/img/rpy_nxt.gif" width="90" height="28" alt="다음글"></td>
											<td height="28">&nbsp;<a href="?seq=<%=ntP%>"><%=ntTitle%></td>
										</tr>
										<tr>
											<td height="1" bgcolor="d8d8d8"></td>
											<td height="1" bgcolor="d8d8d8"></td>
										</tr>
										<tr>
											<td><img src="/img/rpy_pre.gif" width="90" height="28" alt="이전글"></td>
											<td height="28">&nbsp;<a href="?seq=<%=pvP%>"><%=pvTitle%></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><img src="/img/bbs_line01.gif" width="800" height="1"></td>
							</tr>
							<tr>
								<td height="32">&nbsp;</td>
							</tr>
							<!-- 한줄 댓글 시작 -->
							<!--
							<tr>
								<td height="2" bgcolor="83d4cd"></td>
							</tr>
							<tr>
								<td align="center" bgcolor="83d4cd">
									<table width="706" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="144"><img src="/img/reply_tle.gif" width="144" height="23"></td>
											<td width="480"><textarea name="textfield" id="textfield" class="bx1" style="width:480;height:38;"></textarea></td>
											<td height="56" align="center"><img src="/img/btn_reply.gif" width="61" height="38"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="2" bgcolor="83d4cd"></td>
							</tr>
							<tr>
								<td height="5"></td>
							</tr>
							<tr>
								<td height="30">양선영 (2011-09-08 오전 10:56:34) <img src="/img/rpy_delete.gif" width="13" height="13" align="absmiddle"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="d8d8d8"></td>
							</tr>
							<tr>
								<td height="30">김수현 (2011-09-08 오전 10:56:34) <img src="/img/rpy_delete.gif" width="13" height="13" align="absmiddle"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							//-->
							<tr>
								<td>&nbsp;</td>
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