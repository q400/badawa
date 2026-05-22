<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	cd4							= SQLI(Request("cd4"))			'등급구분자
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 20							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "uname"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		If cd1 = "seq" Then
			param = " WHERE seq = '"& cd2 &"' "
		Else
			param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
		End If
	Else
		param = " WHERE memid <> '' "
	End If

	If cd4 <> "" Then
		param = param & " AND memtype = '"& cd4 &"' "
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _omemt010 " & param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

'	If op <> "" Then
'		param = param & " ORDER BY ddate DESC "
'	Else
'		param = param & " ORDER BY ddate DESC "
'	End If

	totalpage = Int((recordcount-1)/pgsize) + 1
	pageParam = "cd1="& cd1 &"&cd2="& cd2 &"&cd4="& cd4
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "mem.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
function goSMS(){
	var seq = "";
	var selectedCount = 0;
	var f = document.fm1;

	for (cnt=0; cnt < f.elements.length; cnt++){
		if(f.elements[cnt].name == 'chk'){
			if(f.elements[cnt].checked == true){
				seq = seq + f.elements[cnt].value + ",\n";
				selectedCount = selectedCount+1;
			}
		}
	}
	if(seq != ""){
		seq = seq.substring(0, seq.length-1);
		var msg = "++ 선택한 회원, 총 "+ selectedCount +"명 ++     \n\n----------------------------------------     \n\n"+ seq
		+"\n\n----------------------------------------     \n\n\n위 회원(들)에게 SMS를 발송하시겠습니까?     "
		window.event.returnValue = false;

		if(confirm(msg)){
			window.open("/_backoffice/sms/sms03.asp?id="+ seq,'_goPage','resizable=1,scrollbars=0,status=0,width=192,height=495');
		}
	}else{
		window.open("/_backoffice/sms/sms03.asp?id=all",'_goPage','resizable=1,scrollbars=1,status=0,width=192,height=495');
	}
}
var checkflag = "false";
function check(field){
	if(checkflag == "false"){
		for (i = 0; i < field.length; i++){
			field[i].checked = true;
		}
		checkflag = "true";
		return "모두해제";
	}else{
		for (i = 0; i < field.length; i++){
			field[i].checked = false;
		}
		checkflag = "false";
		return "모두선택";
	}
}
function memExcel(){
	if(confirm("개인정보 보호를 위하여 열람 후\n보관하지 마시고 반드시 파기바랍니다.\n\n다운로드 받은 xls 파일은 shift + Delete를 이용하여 완전 삭제합니다.\n\n")){
		document.location = "excelMember.asp";
	}
}

