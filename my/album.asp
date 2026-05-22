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
	tag							= 11

	If cd1 = "" Then cd1 = "rnm"
	If page = "" Then
		page = 1
	Else
		page = CInt(page)
	End If

	Set cx = New BsfCode

	If cd2 <> "" Then
		param = " WHERE "& cd1 &" LIKE '%"& cd2 &"%' AND uno = "& FID_NO
	Else
		param = " WHERE uno = "& FID_NO
	End If

	rso()
	SQL = " SELECT	COUNT(*) FROM _oalbt010 "& param
	rs.open SQL, dbcon, 3
		recordcount = CInt(rs(0))
	rsc()

	totalpage = Int((recordcount-1)/pgsize) + 1
%>

<script language="JavaScript">
<!--
function goSearch(){
	var f = document.fm1;
	f.action = "album.asp";
	f.method = "post";
	f.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	goSearch();
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
function inhwa(){
	var f = document.fm1;
	var bval = false;
	for (var i = 0; i < f.chk.length; i++){			//라디오버튼의 갯수 - 1 만큼 loop
		if(f.chk[i].checked == true){					//체크된 버튼을 찾으면
			bval = true;
		}
	}
	if(bval){					//선택된 사항이 존재
		if(confirm("선택한 사진들을 [인화] 신청 하시겠습니까?       ")){
			f.flag.value = "inhwa";
			f.action = "album_m.asp";
			f.method = "post";
			f.submit();
		}
	}else{					//선택사항이 없을때
		alert("[인화] 신청하고자 하는 사진을 하나 이상 선택하세요.        ");
	}
}
function frame(){
	var f = document.fm1;
	var bval = false;
	for (var i = 0; i < f.chk.length; i++){			//라디오버튼의 갯수 - 1 만큼 loop
		if(f.chk[i].checked == true){					//체크된 버튼을 찾으면
			bval = true;
		}
	}
	if(bval){					//선택된 사항이 존재
		if(confirm("선택한 사진들을 [액자] 신청 하시겠습니까?       ")){
			f.flag.value = "frame";
			f.action = "album_m.asp";
			f.method = "post";
			f.submit();
		}
	}else{					//선택사항이 없을때
		alert("[액자] 신청하고자 하는 사진을 하나 이상 선택하세요.        ");
	}
}
function goDelete(){
	var f = document.fm1;
	var bval = false;
	for (var i = 0; i < f.chk.length; i++){			//라디오버튼의 갯수 - 1 만큼 loop
		if(f.chk[i].checked == true){					//체크된 버튼을 찾으면
			bval = true;
		}
	}
	if(bval){					//선택된 사항이 존재
		if(confirm("선택한 사진들을 삭제 하시겠습니까?       ")){
			f.flag.value = "D";
			f.action = "album_x.asp";
			f.method = "post";
			f.submit();
		}
	}else{					//선택사항이 없을때
		alert("삭제하고자 하는 사진을 하나 이상 선택하세요.        ");
	}
}
//-->
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
						<img src="/img/my_album.gif" alt="나의 앨범" title="나의 앨범" />
					</div>
					<div>
						<div class="gbox01">
							<dl>* 조황갤러리에서 선택했던 사진들을 확인할 수 있습니다.</dl>
							<!--
							<dl>* 사진을 선택하여 액자신청이나 사진인화 신청을 할 수 있습니다.</dl>
							<dl>* 액자신청/사진인화 택배 비용은 <b class="fcr">착불</b>입니다.</dl-->
						</div>
					</div>
					<div class="pt10"></div>
					<hr style="border:1px solid #777;">

<form name="fm1" method="post">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">

					<div>
						<ul class="mt5 mb5">
							<li style="width:20px;" class="ib ct"></li>
							<li style="width:40px;" class="ib ct">번호</li>
							<li style="width:100px;" class="ib ct">사진</li>
							<li style="width:100px;" class="ib ct">상태</li>
							<li style="width:100px;" class="ib ct">위치</li>
							<li style="width:100px;" class="ib ct">등록일자</li>
							<li style="width:220px;" class="ib ct">선택일자</li>
						</ul>
					</div>
					<hr style="border:1px dotted #777;">
					<div>
<%
		rso()
		SQL = " SELECT TOP "& pgsize &" * FROM _oalbt010 "& param _
			& " AND idx NOT IN (SELECT TOP "& ((page-1) * pgsize) &" idx FROM _oalbt010 "& param _
			& " ORDER BY idx DESC) ORDER BY idx DESC "
		rs.open SQL, dbcon, 0, 3

		j = recordcount

		If Not (rs.eof And rs.bof) Then
			If page <> 1 Then
				j = j - (page - 1) * pgsize
			End If

			i = 1
			rs.MoveFirst
			Do Until rs.EOF
				Select Case rs("status")
					Case "A"			: stat = "-"
					Case "C"			: stat = "인화신청"
					Case "E"			: stat = "액자신청"
					Case "Z"			: stat = "완료"
				End Select
				Select Case rs("op")
					Case "gallery"		: op = "조황갤러리"
					Case "ps"			: op = "조황후기"
				End Select
%>
						<ul class="mt5 mb5">
							<li style="width:20px;" class="ib ct"><input type="checkbox" name="chk" id="chk" value="<%=rs("idx")%>"></li>
							<li style="width:40px;" class="ib ct"><%=j%></li>
							<li style="width:100px;" class="ib ct">
								<a href="javascript:Popup('/inc/imgv_album.asp?idx=<%=rs("photo")%>&op=<%=rs("op")%>',820,770,100,50,1,1,1);"><img src="<%=photoInfo(rs("photo"),rs("op"))%>" width="60"></a>
							</li>
							<li style="width:100px;" class="ib ct"><%=stat%></li>
							<li style="width:100px;" class="ib ct"><%=op%></li>
							<li style="width:100px;" class="ib ct"><%=rs("wdate")%></li>
							<li style="width:220px;" class="ib rg"><%=rs("ddate")%></li>
						</ul>
<%
				rs.MoveNext
				i = i + 1
				j = j - 1
			Loop
		Else
%>
						<ul>
							<li style="height:200px;" class="ct">등록된 사진이 없습니다.</li>
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
						<!-- <a href="javascript:inhwa();" class="btn btn25"><span>인화신청</span></a> -->
						<!-- <a href="javascript:frame();" class="btn btn25"><span>액자신청</span></a> -->
						<a href="javascript:goDelete();" class="btnr btn25"><span>선택사진삭제</span></a>
<%		End If %>
					</div>
					<div class="pt20 pb20"></div>
</form>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
