<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	rso()
	SQL = " SELECT COUNT(*) FROM _ocodt020 "
	rs.open SQL, dbcon, 3
		rcnt = CInt(rs(0))
	rsc()
	rso()
	SQL = " SELECT	yy, mm, dd, op1, op2, op3, op4, moon, mtime1, mtime7, mtime8 " _
		& " FROM	mooltime " _
		& " WHERE	yy = (SELECT MAX(yy) FROM mooltime) " _
		& " AND		mm = (SELECT MAX(mm) FROM mooltime WHERE yy = (SELECT MAX(yy) FROM mooltime)) "
	rs.open SQL, dbcon
	'Response.Write "SQL : "& SQL &"<br>"
	If Not (rs.eof And rs.bof) Then
	End If
		lastYY = rs("yy")
		lastMM = rs("mm")
	rsc()
%>

<script type="text/javascript">
<!--
function goUpload(){
	var f = document.fm1;
	var now = new Date();
	var year = now.getFullYear();
	var mon = (now.getMonth()+1) > 9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	//alert($(':radio[name="yy"]:checked').val());

	//for(var i = year; i < year + 5; i++){
		if($(':radio[name="yy"]:checked').val() == undefined){
			alert("해당 년도를 선택해 주세요.");
			return;
		}
	//}
	//for(var j = 0; j < 12; j++){
		if($(':radio[name="mm"]:checked').val() == undefined){
			alert("해당 월을 선택해 주세요.");
			return;
		}
	//}
	if(f.cFile.value == ""){
		alert("업로드할 엑셀파일을 선택해 주세요.");
		return;
	}
	//엑셀만 허용
	/*
	if(!limitFileX(fm1.cFile.value))
		return false;
	}
	*/
	f.action = "mool_xx.asp";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if(confirm('삭제하시겠습니까?')){
		f.action = "/data/delete_mool.asp";
//		f.action = "excel2db_x2.asp";
//		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post" enctype="multipart/form-data">
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
						<span class="tt2">물때표 관리</span>
						<span class="ib fright"><a href="http://www.khoa.go.kr/swtc/main.do" target="_blank"><font class="fc8">조석예보 바로가기</font></a></span>
					</p>

					<!-- 선박정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:130px;" />
							<col />
						</colgroup>
						<tbody>
							<tr height=30>
								<th class="ct">해당 년도</th>
								<td>
<%
		For u = Year(Date) To Year(Date) + 5 Step 1
%>
									<input type="radio" name="yy" id="yy<%=u%>" value="<%=u%>"<%If Year(Now)+1 = u Then%> checked<%End If%>><label for="yy<%=u%>"><%=u%> 년</label>&nbsp;
<%
		Next
%>
								</td>
							</tr>
							<tr height=30>
								<th class="ct">해당 월</th>
								<td>
<%
		For m = 1 To 12 Step 1
%>
									<input type="radio" name="mm" id="mm<%=m%>" value="<%=m%>"<%If setp(lastMM + 1) = setp(m) Then%> checked<%End If%>><label for="mm<%=m%>"><%=m%> 월</label>&nbsp;
<%
		Next
%>
								</td>
							</tr>
							<tr height=30>
								<th class="ct">엑셀파일</th>
								<td>
									<input type="File" name="cFile" class="file" style="width:550px;">
								</td>
							</tr>
							<tr height=30>
								<th class="ct">최종정보</th>
								<td>
									<span class="fc4 fb">EXCEL을 통해 DB에 등록된 마지막 해당 월 : &nbsp;:</span>&nbsp;&nbsp;
									<b class="f15 fc7"><%=lastYY%>-<%=setp(lastMM)%></b>
									</span>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
						<a href="mool.asp" id=btnReset class="btn btn25"><span>새로고침</span></a>
						<a href="javascript:goUpload();" class="btn btn25"><span>등록</span></a>
						<!-- <a href="#" onClick="Popup('/data/mool_d.asp',380,150,700,200,0,59);" class="btnr btn25"><span>부분삭제</span></a> -->
						<!-- <a href="#" onClick="location='/data/dld.asp'" class="btn btn25"><span>다운로드</span></a> -->
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
