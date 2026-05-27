<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%
	dbo()
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>안흥낚시</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=0.5, maximum-scale=1">
<link rel="SHORTCUT ICON" href="/favicon2.ico" />
<meta name="title" content="안흥낚시-badawa.co.kr" />
<meta name="author" content="안흥낚시-badawa.co.kr" />
<meta name="publisher" content="안흥낚시-badawa.co.kr" />
<meta name="copyright" content="안흥낚시-badawa.co.kr" />
<meta http-equiv="keywords" content="낚시, 침선낚시, 근해낚시, 선상낚시, 어초낚시, 열기낚시, 주꾸미낚시, 바다낚시, 안흥, 태안, 서해안" />
<meta name="keywords" content="낚시, 침선낚시, 근해낚시, 선상낚시, 어초낚시, 열기낚시, 주꾸미낚시, 바다낚시, 안흥, 태안, 서해안" />
<meta name="description" content="낚시, 침선낚시, 근해낚시, 선상낚시, 어초낚시, 열기낚시, 주꾸미낚시, 바다낚시, 안흥, 태안, 서해안" />
<meta name="abstract" content="" />
<meta name="page-topic" content="낚시" />
<meta name="revisit" content="" />
<meta name="language" content="COREA, KOREAN" />
<meta name="robots" content="All" />
<meta name="audience" content="All" />
<meta name="rating" content="General" />

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-96094512-1"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag(){dataLayer.push(arguments);}
	gtag('js', new Date());
	gtag('config', 'UA-96094512-1');
</script>

<link rel="stylesheet" type="text/css" href="/inc/css/base2.css" />
<link rel="stylesheet" type="text/css" href="/lib/themes/base/jquery.ui.all.css" />
<script type="text/javascript" src="/inc/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.js"></script>
<script type="text/javascript" src="/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>

<!-- Slider Kit compatibility -->
<!--[if IE 6]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie6.css" /><![endif]-->
<!--[if IE 7]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie7.css" /><![endif]-->
<!--[if IE 8]><link rel="stylesheet" type="text/css" href="/lib/css/sliderkit-demos-ie8.css" /><![endif]-->

<script type="text/javascript" src="/lib/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/inc/js/shared.js"></script>
<script type="text/javascript" src="/inc/js/modal.js"></script>
<!-- modal window -->
<link rel="stylesheet" type="text/css" href="/lib/css/start/jquery-ui-1.8.20.custom.css">
<script type="text/javascript" src="/lib/js/jquery-ui-1.8.20.custom.min.js"></script>

<script type="text/javascript" src="/inc/js/mpop.js"></script>
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
<!--
<script>
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-96094512-1', 'auto');
	ga('send', 'pageview');
</script>

<!-- Google Tag Manager 2nd pub GA back ------------
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-KBFB7NV');</script>
<!-- End Google Tag Manager 2nd pub GA back -->
<!-- Google Tag Manager 2nd pub GA back (noscript) ---------------
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KBFB7NV" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager 2nd pub GA back (noscript) -->
</head>


<body onLoad="Fulllayer();" style="overflow-x:hidden;">
<div id="overlay"></div>
<div class="loader" style="display:none;">
	<img src="/img/btn/loading01.gif" style="width:100px;" alt="로딩중" />
	<!-- <img src="/img/btn/loader02.gif" style="width:100px;" alt="로딩중" /> -->
</div>
