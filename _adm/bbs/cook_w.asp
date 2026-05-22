<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	bbs_id						= 50								'10-공지/20-메모/50-요리/60-초보자/70-노하우/80-매니아/90-카풀/100-중고/110-레시피/120-잡다한소식/130-상품소개
	seq							= Request("seq")
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= Request("page")
	flag						= SQLI(Request("flag"))

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, gubn, title, cnt, ddate, contents FROM _obbst010 WHERE bbs_id = "& bbs_id &" AND seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			gubn				= rs("gubn")
			title				= rs("title")
			cnt					= rs("cnt")
			ddate				= rs("ddate")
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
		alert("제목을 입력하세요.       ");
		f.title.focus();
		return;
	}
	if(confirm("입력하시겠습니까?")){
		upload();
		f.action = "cook_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}else{
		return;
	}
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "cook_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.fm1;
	if(confirm("첨부파일을 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "delpic";
		f.action = "cook_x.asp";
		f.method = "post";
//		f.target = "nullframe";
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
//		txtbox = txtbox + "<input type='file' name='upFile' style='width:600px;'><br>";
		txtbox = txtbox + "<div class='pt5 ml10'>사진 : <input type='file' name='upFile' class='file' style='width:485px;'></div>";
		txtbox = txtbox + "<div class='pb5 ml10'>설명 : <input type='text' name='upText' style='width:480px;'></div>";
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
	$("#datepicker").datepicker();
//	$("#format").val("yy-mm-dd");
//	$("#format").change(function(){
//	$("#datepicker").datepicker("<%=rdate%>", "dateFormat", "yy-mm-dd");//$(this).val()
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

<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="bbs_id" value="<%=bbs_id%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag" value="<%=flag%>">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">요리교실 글<%If flag = "W" Then%>쓰기<%Else%>수정<%End If%></span>
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
								<th class="ct">제목</th>
								<td colspan=3>
									<input type="text" name="title" maxlength="100" value="<%=title%>" style="width:600px; ime-mode:active;">
								</td>
							</tr>
							<tr height=30>
								<th class="ct">분류선택</th>
								<td colspan=3>
									<select name="gubn" style="width:160px;">
									<option value=""<%If gubn = "" Then%> selected<%End If%>>선택</option>
<%
	rso()
	sql = " SELECT code_nm FROM _ocodt010 WHERE gubn = '요리종류' ORDER BY idx "
	rs.open SQL, dbcon
	While Not rs.eof
%>
									<option value="<%=rs("code_nm")%>"<%If gubn = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ct">내용</th>
								<td colspan=3>
									<textarea name="contents" id="contents" class="tarea" style="width:600px; height:245px; ime-mode:active;"><%=contents%></textarea>
								</td>
							</tr>
							<tr height=30>
								<th class="ct">사진등록</th>
								<td colspan=3>
									<table border=0>
										<tr>
<%
	If seq <> "" Then
		rso()
		SQL = " SELECT idx, fpath, fnm, onm, fsz, fwd, ext, best FROM _obbst011 WHERE seq = "& seq &" AND ext NOT IN ('flv','wmv') "
		rs.open SQL, dbcon
		If Not rs.eof Then
			k = 1
			While Not rs.eof
%>
											<td class="vt">
												<div style="position:absolute; margin:0 2px;">
													<a href="javascript:;" onClick="delPhoto(<%=rs("idx")%>);"><img src="/img/icon/delete_2.gif" title="이미지 삭제" /></a>
												</div>
												<a href="javascript:Popup('/inc/imgv.asp?seq=<%=seq%>&idx=<%=rs("idx")%>&op=cook',820,770,100,50,1,1,1);">
												<img src="/data/cook/<%=rs("fnm")%>" width="100" alt="<%=rs("onm")%>"></a>
												<input type="checkbox" name="cbox" id="cbox" value="<%=rs("idx")%>">
											</td>
<%						If k Mod 5 = 0 Then %>
										</tr>
										<tr>
<%
						End If
				k = k + 1
				rs.MoveNext
			Wend
		End If
		rsc()
	End If
%>
										</tr>
									</table>
									<select name="filecnt" onChange="make();" style="width:100px;">
									<option value="0">0</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									</select>&nbsp;&nbsp;<font class="f11 fc8"><b>1MB 이하</b>의 사진 파일만, 사진설명과 함께 등록하세요.</font>
									<br>
									<span id="layer17"></span>
									<!--
									<div class='pt5'>사진1 : <input type='file' name='upFile' class='file' style='width:90%;'></div>
									<div class='pb5'>설명1 : <input type='text' name='upText' style='width:90%;'></div>
									<div class='pt5'>사진2 : <input type='file' name='upFile' class='file' style='width:90%;'></div>
									<div class='pb5'>설명2 : <input type='text' name='upText' style='width:90%;'></div>
									<div class='pt5'>사진3 : <input type='file' name='upFile' class='file' style='width:90%;'></div>
									<div class='pb5'>설명3 : <input type='text' name='upText' style='width:90%;'></div>
									<div class='pt5'>사진4 : <input type='file' name='upFile' class='file' style='width:90%;'></div>
									<div class='pb5'>설명4 : <input type='text' name='upText' style='width:90%;'></div>
									<div class='pt5'>사진5 : <input type='file' name='upFile' class='file' style='width:90%;'></div>
									<div class='pb5'>설명5 : <input type='text' name='upText' style='width:90%;'></div-->
								</td>
							</tr>
							<tr height=30>
								<th class="ct">동영상등록</th>
								<td colspan=3>
<%
	If seq <> "" Then
		rso()
		SQL = " SELECT idx, fpath, fnm, onm, fsz, fwd, ext, best FROM _obbst011 WHERE seq = "& seq &" AND ext IN ('flv','wmv') "
		rs.open SQL, dbcon
		If Not rs.eof Then
			While Not rs.eof
%>
									<a href="/data/dld.asp?path=cook&file=<%=rs("fnm")%>"><%=rs("onm")%></a>
									<input type="checkbox" name="cbox" value="<%=rs("idx")%>">
<%
				rs.MoveNext
			Wend
		End If
		rsc()
	End If
%>
									<input type="file" name="upVod" class="file mt5" style="width:600px;">
									<div class="f11 fc8 mt5">※ flv 혹은 wmv 파일을 업로드 바랍니다.</div>
									<div class="f11 fc8 mt5">※ 사진과 동영상 모두 체크 후 수정하면 해당 파일은 삭제됩니다.</div>
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
						<a href="cook.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>" class="btn btn25"><span>목록</span></a>
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
