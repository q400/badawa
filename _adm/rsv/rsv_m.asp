<!-- #include virtual = "/inc/header_pop.asp" -->

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<link rel="stylesheet" href="/lib/css/demos.css">

<%
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	okinwon						= shipinfo(shipid,"capa") - guestCount(shipid,yy & mm & dd)		'승선 가능 인원
'	Response.Write "okinwon : "& okinwon &"<br>"

	If guestCount(shipid,yy & mm & dd) > 0 Then
		flag1					= "noD"
	End If

	Set cx = New BsfCode

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, omoney, pwd, uip, ddate, memo " _
			& " FROM _orsvt010 " _
			& " WHERE ridx = "& ridx
		rs.open SQL, dbcon
		If Not rs.eof Then
			rdate				= rs("rdate")
			uno					= rs("uno")
			rnm					= rs("rnm")
			inwon				= rs("inwon")
			tel					= rs("tel")
			hp					= rs("hp")
			email				= rs("email")
			shipid				= rs("shipid")
			gubn				= rs("gubn")	'D-독배/G-개인(합승)
			status				= rs("status")
			rmoney				= rs("rmoney")
			omoney				= rs("omoney")
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
		End If
		rsc()
	End If
'Response.Write "value : "& InStr(email,"@") &"<br>"
	If email <> "" Then
		If trim(email) = "@" Then
				email1			= ""
				email2			= ""
		Else
			If InStr(email,"@") > 0 Then
				email0			= email
				email1			= Left(email0, InStr(email0, "@")-1)
				email2			= Right(email0, Len(email0)-Len(email1)-1)
			Else
				email0			= cx.SetDecode(email)
				email1			= Left(email0, InStr(email0, "@")-1)
				email2			= Right(email0, Len(email0)-Len(email1)-1)
			End If
		End If
	End If

	If hp <> "" Then
		hp1						= onTel(hp,1)
		hp2						= onTel(hp,2)
		hp3						= onTel(hp,3)
	End If
%>

