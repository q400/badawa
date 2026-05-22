<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	rso()
	SQL = " SELECT	COUNT(*) FROM _ocodt020 "
	rs.open SQL, dbcon, 3
		rcnt = CInt(rs(0))
	rsc()
%>

<script language="JavaScript">
<!--
function upload(){
	mpop7('/inc/loader.html','ev','center',50,50,0);
}
function goUpload(){
	var f = document.fm1;
	if(confirm("등록합니까?")){
//		upload();
		f.action = "intro_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}else{
		return;
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("이미지를 삭제하겠습니까?")){
		f.iidx.value = xidx;
		f.flag.value = "D";
		f.action = "intro_x.asp";
		f.method = "post";
		f.submit();
	}
}
function make(){						//첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<div class='ml10 mt5'><input type='file' name='upFile' id='upFile' class='file' style='width:550px;'></div>";
		txtbox = txtbox + "<div class='ml10 mt5'>사진설명 : <input type='text' name='upText' id='upText' style='width:493px;'></div>";
		//txtbox = txtbox + "<div class='ml10 mt5'>파일경로 : <input type='text' name='imgFilePath' style='width:100px;' value='img/intro'></div>";
		//txtbox = txtbox + "<div class='ml10 mt5'>파일이름 : <input type='text' name='imgFileNm' style='width:200px;'></div>";
		//txtbox = txtbox + "<div class='ml10 mt5 mb5'>사진설명 : <input type='text' name='imgText' style='width:550px;'></div>";
	}
	layer71.innerHTML = txtbox;
}
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="iidx">
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
						<span class="tt2">소개글 사진/동영상 관리</span>
						<span class="ib fright"></span>
					</p>
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col />
						</colgroup>
						<tbody>
							<tr height=30>
								<th class="ct">사진파일</th>
								<td class="pl5 pt5">
									<select name="filecnt" onChange="make();" style="width:100px;">
									<option value="0">0</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									</select>
									&nbsp;&nbsp;
									<font color="#ff7600">가로 <b>400px</b> 권장 (계속 추가 등록 가능)</font>
									<br>
									<span id="layer71"></span>
								</td>
							</tr>
							<tr>
								<td colspan=2>
									<table id="list03">
										<tr>
<%
				rso()
				SQL = " SELECT	idx, gubn, fpath, fnm, fsz, fwd, ext, comment FROM _ocmmt010 WHERE gubn = 'photo' "
				rs.open SQL, dbcon
				k = 1
				While Not rs.eof
%>
											<input type="hidden" name="idx" value="<%=rs("idx")%>">
											<td style="border:0;" class="vt pl10">
												<div style="position:absolute; margin:0 2px;">
													<a href="javascript:;" onClick="delPhoto(<%=rs("idx")%>);"><img src="/img/icon/delete_2.gif" title="이미지삭제" /></a>
												</div>
												<a href="javascript:Popup('/inc/imgv_intro.asp?idx=<%=rs("idx")%>',720,600,100,50,1,1,1);">
												<img src="/<%=rs("fpath")%>/<%=rs("fnm")%>" width="100" class="vm" alt="Intro사진" /></a>
												<!-- <input type="checkbox" name="cbox" value="<%=rs("idx")%>"> -->
											</td>
											<!--
											<td style="border:0;" class="vt">
												<div class="ml10 mt5">파일경로 : <input type="text" name="imgFilePathUpdate" style="width:100px;" value="<%=rs("fpath")%>"></div>
												<div class="ml10 mt5">파일이름 : <input type="text" name="imgFileNmUpdate" style="width:200px;" value="<%=rs("fnm")%>"></div>
												<div class="ml10 mt5 mb5">사진설명 : <input type="text" name="imgTextUpdate" style="width:550px;" value="<%=rs("comment")%>"></div>
											</td>
											-->
<%
						If k Mod 5 = 0 Then
%>
										</tr>
										<tr>
<%
						End If
						rs.MoveNext
						k = k + 1
				Wend
				rsc()
%>
									</table>
								</td>
							</tr>
<%
				rso()
				SQL = " SELECT TOP 1 idx, gubn, fpath, fnm, fsz, fwd, ext, comment FROM _ocmmt010 WHERE gubn = 'movie' ORDER BY idx DESC "
				rs.open SQL, dbcon
				k = 1
				If Not rs.eof Then
					vodIdx = rs("idx")
					vodFilePath = rs("fpath")
					vodFileNm = rs("fnm")
				End If
				rsc()
%>
							<tr height=30>
								<th class="ct">동영상파일</th>
								<td class="pl5 pt5">
									<input type="file" name="movFile" id="movFile" class="file" style="width:550px;" />
									<br>
									<span class="pl10 fb"><%=vodFileNm%>&nbsp;<input type="checkbox" name="cbox" value="<%=vodIdx%>" onClick="delPhoto(<%=vodIdx%>)" class="vm" /></span>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
						<a href="javascript:goUpload();" class="btn btn25"><span>등록</span></a>
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
