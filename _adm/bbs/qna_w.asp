<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= Request("seq")
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= Request("page")
	flag						= SQLI(Request("flag"))

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "M"
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		Call rso()
		SQL = " SELECT seq, title, uno, uname, hp, uip, secret, cnt, ddate, contents, answer " _
			& "	FROM _obbst030 " _
			& " WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			uname				= rs("uname")
			hp					= rs("hp")
			uip					= rs("uip")
			secret				= rs("secret")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
			contents			= rs("contents")
			answer				= rs("answer")
		End If
		Call rsc()
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
		f.action = "qna_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}else{
		return;
	}
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "qna_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("첨부파일을 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "delpic";
		f.action = "qna_x.asp";
		f.method = "post";
		f.target = "nullframe";
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

<form name="fm1" method="post">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">문의게시판 관리</span>
						<span class="ib fright"></span>
					</p>
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col />
						</colgroup>
						<tbody>
							<tr height=30>
								<th class="ct">제목</th>
								<td>
									<%=title%>
								</td>
							</tr>
							<tr height=30>
								<th class="ct">글쓴이</th>
								<td><%=uname%></td>
							</tr>
							<tr height=30>
								<th class="ct">연락처</th>
								<td><%If hp <> "" Then%><%=Left(hp,3)%>-<%=onTel(hp,2)%>-<%=Right(hp,4)%><%End If%></td>
							</tr>
							<tr>
								<th class="ct">내용</th>
								<td colspan=3>
									<textarea name="contents" id="contents" class="tarea" style="width:600px; height:200px;"><%=contents%></textarea>
								</td>
							</tr>
							<tr>
								<th class="ct">답변</th>
								<td colspan=3>
									<textarea name="answer" id="answer" class="tarea" style="width:600px; height:85px;"><%=answer%></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
						<a href="javascript:goSave();" class="btn btn25"><span>답변완료</span></a>
						<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
						<a href="qna.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
