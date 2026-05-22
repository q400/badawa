<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))

	If cd1 = "" Then cd1 = "shipnm"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"

	Set cx = New BsfCode

	If shipid <> "" Then
		rso()
		SQL = " SELECT shipno, shipnm, captain, captain_sub, sz, capa0, capa, speed, equip, seat, tel, hp, homp, bank, acc, cost, chuljo0, chuljo, comfort, service, blog, smart, ddate, active_yn, captel, capaddr, memo " _
			& "	FROM _oshpt010 " _
			& " WHERE shipid = "& shipid
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipno				= rs("shipno")
			shipnm				= rs("shipnm")
			captain				= rs("captain")
			captain_sub			= rs("captain_sub")
			sz					= rs("sz")
			capa0				= rs("capa0")
			capa				= rs("capa")
			speed				= rs("speed")
			equip				= rs("equip")
			seat				= rs("seat")
			tel					= rs("tel")
			hp					= rs("hp")
			homp				= rs("homp")
			bank				= rs("bank")
			acc					= rs("acc")
			cost				= rs("cost")
			chuljo0				= rs("chuljo0")
			chuljo				= rs("chuljo")
			comfort				= rs("comfort")
			service				= rs("service")
			blog				= rs("blog")
			smart				= rs("smart")
			ddate				= rs("ddate")
			active_yn			= rs("active_yn")
			captel				= rs("captel")
			capaddr				= rs("capaddr")
			memo				= rs("memo")
		End If
		rsc()
		flag = "M"
	End If

	If chuljo <> "" Then
		arrchuljo				= Split(chuljo, ", ")
	End If

	If speed = "" Then speed = "평균 16노트 / 최대 20노트"
	If equip = "" Then equip = "레이다, 프로타, 어군탐지기, 무전기(최신장비보유)"
	If homp = "" Then homp = "www.badawa.co.kr"
	If email = "" Then email = "webmaster@badawa.co.kr"
	If tel = "" Then tel = "041-675-1133"
	If bank = "" Then bank = "우체국"
	If acc = "" Then acc = "312090-02-004546 (예금주:김종훈)"

	'If tel <> "" And tel <> "--" Then
		'tel1				= TelSepa(tel,1)
		'tel2				= TelSepa(tel,2)
		'tel3				= TelSepa(tel,3)
	'End If
	If hp <> "" And hp <> "--" Then
		hp1					= onTel(hp,1)
		hp2					= onTel(hp,2)
		hp3					= onTel(hp,3)
	End If
%>

