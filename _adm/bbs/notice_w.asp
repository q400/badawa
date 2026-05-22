<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 10								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= Request("seq")
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= Request("page")
	flag						= SQLI(Request("flag"))

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, title, uno, uip, cnt, ddate, contents " _
			& "	FROM _obbst010 " _
			& " WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uip					= rs("uip")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()
		flag = "M"
	End If
%>

<script language="JavaScript">
<!--
function goSave(){
	var f = document.fm1;
//	카테고리 선택
//	if(!(fm1.cate[0].checked) && !(fm1.cate[1].checked) && !(fm1.cate[2].checked) && !(fm1.cate[3].checked) && !(fm1.cate[4].checked)){
//		alert("분류를 선택해 주세요.       ");
//		return;
//	}
	if(f.title.value == ""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return;
	}
	if(f.contents.value == ""){
		alert("내용을 입력하세요.");
		f.contents.focus();
		return;
	}
	if(confirm("입력하시겠습니까?")){
		f.action = "zbbs_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	}else{
		return;
	}
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "zbbs_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("첨부파일을 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "delpic";
		f.action = "zbbs_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<input type='file' name='upFile' style='width:600px;'><br>";
	}
	layer17.innerHTML = txtbox;
}
//-->
</script>


<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">

<form name="fm1" method="POST" enctype="multipart/form-data" onSubmit="return goSave()">
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">공지사항 글<%If flag = "W" Then%>쓰기<%Else%>수정<%End If%></span>
						<span class="ib fright"></span>
					</p>
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="width:280px;" />
							<col style="width:120px;" />
							<col />
						</colgroup>
						<tbody>
							<tr height=30>
								<th class="ct">제목</th>
								<td colspan=3>
									<input type="text" name="title" maxlength="100" value="<%=title%>" style="width:600px; ime-mode:active;">
								</td>
							</tr>
							<tr>
								<th class="ct">내용</th>
								<td colspan=3>
									<textarea name="contents" id="contents" class="tarea" style="width:600px; height:245px; ime-mode:active;"><%=contents%></textarea>
								</td>
							</tr>
							<tr height=30>
								<th class="ct">파일첨부</th>
								<td colspan=3>
									<input type="file" name="upFile" class="file" style="width:600px;">
								</td>
							</tr>
							<tr height=30>
								<th class="ct">첨부파일</th>
								<td colspan=3>
<%
		If seq <> "" Then
			rso()
			SQL = " SELECT idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _obbst011 WHERE seq = "& seq
			rs.open SQL, dbcon
			k = 1
			While Not rs.eof
%>
									<a href="/data/notice/<%=rs("fnm")%>"><%=rs("fnm")%></a>&nbsp;&nbsp;
									<input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="delPhoto(<%=rs("idx")%>)"><br>
<%
				k = k + 1
				rs.MoveNext
			Wend
			rsc()
		End If
%>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
<%			If flag = "W" Then %>
						<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%			Else %>
						<a href="javascript:goSave();" class="btn btn25"><span>수정</span></a>
						<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%			End If %>
						<a href="notice.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
					</div>
				</div>
				<!-- poptitle2 E -->
			</div>
			<!-- admwrap1 E -->
		</div>
	</center>
</form>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
<%	Set cx = Nothing %>
