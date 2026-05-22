<!-- #include virtual = "/inc/header_addr.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	Set cx = New BsfCode
	tag							= 1

	prevURL = Request.ServerVariables("HTTP_REFERER")
'	Response.Write "<br>prevURL : "& prevURL &"<br>"

	If prevURL <> httpsRoot &"/mem/mod_chk.asp" Then
		Call noAlertGo(httpsRoot &"/mem/mod_chk.asp")
		Response.End
	End If

	rso()
	SQL = " SELECT memid, mempw, uname, unamee, tel, email, hp, memtype, zip, addr1, addr2, ddate, point, cnt, ldate FROM _omemt010 WHERE seq = "& FID_NO
	rs.open SQL, dbcon, 3
	If Not rs.EOF Then
		memid					= rs("memid")
		mempw					= cx.SetDecode(rs("mempw"))
		uname					= rs("uname")
		unamee					= rs("unamee")
		tel						= rs("tel")
		email					= cx.SetDecode(rs("email"))
		hp						= rs("hp")
		memtype					= rs("memtype")
		zip						= rs("zip")
		addr					= rs("addr1") &" "& rs("addr2")
		ddate					= rs("ddate")
		point					= rs("point")
		cnt						= rs("cnt")
		ldate					= rs("ldate")
	Else
		Call AlertGo("해당 정보가 없습니다.","/")
		Response.End
	End If
	rsc()

	If email <> "" Then
		email1					= Left(email, InStr(email, "@")-1)
		email2					= Right(email, Len(email)-Len(email1)-1)
	End If
'	Response.Write "<font color=#ffffff>email : "& email &"</font><br>"
%>

