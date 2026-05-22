<!-- #include virtual = "/inc/header_pop.asp" -->

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<link rel="stylesheet" href="/lib/css/demos.css">

<%
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	okinwon						= shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & dd)		'승선 가능 인원
'	Response.Write "okinwon : "& okinwon &"<br>"

	If guestCount(shipid,yy & mm & dd) > 0 Then
		flag1					= "noD"
	End If
%>

<script type="text/javascript">
function upload(){
	document.all.upload.style.visibility = "visible";
}
function rsvOK(){
	var f = document.fm1;
	if(confirm("예약을 승인하고 <%=hp1%>-<%=hp2%>-<%=hp3%> 로 sms를 발송합니다.")){
		f.flag.value = "OK";
		f.action = "rsv_x.asp";
		f.method = "post";
//		f.target = "nullframe";			//modal 창이므로 안씀
		f.submit();
	}else{
		return;
	}
}
function goSave(){
	var f = document.fm1;
	if(f.rdate.value == ""){
		alert("승선일자를 입력하세요.");
		f.rdate.focus();
		return;
	}
	if(f.rnm.value == ""){
		alert("예약자 이름을 입력하세요.");
		f.rnm.focus();
		return;
	}
/*
	if(!f.hp.value){
		alert("휴대전화번호는 필수입니다.");
		f.hp.focus();
		return;
	}
	if(!(f.rmoney[0].checked) && !(f.rmoney[1].checked) && !(f.rmoney[2].checked)){
		alert("예약금액을 선택해 주세요.");
		return;
	}
*/
	if(confirm("저장 후 출항인원과 명부를 작성합니다.")){
//		upload();
		f.action = "rsv_xn.asp";
		f.method = "post";
		f.submit();
	}else{
		return;
	}
}
function goCancel(){
	var f = document.fm1;
	if(confirm("예약을 취소합니까?")){
		f.flag.value = "X";
		f.action = "rsv_x.asp";
		f.method = "post";
		f.submit();
	}
}
function goAgain(){
	var f = document.fm1;
	if(confirm("예약을 다시 복구하고 승인합니까?")){
		f.flag.value = "A";
		f.action = "rsv_x.asp";
		f.method = "post";
		f.submit();
	}
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하시겠습니까?")){
		f.flag.value = "D";
		f.action = "rsv_x.asp";
		f.method = "post";
//		f.target = "nullframe";			//modal 창이므로 안씀
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<input type='file' name='upFile' style='width:550px;'><br>";
	}
	layer1.innerHTML = txtbox;
}
function selectMail(form){
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if(len == "직접입력"){
		txtbox = "<input type='text' name='email3' maxlength='30' style='width:120px;'>";
		layer10.innerHTML = txtbox;
	}else{
		layer10.innerHTML = "";
	}
}
function chkTel1(){
//	if(document.fm1.tel2.value.length == 4)
//		document.fm1.tel3.focus();
}
function chkTel2(){
//	if(document.fm1.tel3.value.length == 4)
//		document.fm1.hp0.focus();
}
function chkHp0(){
	if(document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp1(){
	if(document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function chkHp2(){
//	if(document.fm1.hp3.value.length == 4)
//		document.fm1.email1.focus();
}
function gob(){
	document.fm1.rmoney.value = document.fm1.rmoney1.value * 10000;
}
</script>
<script>
$(function(){
	$("#datepicker").datepicker();
});
</script>


<form name="fm1" method="post">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="memo" value="관리자예약">
<input type="hidden" name="flag" value="W">
<div id="wrap">
	<div id="mwrap2">
		<div id="poptitle2">
			<p><img src="/img/rsv_title.gif" alt="예약정보" title="예약정보" /></p>
			<table width=700 id="list2">
				<colgroup>
					<col style="width:130px;" />
					<col width="*" />
				</colgroup>
				<tr>
					<td class="bdr-ds1 bdr-ds3">선박이름</td>
					<td class="bdr-ds3 lh26"><b><%=shipinfo(shipid,"shipnm")%></b></td>
				</tr>
				<tr>
					<td class="bdr-ds1">예약일시</td>
					<td class="">
						<input type="text" name="rdate" id="rdate" maxlength="10" class="ff fb ls fcb ct" style="width:130px;" readonly value="<%=setD(yy & mm & dd)%>" />
<%			If status = "N" Then %>
						&nbsp;&nbsp;<font class="fc5 fb">대기중</font>
<%			End If %>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">예약자이름</td>
					<td class=""><input type="text" name="rnm" id="rnm" maxlength="20" style="width:130px;ime-mode:active;" value="<%=rnm%>" /></td>
				</tr>
				<!--
				<tr>
					<td class="bdr-ds1">집전화</td>
					<td class="">
						<input type="text" name="tel" id="tel" class="ff" style="width:130px;" maxlength="20" value="<%=tel%>" />&nbsp;&nbsp;<font class="f11 fc4">숫자만 입력
					</td>
				</tr-->
				<tr>
					<td class="bdr-ds1">휴대전화</td>
					<td class="">
						<input type="text" name="hp" id="hp" class="ff ls" style="width:130px;" maxlength="20" value="<%=hp%>" />&nbsp;&nbsp;<font class="f11 fc4">숫자만 입력
					</td>
				</tr>
				<!--
				<tr>
					<td class="bdr-ds1">이메일</td>
					<td class="">
						<input type="text" name="email1" id="email1" maxlength="20" style="width:130px;" value="<%=email1%>" />
						@
						<select name="email2" id="email2" style="width:150px;" onChange="selectMail(this.form);">
						<option value="" selected>메일선택</option>
<%
		Call rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '이메일' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
						<option value="<%=rs("code_nm")%>"<%If email2 = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		Call rsc()
%>
						</select>
						<span id="layer10"></span>
					</td>
				</tr>
				-->
				<tr>
					<td class="bdr-ds1">예약금</td>
					<td class="">
						<input type="text" name="rmoney1" id="rmoney1" maxlength="5" class="ff" style="width:40px;" />
						<a href="javascript:;" onClick="gob();" class="btn btn21"><span>×만원</span></a>
						<input type="text" name="rmoney" id="rmoney" maxlength="20" class="ff rg" style="width:100px;" value="<%=rmoney%>" /> 원
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">기타</td>
					<td class="">관리자 예약</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
			<!-- N-신청중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소 -->
			<a href="javascript:goSave();" class="btnr btn25"><span>다음</span></a>
			<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>창닫기</span></a>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	dbc() %>
