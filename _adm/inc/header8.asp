<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%	dbo() %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="SHORTCUT ICON" href="/favicon2.ico">
<title>안흥낚시 관리자페이지입니다.</title>
<link rel="stylesheet" type="text/css" href="/_adm/inc/css/boss.css">
<link rel="stylesheet" href="/lib/themes/base/jquery.ui.all.css">
<!-- <link rel="stylesheet" type="text/css" href="/_adm/inc/css/reset.css"> -->

<script type="text/javascript" src="/inc/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>

<script language="JavaScript" src="/inc/js/shared.js"></script>
<script language="JavaScript" type="text/javascript" src="/inc/js/modal.js"></script>
<!-- modal window -->
<link rel="stylesheet" type="text/css" href="/lib/css/start/jquery-ui-1.8.20.custom.css">
<script src="/lib/js/jquery-ui-1.8.20.custom.min.js"></script>

<script language="JavaScript" src="/inc/js/mpop.js"></script>
<script type="text/javascript">
/* modal */
function unoPop(url, tit, x, y){
	$.unoDialog({
		url: url,
		dialogArguments: '',
		top: 0,
		width: x,
		height: y,
		scrollable: false,
		title: tit,
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
$(document).ready(function(){
	$("#first, #prev, #next, #end, #middle, #search, #reload").click(function (){		//paging loading
		$(".loader").show();
	});
	$("#btnSearch, #btnReset").click(function (){		//paging loading
		$(".loader").show();
	});
});
function goUrl(url){
	$(".loader").show();
	this.document.location = url;
}
</script>
</head>


<body<%If FID_ID <> "admin" And FID_AUTH > 10 Then%> onLoad="Fulllayer();return mpop5('/_adm/login_p.asp?preURL=<%=Request.ServerVariables("PATH_INFO")%>','eve','center',450,270,0);"<%Else%> onLoad="Fulllayer();startBlink();"<%End If%>>
<div id="overlay"></div>
<div class="loader" style="display:none;">
	<img src="/img/btn/loading01.gif" style="width:100px;" alt="로딩중" />
</div>
