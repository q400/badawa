<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	idx							= SQLI(Request("idx"))
	flag						= SQLI(Request("flag"))

	If flag = "" Then flag = "W"

	If idx <> "" Then
		rso()
		SQL = " SELECT	shipnm, link " _
			& "	FROM	_oshpt030 " _
			& " WHERE	idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipnm				= rs("shipnm")
			link				= rs("link")
		End If
		rsc()
		flag = "M"
	End If
%>

<script language="JavaScript">
<!--
function goSave(){
	var f = document.fm1;
	if(!f.shipnm.value){								//선박이름체크
		alert("선박이름을 입력하세요.");
		f.shipnm.focus();
		return;
	}
	if(!f.link.value){								//link
		alert("관련 링크를 입력하세요.");
		f.link.focus();
		return;
	}
	f.flag.value = "<%=flag%>";
	f.action = "link_x.asp";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "link_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="idx" value="<%=idx%>">
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
						<span class="tt2">선박사이트 바로가기</span>
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
								<th class="ct">선박이름</th>
								<td colspan=3>
									<input type="text" name="shipnm" id="shipnm" maxlength="100" value="<%=shipnm%>" style="width:200px;">
								</td>
							</tr>
							<tr>
								<th class="ct">관련 link</th>
								<td colspan=3>
									<input type="text" name="link" id="link" maxlength="200" value="<%=link%>" style="width:370px;">
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
						<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%	If flag = "M" Then %>
						<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%	End If %>
						<a href="link.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
