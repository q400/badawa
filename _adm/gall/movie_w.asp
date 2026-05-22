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
	If flag = "" Then flag = "W"
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, shipid, title, cnt, wdate, ddate, tnm, fnm, ext, contents FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid				= rs("shipid")
			title				= rs("title")
			cnt					= rs("cnt")
			wdate				= rs("wdate")
			ddate				= rs("ddate")
			tnm					= rs("tnm")
			fnm					= rs("fnm")
			ext					= rs("ext")
			contents			= rs("contents")
		End If
		rsc()
		flag = "M"
	End If
'	nmparam						= setp(month(now)) & setp(day(now)) & setp(hour(now)) & setp(minute(now)) & setp(second(now))
'	Response.Write "value : "& nmparam &"<br>"
%>

<style type="text/css">
	/*demo page css*/
	/*body{ font: 62.5% "Trebuchet MS", sans-serif; margin: 50px;}*/
	.demoHeaders { margin-top: 2em; }
	#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
	#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
	ul#icons {margin: 0; padding: 0;}
	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
	ul#icons span.ui-icon {float: left; margin: 0 4px;}
</style>
<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<!-- <link rel="stylesheet" href="/lib/css/demos.css"> -->
<script language="JavaScript">
<!--
function upload(){
//	document.all.upload.style.visibility = "visible";
	mpop7('/inc/loader.html','ev','center',50,50,0);
}
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
	if(f.shipid.value == ""){
		alert("선박을 선택하세요.");
		f.shipid.focus();
		return;
	}
	if(f.wdate.value == ""){
		alert("촬영일자를 선택하세요.");
		f.wdate.focus();
		return;
	}
	if(confirm("입력하시겠습니까?")){
		upload();
		f.action = "movie_x.asp";
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
		f.action = "movie_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function delmovie(xidx){
	var f = document.fm1;
	if(confirm("동영상을 삭제하겠습니까?")){
		f.flag.value = "delpic";
		f.action = "movie_x.asp";
		f.method = "post";
//		f.target = "nullframe";
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
//function init(){
//	upload();
//}
//window.onload = init;
//-->
</script>
<script>
$(function(){
	$("#wdate").datepicker();
//	$("#format").val("yy-mm-dd");
//	$("#format").change(function(){
//	$("#wdate").datepicker("<%=rdate%>", "dateFormat", "yy-mm-dd");//$(this).val()
//	});
});
</script>
<script type="text/javascript">
//$(function(){
	// Dialog
//	$('#dialog<%=j%>').dialog({
//			autoOpen: false
//		,	width: 700
//		,	height: 800
//		,	buttons: {
//				"Ok": function(){
//					$(this).dialog("close");
//				}
//		,
//				"Cancel": function(){
//					$(this).dialog("close");
//				}
//			}
//	});
	// Dialog Link
//	$('#dialog_link<%=j%>').click(function(){
//		$('#dialog<%=j%>').dialog('enable').dialog('open');
//		return false;
//	});
//	$('#dialog<%=j%>').click(function(){
//		$('#dialog<%=j%>').dialog('enable').dialog('close');
//		return false;
//	});
	//hover states on the static widgets
//	$('#dialog_link, ul#icons li').hover(
//		function(){ $(this).addClass('ui-state-hover'); },
//		function(){ $(this).removeClass('ui-state-hover'); }
//	);
//});
</script>


<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">

<form name="fm1" method="post" enctype="multipart/form-data" onSubmit="return goSave()">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">동영상 <%If flag = "W" Then%>입력<%Else%>수정<%End If%></span>
						<span class="ib fright"></span>
					</p>

					<!-- 선박정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="width:280px;" />
							<col style="width:120px;" />
							<col style="width:280px;" />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">제목</th>
								<td colspan=3>
									<input type="text" name="title" id="title" maxlength="100" value="<%=title%>" style="width:600px;">
								</td>
							</tr>
							<tr>
								<th class="ct">선박선택</th>
								<td colspan=3>
									<select name="shipid" id="shipid" style="width:150px;">
									<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	shipid, shipnm FROM _oshpt010 ORDER BY shipid ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
									<option value="<%=rs("shipid")%>"<%If CInt(shipid) = CInt(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ct">촬영일자</th>
								<td colspan=3>
									<input type="text" name="wdate" id="wdate" class="ct" value="<%=wdate%>" style="width:120px;"/>
								</td>
							</tr>
							<tr>
								<th class="ct">Thumbnail</th>
								<td colspan=3>
<%		If tnm <> "" Then %>
									<a href="/data/dld.asp?path=movie&file=<%=tnm%>"><img src="/data/vod/<%=tnm%>" width="160" alt="<%=tnm%>"></a>
<%		End If %>
									<input type="file" name="upThumb" id="upThumb" class="file mt5" style="width:600px;">
									<div class="fc8 mt5">※ 화면을 캡쳐하여 <b>160 × 120(118)</b> 크기로 업로드 바랍니다.</div>
								</td>
							</tr>
							<!--
							<tr>
								<th class="ct">동영상파일</th>
								<td colspan=3>
<%		If fnm <> "" Then %>
									<a href="/data/dld.asp?path=movie&file=<%=fnm%>"><span class="ff ls"><%=fnm%></span></a>
									<input type="checkbox" name="cbox" value="<%=seq%>" onClick="delmovie(<%=seq%>)">
<%		End If %>
									<input type="file" name="upFile" class="file mt5" style="width:600px;">
									<div class="fc8 mt5 mb5">※ flv 혹은 wmv 파일을 업로드 바랍니다.&nbsp;&nbsp;&nbsp;새로 등록하면 기존 것은 삭제됩니다.</div>
								</td>
							</tr>
							-->
							<tr>
								<th class="ct">Youtube URL</th>
								<td colspan=3>
									<!-- <div class="fc8 mt5">※ 유투브 등록을 기준으로 합니다.</div> -->
									<!-- <div class="fcr fb mt5 mb5">※ iframe 내에 꼭 [ id="mov" width="100%" height="335" ] 로 수정해 넣으세요.</div> -->
									<input type="text" name="contents" id="contents" maxlength="200" class="mt5 mb5" value="<%=contents%>" style="width:600px;">
									<!-- <textarea name="contents" style="width:600px;height:0px;"><%=contents%></textarea> -->
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
						<a href="movie.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
