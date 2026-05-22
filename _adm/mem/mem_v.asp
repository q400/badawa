<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= SQLI(Request("seq"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	cd3							= SQLI(Request("cd3"))
	cd4							= SQLI(Request("cd4"))
	page							= SQLI(Request("page"))

	If cd1 = "" Then cd1 = "uname"
	If page = "" Then page = 1
	If seq = "" Then
		Call AlertGo("변수가 넘어오지 않았습니다.","/_adm/")
		Response.End
	End If

	Set cx = New BsfCode

	rso()
	SQL = " SELECT " _
		& " memid" _
		& ",mempw" _
		& ",uname" _
		& ",unamee" _
		& ",tel" _
		& ",hp" _
		& ",zip" _
		& ",addr1" _
		& ",addr2" _
		& ",email" _
		& ",memtype" _
		& ",ddate" _
		& ",ldate" _
		& ",cnt" _
		& ",point" _
		& "	FROM _omemt010 " _
		& " WHERE seq = "& seq
	rs.open SQL, dbcon
	If Not rs.eof Then
		memid				= rs("memid")
		mempw				= cx.SetDecode(rs("mempw"))
		uname				= rs("uname")
		unamee				= rs("unamee")
		tel						= rs("tel")
		hp						= rs("hp")
		zip						= rs("zip")
		addr1					= rs("addr1")
		addr2					= rs("addr2")
		email					= cx.SetDecode(rs("email"))
		memtype				= rs("memtype")
		ddate					= rs("ddate")
		ldate					= rs("ldate")
		cnt						= rs("cnt")
		point					= rs("point")
	End If
	rsc()

	If tel <> "" And tel <> "--" Then
		tel1					= TelSepa(tel,1)
		tel2					= TelSepa(tel,2)
		tel3					= TelSepa(tel,3)
	End If
	If hp <> "" And hp <> "--" Then
		hp1					= onTel(hp,1)
		hp2					= onTel(hp,2)
		hp3					= onTel(hp,3)
	End If
	If email <> "" Then
		email1					= Left(email, InStr(email, "@")-1)
		email2					= Right(email, Len(email)-Len(email1)-1)
	End If
%>

<script type="text/javascript">
<!--
function goSave() {
	var f = document.fm1;
	f.flag.value = "M";
	f.target = "nullframe";
	f.action = "mem_x.asp";
	f.submit();
}
function goDelete() {
	var f = document.fm1;
	if (confirm("삭제하겠습니까?")) {
		f.flag.value = "D";
		f.action = "mem_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function selectMail(form) {
	var len = document.fm1.email2.options[document.fm1.email2.selectedIndex].value;
	txtbox = "";
	if (len == "직접입력") {
		txtbox = "<input type='text' name='email3' id='email3' maxlength='30' style='width:120px;ime-mode:disabled;'>";
		layer10.innerHTML = txtbox;
	} else {
		layer10.innerHTML = "";
	}
}
function chktel0() {
	if (document.fm1.tel2.value.length == 4)
		document.fm1.tel3.focus();
}
function chkHp0() {
	if (document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp1() {
	if (document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function setdiv(menu) {
	if (menu == 1) {
		document.getElementById("show01").style.display = "";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	} else if (menu == 2) {
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	} else if (menu == 3) {
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "none";
	} else if (menu == 4) {
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "";
		document.getElementById("show05").style.display = "none";
	} else if (menu == 5) {
		document.getElementById("show01").style.display = "none";
		document.getElementById("show02").style.display = "none";
		document.getElementById("show03").style.display = "none";
		document.getElementById("show04").style.display = "none";
		document.getElementById("show05").style.display = "";
	}
}
function unoPOP(op){
	var urllink = "";
	var title = "우편번호검색";
	var wt, ht = "0";

	if(op == 9){			//우편번호검색
		urllink = "/mem/zip3.asp";
		title = "우편번호검색";
		wt = 447;
		ht = 590;
	}
	$.unoDialog({
		url: urllink,
		dialogArguments: '',
		top: 0,
		width: wt,
		height: ht,
		scrollable: false,
		title: title,
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="memid" value="<%=memid%>">
<input type="hidden" name="unamee" value="<%=unamee%>">
<input type="hidden" name="memtype" value="<%=memtype%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="cd4" value="<%=cd4%>">
<input type="hidden" name="flag">
<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">
				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">회원정보관리</span>
						<span class="ib fright"></span>
					</p>

					<!-- 선박정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="width:280px;" />
							<col style="width:120px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">회원이름(실명)</th>
								<td colspan=3>
									<input type="text" name="uname" maxlength="20" value="<%=uname%>" style="width:160px;">
								</td>
							</tr>
							<tr>
								<th class="ct">아이디(닉네임)</th>
								<td colspan=3 title="<%=mempw%>">
									<b><%=memid%></b> (<%=unamee%>)
								</td>
							</tr>
							<tr>
								<th class="ct">비밀번호</th>
								<td colspan=3>
									<input type="password" name="mempw01" maxlength="20" style="width:160px;">
									<span class="f12 fc9">※ 비밀번호 분실시 관리자가 임의로 지정 후 통보해 줍니다.</span>
								</td>
							</tr>
							<tr>
								<th class="ct">전화번호</th>
								<td colspan=3>
									<select name="tel1" style="width:80px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '일반전화' ORDER BY idx ASC "
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
									-
									<input type="text" name="tel2" maxlength="4" value="<%=tel2%>" style="width:50px;">
									-
									<input type="text" name="tel3" maxlength="4" value="<%=tel3%>" style="width:50px;">
								</td>
							</tr>
							<tr>
								<th class="ct">휴대폰번호</th>
								<td colspan=3>
									<select name="hp1" style="width:80px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '휴대전화' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If onTel(hp,1) = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
									-
									<input type="text" name="hp2" maxlength="4" value="<%=hp2%>" style="width:50px;">
									-
									<input type="text" name="hp3" maxlength="4" value="<%=hp3%>" style="width:50px;">
								</td>
							</tr>
							<tr>
								<th class="ct">이메일</th>
								<td colspan=3>
									<input type="text" name="email1" id="email1" maxlength="20" value="<%=email1%>" style="width:100px;ime-mode:disabled;">
									@
									<select name="email2" id="email2" style="width:140px;" onChange="selectMail(this.form);">
									<option value="" selected>메일선택</option>
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
									<span id="layer10"></span>
								</td>
							</tr>
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
							<tr>
								<th class="ct">주소</th>
 								<td colspan=3>
									<input type="text" name="zip" id=zip maxlength="6" value="<%=zip%>" style="width:100px;">
<!-- 									<input type="text" name="zip1" maxlength="3" value="<%=Left(zip,3)%>" style="width:50px;"> -->
<!-- 									<input type="text" name="zip2" maxlength="3" value="<%=Right(zip,3)%>" style="width:50px;"> -->
									<a href="javascript:;" onclick="goPopup();" class="btn btn21"><span>우편번호 찾기</span></a>
<!-- 									<a href="javascript:;" onClick="unoPOP(9); return false;" class="btng btn25"><span>우편번호검색</span></a> -->
<!-- 									<a href="#" onClick="return mpop5('/mem/zip.asp','ev','center',446,507,0);" class="btn btn21"><span>우편번호검색</span></a> -->
									<input type="text" name="addr" id=addr value="<%=addr1%> <%=addr2%>" style="width:90%;">
<!-- 									<input type="text" name="addr2" value="<%=addr2%>" style="width:90%;"> -->
								</td>
							</tr>
							<tr>
								<th class="ct">포인트</th>
								<td colspan=3>
									<input type="text" name="point" maxlength="20" value="<%=point%>" style="width:120px;text-align:right;">
								</td>
							</tr>
							<tr>
								<th class="ct">가입일시</th>
								<td colspan=3><%=ddate%></td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
						<a href="javascript:goDelete();"><img src="/img/adm/btn_delete.gif" align="absmiddle"></a>
						<a href="javascript:goSave();"><img src="/img/adm/btn_modify.gif" align="absmiddle"></a>
						<a href="mem.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&cd3=<%=cd3%>&cd4=<%=cd4%>"><img src="/img/adm/btn_list.gif" align="absmiddle"></a>
					</div>
				</div>
				<!-- poptitle2 E -->
			</div>
			<!-- admwrap1 E -->
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
