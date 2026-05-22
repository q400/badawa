<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 3
	seq							= SQLI(Request("seq"))
	memid						= SQLI(Request("memid"))

	If FID_NO <> "" Then
		flag = "M"
	Else
		flag = "W"
	End If

	If flag = "M" Then
		rso()
		SQL = " SELECT COUNT(*) FROM _omemt011 WHERE seq = "& FID_NO
		rs.open SQL, dbcon
			pcnt = CInt(rs(0))				'기존 사진 갯수
		rsc()
	End If
%>

<link rel="stylesheet" type="text/css" href="/lib/css/tipsy.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/tipsy_docs.css" />
<script type="text/javascript" src="/lib/js/jquery.tipsy.js"></script>

<script language="JavaScript">
<!--
function goSave(){
	var f = document.fm1;
	var len = f.filecnt.options[f.filecnt.selectedIndex].value;
	if(len == 0){
		alert("사진을 저장하시려면 사진을 선택하세요.");
		return;
	}
	if(confirm("사진을 저장하겠습니까?")){
		f.flag.value = "<%=flag%>";
		f.action = "mem_photox.asp";
		f.submit();
	}
	return;
}
function goNext(){
	var f = document.fm1;
	if(confirm("회원 정보 수정 페이지에서 다음에 사진을 등록하세요.")){
		f.action = "mem_finish.asp";
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<div class='pt5'>사진 : <input type='file' name='upFile' class='bx1' style='width:404px;'></div>";
		txtbox = txtbox + "<div class='pb5'>설명 : <input type='text' name='upText' class='bx1' style='width:400px;'></div>";
	}
	layer17.innerHTML = txtbox;
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DP";
		f.action = "mem_photox.asp";
		f.method = "post";
		f.submit();
	}
}
function bestPhoto(xidx){
	var f = document.fm1;
	if(confirm("대표 사진으로 선정하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "B";
		f.action = "mem_photox.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td bgcolor="#ffffff">
			<table width="1100" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="250" valign="top"><!-- #include virtual = "/inc/left/mem.asp" --></td>
					<td width="710" valign="top">
						<table width="710" border="0" cellspacing="0" cellpadding="0">

<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="memid" value="<%=memid%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">

							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/memcenter_tle.gif" width="265" height="24"></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/memcnt_photo_tle.gif" width="172" height="18" title="회원사진등록"></td>
							</tr>
							<tr>
								<td height="30"></td>
							</tr>
							<tr>
								<td>
									<div class="gbox01">
									<dl>3장의 사진을 등록해 두고, 대표사진을 선정하면 댓글 달기나 본인 게시글에 드러나게 됩니다.</dl>
									<dl>사진은 500 byte(바이트) 보다 작게하여 가급적 130Ⅹ130 픽셀(정사각형) 크기로 등록해 주세요.</dl>
									</div>
								</td>
							</tr>
							<tr>
								<td height="30"></td>
							</tr>
							<tr>
								<td>
									<table width="710" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<!-- 사진등록 부분 -->
<%	If pcnt = 0 Then %>
											<td width="124" class="rg">회원사진 등록</td>
											<td width="29">&nbsp;</td>
											<td class="pb10">
												<select name="filecnt" onChange="make();" style="width:80px;">
												<option value="0">0</option>
												<option value="1">1장 등록</option>
												<option value="2">2장 등록</option>
												<option value="3">3장 등록</option>
												</select>&nbsp;&nbsp;<font class="f11 fc8"><b>0.5MB 이하</b>의 사진 파일만, <b>130Ⅹ130 사이즈</b>에 맞춰 사진설명과 함께 등록하세요.</font>
												<br>
												<span id="layer17"></span>
											</td>
<%	ElseIf pcnt = 1 Then %>
											<td width="124" class="rg">회원사진 등록</td>
											<td width="29">&nbsp;</td>
											<td class="pb10">
												<select name="filecnt" onChange="make();" style="width:80px;">
												<option value="0">0</option>
												<option value="1">1장 등록</option>
												<option value="2">2장 등록</option>
												</select>&nbsp;&nbsp;<font class="f11 fc8"><b>0.5MB 이하</b>의 사진 파일만, <b>130Ⅹ130 사이즈</b>에 맞춰 사진설명과 함께 등록하세요.</font>
												<br>
												<span id="layer17"></span>
											</td>
<%	ElseIf pcnt = 2 Then %>
											<td width="124" class="rg">회원사진 등록</td>
											<td width="29">&nbsp;</td>
											<td class="pb10">
												<select name="filecnt" onChange="make();" style="width:80px;">
												<option value="0">0</option>
												<option value="1">1장 등록</option>
												</select>&nbsp;&nbsp;<font class="f11 fc8"><b>0.5MB 이하</b>의 사진 파일만, <b>130Ⅹ130 사이즈</b>에 맞춰 사진설명과 함께 등록하세요.</font>
												<br>
												<span id="layer17"></span>
											</td>
<%	ElseIf pcnt = 3 Then %>
											<td width="124" class="rg">회원사진 등록</td>
											<td width="29">&nbsp;</td>
											<td class="pb10 fc9">"3 장까지만 등록 가능합니다."</td>
<%	End If %>
										</tr>
<%	If FID_NO <> "" Then %>
										<tr>
											<!-- 기 등록 사진 -->
											<td width="144" class="rg">기존사진</td>
											<td width="29">&nbsp;</td>
											<td class="pt10">
<%
		rso()				'메인 이미지
		SQL = " SELECT idx, seq, best, fnm, onm, fwd, ext, comment FROM _omemt011 WHERE seq = "& seq
		rs.open SQL, dbcon
		k = 1
		While Not rs.eof
%>
<script type="text/javascript">
$(function(){
	// Dialog
	$('#dialog<%=k%>').dialog({
			autoOpen: false
		,	width: 200
		,	height: 200
	});
	// Dialog Link
	$('#dialog_link<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('open');
		return false;
	});
	$('#dialog<%=k%>').click(function(){
		$('#dialog<%=k%>').dialog('enable').dialog('close');
		return false;
	});
});
</script>
												<a href="#" id="dialog_link<%=k%>"><img src="/data/mem/<%=rs("fnm")%>" alt="<%=rs("comment")%>" title="<%=rs("comment")%>" /></a>
												<input type="radio" name="rbox" value="<%=rs("idx")%>" onClick="bestPhoto(<%=rs("idx")%>)" title="대표 이미지 선정"<%If rs("best") = "Y" Then%> checked<%End If%>>
												<input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="delPhoto(<%=rs("idx")%>)" title="이미지 삭제">
												<!-- ui-dialog -->
												<div id="dialog<%=k%>" title="이미지 크게보기" style="display:none;">
												<p class="ct"><img src="/data/mem/<%=rs("fnm")%>" class="ct" style="cursor:pointer;"></p>
												</div>
<%
			k = k + 1
			rs.MoveNext
		Wend
		rsc()
%>
											</td>
										</tr>
<%	End If %>
									</table>
								</td>
							</tr>
							<tr>
								<td height="30"></td>
							</tr>
							<tr>
								<td class="ct">
<%	If flag = "M" Then %>
									<a href="mod.asp" class="btn btn25"><span>이전화면</span></a>
									<a href="javascript:goSave();" class="btnr btn25"><span>사진저장</span></a>
<%	Else %>
									<a href="javascript:goSave();" class="btnr btn25"><span>사진저장</span></a>
									<a href="mem_finish.asp?seq=<%=seq%>&memid=<%=memid%>" class="btn btn25"><span>다음에 등록</span></a>
<%	End If %>
								</td>
							</tr>
							<tr>
								<td height="50"></td>
							</tr>
</form>
						</table>
					</td>
					<td valign="top"><!-- #include virtual = "/inc/quick.asp" --></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- #include virtual = "/inc/footer.asp" -->