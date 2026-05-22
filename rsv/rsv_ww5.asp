<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->

<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<link rel="stylesheet" href="/lib/css/demos.css">

<%
	ssid						= session.sessionid
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= setp(SQLI(Request("mm")))
	dd							= setp(SQLI(Request("dd")))
	inpwd						= SQLI(Request("inpwd"))
	op							= SQLI(Request("op"))				'대기예약 구분
	okinwon						= shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & dd)		'승선 가능 인원
'	Response.Write "<font color=#ffffff>ssid : "& ssid &"</font><br>"

	If ridx = "" Then
		If CDate(Now) > CDate(yy &"-"& mm &"-"& dd) Then
			Call JSalert("과거로 예약을 잡을 수 없습니다.")
			Response.End
		End If
		If CDate(Now) + 93 < CDate(yy &"-"& mm &"-"& dd) Then
			Call JSalert("예약 가능한 기간이 아닙니다.")
			Response.End
		End If
	End If

	If guestCount(shipid,yy & mm & dd) > 0 Then
		flag1					= "noD"
	End If

	If op = "SB" Then			'대기예약의 경우 예약가능 인원
		capa9 = shipinfo(shipid,"capa")
	Else						'승선가능 인원 계산
		capa9 = okinwon
	End If

	If ridx <> "" Then flag	= "M"
	If flag = "M" Then msg = "예약을 수정합니다." Else msg = "예약하시겠습니까?"

	Set cx = New BsfCode

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, uno, rdate, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo FROM _orsvt010 WHERE ridx = "& ridx
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno					= rs("uno")
			rdate0				= rs("rdate")
			rdate				= setd(rs("rdate"))
			rnm					= rs("rnm")
			inwon				= rs("inwon")
			tel					= rs("tel")
			hp					= rs("hp")
			email				= rs("email")
			ship0				= rs("shipid")
			gubn				= rs("gubn")				'D-독선/G-개인(합승)
			status				= rs("status")				'N-대기/C-예약완료/Y-출조완료/K-예약대기
			rmoney				= rs("rmoney")
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
		End If
		rsc()
		If FID_AUTH = "" Then
			If inpwd <> "" Then
				If cx.SetEncode(inpwd) <> pwd Then
					Call JSalert("비밀번호가 다릅니다.")
					Response.End
				End If
			Else
					Call JSalert("비밀번호가 필요합니다.")
					Response.End
			End If
		End If
	End If
	'Response.Write "rdate0 : "& rdate0 &"<br>"

	If rdate = "" Then
		rdate = yy &"-"& mm &"-"& dd
	End If

'	Response.Write "<font color=#ffffff>FID_EMAIL : "& FID_EMAIL &"</font><br>"
	If email = "" Then
		If FID_EMAIL <> "" Then
			email0 = FID_EMAIL
			email1 = Left(email0, InStr(email0, "@")-1)
			email2 = Right(email0, Len(email0)-Len(email1)-1)
		Else
			email1 = ""
			email2 = ""
		End If
	Else
			email0 = email
			email1 = Left(email0, InStr(email0, "@")-1)
			email2 = Right(email0, Len(email0)-Len(email1)-1)
	End If

	If hp = "" Then
		If FID_HP <> "" Then
			hp = FID_HP
		Else
			hp = ""
		End If
	Else
			hp = hp
	End If

	If tel <> "" Then
			tel = tel
	End If

	If rnm = "" Then rnm = FID_NIC
%>

