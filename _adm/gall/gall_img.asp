<!--
'************************************************************************************
'* Program 명	: gall_img.asp (조황갤러리 이미지관리)
'************************************************************************************
-->
<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= Request("seq")
	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	sdate						= Request("sdate")
	page						= Request("page")
	flag						= SQLI(Request("flag"))

	fcolor						= "#ffaa00"
	fontx						= 40
	fonty						= 40
	pcomment					= "www.badawa.co.kr"

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"
	If sdate = "" Then sdate = CDate(Date)
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, title, uno, cnt, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
			& "	FROM _ogalt020 " _
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

	Dim uploadUrl
	uploadUrl = "http://" & Request.ServerVariables("HTTP_HOST") & ":" & Request.ServerVariables("SERVER_PORT") & Request.ServerVariables("URL")
	uploadUrl = Mid(uploadUrl, 1, InStrRev(uploadUrl, "/"))

	'If shipid = "" Then shipid = 0
%>

<script type="text/javascript">
$(document).ready(function(){
	setMoolTm(fm1);
});
function goSave(){
	var f = document.fm1;
	if($("#shipid").val() == ""){
		alert("선박을 선택하세요.");
		$("#shipid").focus();
		return;
	}
	$(".loader").show();
	f.action = "gall_img_x.asp";
	f.method = "post";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if (confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "gall_img_x.asp";
		f.method = "post";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if (confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DP";
		f.action = "gall_img_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function setMoolTm(form){			//양력일자 입력 (_ocodt020)
	var yy = form.syear.value;
	var mm = form.smon.value;
	var dd = form.sday.value;
	form.action = "mool_set.asp?yy="+ yy +"&mm="+ mm +"&dd="+ dd;
	form.target = "nullframe";
	form.submit();
}
</script>


<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<div>
		<center>
			<div class="ib vt"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib" id="admwrap1">

<form name="fm1" id="fm1" method="post" enctype="multipart/form-data" onSubmit="return goSave()">
<input type="hidden" name="seq" value="<%=seq%>" />
<input type="hidden" name="page" value="<%=page%>" />
<input type="hidden" name="cd1" value="<%=cd1%>" />
<input type="hidden" name="cd2" value="<%=cd2%>" />
<input type="hidden" name="flag" />
<input type="hidden" name="idx" />

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">갤러리 이미지관리</span>
						<span class="ib fright"></span>
					</p>
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:150px;" />
							<col style="width:*;" />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">선박선택</th>
								<td>
									<select name="shipid" id="shipid" style="width:150px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	shipid, shipnm FROM _oshpt010 ORDER BY shipid ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("shipid")%>"<%If CStr(shipid) = CStr(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%>[<%=rs("shipid")%>]</option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ct">출조일자</th>
								<td>
									<select name="syear" id="syear" style="width:80px;">
<%		For u = year(Date)-2 To year(Date)+1 Step 1 %>
										<option value="<%=u%>"<%If Year(sdate) = u Then%> selected<%End If%>><%=u%></option>
<%		Next %>
									</select> 년&nbsp;
									<select name="smon" id="smon" style="width:70px;">
<%		For j = 1 To 12 Step 1 %>
										<option value="<%=setp(j)%>"<%If setp(Month(sdate)) = setp(j) Then%> selected<%End If%>><%=setp(j)%></option>
<%		Next %>
									</select> 월&nbsp;
									<select name="sday" id="sday" style="width:70px;" onchange="setMoolTm(this.form);">
<%		For k = 1 To 31 Step 1 %>
										<option value="<%=setp(k)%>"<%If Day(sdate) = k Then%> selected<%End If%>><%=setp(k)%></option>
<%		Next %>
									</select> 일
									&nbsp;&nbsp;
									<input type="text" name="multime" id="multime" maxlength="20" value="<%=multime%>" style="width:130px;" />&nbsp;
									<span class="f11 fcr ls">출조일 선택시 자동 입력</span>
								</td>
							</tr>
							<tr>
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
							<tr>
								<th class="ct">날씨</th>
								<td>
									<input type="radio" name="weather" id="weather1" value="맑음"<%If weather = "맑음" Or weather = "" Then%> checked<%End If%> /><label for="weather1">맑음</label>
									<input type="radio" name="weather" id="weather2" value="흐림"<%If weather = "흐림" Then%> checked<%End If%> /><label for="weather2">흐림</label>
									<input type="radio" name="weather" id="weather3" value="안개"<%If weather = "안개" Then%> checked<%End If%> /><label for="weather3">안개</label>
									<input type="radio" name="weather" id="weather4" value="비"<%If weather = "비" Then%> checked<%End If%> /><label for="weather4">비</label>
									<input type="radio" name="weather" id="weather5" value="눈"<%If weather = "눈" Then%> checked<%End If%> /><label for="weather5">눈</label>
									<input type="radio" name="weather" id="weather6" value="바람"<%If weather = "바람" Then%> checked<%End If%> /><label for="weather6">바람</label>
								</td>
							</tr>
							<tr>
								<th class="ct">파고</th>
								<td>
									<select name="pago" style="width:150px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '파고' ORDER BY idx ASC "
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
							<tr>
								<th class="ct">입질</th>
								<td>
									<input type="radio" name="ipzil" id="ipzil1" value="대박"<%If ipzil = "대박" Or ipzil = "" Then%> checked<%End If%> /><label for="ipzil1">대박</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil2" value="호조"<%If ipzil = "호조" Then%> checked<%End If%> /><label for="ipzil2">호조</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil3" value="좋음"<%If ipzil = "좋음" Then%> checked<%End If%> /><label for="ipzil3">좋음</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil4" value="보통"<%If ipzil = "보통" Then%> checked<%End If%> /><label for="ipzil4">보통</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil5" value="저조"<%If ipzil = "저조" Then%> checked<%End If%> /><label for="ipzil5">저조</label>
								</td>
							</tr>
							<tr>
								<th class="ct">조과</th>
								<td>
									<select name="jogwa" style="width:150px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '조과' ORDER BY idx ASC "
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
							<tr>
								<th class="ct">최대어종</th>
								<td>
									<select name="bestfish" style="width:150px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '어종' ORDER BY idx ASC "
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
							<tr>
								<th class="ct">최대크기</th>
								<td>
									<input type="text" name="fishsize" maxlength="10" value="<%=fishsize%>" style="width:142px;" /> 센티미터
								</td>
							</tr>
							<tr>
								<td colspan=4><!-- 사진등록 -->
									<input type="file" name="upFile" multiple accept=".jpg, .jpeg, .png" style="width:100%;height:60px;cursor:pointer;" />
<script>
//	const fileSelector = document.getElementById('file-selector');
//	fileSelector.addEventListener('change', (event) => {
//		const fileList = event.target.files;
//		console.log("fileList = "+ fileList);
//		console.log(fileList);
//	});
</script>
								</td>
							</tr>
						</tbody>
					</table>
					<div id="btnarea1">
						<a href="javascript:" onclick="goSave();" class="btn btn25"><span>저장(계속)</span></a>
						<a href="gall.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn25"><span>목록</span></a>
					</div>
				</div><!-- poptitle2 E -->
			</div><!-- admwrap1 E -->
		</center>
	</div>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
