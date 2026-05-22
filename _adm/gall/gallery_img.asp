<!--
'************************************************************************************
'* Program 명	: gallery_img.asp (조황갤러리 이미지관리)
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
<!--
function goDelete(){
	var f = document.FrmUpload;
	if (confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "gallery5_xx.asp";
		f.method = "post";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.FrmUpload;
	if (confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DelPhoto";
		f.action = "gallery5_xx.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
//-->
</script>


<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<div>
		<center>
			<div class="ib vt"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib" id="admwrap1">

<form name="FrmUpload" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">갤러리 이미지관리</span>
						<span class="ib fright"></span>
					</p>
					<div>
						<input type="file" name="upFile[]" id="file-selector" multiple accept=".jpg, .jpeg, .png" style="width:100%;height:100px;" />
<script>
	const fileSelector = document.getElementById('file-selector');
	fileSelector.addEventListener('change', (event) => {
		const fileList = event.target.files;
		console.log("fileList = "+ fileList);
		console.log(fileList);
	});
</script>
					</div>
					<div id="btnarea1">
						<a href="javascript:" onclick="goSave();" class="btn btn25"><span>저장</span></a>
						<a href="gallery5.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn25"><span>목록</span></a>
					</div>
				</div><!-- poptitle2 E -->
			</div><!-- admwrap1 E -->
		</center>
	</div>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
<%	dbc() %>
