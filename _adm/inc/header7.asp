<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<!-- #include virtual = "/inc/bsfCode.asp" -->
<%	Call dbo() %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="SHORTCUT ICON" href="/favicon2.ico">
<title>안흥낚시 관리자페이지입니다. <%=FID_AUTH%></title>
<link rel="stylesheet" type="text/css" href="/_adm/inc/css/boss.css">
<!-- <link rel="stylesheet" type="text/css" href="/_adm/inc/css/reset.css"> -->
<script type="text/javascript" src="/inc/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/inc/js/lib/js/sliderkit/jquery.sliderkit.1.9.2.js"></script>
<script type="text/javascript" src="/inc/js/lib/js/sliderkit/jquery.sliderkit.1.9.2.pack.js"></script>
<script language="JavaScript" src="/inc/js/common.js"></script>
<script language="JavaScript" src="/inc/js/mpop.js"></script>
</head>

<body<%If FID_ID <> "admin" And FID_AUTH > 10 Then%> onLoad="Fulllayer();return mpop5('/_adm/login_p.asp?preURL=<%=Request.ServerVariables("PATH_INFO")%>','eve','center',450,270);"<%End If%>>
<div id="overlay"></div>