function unoPOP(uno, gubn){
	var urllink = "";
	var title = "포인트정보";
	var wt, ht = "0";

	if(gubn == 1){			//예약신규등록
		urllink = "point_p1.asp";
		title = "포인트정보";
		wt = 750;
		ht = 650;
	}
	$.unoDialog({
		url: urllink + "?uno="+ uno,
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


<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="gubn" value="<%=gubn%>">
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
						<span class="ib fright">
							<select name="cd1" style="width:120px;">
								<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
								<option value="uname"<%If cd1 = "uname" Then%> selected<%End If%>>회원이름</option>
								<option value="unamee"<%If cd1 = "unamee" Then%> selected<%End If%>>회원닉네임</option>
								<option value="memid"<%If cd1 = "memid" Then%> selected<%End If%>>회원아이디</option>
								<option value="seq"<%If cd1 = "seq" Then%> selected<%End If%>>회원번호</option>
								<option value="addr1"<%If cd1 = "addr1" Then%> selected<%End If%>>주소</option>
								<option value="tel"<%If cd1 = "tel" Then%> selected<%End If%>>전화번호</option>
								<option value="hp"<%If cd1 = "hp" Then%> selected<%End If%>>휴대폰번호</option>
							</select>
							<input type="text" name="cd2" value="<%=cd2%>" style="width:100px;ime-mode:active;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
							<a href="javascript:;" onClick="memExcel()" class="btnp btn25 vt"><span>엑셀저장</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:40px;" />
							<col style="width:100px;" /><!-- 이름 -->
							<!--<col style="width:30px;" /><!-- 사진 -->
							<col style="width:100px;" /><!-- 닉네임 -->
							<col style="width:100px;" /><!-- 아이디 -->
							<col style="width:100px;" /><!-- 연락처 -->
							<col /><!-- 주소 -->
							<col style="width:130px;" /><!-- 가입일자 -->
						</colgroup>
						<thead>
							<tr>
								<th class="bdr-dash-r ct">번호</th>
								<th class="bdr-dash-r ct">이름</th>
								<!--<th class="bdr-dash-r ct">사진</th> -->
								<th class="bdr-dash-r ct">닉네임</th>
								<th class="bdr-dash-r ct">아이디</th>
								<th class="bdr-dash-r ct">연락처</th>
								<th class="bdr-dash-r ct">주소</th>
								<th class="ct">가입일자</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _omemt010 "& param _
			& " AND ddate NOT IN (SELECT TOP "& ((page-1) * pgsize) &" ddate FROM _omemt010 "& param _
			& " ORDER BY ddate DESC) ORDER BY ddate DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				hp			= onTel(rs("hp"),1) &"-"& onTel(rs("hp"),2) &"-"& onTel(rs("hp"),3)
				tel			= TelSepa(rs("tel"),1) &"-"& TelSepa(rs("tel"),2) &"-"& TelSepa(rs("tel"),3)
				ddate1		= Left(rs("ddate"),10)
				ddate2		= Right(rs("ddate"), Len(rs("ddate"))-Len(ddate1)-1)
%>
<script type="text/javascript">
$(function(){
	// Dialog
	$('#dialog<%=j%>').dialog({
			autoOpen: false
		,	width: 300
		,	height: 400
//		,	buttons: {
//				"Ok": function(){
//					$(this).dialog("close");
//				}
//		,
//				"Cancel": function(){
//					$(this).dialog("close");
//				}
//			}
	});
	// Dialog Link
	$('#dialog_link<%=j%>').click(function(){
		$('#dialog<%=j%>').dialog('enable').dialog('open');
		return false;
	});
	$('#dialog<%=j%>').click(function(){
		$('#dialog<%=j%>').dialog('enable').dialog('close');
		return false;
	});
	//hover states on the static widgets
//	$('#dialog_link, ul#icons li').hover(
//		function(){ $(this).addClass('ui-state-hover'); },
//		function(){ $(this).removeClass('ui-state-hover'); }
//	);
});
</script>
							<tr>
								<td class="ct"><%=j%></td>
								<td class="ct">
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><span class="fcb"><%=Left(rs("uname"), Len(rs("uname")) - 1)%>*</span></a>
									<a href="#" onClick="return unoPOP('<%=rs("seq")%>',1);"><img src="/img/icon/icon_!.gif" class="pl5"></a>
									<!-- <a href="#" onClick="return mpop5('point_p1.asp?uno=<%=rs("seq")%>','ev','center',750,670,0);"><img src="/img/icon/icon_!.gif" width="10" height="10"></a> -->
								</td>
								<!--
								<td class="ct">
									<a href="#" id="dialog_link<%=j%>" class="ui-state-default ui-corner-all"><img src="<%=memPhoto(rs("seq"))%>" width="25" class="vm gbox03"></a>
									<!-- ui-dialog --
									<div id="dialog<%=j%>" title="이미지 크게보기" style="display:none;">
										<p class="ct"><img src="<%=memPhoto(rs("seq"))%>" class="ct" style="cursor:pointer;"></p>
									</div>
								</td>
								//-->
								<td class="ct">
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><%=rs("unamee")%></a>
								</td>
								<td class="ct">
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><span class="fcb ff f11"><%=rs("memid")%></span></a>
								</td>
								<td>
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><span class="fcb ff f11"><%=hp%></span></a>
								</td>
								<!-- <td class="fc2"><a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><%=cx.SetDecode(rs("email"))%></a></td> -->
								<td class="">
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><%=trimtext(rs("addr1"),50)%>&nbsp;&nbsp;<%=trimtext(rs("addr2"),25)%></a>
								</td>
								<td class="">
									<a href="mem_v.asp?seq=<%=rs("seq")%>&page=<%=page%>&<%=pageParam%>"><span class="fcb ff f11"><%=ddate1%> <%=ddate2%></span></a>
								</td>
							</tr>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan=10>회원이 없습니다.</td>
							</tr>
<%
		End If
		rsc()
%>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
				</div>
				<div class="ct mt10"><%=fnPaging(totalpage, page, 10, pageParam)%></div>
				<div id="btnarea1"></div>
			</div>
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
