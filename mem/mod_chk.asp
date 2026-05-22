<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	Call checkLevel(FID_AUTH, 100, Request.ServerVariables("PATH_INFO"))

	Set cx = New BsfCode
	tag							= 1
%>

<link rel="stylesheet" type="text/css" href="/lib/css/tipsy.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/tipsy_docs.css" />
<script type="text/javascript" src="/lib/js/jquery.tipsy.js"></script>

<script type="text/javascript">
<!--
function chkpass(){
	if(document.fm1.passwd.value == ""){
		alert("비밀번호를 입력하세요.");
		document.fm1.passwd.focus();
		return;
	}
	fm1.action = "mod_chkx.asp";
	fm1.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	chkpass();
}
//-->
</script>

<script type="text/javascript">
$(function(){
	$('#example-1').tipsy();

	$('#north').tipsy({gravity:'n'});
	$('#south').tipsy({gravity:'s'});
	$('#east').tipsy({gravity:'e'});
	$('#west').tipsy({gravity:'w'});

	$('#auto-gravity').tipsy({gravity:$.fn.tipsy.autoNS});

	$('#fade').tipsy({fade:true}).tipsy({gravity:'w'}).tipsy({html:true});
//	$('#fade').tipsy({fade:true}).tipsy({gravity:$.fn.tipsy.autoNS});

	$('#example-custom-attribute').tipsy({title: 'id'});
	$('#example-callback').tipsy({title: function(){ return this.getAttribute('original-title').toUpperCase(); } });
	$('#example-fallback').tipsy({fallback: "Where's my tooltip yo'?" });

	$('#example-html').tipsy({html: true });
});
</script>


<form name="fm1" method="post">
<input type="hidden" name="chknickflag">
<input type="hidden" name="chkidflag">
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/my.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20">
						<img src="/img/bbs/mypage_tle.png" alt="마이페이지" title="마이페이지" />
					</div>
					<div class="mt10 mb10">
						<img src="/img/mem_mod_tle.gif" alt="회원정보수정" title="회원정보수정" />
					</div>
					<div>
						<div class="gbox03" style="padding:15px 20px 20px 20px;">
							<span class="f13">※ 회원 정보 수정을 위해 다시 한번 비밀번호를 입력하세요.</span>
						</div>
					</div>
					<div>
						<div class="mt10 mb10 ct">
							<input type="password" name="passwd" id="passwd" maxlength="20" tabindex=2 style="width:126px;" onKeyDown="writeKeyDown();">
							<a href="javascript:chkpass();" class="btn btn25"><span>비밀번호 확인</span></a>
						</div>
					</div>
					<div class="pt20 pb20"></div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
</form>
<!-- #include virtual = "/inc/footer.asp" -->
