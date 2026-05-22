<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag = 2
%>

<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/data.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20"><img src="/img/data_tle.gif" alt="기상정보" /></div>
					<div class="mt10 mb10"><img src="/img/data_time_tle.gif" alt="물때표" /></div>
					<div style="width:710px; border:0px solid #000;" class="mt30 mb5">
						<p class="mt20 mb10 ct"><a href="#" onClick="unoPop('mool1.asp','물때표',1150,950);return false;">물때표 보기</a></p>
					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->

<script language="javascript">
function init() {
	unoPop('mool1.asp','물때표',1150,950);
}
window.onload = init;
</script>