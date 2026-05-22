<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= Request("seq")
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	sdate						= Request("sdate")
	page						= Request("page")
	flag						= SQLI(Request("flag"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	shipid						= Request("shipid")

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"
	If sdate = "" Then sdate = CDate(Date)
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, title, uno, cnt, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
			& "	FROM _obbst020 " _
			& " WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			cnt					= rs("cnt")
			shipid				= rs("shipid")
			wdate				= rs("wdate")
			chuljo				= rs("chuljo")
			multime				= rs("multime")
			weather				= rs("weather")
			pago				= rs("pago")
			ipzil				= rs("ipzil")
			jogwa				= rs("jogwa")
			bestfish			= rs("bestfish")
			fishsize			= rs("fishsize")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()
		flag = "M"
		If wdate <> "" Then sdate = wdate
	End If
%>

<script language="JavaScript">
<!--
function goSave(){
	var f = document.fm1;
//	upload();
	if(f.upFile.value == ""){
		alert("업로드할 엑셀파일을 선택해 주세요.");
		return;
	}
	f.action = "gallery_excel_x.asp";
	f.method = "post";
	f.submit();
}

function goDelete(){
	var f = document.fm1;
	if(confirm("DB정보를 삭제하겠습니까?")){
		f.flag.value = "DX";
		f.action = "gallery_excel_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
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
						<span class="tt2">갤러리 Excel 파일 등록</span>
						<span class="ib fright"></span>
					</p>
					<!-- 갤러리정보 시작 -->
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
								<td colspan=3>[<%=shipid%>] <%=shipInfo(shipid,"shipnm")%></td>
							</tr>
							<tr>
								<th class="ct">게시물번호</th>
								<td colspan=3><%=seq%></td>
							</tr>
							<tr height="30">
								<th class="ct">출조일자</th>
								<td colspan=3><%=wdate%></td>
							</tr>
							<tr>
								<td colspan=10 class="fc4 lf pl10 pt10 pb10">
									※ 이미지 사이즈 <b>800×533</b> 로 &nbsp;<b>JPG</b> 를 권장합니다.<br>
									※ <b>IMGUR.COM</b>에 이미지를 등록한 후 매뉴얼에 따라 이미지 목록을 <b>엑셀로 작성</b>하여 업로드합니다.<br>
									※ 엑셀파일은 <b>Excel 97-2003 통합문서(*.xls)</b> 로 되어 있어야 합니다.
								</td>
							</tr>
<%
			rso()
			SQL = " SELECT	COUNT(*) " _
				& " FROM	_ogalt010 " _
				& " WHERE	shipid = "& shipid _
				& " AND		yymmdd = '"& yy & mm & dd &"'"
			rs.open SQL, dbcon

			If Not (rs.eof And rs.bof) Then
				photoCnt = rs(0)
			End If
%>
							<tr height="30">
								<th class="ct">업로드 사진갯수</th>
								<td colspan=3 class="vb">
									현재 &nbsp;&nbsp;<b class="f15 fc7"><%=photoCnt%> 장</b> &nbsp;&nbsp;업로드 되어 있습니다.
									<span class="frt mr10"><a href="http://www.imgur.com" target="_blank"><b class="fcu">imgur.com 바로가기</b></a></span>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">Excel파일 업로드</th>
								<td colspan=3 class="vb">
									<input type="file" name="upFile" id="upFile" class="file" style="width:600px;" />
								</td>
							</tr>
							<tr height="30">
								<th class="ct">Excel파일 정보</th>
								<td colspan=3 class="vb">
									<span class="fc4 fb">EXCEL을 통해 DB에 등록된 마지막 해당 일자 &nbsp;:</span>&nbsp;&nbsp;
<%
			rso()
			SQL = " SELECT	TOP 1 seq, yymmdd, ddate " _
				& " FROM	_ogalt010 " _
				& " WHERE	shipid = "& shipid _
				& " AND		yymmdd = (SELECT MAX(yymmdd) FROM _ogalt010 WHERE shipid = "& shipid &") "
			rs.open SQL, dbcon
'			Response.Write "SQL : "& SQL &"<br>"
			If Not (rs.eof And rs.bof) Then
%>
									<b class="f15 fc7"><%=rs("yymmdd")%></b> &nbsp;&nbsp;<b>(등록일자 : <%=rs("ddate")%>)</b>
<%
			End If
			rsc()
%>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
<%			If flag = "W" Then %>
						<a href="javascript:;" onClick="goSave();" class="btn btn25"><span>DB정보저장</span></a>
<%			Else %>
						<a href="javascript:;" onClick="goSave();" class="btn btn25"><span>DB정보수정</span></a>
						<a href="javascript:;" onClick="goDelete();" class="btnr btn25"><span>DB정보삭제</span></a>
<%			End If %>
						<a href="gallery_w.asp?seq=<%=seq%>&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btng btn25"><span>이전</span></a>
						<a href="gallery.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn25"><span>목록</span></a>
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
