<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dbo()
	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	page						= SQLI(Request("page"))
	op							= Request("op")

	If shipid = "" Then
		Call JSalert("문제가 있습니다.")
		Response.End
	End If
%>

<script language="javascript">
<!--
function goSave(){
	var f = document.fm1;
	//if(confirm("입력하시겠습니까?")){
		f.action = "photo_x.asp";
		f.method = "post";
		//f.target = "nullframe";
		f.submit();
	//}else{
		//return;
	//}
}
function goDelete(){
	var f = document.fm1;
	if(f.pwd.value == ""){
		alert("비밀번호를 입력하세요.");
		f.pwd.focus();
		return;
	}
	if(confirm("삭제하시겠습니까?")){
		f.flag.value = "D";
		f.action = "commu_x.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function make(){						// 첨부파일 layer
	var len = document.fm1.filecnt.options[document.fm1.filecnt.selectedIndex].value;
	txtbox = " ";
	for (i=0; i<len; i++){
		txtbox = txtbox + "<div class='pt5'><input type='file' name='upFile' class='bx1' style='width:450px;'></div>";
		txtbox = txtbox + "<div class='pt5 pb5'>사진설명 : <input type='text' name='upText' class='bx1' style='width:384px;'></div>";
	}
	layer1.innerHTML = txtbox;
}
//-->
</script>


<form name="fm1" method="post" enctype="multipart/form-data">
<input type="hidden" name="shipid" id="shipid" value="<%=shipid%>" />
<input type="hidden" name="tblnm" id="tblnm" value="<%=tblnm%>" />
<input type="hidden" name="page" id="page" value="<%=page%>" />
<input type="hidden" name="cd1" id="cd1" value="<%=cd1%>" />
<input type="hidden" name="cd2" id="cd2" value="<%=cd2%>" />
<input type="hidden" name="op" id="op" value="<%=op%>" />

<div>
	&nbsp;<!-- <img src="/img/popup/photo_title01.png" title="이미지등록" /> -->
</div>
<div style="height:100%;">
	<ul class="ml20">
		<p><font class="fc7">가로 길이는 <b>800px</b>을 권장합니다.</font></p>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li class="mb5">사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
		<li><input type="file" name="upFile" class="file" style="width:450px;"></li>
		<li>사진설명 : <input type="text" name="upText" class="bx1" style="width:384px;"></li>
	</ul>
</div>
<div class="ct" style="">
	<div class="mt10 mb10"><a href="javascript:goSave();" class="btn btn25"><span>사진저장</span></a></div>
</div>

</form>
</body>
</html>
<%	dbc() %>