<script type="text/javascript">
<!--
function selectMail(form){
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if(len == "직접입력"){
		txtbox = "<input type='text' name='email3' id='email3' maxlength='30' style='width:120px;'>";
		layer10.innerHTML = txtbox;
	}else{
		layer10.innerHTML = "";
	}
}
function goSave(){
	var f = document.fm1;
	if($("#unamee").val() == "" || $("#unamee").val().trim().length == 0){		//닉네임
		alert("닉네임을 입력하세요.");
		$("#unamee").focus();
		return;
	}
	if($("#pw01").val() != ""){
		if(!IsPW(f.pw01.name)){
			alert("비밀번호는 4 ~ 10자의 영문자나 숫자 또는 조합된 문자열이어야 합니다.");
			$("#pw01").focus();
			$("#pw01").select();
			return;
		}
		if($("#pw01").val() != $("#pw02").val()){		//비밀번호 일치확인
			alert("입력하신 비밀번호가 일치하지 않습니다.\n확인하시기 바랍니다.");
			$("#pw02").focus();
			$("#pw02").select();
			return;
		}
	}
	if($("#hp1").val() == "" || $("#hp2").val() == "" || $("#hp3").val() == ""){	//휴대전화번호 체크
		alert("휴대전화번호를 입력해 주세요.");
		return;
	}
	if($("#zip").val() == ""){		//우편번호 입력체크
		alert("우편번호 검색버튼을 이용하여 우편번호를 선택하세요.");
		return;
	}
	if($("#addr").val() == ""){		//주소 입력체크
		alert("우편번호 검색버튼을 이용하여 해당 주소를 선택하세요.");
		$("#addr").focus();
		return;
	}
	if($("#email1").val() == ""){		//이메일 체크
		alert("이메일 계정을 입력해 주세요.");
		$("#email1").focus();
		return;
	}
	if($("#email2").val() == ""){		//이메일 체크
		alert("이메일 도메인을 선택하여 입력하세요.");
		$("#email2").focus();
		return;
	}
//	for (var i = 0; i < f.ulevel.length; i++){		//라디오버튼의 갯수 - 1 만큼 loop
//		if(f.ulevel[i].checked == true){			//체크된 버튼을 찾으면
//			alert(f.ulevel[i].value);
//			return;
//		}
//	}
//	if(i == f.ulevel.length){		//체크된 숫자가 라디오버튼의 갯수와 같으면
//		alert("직급을 하나 골라 주세요.");
//		return;
//	}
	f.action = "mod_x.asp";
	f.submit();
}
function chkJumin1(){
	if(document.fm1.jumin1.value.length == 6)
		document.fm1.jumin2.focus();
}
function chkJumin2(){
	if(document.fm1.jumin2.value.length == 7)
		document.fm1.memid.focus();
}
function chkTel1(){
	if(document.fm1.tel2.value.length == 4)
		document.fm1.tel3.focus();
}
function chkTel2(){
	if(document.fm1.tel3.value.length == 4)
		document.fm1.hp1.focus();
}
function chkHp0(){
	if(document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp1(){
	if(document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function IsID(formname){
	var form = eval("document.fm1." + formname);

	if(form.value.length < 4 || form.value.length > 12){
		return false;
	}
	for (var i = 0; i < form.value.length; i++){
		var chr = form.value.substr(i,1);
		if((chr < '0' || chr > '9') && (chr < 'a' || chr > 'z')){
			return false;
		}
	}
	if(form.value == "guest") return false;
	return true;
}
function IsPW(formname){
	var form = eval("document.fm1." + formname);

	if(form.value.length < 4 || form.value.length > 12){
		return false;
	}
	for (var i = 0; i < form.value.length; i++){
		var chr = form.value.substr(i,1);
		if((chr < '0' || chr > '9') && (chr < 'a' || chr > 'z') && (chr < 'A' || chr > 'Z')){
			return false;
		}
	}
	return true;
}
function IsNumber(formname){
	var form = eval("document.fm1." + formname);
	for (var i = 0; i < form.value.length; i++){
		var chr = form.value.substr(i,1);
		if(chr < '0' || chr > '9'){
			return false;
		}
	}
	return true;
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="chknickflag">
<input type="hidden" name="chkidflag">
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/my.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/bbs/mypage_tle.png" alt="마이페이지" title="마이페이지" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/mem_mod_tle.gif" alt="회원정보수정" title="회원정보수정" />
					</div>
					<div>
						<div class="gbox03" style="padding:15px 20px 20px 20px;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">이름(실명)</span></li>
									<li style="width:500px;" class="ib">
										<%=FID_NAME%>
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">닉네임</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="unamee" id="unamee" value="<%=unamee%>" maxlength="20" style="width:130px;" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">아이디</span></li>
									<li style="width:500px;" class="ib">
										<span class="fc8 fb ff f15"><%=FID_ID%></span>
										<!-- <a href="mem_photo.asp?seq=<%=FID_NO%>&memid=<%=FID_ID%>"><img src="<%=memPhoto(FID_NO)%>" width="50" title="회원대표사진"></a> -->
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">비밀번호</span></li>
									<li style="width:500px;" class="ib">
										<input type="password" name="pw01" id="pw01" maxlength="16" placeholder="" style="width:130px;" />
										<span class="f11 fc8 pl10">비밀번호 변경시에만 입력하세요. (영문 + 숫자 4자 이상 16자 이내)</span>
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">비밀번호 확인</span></li>
									<li style="width:500px;" class="ib">
										<input type="password" name="pw02" id="pw02" maxlength="16" class="bx1" style="width:130px;" />
										<span class="f11 fc8 pl10">다시 한번 비밀번호를 입력하세요.</span>
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">전화번호</span></li>
									<li style="width:500px;" class="ib">
										<select name="tel1" id="tel1" style="width:60px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '일반전화' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If TelSepa(tel,"1") = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
										</select>
										-
										<input type="text" name="tel2" id="tel2" value="<%=TelSepa(tel,"2")%>" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkTel1();" />
										-
										<input type="text" name="tel3" id="tel3" value="<%=TelSepa(tel,"3")%>" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkTel2();" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">휴대전화번호</span></li>
									<li style="width:500px;" class="ib">
										<select name="hp1" id="hp1" style="width:60px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '휴대전화' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If onTel(hp,"1") = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
										</select>
										-
										<input type="text" name="hp2" id="hp2" value="<%=onTel(hp,"2")%>" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkHp1();" />
										-
										<input type="text" name="hp3" id="hp3" value="<%=onTel(hp,"3")%>" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
<script>
document.domain = "badawa.co.kr";
function jusoCallBack(zipNo,roadFullAddr){
	if(roadFullAddr.indexOf('?') == -1){
		$("#zip").val(zipNo);
		$("#addr").val(roadFullAddr);
	}else{
		alert('주소 정보를 가져오는데 문제가 발생했습니다.\n다시 주소를 선택 바랍니다.');
		document.location.reload();
	}
}
function goPopup(){
	var pop = window.open("/mem/jusoPopup.asp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
</script>
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">주소</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="zip" id=zip value="<%=zip%>" readonly style="width:70px;" />
										<a href="javascript:;" onclick="goPopup();" class="btn btn21"><span>우편번호 찾기</span></a>
										<input type="text" name="addr" id=addr value="<%=addr%>" style="width:95%;" readonly />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">이메일</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="email1" id="email1" maxlength="20" value="<%=email1%>" style="width:100px;" />
										@
										<select name="email2" id="email2" style="width:120px;" onChange="selectMail(this.form);">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = " SELECT ISNULL(COUNT(*),0) FROM _ocodt010 WHERE gubn = '이메일' AND code_nm = '"& email2 &"' "
		rs.open SQL, dbcon
			ecnt = CInt(rs(0))
		rsc()

		If ecnt = 0 Then
			email7 = "직접입력"
		Else
			email7 = email2
		End If

		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '이메일' ORDER BY idx ASC "
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
										<span id="layer10"><input type="text" name="email3" id="email3" value="<%=email2%>" maxlength="30" style="width:120px;" /></span>
<%		Else %>
										<span id="layer10"></span>
<%		End If %>
										<span class="f11 fc8 pt5">비밀번호 분실시 필요합니다. 정확하게 입력하세요.</span>
									</li>
								</ul>
							</div>
						</div>
						<!-- gbox03 E -->
					</div>

					<div style="margin:30px 0px;"></div>

					<div class="ct">
						<a href="/" class="btn btn25"><span>취소</span></a>
						<!-- <a href="mem_photo.asp?seq=<%=FID_NO%>&memid=<%=FID_ID%>" class="btn btn25"><span>사진관리</span></a> -->
						<a href="javascript:goSave();" class="btn btn25"><span>확인</span></a>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
</form>
<!-- #include virtual = "/inc/footer.asp" -->