<script language="javascript">
<!--
function upload(){
	document.all.upload.style.visibility = "visible";
}
function rsvOK(){
	var f = document.fm1;
	var msg2 = "예약을 승인합니다.";
	if(confirm(msg2)){
		f.flag.value = "OK";
		f.action = "rsv_x.asp";
		f.method = "post";
		f.submit();
	}else{
		return;
	}
}
function goSave(){
	var f = document.fm1;
	if($("#rdate").val == ""){
		alert("승선일자를 입력하세요.");
		$("#rdate").focus();
		return;
	}
	if($("#inwon").val == ""){
		alert("승선인원을 입력하세요.");
		$("#inwon").focus();
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
		alert("예약금액을 선택해 주세요.       ");
		return;
	}
*/
	if(confirm("수정합니까?")){
//		upload();
		f.action = "rsv_x.asp";
		f.method = "post";
//		f.target = "nullframe";
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
	for(i=0; i<len; i++){
		txtbox = txtbox + "<input type='file' name='upFile' class='' style='width:550px;'><br>";
	}
	layer1.innerHTML = txtbox;
}
function selectMail(form){
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if(len == "직접입력"){
		txtbox = "<input type='text' name='email3' maxlength='30' style='width:150px;'>";
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
	if($("#hp2").length == 4)
		$("#hp3").focus();
}
function chkHp2(){
//	if($("#hp3").val().length == 4)
//		$("#email1").focus();
}
function gob(){
	document.fm1.rmoney.value = document.fm1.rmoney1.value * 10000;
}
function goc(){
	document.fm1.omoney.value = document.fm1.omoney1.value * 10000;
}
//-->
</script>
<script>
$(function(){
	$("#datepicker").datepicker();
});
</script>


<form name="fm1" method="post" onSubmit="return upload()">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="flag">
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
					<td class="bdr-ds1">출조일자</td>
					<td class="">
						<input type="text" name="rdate" id="rdate" maxlength="10" class="ff fb ls fcb ct" style="width:130px;" readonly value="<%=setD(rdate)%>" />
<%			If status = "N" Then %>
						&nbsp;&nbsp;<font class="fc5 fb">대기중</font>
<%			End If %>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">출조인원</td>
					<td class="">
						<select name="inwon" id="inwon" style="width:134px;">
						<option value="0" selected>승선인원 선택</option>
<%		For intLoop = 1 To shipinfo(shipid,"capa") %>
						<option value="<%=intLoop%>"<%If CInt(inwon) = intLoop Then%> selected<%End If%>>전체 <%=intLoop%>명</option>
<%		Next %>
						</select>
						<input type="radio" name="gubn" id="gubn" value="G"<%If gubn = "G" Or gubn = "" Then%> checked<%End If%> />
						<span onClick="changeBox('fm1.gubn[0]')" style="cursor:pointer;">개인/합승</span>
						<input type="radio" name="gubn" id="gubn" value="D"<%If gubn = "D" Then%> checked<%End If%> />
						<!-- <input type="radio" name="gubn" value="D"<%If gubn = "D" Then%> checked<%End If%><%If flag1 = "noD" Then%> disabled<%End If%>> -->
						<span<%If flag1 <> "noD" Then%> onClick="changeBox('fm1.gubn[1]')" style="cursor:pointer;"<%End If%>>독배</span>
						<span class="fright">
						추가예약 가능인원&nbsp;<b><%=okinwon%></b> 명&nbsp;&nbsp;&nbsp;
						<a href="javascript:Popup('book.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&man='+ fm1.inwon.value,760,600,400,100,0,0,8);">
						<img src="/img/rsv/namebook.gif" class="vm" alt="출항명부작성" title="출항명부작성"></a>
						</span>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">예약자명</td>
					<td class=""><input type="text" name="rnm" id="rnm" maxlength="20" class="" style="width:130px;" value="<%=rnm%>" /></td>
				</tr>
<%			If uno <> "0" And uno <> "" Then %>
				<tr>
					<td class="bdr-ds1">회원실명(ID)</td>
					<td class=""><b><%=meminfo(uno,"uname")%> (<%=meminfo(uno,"memid")%>)</b></td>
				</tr>
<%			End If %>
				<!--
				<tr>
					<td class="bdr-ds1">집전화</td>
					<td class="">
						<input type="text" name="tel" id="tel" class="ff" style="width:130px;" maxlength="15" value="<%=tel%>" />&nbsp;&nbsp;<font class="f11 fc4">숫자만 입력
					</td>
				</tr-->
				<tr>
					<td class="bdr-ds1">휴대전화</td>
					<td class="">
						<input type="text" name="hp" id="hp" class="ff ls" style="width:130px;" maxlength="15" value="<%=hp%>" />&nbsp;&nbsp;<font class="f11 fc4">숫자만 입력
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
				</tr-->
				<tr>
					<td class="bdr-ds1">예약금</td>
					<td class="">
						<input type="text" name="rmoney1" id="rmoney1" maxlength="5" class="ff" style="width:40px;" placeholder="숫자" />
						<a href="javascript:;" onClick="gob();" class="btn btn21"><span>×만원</span></a>
						<input type="text" name="rmoney" id="rmoney" maxlength="20" class="ff rg" style="width:100px;" value="<%=rmoney%>"> 원
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">실결제금액</td>
					<td class="">
						<input type="text" name="omoney1" id="omoney1" maxlength="5" class="ff" style="width:40px;" placeholder="숫자" />
						<a href="#" onClick="goc();" class="btn btn21"><span>×만원</span></a>
						<input type="text" name="omoney" id="omoney" maxlength="20" class="ff rg" style="width:100px;" value="<%=omoney%>"> 원
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">예약구분</td>
					<td class="">
<%			If uno <> "0" And uno <> "" Then %>
						<b class="fc5">회원예약</b>
<%			Else %>
						<b class="fc5">비회원예약</b>
<%			End If %>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">남기는 글</td>
					<td class="">
						<textarea name="memo" id="memo" cols="45" rows="3" style="width:400px;"><%=memo%></textarea>
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
			<!-- N-신청중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소 -->
<%	If status = "" Or status = "N" Or status = "K" Then %>
			<a href="javascript:rsvOK();" class="btnp btn25"><span>예약승인</span></a>
<%	End If %>
<%	If status <> "Y" And status <> "X" Then %>
			<a href="javascript:goCancel();" class="btng btn25"><span>예약취소</span></a>
<%	End If %>
<%	If status = "X" Then %>
			<a href="javascript:goAgain();" class="btn btn25"><span>예약복구</span></a>
<%	End If %>
			<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
			<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
			<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>창닫기</span></a>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	'Set cx = Nothing %>
<%	dbc() %>
