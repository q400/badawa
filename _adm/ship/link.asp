<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))
%>


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
						<span class="tt2">선박사이트 바로가기</span>
						<span class="ib fright"></span>
					</p>

					<!-- 리스트 시작 -->
					<table id="list1" class="wrapSub">
						<colgroup>
							<col style="width:130px;" />
							<col /><!-- 제목 -->
						</colgroup>
						<thead>
							<tr style="height:30px;">
								<th class="bdr-dash-r ct">선박이름</th>
								<th class="ct">link</th>
							</tr>
						</thead>
						<tbody>
<%
		rso()
		SQL = " SELECT	* FROM _oshpt030 ORDER BY shipnm DESC "
		rs.open SQL, dbcon, 0, 3

		If Not(rs.eof And rs.bof) Then
			Do Until rs.EOF
%>
							<tr height=30>
								<td class="ct"><a href="link_w.asp?idx=<%=rs("idx")%>"><b><%=rs("shipnm")%></b></a></td>
								<td>&nbsp;&nbsp;&nbsp;<a href="<%=rs("link")%>" target="_blank"><%=rs("link")%></a></td>
							</tr>
<%
					rs.MoveNext
			Loop
		Else
%>
							<tr height="100">
								<td class="ct vm" colspan="10">등록된 선박이 없습니다.</td>
							</tr>
<%
		End If
		rsc()
%>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
				</div>
				<!-- poptitle2 E -->
				<div id="btnarea1">
					<a href="link_w.asp" class="btn btn25"><span>신규등록</span></a>
				</div>
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