<script language="JavaScript">
<!--
function goSave(){
	var f = document.fm1;
	if(!f.shipnm.value){					//선박이름체크
		alert("선박이름을 입력하세요.");
		f.shipnm.focus();
		return;
	}
	//if(!f.captain.value){					//선장ID체크
	//	alert("선장 아이디를 입력하세요.");
	//	f.captain.focus();
	//	return;
	//}
	if(!f.sz.value){						//선박규모체크
		alert("선박규모를 입력하세요.");
		f.sz.focus();
		return;
	}
	if(!f.capa.value){					//정원체크
		alert("정원을 입력하세요.");
		f.capa.focus();
		return;
	}
	if(!f.speed.value){					//속도체크
		alert("속도를 입력하세요.");
		f.speed.focus();
		return;
	}
	if(!f.equip.value){					//보유장비체크
		alert("보유장비를 입력하세요.");
		f.equip.focus();
		return;
	}
	f.flag.value = "<%=flag%>";
	//f.target = "nullframe";
	f.action = "ship_x.asp";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "ship_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DP";
		f.action = "ship_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
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
//function chkTel1(){
	//document.fm1.tel2.focus();
//}
//function chkTel2(){
	//if(document.fm1.tel2.value.length == 4)
		//document.fm1.tel3.focus();
//}
//function chkTel3(){
	//if(document.fm1.tel3.value.length == 4)
		//document.fm1.hp1.focus();
//}
function chkHp1(){
	if(document.fm1.hp1.value.length == 3)
		document.fm1.hp2.focus();
}
function chkHp2(){
	if(document.fm1.hp2.value.length == 4)
		document.fm1.hp3.focus();
}
function chkHp3(){
	if(document.fm1.hp3.value.length == 4)
		document.fm1.email.focus();
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

function unoPOP(sid, op, gubn){
	var urllink = "/inc/photo.asp";
	var title = "";
	var wt, ht = "0";

	if(gubn == 1){			//예약신규등록
		title = "사진관리";
		wt = 500;
		ht = 670;
	}else if(gubn == 2){	//미정
		title = "미정";
		wt = 750;
		ht = 600;
	}
	$.unoDialog({
		url: urllink + "?shipid="+ sid +"&op="+ op,
		dialogArguments: '',
		top: 0,
		width: wt,
		height: ht,
		scrollable: false,
		title: title,
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="memid" value="<%=memid%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">
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
						<span class="tt2">선박정보관리</span>
						<span class="ib fright"></span>
					</p>

					<!-- 선박정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="width:280px;" />
							<col style="width:120px;" />
							<col style="width:280px;" />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">선박이름</th>
								<td>
									<input type="text" name="shipnm" id="shipnm" maxlength="20" value="<%=shipnm%>" style="width:160px;ime-mode:active;">&nbsp;
									활동여부
									<input type="checkbox" name="active_yn" id="active_yn" value="1"<%If active_yn Then%> checked<%End If%>>
								</td>
								<th class="ct">선장이름</th>
								<td>
									<input type="text" name="captain" id="captain" maxlength="20" value="<%=captain%>" style="width:70px;">
									&nbsp;&nbsp;부선장&nbsp;
									<input type="text" name="captain_sub" id="captain_sub" maxlength="20" class="vm" value="<%=captain_sub%>" style="width:70px;">
									<!--
									<input type="text" name="captain" maxlength="20" readonly value="<%=captain%>" style="width:100px;">&nbsp;
									<a href="#" onClick="mpop5('/_adm/mem/capid.asp','ev','center',446,409,50);"><img src="/img/adm/z_search02.gif" align="absmiddle"></a>
									-->
								</td>
							</tr>
							<tr>
								<th class="ct">수용인원(정원)</th>
								<td>
									<input type="text" name="capa0" id="capa0" maxlength="20" value="<%=capa0%>" placeholder="ex) 15 (선장포함)" style="width:50px;"> 명
								</td>
								<th class="ct">예약가능인원</th>
								<td>
									<input type="text" name="capa" id="capa" maxlength="20" value="<%=capa%>" style="width:30px;"> 명
								</td>
							</tr>
							<tr>
								<th class="ct">어선번호</th>
								<td>
									<input type="text" name="shipno" id="shipno" maxlength="20" value="<%=shipno%>" placeholder="ex) 1122334-55667789" style="width:160px;">
								</td>
								<th class="ct">선박규모</th>
								<td>
									<input type="text" name="sz" id="sz" maxlength="20" value="<%=sz%>" placeholder="ex) 7.5" style="width:50px;"> 톤
								</td>
							</tr>
							<tr>
								<th class="ct">선비</th>
								<td>
									<input type="text" name="cost" id="cost" maxlength="20" value="<%=cost%>" style="width:80px; text-align:right;">&nbsp;
									<font class="f11 fc4">ㅁ 숫자만 넣으세요.</font>
								</td>
								<th class="ct">자리배정방식</th>
								<td>
									<input type="radio" name="seat" id="seat1" value="추첨"<%If seat = "추첨" Then%> checked<%End If%>>&nbsp;
									<span onClick="changeBox('fm1.seat[0]')" style="cursor:pointer;">추첨</span>&nbsp;&nbsp;&nbsp;
									<input type="radio" name="seat" id="seat2" value="선착순"<%If seat = "선착순" Then%> checked<%End If%>>&nbsp;
									<span onClick="changeBox('fm1.seat[1]')" style="cursor:pointer;">선착순</span>&nbsp;&nbsp;&nbsp;
									<input type="radio" name="seat" id="seat3" value="기타"<%If seat = "기타" Then%> checked<%End If%>>&nbsp;
									<span onClick="changeBox('fm1.seat[2]')" style="cursor:pointer;">기타</span>
								</td>
							</tr>
							<tr>
								<th class="ct">기본출조종류</th>
								<td colspan=3>
<%
		rso()				'기본출조종류
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '출조' AND etc = '1' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		i = 0
		Do Until rs.eof
%>
									<input type="radio" name="chuljo0" id="chuljo0" value="<%=rs("code_nm")%>"<%If chuljo0 = rs("code_nm") Then%> checked<%End If%>>
									<span onClick="changeBox('fm1.chuljo0[<%=i%>]')" style="cursor:pointer;"><%=rs("code_nm")%></span>&nbsp;&nbsp;&nbsp;
<%
			rs.MoveNext
			i = i + 1
		Loop
		rsc()
%>
								</td>
							</tr>
							<tr>
								<th class="ct">가능출조종류</th>
								<td colspan=3>
<%
		rso()				'가능출조종류
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '출조' AND etc = '1' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		i = 0
		Do Until rs.eof
%>
									<input type="checkbox" name="chuljo" id="chuljo" value="<%=rs("code_nm")%>"
<%
			If chuljo <> "" Then
				For k = LBound(arrchuljo) To UBound(arrchuljo)
					If Replace(arrchuljo(k),Chr(10),"") = rs("code_nm") Then
%>
									checked
<%					End If
				Next
			End If
'			If rs("code_nm") = chuljo0 Then %>
<%'			End If %>
									>
									<span onClick="changeBox('fm1.chuljo[<%=i%>]')" style="cursor:pointer;"><%=rs("code_nm")%></span>&nbsp;&nbsp;&nbsp;
<%
			rs.MoveNext
			i = i + 1
		Loop
		rsc()
%>
								</td>
							</tr>
							<tr>
								<th class="ct">선박속도</th>
								<td colspan=3>
									<input type="text" name="speed" id="speed" maxlength="100" value="<%=speed%>" placeholder="ex) 평균16노트/최대20노트" style="width:350px;ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">주요편의시설</th>
								<td colspan=3>
									<input type="text" name="comfort" id="comfort" maxlength="100" value="<%=comfort%>" placeholder="ex) 3개선원실,히터/에어컨설치" style="width:350px;ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">보유장비</th>
								<td colspan=3>
									<input type="text" name="equip" id="equip" maxlength="200" value="<%=equip%>" placeholder="ex) 레이다, 프로타, 어군탐지기, 무전기(최신장비보유)" style="width:650px;ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">서비스</th>
								<td colspan=3>
									<input type="text" name="service" id="service" maxlength="100" value="<%=service%>" placeholder="ex) 일일최대어사진출력, 출조시 10% 포인트적립" style="width:650px;ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">홈페이지</th>
								<td>
									<input type="text" name="homp" id="homp" maxlength="100" value="<%=homp%>" style="width:200px;ime-mode:inactive;">
								</td>
								<th class="ct">개인블로그</th>
								<td>
									<input type="text" name="blog" id="blog" maxlength="100" value="<%=blog%>" style="width:250px;ime-mode:inactive;">
								</td>
							</tr>
							<tr>
								<th class="ct">거래은행</th>
								<td>
									<input type="text" name="bank" id="bank" maxlength="100" value="<%=bank%>" style="width:100px;ime-mode:active;">
								</td>
								<th class="ct">계좌번호</th>
								<td>
									<input type="text" name="acc" id="acc" maxlength="150" value="<%=acc%>" placeholder="ex) 101-25-256398 (예금주:홍두깨)" style="width:250px;">
								</td>
							</tr>
							<tr>
								<th class="ct">선장연락처</th>
								<td>
									<input type="text" name="captel" id="captel" maxlength="100" value="<%=captel%>" placeholder="ex) 010-1234-5678" style="width:200px;">
								</td>
								<th class="ct">E-Mail</th>
								<td>
									<input type="text" name="smart" id="smart" maxlength="100" value="<%=smart%>" style="width:250px;ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">선장주소지</th>
								<td colspan=3>
									<input type="text" name="capaddr" id="capaddr" value="<%=capaddr%>" style="width:650px;">
								</td>
							</tr>
							<tr>
								<th class="ct">대표예약전화</th>
								<td colspan=3>
									<input type="text" name="tel" id="tel" maxlength="100" value="<%=tel%>" placeholder="ex) 010-1234-5678 / 010-1234-5678" style="width:200px;">
								</td>
							</tr>
							<tr>
								<th class="ct">선박안내</th>
								<td colspan=3>
									<textarea name="memo" id="memo" class="tarea" style="width:650px;height:70px;ime-mode:active;"><%=memo%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan=4>
									<table id="list3">
										<tr>
<%
				If shipid <> "" Then
					rso()
					SQL = " SELECT	idx, shipid, fpath, fnm, fsz, fwd, ext FROM _oshpt011 WHERE shipid = "& shipid
					rs.open SQL, dbcon, 3
					k = 1
					While Not rs.eof
						change_file = ChangeFile(rs("ext"))
						ext_img = getFileImg(rs("ext"))
%>
											<td style="width:100px;">
												<div style="position:absolute; margin:0 2px;">
													<a href="javascript:;" onClick="delPhoto(<%=rs("idx")%>);"><img src="/img/icon/delete_2.gif" title="이미지 삭제" /></a>
												</div>
												<a href="javascript:Popup('/inc/imgv_ship.asp?shipid=<%=shipid%>&idx=<%=rs("idx")%>&op=ship',820,670,100,50,1,1,1);">
												<img src="<%=rs("fpath") &"/thumb/"& rs("fnm") &".gif"%>" width="100" title="<%=rs("fpath") &"/thumb/"& rs("fnm") &"."& rs("ext")%>"></a>
											</td>
<%						If k Mod 7 = 0 Then %>
										</tr>
										<tr>
<%
						End If
						rs.MoveNext
						k = k + 1
					Wend
					rsc()
				End If
%>
										</tr>
									</table>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 선박정보 끝 -->
					<div id="btnarea1">
<%			If flag = "W" Then %>
						<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a><!-- <img src="/img/adm/btn_save.gif" align="absmiddle"> -->
<%			Else %>
						<a href="javascript:goSave();" class="btn btn25"><span>수정</span></a>
						<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
						<a href="javascript:;" onClick="unoPOP('<%=shipid%>','ship',1); return false;" class="btn btn25"><span>사진관리</span></a>
<%			End If %>
						<a href="ship.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
					</div>
				</div><!-- poptitle2 E -->
			</div><!-- admwrap1 E -->
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
