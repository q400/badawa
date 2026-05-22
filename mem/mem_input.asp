<!-- #include virtual = "/inc/header_addr.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 3
	ip							= Request.servervariables("REMOTE_ADDR")
%>

<script type="text/javascript">
<!--
function checkIdWindow(ref){
	var id = eval(document.fm1.memid);
	if(!id.value){
		alert('아이디(ID)를 입력하신 후에 확인하세요!');
		id.focus();
		return;
	}else{
		ref = ref + "?pSearchID=" + id.value;
		var wleft = (screen.width-400)/2;
		var wtop = (screen.height-260)/2;
		Popup(ref,365,250,wleft,wtop,0,4);
	}
}
function selectMail(form){
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if(len == "직접입력"){
		txtbox = "<input type='text' name='email3' maxlength='30' style='width:120px;ime-mode:disabled;'>";
		layer10.innerHTML = txtbox;
	}else{
		layer10.innerHTML = "";
	}
}
function selectID(form){
	var index = form.hp1.selectedIndex;
	form.memid.value = form.hp1.options[index].value + form.hp2.value + form.hp3.value;
}
function goSave(){
	var f = document.fm1;
	if(!f.uname.value){						//이름체크
		alert("이름을 입력하세요.");
		f.uname.focus();
		return;
	}
	if(!checkName(f.uname))		return;
	if(f.checkNickNmFlag.value != "Y"){
		alert("닉네임 중복검사를 하세요.");
		return;
	}
	if(f.checkIdFlag.value != "Y"){
		alert("아이디 중복검사를 하세요.");
		return;
	}
	if(!f.memid.value){						//아이디체크
		alert("아이디(ID)를 입력하세요.");
		f.memid.focus();
		return;
	}
	if(!IsID(f.memid.name)){
		alert("아이디는 4 ~ 12자의 영문소문자나 숫자 또는 조합된 문자열이어야 합니다.");
		f.memid.focus();
		f.memid.select();
		return;
	}
	if(!f.pw01.value){						//비밀번호확인
		alert("비밀번호를 입력하세요.");
		f.pw01.focus();
		return;
	}
	if(!IsPW(f.pw01.name)){
		alert("비밀번호는 4 ~ 10자의 영문자나 숫자 또는 조합된 문자열이어야 합니다.");
		f.pw01.focus();
		f.pw01.select();
		return;
	}
	if(f.pw01.value != f.pw02.value){		//비밀번호 일치확인
		alert("입력하신 비밀번호가 일치하지 않습니다.\n확인하시기 바랍니다.");
		f.pw02.focus();
		f.pw02.select();
		return;
	}
	if(!f.email1.value){					//이메일 체크
		alert("이메일 계정을 입력해 주세요.");
		f.email1.focus();
		return;
	}
	if(!f.email2.value){					//이메일 체크
		alert("이메일 도메인을 선택하여 입력하세요.");
		f.email2.focus();
		return;
	}
	if(!f.zip.value){						//우편번호 입력체크
		alert("우편번호 검색버튼을 이용하여 우편번호를 선택하세요.");
		return;
	}
	/*
	if(!f.addr1.value){						//주소 입력체크
		alert("우편번호 검색버튼을 이용하여 해당 주소를 선택하세요.");
		f.addr1.focus();
		return;
	}
	if(!f.addr2.value){						//주소 입력체크
		alert("나머지 주소를 압력하세요.");
		f.addr2.focus();
		return;
	}*/
	if(!f.hp1.value || !f.hp2.value || !f.hp3.value){	//휴대전화번호 체크
		alert("휴대전화번호를 입력해 주세요.");
		return;
	}
//	for (var i = 0; i < f.ulevel.length; i++){		//라디오버튼의 갯수 - 1 만큼 loop
//		if(f.ulevel[i].checked == true){			//체크된 버튼을 찾으면
//			alert(f.ulevel[i].value);
//			return;
//		}
//	}
//	if(i == f.ulevel.length){				//체크된 숫자가 라디오버튼의 갯수와 같으면
//		alert("직급을 하나 골라 주세요.");
//		return;
//	}
	f.target = "_top";
	f.action = "mem_x.asp";
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
function setdiv(menu){
	if(menu == 1){
		document.getElementById("show01").style.display = "";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	}else if(menu == 2){
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	}else if(menu == 3){
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	}else if(menu == 4){
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "";
		document.getElementById("show05").style.display = "none";
	}else if(menu == 5){
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "";
	}
}
function checkNickNm(op){				//닉네임 체크
	var f = document.fm1;
	if($("#unamee").val() == ""){
		alert("닉네임을 입력하세요.");
		$("#unamee").focus();
		return false;
	}else{
		f.op.value = op;
		f.action = "checkNickNm.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function checkId(op){					//ID 체크
	var f = document.fm1;
	if($("#memid").val() == ""){
		alert("사용할 ID를 입력하세요.");
		$("#memid").focus();
		return false;
	}else{
		f.op.value = op;
		f.action = "checkId.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="checkNickNmFlag">
<input type="hidden" name="checkIdFlag">
<input type="hidden" name="op">
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
						<img src="/img/memcnt_input_tle.gif" alt="개인정보입력" title="개인정보입력" />
					</div>
					<div class="mt10"></div>
					<div>
						<div class="gbox03" style="padding:15px 20px 20px 20px;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">이름(실명)</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="uname" id="uname" maxlength="20" style="width:130px;" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">닉네임</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="unamee" id="unamee" maxlength="20" style="width:130px;" />
										<!-- <a href="#" onClick="checkNickNm(''+ fm1.unamee.value +'');"><img src="/img/btn_jungbok.gif" id="unamee" alt="닉네임중복검사" title="닉네임중복검사" /></a> -->
										<a href="javascript:;" onClick="checkNickNm(''+ fm1.unamee.value +'');" class="btng btn25"><span>중복여부확인</span></a>
										<img src="/img/nick_sul.gif" class="vm" title="홈페이지 내에서 실제로 사용될 이름입니다." />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">아이디</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="memid" id="memid" maxlength="20" style="width:130px;" />
										<!-- <a href="#" onClick="checkId(''+ fm1.memid.value +'');"><img src="/img/btn_jungbok.gif" id="memid" alt="아이디중복검사" title="아이디중복검사" /></a> -->
										<a href="javascript:;" onClick="checkId(''+ fm1.memid.value +'');" class="btng btn25"><span>중복여부확인</span></a>
										<img src="/img/id_sul.gif" class="vm" title="영문 또는 숫자 4자 이상 16자 이내" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">비밀번호</span></li>
									<li style="width:500px;" class="ib">
										<input type="password" name="pw01" id="pw01" maxlength="16" style="width:130px;" />
										<img src="/img/pw_sul01.gif" class="vm" title="영문 또는 숫자 4자 이상 16자 이내" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">비밀번호 확인</span></li>
									<li style="width:500px;" class="ib">
										<input type="password" name="pw02" id="pw02" maxlength="16" style="width:130px;" />
										<img src="/img/pw_sul02.gif" class="vm" title="비밀번호를 한번 더 입력해 주세요" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">전화번호</span></li>
									<li style="width:500px;" class="ib">
										<select name="tel1" id="tel1" style="width:80px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '일반전화' ORDER BY idx ASC "
		rs.open SQL, dbcon
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If tel1 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
										</select>
										-
										<input type="text" name="tel2" id="tel2" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkTel1();" />
										-
										<input type="text" name="tel3" id="tel3" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkTel2();" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">휴대전화번호</span></li>
									<li style="width:500px;" class="ib">
										<select name="hp1" id="hp1" style="width:80px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '휴대전화' ORDER BY idx ASC "
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
										<input type="text" name="hp2" id="hp2" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" onKeyUp="chkHp1();" />
										-
										<input type="text" name="hp3" id="hp3" maxlength="4" style="width:50px;" onKeyPress="onlyNumber()" />
									</li>
								</ul>
							</div>
							<hr style="border:1px dotted #ccc;">
<script>
document.domain = "badawa.co.kr";
function jusoCallBack(zipNo,roadFullAddr){
	console.log('___________ '+ roadFullAddr);
	console.log('___________ '+ roadFullAddr.indexOf("?"));
	if(roadFullAddr.indexOf('?') == -1){
		$("#zip").val(zipNo);
		$("#addr").val(roadFullAddr);
	}else{
		alert('주소 정보를 가져오는데 문제가 발생했습니다.\n다시 주소를 선택 바랍니다.');
		document.location.reload();
	}
	//document.getElementById('addr').value = roadFullAddr;
}
function goPopup(){
	var pop = window.open("/mem/jusoPopup.asp","pop","width=570,height=420, scrollbars=yes, resizable=yes");
}
</script>
							<div>
								<ul style="">
									<li style="width:150px;" class="ib lh32"><span class="ml20">주소</span></li>
									<li style="width:500px;" class="ib">
										<input type="text" name="zip" id=zip readonly style="width:80px;" title="우편번호찾기를 눌러 검색하세요." />
										<a href="javascript:;" onclick="goPopup();" class="btn btn21"><span>우편번호 찾기</span></a>
										<!-- <a href="javascript:;" onClick="unoPOP(9); return false;" class="btng btn25"><span>우편번호검색</span></a> -->
										<!-- <a href="javascript:;" onClick="Popup('/mem/zip3.asp',443,507,400,300,0,0,80);" class="btng btn25"> -->
										<!-- <a href="javascript:;" onClick="Popup('/mem/zip3.asp',443,507,400,300,0,0,80);"><img src="/img/btn_zip.gif" alt="우편번호검색" title="우편번호검색" /></a> -->
										<!-- <input type="text" name="addr1" id="addr1" style="width:450px;" /> -->
										<input type="text" name="addr" id=addr style="width:95%;" placeholder="나머지 주소를 입력해 주세요" />
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
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '이메일' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If tel1 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
										</select>
										<span id="layer10"></span>
									</li>
								</ul>
							</div>
						</div>
						<!-- gbox03 E -->
					</div>

					<div style="margin:30px 0px;"></div>

					<div class="ct">
						<a href="/"><img src="/img/btn_cancel.gif" alt="취소" title="취소" /></a>
						<a href="javascript:;" onClick="goSave();"><img src="/img/btn_ok.gif" alt="회원가입완료" title="회원가입완료" /></a>
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

<div id="work" style="position:absolute; width:0; left:0; top:0; height:1; z-index:1; visibility:hidden;">
	<iframe name="nullframe" src="about:blank" scrolling="yes" frameborder="0" style="width:100px; background-color:#fff;"></iframe>
</div>
