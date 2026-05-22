<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	idx							= SQLI(Request("idx"))
	cd1							= SQLI(Request("cd1"))			'검색조건
	cd2							= SQLI(Request("cd2"))			'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	inpwd						= SQLI(Request("pwd"))
	tag							= 8

	If cd1 = "" Then cd1 = "rname"
	If page = "" Then page = 1
	If flag = "" And idx <> "" Then flag = "M"
	If flag = "" Then flag = "W"

	Set cx = New BsfCode

	If idx <> "" Then
		rso()
		SQL = " SELECT	uno, rname, rel, hp, zip, addr1, addr2, ddate FROM _omemt020 WHERE uno = "& FID_NO &" AND idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			uno					= rs("uno")
			rname				= rs("rname")
			rel					= rs("rel")
			hp					= rs("hp")
			zip					= rs("zip")
			addr1				= rs("addr1")
			addr2				= rs("addr2")
			ddate				= rs("ddate")
		End If
		rsc()
	End If

'	If hp <> "" Then
'		hp1						= Left(hp,3)
'		hp2						= ontel(hp,2)
'		hp3						= Right(hp,4)
'	End If

	If flag = "M" Then					'수정
		If FID_NO <> "" And CInt(FID_NO) <> CInt(uno) Then			'작성자가 아닌 경우
			divAlertReload("글쓴이만 수정 가능합니다.")
			Response.End
		End If
	End If
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	if (f.rname.value == "") {
		alert("일행분의 이름을 입력하세요.");
		f.rname.focus();
		return;
	}
	if (f.hp.value == "") {
		alert("일행분의 휴대전화번호나 자택전화번호를 입력하세요.");
		f.hp.focus();
		return;
	}
	if (f.addr1.value == "") {
		alert("일행분의 주소1을 우편번호 검색을 통해 입력하세요.");
		f.addr1.focus();
		return;
	}
	if (f.addr2.value == "") {
		alert("일행분의 주소2를 입력하세요.");
		f.addr2.focus();
		return;
	}
//	if (confirm("입력하시겠습니까?")) {
		f.action = "friend_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
//	} else {
//		return;
//	}
}
function goDelete() {
	var f = document.fm1;
	if (confirm("삭제하시겠습니까?")) {
		f.flag.value = "D";
		f.action = "friend_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function chkTel1() {
	if (document.fm1.tel2.value.length == 4)
		document.fm1.tel3.focus();
}
function chkTel2() {
	if (document.fm1.tel3.value.length == 4)
		document.fm1.hp1.focus();
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
		document.fm1.addr1.focus();
}
//-->
</script>


<form name="fm1" method="post" onsubmit="return goSave()">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap3">
		<div>
			<span><p class="tt">일행관리</p></span>
			<div class="gbox01" style="padding:5px 20px;">
				<dl>
					<font class="f12 ls">
					ㅇ 자주 동행하는 분들을 등록하여 출항명부 작성시 번거로움을 없앨 수 있습니다.<br>
					ㅇ 출항명부는 법적으로 반드시 작성해야 하며 가명/허위 작성시 불이익을 당하실 수 있습니다.<br>
					ㅇ 당일(출항일) 주민등록번호만 따로 기입하시면 됩니다.</font>
				</dl>
			</div>
			<table width="100%" id="list2">
				<colgroup>
				<col style="width:130px;" />
				<col width="*" />
				</colgroup>
				<tr>
					<td class="bdr-ds1 bdr-ds3">일행이름</td>
					<td class="bdr-ds3">
						<input type="text" name="rname" value="<%=rname%>" maxlength="20" style="width:130px;">
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">연락처</td>
					<td class="">
						<input type="text" name="hp" maxlength="13" value="<%=hp%>" style="width:130px;">&nbsp;
						<font class="fc9 f11">휴대전화/자택전화 중 택일 (숫자만) 예) 01033337777</font>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">주소</td>
					<td class="">
						<!-- 우편번호입력 부분 -->
						<input type="text" name="zip1" id="zip1" value="<%=Left(zip,3)%>" readonly style="width:40px;">
						-
						<input type="text" name="zip2" id="zip2" value="<%=Right(zip,3)%>" readonly style="width:40px;">
						<a href="javascript:;" onClick="Popup('/mem/zip3.asp?op=winpop',450,540,500,100,0,45);" class="btn btn21"><span>우편번호검색</span></a>
						<!-- 주소입력 부분 -->
						<input type="text" name="addr1" id="addr1" value="<%=addr1%>" style="width:370px;">
						<input type="text" name="addr2" id="addr2" value="<%=addr2%>" style="width:370px;">
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">관계</td>
					<td class="">
						<input type="radio" name="rel" id="rel01" value="가족"<%If rel = "가족" Then%> checked<%End If%>><label for="rel01">가족</label>
						<input type="radio" name="rel" id="rel02" value="연인"<%If rel = "연인" Then%> checked<%End If%>><label for="rel02">연인</label>
						<input type="radio" name="rel" id="rel03" value="직장동료"<%If rel = "직장동료" Then%> checked<%End If%>><label for="rel03">직장동료</label>
						<input type="radio" name="rel" id="rel04" value="선후배"<%If rel = "선후배" Then%> checked<%End If%>><label for="rel04">선후배</label>
						<input type="radio" name="rel" id="rel05" value="지인"<%If rel = "지인" Then%> checked<%End If%>><label for="rel05">지인</label>
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
			<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%	If flag <> "W" Then %>
			<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%	End If %>
			<a href="javascript:goClose(0);" class="btn btn25"><span>닫기</span></a>
		</div>
	</div>
</div>
</form>
<%	dbc() %>
