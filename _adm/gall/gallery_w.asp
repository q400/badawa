<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= Request("seq")
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	sdate						= Request("sdate")
	page						= Request("page")
	shipid						= Request("shipid")
	flag						= SQLI(Request("flag"))

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"
	If sdate = "" Then sdate = CDate(Date)
	'Response.Write "sdate : "& sdate &"<br>"

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

<script type="text/javascript">
<!--
$(document).ready(function(){
	mool('<%=Year(sdate)%>','<%=setp(Month(sdate))%>','<%=setp(Day(sdate))%>');
});

function goSave(){
	var f = document.fm1;
//	카테고리 선택
//	if(!(fm1.cate[0].checked) && !(fm1.cate[1].checked) && !(fm1.cate[2].checked) && !(fm1.cate[3].checked) && !(fm1.cate[4].checked)){
//		alert("분류를 선택해 주세요.");
//		return;
//	}
	if($("#shipid").val() == ""){
		alert("선박을 선택하세요.");
		$("#shipid").focus();
		return;
	}
	if(confirm("입력하시겠습니까?")){
//		upload();
		f.action = "gallery_x.asp";
		f.method = "post";
		f.submit();
	}else{
		return;
	}
}
function goExcel(){
	var f = document.fm1;
	f.action = "gallery_excel.asp";
	f.method = "post";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "gallery_x.asp";
		f.method = "post";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DelPhoto";
		f.action = "gallery_x.asp";
		f.method = "post";
		f.submit();
	}
}
function mool(op1,op2,op3){			//양력일자 입력 (_ocodt020)
	var f = document.fm1;
	f.yy.value = op1;
	f.mm.value = op2;
	f.dd.value = op3;
	f.action = "mool_x.asp";
	f.method = "post";
	f.target = "nullframe";
	f.submit();
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="seq" value="<%=seq%>" />
<input type="hidden" name="page" value="<%=page%>" />
<input type="hidden" name="cd1" value="<%=cd1%>" />
<input type="hidden" name="cd2" value="<%=cd2%>" />
<input type="hidden" name="flag" value="<%=flag%>" />
<input type="hidden" name="idx" />
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
						<span class="tt2">갤러리 관리</span>
						<span class="ib fright"></span>
					</p>
					<!-- 갤러리정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="" />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">선박선택</th>
								<td>
									<select name="shipid" id="shipid" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT shipid, shipnm FROM _oshpt010 ORDER BY shipid ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("shipid")%>"<%If Trim(shipid) = Trim(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%> [<%=rs("shipid")%>]</option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">출조일자</th>
								<td>
									<select name="yy" id="yy" style="width:70px;">
<%		For u = year(Date)-5 To year(Date) Step 1 %>
									<option value="<%=u%>"<%If Year(sdate) = u Then%> selected<%End If%>><%=u%></option>
<%		Next %>
									</select> 년&nbsp;
									<select name="mm" id="mm" style="width:50px;" onChange="mool(''+ document.fm1.yy.value +'',''+ this.options[this.selectedIndex].value +'',''+ document.fm1.mm.value +'');">
<%		For j = 1 To 12 Step 1 %>
									<option value="<%=setp(j)%>"<%If setp(Month(sdate)) = setp(j) Then%> selected<%End If%>><%=setp(j)%></option>
<%		Next %>
									</select> 월&nbsp;
									<select name="dd" id="dd" style="width:50px;" onChange="mool(''+ document.fm1.yy.value +'',''+ document.fm1.mm.value +'',''+ this.options[this.selectedIndex].value +'');">
<%		For k = 1 To 31 Step 1 %>
									<option value="<%=setp(k)%>"<%If Day(sdate) = k Then%> selected<%End If%>><%=setp(k)%></option>
<%		Next %>
									</select> 일
									<!-- <a href="javascript:carcmool();">물때</a> -->
								</td>
							</tr>
							<tr height="30">
								<th class="ct">출조</th>
								<td>
									<select name="chuljo" id="chuljo" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '출조' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If chuljo = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">물때</th>
								<td>
									<input type="text" name="multime" id="multime" maxlength="20" value="<%=multime%>" style="width:80px;">&nbsp;
									<span class="f11 fcr ls">출조일 선택시 자동 입력</span>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">날씨</th>
								<td>
									<input type="radio" name="weather" id="weather1" value="맑음"<%If weather = "맑음" Or weather = "" Then%> checked<%End If%>><label for="weather1">맑음</label>
									<input type="radio" name="weather" id="weather2" value="흐림"<%If weather = "흐림" Then%> checked<%End If%>><label for="weather2">흐림</label>
									<input type="radio" name="weather" id="weather3" value="안개"<%If weather = "안개" Then%> checked<%End If%>><label for="weather3">안개</label>
									<input type="radio" name="weather" id="weather4" value="비"<%If weather = "비" Then%> checked<%End If%>><label for="weather4">비</label>
									<input type="radio" name="weather" id="weather5" value="눈"<%If weather = "눈" Then%> checked<%End If%>><label for="weather5">눈</label>
									<input type="radio" name="weather" id="weather6" value="바람"<%If weather = "바람" Then%> checked<%End If%>><label for="weather6">바람</label>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">파고</th>
								<td>
									<select name="pago" id="pago" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '파고' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If pago = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">입질</th>
								<td>
									<input type="radio" name="ipzil" id="ipzil1" value="대박"<%If ipzil = "대박" Or ipzil = "" Then%> checked<%End If%>><label for="ipzil1">대박</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil2" value="호조"<%If ipzil = "호조" Then%> checked<%End If%>><label for="ipzil2">호조</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil3" value="좋음"<%If ipzil = "좋음" Then%> checked<%End If%>><label for="ipzil3">좋음</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil4" value="보통"<%If ipzil = "보통" Then%> checked<%End If%>><label for="ipzil4">보통</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil5" value="저조"<%If ipzil = "저조" Then%> checked<%End If%>><label for="ipzil5">저조</label>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">조과</th>
								<td>
									<select name="jogwa" id="jogwa" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '조과' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If jogwa = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">최대어종</th>
								<td>
									<select name="bestfish" id="bestfish" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '어종' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If bestfish = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr height="30">
								<th class="ct">최대크기</th>
								<td>
									<input type="text" name="fishsize" id="fishsize" maxlength="10" value="<%=fishsize%>" style="width:80px;"> 센티미터
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
<%			If flag = "W" Then %>
						<a href="javascript:;" onClick="goSave();" class="btn btn25"><span>저장</span></a>
<%			Else %>
						<a href="javascript:;" onClick="goSave();" class="btn btn25"><span>수정</span></a>
						<a href="javascript:;" onClick="goDelete();" class="btnr btn25"><span>전체삭제</span></a>
						<a href="gallery_excel.asp?seq=<%=seq%>&shipid=<%=shipid%>&yy=<%=Year(sdate)%>&mm=<%=setp(Month(sdate))%>&dd=<%=setp(Day(sdate))%>" class="btng btn25"><span>Excel 업로드</span></a>
<%			End If %>
						<a href="gallery.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn25"><span>목록</span></a>
						<a href="gallery.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>처음으로</span></a>
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
