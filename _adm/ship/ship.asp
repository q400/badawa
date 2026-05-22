<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= SQLI(Request("op"))
	setsize						= 10							'보여지는 페이지 수
	pgsize						= 20							'보여지는 게시물 수

	If cd1 = "" Then cd1 = "shipnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' "
	Else
		param = " WHERE shipnm <> '' "
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _oshpt010 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script type="text/javascript">
<!--
function goSearch(){
	var f = document.fm1;
	f.page.value = 1;
	f.action = "ship.asp";
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
//-->
</script>


<form name="fm1">
<input type="hidden" name="page" value="<%=page%>">
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
						<span class="ib fright">
							<select name="cd1" style="width:90px;">
							<option value=""<%If cd1 = "" Then%> selected<%End If%>>선택</option>
							<option value="shipnm"<%If cd1 = "shipnm" Then%> selected<%End If%>>선박이름</option>
							<option value="captain"<%If cd1 = "captain" Then%> selected<%End If%>>선장이름</option>
							</select>
							<input type="text" name="cd2" style="width:100px;ime-mode:active;" />
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
						</span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:40px;" />
							<col style="width:120px;" /><!-- 선박이름 -->
							<col style="width:70px;" /><!-- 어선번호 -->
							<col style="width:100px;" /><!-- 선장/부선장 -->
							<col style="width:100px;" /><!-- 연락처 -->
							<col style="width:70px;" /><!-- 크기/정원 -->
							<col /><!-- 기본/가능출조 -->
							<col style="width:60px;" /><!-- 일정관리 -->
						</colgroup>
						<thead>
							<tr>
								<th class="bdr-dash-r ct">ID</th>
								<th class="bdr-dash-r ct">선박이름</th>
								<th class="bdr-dash-r ct">어선번호</th>
								<th class="bdr-dash-r ct">선장/부선장</th>
								<th class="bdr-dash-r ct">연락처</th>
								<th class="bdr-dash-r ct">크기/정원</th>
								<th class="bdr-dash-r ct">기본/가능출조</th>
								<th class="ct">일정관리</th>
							</tr>
						</thead>
						<tbody>
<%
		Call rso()
		SQL = " SELECT	TOP "& pgsize &" * FROM _oshpt010 "& param _
			& " AND ddate NOT IN (SELECT TOP "& ((page-1) * pgsize) &" ddate FROM _oshpt010 "& param _
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
'				hp			= onTel(rs("hp"),1) &"-"& onTel(rs("hp"),2) &"-"& onTel(rs("hp"),3)
'				tel			= TelSepa(rs("tel"),1) &"-"& TelSepa(rs("tel"),2) &"-"& TelSepa(rs("tel"),3)
				ddate1		= Left(rs("ddate"),10)
				ddate2		= Right(rs("ddate"), Len(rs("ddate"))-Len(ddate1)-1)
				ttel		= Replace(rs("tel"),"/","<br>")
				ttel		= Replace(ttel,",","<br>")

				Set rs3 = Server.CreateObject("ADODB.Recordset")
				SQL = " SELECT ISNULL(COUNT(*),0) FROM _oshpt011 WHERE shipid = "& rs("shipid")
				rs3.open SQL, dbcon
					pCnt	= CInt(rs3(0))
				rs3.close
				Set rs3 = Nothing
%>
						<tr onClick="location='ship_w.asp?shipid=<%=rs("shipid")%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>'" style="cursor:pointer;">
							<td class="ct"><%=rs("shipid")%></td>
							<td class="ct"><b><%=rs("shipnm")%></b>
								<%If pCnt > 0 Then%><img src="/img/icon/file.gif" class="vm"><%End If%></a>
								<%If rs("active_yn") Then%><font class="f11 fc4">√</font><%End If%>
							</td>
							<td class="ct"><%=Replace(rs("shipno"),"-","<br>")%></td>
							<td class="ct"><%=rs("captain")%><%If rs("captain_sub") <> "" Then%><br><%=rs("captain_sub")%><%End If%></td>
							<td class=""><%=ttel%></td>
							<td class="ct"><%=rs("sz")%><br><%=rs("capa")%></td>
							<td class="ml5"><%=rs("chuljo0")%><br><%=rs("chuljo")%></td>
							<td class="ct">
								<a href="ship_s.asp?shipid=<%=rs("shipid")%>" class="btn btn21"><span>관리</span></a>
							</td>
<%
					rs.MoveNext
					i = i + 1
					j = j - 1
			Loop
		Else
%>
						<tr height="100">
							<td class="ct vm" colspan="10">등록된 선박이 없습니다.</td>
						</tr>
<%
		End If
		Call rsc()
%>
					</table>
					<!-- 리스트 끝 -->

					<div id="btnarea1"><a href="ship_w.asp" class="btn btn25"><span>선박등록</span></a></div>
				</div>
			</div>
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
<%	Set cx = Nothing %>