<script language="javascript">
<!--
function upload(){
	document.all.upload.style.visibility = "visible";
}
function goSave(){
	if ($.trim($("#inwon").val()) == ""){
		alert("승선인원을 입력하세요.");
		$("#inwon").focus();
		return;
	}
	if ($.trim($("#rnm").val()) == ""){
		alert("예약자 이름을 입력하세요.");
		$("#rnm").focus();
		return;
	}
	if ($.trim($("#hp").val()) == ""){
		alert("휴대전화번호는 필수입니다.");
		$("#hp").focus();
		return;
	}
<%	If FID_ID = "" Then %>
	if ($.trim($("#pwd").val()) == ""){
		alert("비회원의 경우 비밀번호는 필수입니다.");
		$("#pwd").focus();
		return;
	}
<%	End If %>
	if (confirm("<%=msg%>")){
		unoRequest("fm1", "rsv_xx.asp", "_top");
	} else {
		return;
	}
}
function goDelete(){
	var f = document.fm1;
	if (confirm("예약을 취소하시겠습니까?")){
		f.flag.value = "D";
		f.action = "rsv_xx.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<input type='file' name='upFile' class='bx1' style='width:550px;'><br>";
	}
	layer1.innerHTML = txtbox;
}
function selectMail(form){
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if (len == "직접입력"){
		txtbox = "<input type='text' name='email3' class='bx2' maxlength='30' style='width:120px;'>";
		layer10.innerHTML = txtbox;
	} else {
		layer10.innerHTML = "";
	}
}
function chkTel1(){
	if ($.trim($("#tel2")).val().length == 4)
		$("#tel3").focus();
}
function chkTel2(){
//	if (document.fm1.tel3.value.length == 4)
//		document.fm1.hp0.focus();
}
function chkHp0(){
	if (document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp1(){
	if (document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function chkHp2(){
//	if (document.fm1.hp3.value.length == 4)
//		document.fm1.email1.focus();
}
//-->
</script>
<script>
$(function(){
	$("#datepicker").datepicker();
//	$("#format").val("yy-mm-dd");
//	$("#format").change(function(){
//	$("#datepicker").datepicker("<%=rdate%>", "dateFormat", "yy-mm-dd");//$(this).val()
//	});
});
</script>
<script type="text/JavaScript">
/* modal */
function popup1(rid, sid, yy, mm, dd, man){
//	if (man == ""){
//		alert("승선인원을 먼저 선택해 주세요.");
//		$("#inwon").focus();
//		return;
//	}

	$.unoDialog({
		url: "book5.asp?ridx="+ rid +"&shipid="+ sid +"&yy="+ yy +"&mm="+ mm +"&dd="+ dd +"&man="+ man,
		dialogArguments: '',
		top: 0,
		width: 620,
		height: 530,
		scrollable: false,
		title: "출항명부작성",
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/rsv.asp" --></li>
			<li class="ib vt">

<form name="fm1" id="fm1" method="post" action="rsv_xx.asp">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="rdate" value="<%=rdate%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="op" value="<%=op%>"><!-- 대기예약 구분 -->
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="shipid" value="<%=shipid%>">

				<div id="mainwrap1">
					<div class="mt20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약타이틀" /></div>
					<div class="mt10 mb10"><img src="/img/reser_list_tle.gif" width="239" height="18" alt="낚시배예약" /></div>
					<div class="mt10 mb10"><img src="/img/reser_s_tle04.gif" width="99" height="15" alt="예약자정보입력" /></div>
					<div style="width:710px; border:0px solid #000;" class="mb10">
						<div class="gbox02">
							<div class="mt20 mb20">
								<ul style="width:710px;">
									<li class="pl20 ib" style="width:130px;">어선명</li>
									<li class="ib pt3 pb3" style="width:550px;"><b class="fcb f15"><%=shipinfo(shipid,"shipnm")%></b></li>
									<li class="pl20 ib" style="width:130px;">승선일자</li>
									<li class="ib pt3 pb3" style="width:550px;"><font class="fb fc7 ff f12 lf"><%=rdate%></font></li>
									<li class="pl20 ib" style="width:130px;">승선인원</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<select name="inwon" id="inwon" style="width:130px;">
										<option value="">승선인원 선택</option>
<%		For nn = 1 To capa9 %>
										<option value="<%=nn%>"<%If CInt(inwon) = nn Then%> selected<%End If%>>전체 <%=nn%>명</option>
<%		Next %>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;<font class="f11 fc4">추가예약 가능인원&nbsp;<b><%=okinwon%></b> 명</font>
										&nbsp;&nbsp;&nbsp;
										<a href="javascript:;" onClick="popup1('<%=ridx%>','<%=shipid%>','<%=yy%>','<%=mm%>','<%=dd%>',''+ $('#inwon').val() +''); return false;">
										<img src="/img/rsv/namebook.gif" class="vm" alt="출항명부작성" /></a>
									</li>
									<li class="ib" style="width:130px;">&nbsp;</li>
									<li class="ib pl20 pt3 pb5" style="width:550px;">
										<input type="radio" name="gubn" id="gubn1" value="G"<%If gubn = "G" Or gubn = "" Then%> checked<%End If%> class="vm">
										<label for="gubn1">개인/합승</label>
										<input type="radio" name="gubn" id="gubn2" value="D"<%If gubn = "D" Then%> checked<%End If%> class="vm">
										<label for="gubn2">독배</label>
										<!-- <span<%If flag1 <> "noD" Then%> onClick="changeBox('fm1.gubn[1]')" style="cursor:pointer;"<%End If%>>독배</span> -->
									</li>
									<li class="pl20 ib" style="width:130px;">예약자이름</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<input type="text" name="rnm" id="rnm" maxlength="20" class="bx1" style="width:130px;ime-mode:active;" value="<%=rnm%>">
										&nbsp;&nbsp;<font class="f11 fc4">비회원의 경우 꼭 실명을 넣어주세요. (회원은 닉네임 가능)</font>
									</li>
									<!--
									<li class="pl20 ib" style="width:130px;">일반전화</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<input type="text" name="tel" maxlength="20" class="bx1" style="width:130px;" placeholder="숫자만 입력하세요." value="<%=tel%>" />
									</li>
									-->
									<li class="pl20 ib" style="width:130px;">연락처</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<input type="text" name="hp" id="hp" maxlength="15" class="bx1" style="width:130px;" placeholder="숫자만 입력하세요." value="<%=hp%>" />
									</li>
									<!--
									<li class="pl20 ib" style="width:130px;">이메일</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<input type="text" name="email1" id="email1" maxlength="20" value="<%=email1%>" class="bx1" style="width:130px; ime-mode:disabled;">
										@
										<select name="email2" style="width:120px;" onChange="selectMail(this.form);">
										<option value="" selected>메일선택</option>
<%
		rso()
		SQL = " SELECT	ISNULL(COUNT(*),0) FROM _ocodt010 WHERE gubn = '이메일' AND code_nm = '"& email2 &"' "
		rs.open SQL, dbcon
			ecnt = CInt(rs(0))
		rsc()

		If ecnt = 0 Then
			email7 = "직접입력"
		Else
			email7 = email2
		End If

		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '이메일' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If email7 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
										</select>
<%		If ecnt = 0 Then %>
										<span id="layer10"><input type="text" name="email3" id="em" value="<%=email2%>" class="bx1" maxlength="30" style="width:120px; ime-mode:disabled;"></span>
<%		Else %>
										<span id="layer10"></span>
<%		End If %>
									</li>
									-->
									<li class="pl20 ib" style="width:130px;">남기는 말씀</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<textarea name="memo" id="memo" class="tarea" style="width:400px; height:65px;" placeholder="[안내] 남기실 말씀이 있으시면 적어주세요."><%=memo%></textarea>
									</li>
<%			If (flag <> "M" And FID_ID = "") Or (flag = "M" And pwd <> "") Then %>
									<li class="pl20 ib" style="width:130px;">비밀번호</li>
									<li class="ib pt3 pb3" style="width:550px;">
										<input type="password" name="pwd" id="pwd" maxlength="12" class="bx1" style="width:130px;">
										&nbsp;&nbsp;<font class="f11 fc4">비회원의 경우 필수입니다.</font>
									</li>
<%			End If %>
								</ul>
							</div>
						</div>

						<center class="mt20 mb20">
							<a href="javascript:history.go(-1);" class="btn btn25"><span>이전화면</span></a>
							<a href="/rsv/?yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>" class="btn btn25"><span>메인화면</span></a>
<%			If FID_AUTH <> "" And (status = "N" Or status = "K") Then %>
							<a href="javascript:goDelete();" class="btnr btn25"><span>예약취소</span></a>
<%			End If %>
							<a href="javascript:goSave();" class="btnr btn25"><span>예약완료</span></a>
						</center>
					</div>
					<div><img src="/img/reser_w_cnt01.gif" alt="설명1" /></div>
					<div class="mt20"><img src="/img/reser_w_cnt02.gif" alt="설명2" /></div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
</form>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<%	'Set cx = Nothing %>
<!-- #include virtual = "/inc/footer.asp" -->