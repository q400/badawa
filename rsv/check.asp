<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	cd1							= SQLI(Request("cd1"))				'검색조건
	cd2							= SQLI(Request("cd2"))				'검색단어
	page						= SQLI(Request("page"))
	flag						= SQLI(Request("flag"))
	setsize						= 10								'보여지는 페이지 수
	pgsize						= 15								'보여지는 게시물 수
	tag							= 4
'	Response.Write "<font color=#ffffff>FID_ID : "& FID_ID &"</font><br>"

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT COUNT(*) FROM _orsvt010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	unoRequest("fm1", "check.asp");
}
function writeKeyDown(){
	if (event.keyCode == 13)	goSearch();
}
function goDelete(rid){
	if (confirm("예약을 취소하시겠습니까?")){
		unoRequest("fm2", "rsv_xx.asp?flag=D&ridx="+ rid);
	} else {
		return;
	}
}
/* modal */
function popup1(rid){
	$.unoDialog({
		url: "rsv_pop5.asp?ridx="+ rid,
		dialogArguments: '',
		top: 0,
		width: 460,
		height: 360,
		scrollable: false,
		title: "예약정보확인",
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
//-->
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/rsv.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약타이틀" /></div>
					<div class="mt10 mb10"><img src="/img/rsv/rsv_check.gif" alt="예약확인 및 취소" /></div>
					<div style="width:710px; border:0px solid #000;" class="mb25">
						<center>
						<div class="gbox01" style="width:700px;">
							<dl class="mt5">* 회원의 예약내역을 확인하고 취소할 수 있습니다.</dl>
							<dl class="mb5">* 관리자가 <b class="fcr">예약 확정 후</b>에는 예약 취소가 불가합니다.</dl>
						</div>
						</center>
					</div>
<!--
<form name="fm1" id="fm1" method="post">
<input type="hidden" name="cd1" value="rname">

					<div class="rg">
						<input type="text" name="cd2" maxlength="10" onKeyDown="writeKeyDown()" style="width:120px; ime-mode:active;">
						<a href="javascript:;" onClick="goSearch()" class="btn btn25"><span>검색</span></a>
					</div>
</form>
-->
					<div class="mt5"></div>
					<span>
						<img src="/img/bbs_line01.gif" width="710" height="1" class="db" alt="라인" />
					</span>
					<div>
						<ul>
							<li style="width:50px;" class="ct ib pt5 pb5"><font class="fc3">번호</font></li>
							<li style="width:100px;" class="ct ib pt5 pb5"><font class="fc3">출조일자</font></li>
							<li style="width:80px;" class="ct ib pt5 pb5"><font class="fc3">해당선박</font></li>
							<li style="width:60px;" class="ct ib pt5 pb5"><font class="fc3">인원</font></li>
							<li style="width:60px;" class="ct ib pt5 pb5"><font class="fc3">현재상태</font></li>
							<li style="width:100px;" class="ct ib pt5 pb5"><font class="fc3">입금액</font></li>
							<li style="width:70px;" class="ct ib pt5 pb5"><font class="fc3">예약취소</font></li>
							<li style="width:150px;" class="ct ib pt5 pb5"><font class="fc3">등록일자</font></li>
						</ul>
					</div>
					<span>
						<img src="/img/bbs_line01.gif" width="710" height="1" class="db" alt="라인" />
					</span>

<form name="fm2" id="fm2" method="post">
<input type="hidden" name="ridx">
<input type="hidden" name="flag">

<%
		rso()
		SQL = " SELECT	TOP 15 * FROM _orsvt010 "& param _
			& " AND ridx NOT IN (SELECT TOP "& ((page-1) * 15) &" ridx FROM _orsvt010 "& param _
			& " ORDER BY ridx DESC) ORDER BY ridx DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				rdate0 = Left(rs("rdate"),4) &"-"& Mid(rs("rdate"),5,2) &"-"& Right(rs("rdate"),2)
				If rs("status") = "N" Then
					stat0 = "<font class='fc7'>예약대기</font>"
				Else
					stat0 = "예약완료"
				End If
%>
					<div>
						<ul style="width:700px; border:0px solid #555;" class="mt5 mb5">
							<li style="width:50px;" class="ct ib"><%=j%></li>
							<li style="width:100px;" class="ct ib">
								<a href="javascript:;" onClick="popup1('<%=rs("ridx")%>'); return false;"><b class="ff ls"><%=rdate0%></b></a>
							</li>
							<li style="width:80px;" class="ct ib"><%=shipinfo(rs("shipid"),"shipnm")%></li>
							<li style="width:60px;" class="ct ib"><%=rs("inwon")%> 명</li>
							<li style="width:60px;" class="ct ib"><%=stat0%></li>
							<li style="width:100px;" class="rg ib ff ls"><%=FormatNumber(rs("rmoney"),0)%> 원&nbsp;&nbsp;</li>
							<li style="width:70px;" class="ct ib">
								<%If rs("status") = "N" Or rs("status") = "K" Then%>
								<a href="javascript:;" onClick="goDelete(<%=rs("ridx")%>);" class="btnr btn18"><span>예약취소</span></a>
								<%Else%>
								<a href="javascript:alert('예약이 확정되어 취소하실 수 없습니다. 관리자에게 전화 주세요.');" class="btn btn18"><span>취소불가</span></a>
								<%End If%>
							</li>
							<li style="width:150px;" class="ct ib"><span class="ff f11 ls"><%=rs("ddate")%></span></li>
						</ul>
						<hr style="border:1px dotted #ccc;">
					</div>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
					<div style="width:710px;">
						<ul class="mt5 mb5">
							<li style="width:100%; height:200px;" class="ct ib">등록된 예약이 없습니다.</li>
						</ul>
						<hr style="border:1px dotted #ccc;">
					</div>
<%
		End If
		rsc()
%>
</form>
					<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10+1
		If blockpage = 1 Then %>
<%		Else %>
						<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>처음으로</span></a>
						<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>이전</span></a>
						&nbsp;&nbsp;
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage+i) > totalpage
			If Int(page) = blockpage+i Then
%>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff fb vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			Else %>
						<a href="?page=<%=blockpage+i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff vm ls"><%=setP(blockpage+i)%></a>&nbsp;&nbsp;
<%			End If
			i = i + 1
		Loop
		If (blockpage+i-1) = totalpage Then %>
<%		Else %>
						&nbsp;&nbsp;
						<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>다음</span></a>
						<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn18"><span>끝으로</span></a>
<%		End If %>
					</div>

					<div class="mb30 fright">
<%		If FID_AUTH <> "" Then %>
						<a href="check.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
