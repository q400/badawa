<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 1
	preURL						= SQLI(Request("preURL"))
%>

<script language="JavaScript">
<!--
function chkLogin(){
	if($("#userId").val() == ""){
		alert("아이디를 입력하세요.");
		$("#userId").focus();
		return;
	}
	if($("#userPw").val() == ""){
		alert("비밀번호를 입력하세요.");
		$("#userPw").focus();
		return;
	}
	fm1.action = "login_x.asp";
	fm1.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	chkLogin();
}
function init(){
	document.fm1.userId.focus();
}
window.onload = init;
function pop_find(){
	var sw = screen.width / 2;
	var sh = screen.height / 2;
	var ww = 300;
	var wh = 130;
	var px = sw - (ww / 2);
	var py = sh - (wh / 2);
	window.open('checkPassword.asp','','width='+ww+',height='+wh+',left='+px+',top='+py+',resizable=no,scrollbars=no,status=no,width=500,height=190')
}
// -->
</script>


<form name="fm1" method="post">
<input type="hidden" name="preURL" value="<%=preURL%>">
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/mem.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/memcenter_tle.gif" alt="멤버쉽센터" title="멤버쉽센터" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/memcnt_login_tle.gif" alt="로그인" title="로그인" />
					</div>
					<div style="margin:50px 0px;"></div>
					<div class="ct"><img src="/img/login_cnt01.gif" alt="회원아이디와 패스워드를 입력하세요" /></div>
					<div style="margin:30px 0px;"></div>
					<div>
						<div class="gbox04" style="width:500px;margin:0 auto;">
							<!-- 아이디/패스워드 입력 -->
							<table border=0 cellspacing="0" cellpadding="0" align="center">
								<tr>
									<td width="60">아이디</td>
									<td width="170"><input type="text" name="userId" id="userId" maxlength="20" class="bx2" tabindex=1 value="<%=Request.Cookies("MEM_ID")%>" style="width:150px; ime-mode:disabled;" /></td>
									<td width="100" rowspan="3"><a href="javascript:;" onClick="chkLogin();"><img src="/img/btn_login.gif" tabindex=3 alt="로그인" title="로그인" /></a></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" name="userPw" id="userPw" maxlength="20" class="bx2" tabindex=2 style="width:150px;" onKeyDown="writeKeyDown();" /></td>
								</tr>
							</table>
						</div>
					</div>
					<div style="margin:30px 0px;"></div>
					<div class="ct"><img src="/img/login_cnt02.gif" alt="아이디나 패스워드가 기억나지 않으시면 아래 버튼을 클릭하기 바랍니다" /></div>
					<div class="mt10 mb10"></div>
					<div class="ct">
						<a href="findId.asp"><img src="/img/btn_find_id.gif" alt="아이디찾기" title="아이디찾기" /></a>
						<a href="findPw.asp"><img src="/img/btn_find_pw.gif" alt="패스워드찾기" title="패스워드찾기" /></a>
					</div>
					<div style="margin:30px 0px;"></div>
					<hr style="border:1px solid #ddd;">
					<div style="margin:30px 0px;"></div>
					<div class="ct"><img src="/img/login_cnt03.gif" alt="회원이 아니라면 회원가입 후 서비스를 이용해 보세요" /></div>
					<div style="margin:30px 0px;"></div>
					<div class="ct">
						<a href="mem_agree.asp"><img src="/img/btn_membership.gif" alt="회원가입" title="회원가입" /></a>
					</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
</form>
<!-- #include virtual = "/inc/footer.asp" -->
