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
	tag							= 2
'	Response.Write "<font color=#ffffff>FID_ID : "& FID_ID &"</font><br>"

	If cd1 = "" Then cd1 = "title"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If
	stpage						= Int((page - 1) * pgsize)			'각 페이지에 맞게 잘라올 시작값

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _orsvt010 "& param
	rs.open SQL, dbcon
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "rsv.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
}
//-->
</script><script type="text/JavaScript">
/* modal */
function popup1(rid){
	$.unoDialog({
		url: "/rsv/rsv_pop5.asp?ridx="+ rid,
		dialogArguments: '',
		top: 0,
		width: 460,
		height: 360,
		scrollable: false,
		title: "예약정보확인",
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
function popup2(seq){
	$.unoDialog({
		url: "/rsv/goodqa_r.asp?seq="+ seq +"&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&flag=RM",
		dialogArguments: '',
		top: 0,
		width: 500,
		height: 600,
		scrollable: false,
		title: "답변수정",
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
</script>


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
						<img src="/img/my_rsv.gif" alt="나의 예약내역" title="나의 예약내역" />
					</div>
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">
					<!--
					<div>
						<div class="gbox01">
							<dl>
								* 회원의 예약내역을 확인할 수 있습니다.
							</dl>
						</div>
					</div-->
					<div>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct">번호</li>
							<li style="width:110px;" class="ib ct">출조일자</li>
							<li style="width:100px;" class="ib ct">해당선박</li>
							<li style="width:80px;" class="ib ct">예약인원</li>
							<li style="width:80px;" class="ib ct">현재상태</li>
							<li style="width:80px;" class="ib ct">입금액</li>
							<li style="width:180px;" class="ib ct">등록일자</li>
						</ul>
					</div>
					<hr style="border:1px solid #777;">
					<div>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _orsvt010 "& param _
			& " AND ridx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" ridx FROM _orsvt010 "& param _
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
				If rs("status") = "N" Or rs("status") = "K" Then
					stat0 = "<font class='fc7'>예약대기</font>"
				ElseIf rs("status") = "C" Then
					stat0 = "<font class='fcb'>예약완료</font>"
				ElseIf rs("status") = "Y" Then
					stat0 = "<font class='fc8'>출조완료</font>"
				ElseIf rs("status") = "X" Then
					stat0 = "<font class='fc2'>예약취소</font>"
				End If
%>
						<ul class="mt5 mb5">
							<li style="width:50px;" class="ib ct"><%=j%></li>
							<li style="width:110px;" class="ib ct"><a href="javascript:;" onClick="popup1('<%=rs("ridx")%>'); return false;"><b class="ff f11 ls"><%=rdate0%></b></a></li>
							<li style="width:100px;" class="ib ct"><%=shipinfo(rs("shipid"),"shipnm")%></li>
							<li style="width:80px;" class="ib ct"><%=rs("inwon")%> 명</li>
							<li style="width:80px;" class="ib ct"><%=stat0%></li>
							<li style="width:80px;" class="ib rg"><%=FormatNumber(rs("rmoney"),0)%> 원</li>
							<li style="width:180px;" class="ib rg"><%=rs("ddate")%></li>
						</ul>
						<hr style="border:1px dotted #ccc;">
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<ul>
							<li style="height:200px;" class="ct">내용이 없습니다.</li>
							<hr style="border:1px dotted #ccc;">
						</ul>
<%
		End If
		rsc()
%>
					</div>

					<div class="pt10 ct">
<%
		blockpage = Int((page-1)/10)*10 + 1
		If blockpage = 1 Then %>
<%		Else %>
<a href="?page=1&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>처음으로</span></a>
<a href="?page=<%=blockpage-1%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>이전</span></a>
<%		End If
		i = 0
		Do Until i = 10 Or (blockpage + i) > totalpage
			If Int(page) = blockpage + i Then %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff fb ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			Else %>
<a href="?page=<%=blockpage + i%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="ff ls"><%=setP(blockpage + i)%></a>&nbsp;
<%			End If
			i = i + 1
		Loop
		if(blockpage + i - 1) = totalpage Then %>
<%		Else %>
<a href="?page=<%=blockpage+10%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>다음</span></a>
<a href="?page=<%=totalpage%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn21"><span>끝으로</span></a>
<%		End If %>
					</div>

					<div class="rg">
<%		If FID_AUTH <> "" Then %>
						<a href="rsv.asp" class="btn btn25"><span>새로고침</span></a>
<%		End If %>
					</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
