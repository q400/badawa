<script type="text/javascript">
function goUrl(url){
	//loadingPop();
	$(".loader").show();
	this.document.location.href = url;
}
</script>
	<div>
		<img src="/img/adm/left_bx01.gif" class="db" />
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif);" class="db"><img src="/img/adm/left_tle.gif" alt="ADMIN MENU" title="ADMIN MENU" /></div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/mem/mem.asp');" class="fb">회원정보관리</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/ship/ship.asp');" class="fb">선박정보관리</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/rsv/index.asp');" class="fb">예약관리</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/rsv/stat.asp');" class="fb">출조현황표</a></span>
	</div>
	<!--
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:5px 0 5px 30px;">
			<img src="/img/adm/left_dot.gif">&nbsp;&nbsp;<a href="#" onClick="alert('문자서비스는 따로 연락 바랍니다. 010-5554-9462')"><font class="fb">단체문자(예약자)</font></a>
			<!-- <a href="#" onClick="return mpop5('/_adm/rsv/sms.asp','ev','center',600,260,0);"><font class="fb">단체문자(예약자)</font></a> --
		</td>
	</tr>
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:5px 0 5px 30px;">
			<img src="/img/adm/left_dot.gif">&nbsp;&nbsp;<a href="#" onClick="alert('문자서비스는 따로 연락 바랍니다. 010-5554-9462')"><font class="fb">단체문자(회원전체)</font></a>
			<!-- <a href="#" onClick="return mpop5('/_adm/rsv/sms_all.asp','ev','center',600,260,0);"><font class="fb">단체문자(회원전체)</font></a> --
		</td>
	</tr>
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:5px 0 5px 30px;">
			<img src="/img/adm/left_dot.gif">&nbsp;&nbsp;<a href="http://dulgotzam.co.kr/inc/mool.asp" target="_blank" class="fb">물때표관리</a>
			<!-- <a href="http://mool.unoweb.co.kr/mool.asp" target="_blank" class="fb">물때표관리</a>
			<!-- <a href="/_adm/mool.asp" class="fb">물때표관리</a>
		</td>
	</tr>
	//-->
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/mool/mool.asp');" class="fb">물때표관리</a></span>
	</div>
	<!--
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="/_adm/gall/gallery.asp" class="fb">조황갤러리</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf" title="베타버전을 사용하세요.">
		<span class="ml25">ㅇ <a href="javascript:alert('플래시가 없는 베타버전을 사용하세요.');" class="fb">조황갤러리</a></span>
		<!-- <span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/gall/gallery3.asp');" class="fb">조황갤러리</a></span>
	</div>
	//-->
<%
'	If FID_ID = "master" Then
%>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf" title="베타버전입니다. 오류가 없고 기능이 잘 되는지 사용하면서 확인 바랍니다.">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/gall/gall.asp');" class="fb">조황갤러리</a></span>
	</div>
<%
'	End If
%>
	<!--
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:5px 0 5px 30px;">
			<a href="/_adm/gall/ps.asp" class="fb">후기관리</a>
		</td>
	</tr-->
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/gall/movie.asp');" class="fb">낚시동영상</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="#" class="fb">게시판</a></span>
		<table border=0 cellspacing="0" cellpadding="0" class="ml30 mt5 pb10">
			<tr height="22">
				<td>- <a href="/_adm/bbs/notice.asp">공지사항</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="#" onClick="return mpop5('/_adm/bbs/mnotice.asp','ev','center',600,160,0);">모바일 공지사항</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/qna.asp">문의게시판</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/faq.asp">자주묻는질문</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/beginner.asp">초보자교실</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/cook.asp">요리교실</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/news.asp">제임스 이야기</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/bbs/shop.asp">상품소개</a></td>
			</tr>
		</table>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/intro.asp');" class="fb">소개글/동영상 관리</a></span>
	</div>
	<!--
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:5px 0 5px 30px;">
			<a href="/_adm/gall/order.asp" class="fb">앨범/액자신청</a>
		</td>
	</tr-->
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/pop.asp');" class="fb">팝업관리</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 lf">
		<span class="ml25">ㅇ <a href="#" class="fb">포인트관리</a></span>
		<table border=0 cellspacing="0" cellpadding="0" class="ml30 mt5 pb10">
			<tr height="22">
				<td>- <a href="/_adm/mem/point01.asp">쉽포인트</a></td>
			</tr>
			<tr height="22">
				<td>- <a href="/_adm/mem/point02.asp">톡포인트</a></td>
			</tr>
		</table>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db lf">
		<span class="ml25">ㅇ <a href="javascript:;" onclick="goUrl('/_adm/ship/link.asp');" class="fb">선박사이트 바로가기</a></span>
	</div>
	<div style="background:#fff url(/img/adm/left_bx03.gif) repeat;" class="db pt10 pb30 lf">
		<span class="ml25">ㅇ <a href="#" class="fb">통계</a></span>
		<table border=0 cellspacing="0" cellpadding="0" class="ml30 mt5 pb10">
			<tr height="22">
				<td>
					- <a href="/_adm/stat/mem.asp"><span class="fc7">[회원]</span> 가입통계</a>
				</td>
			</tr>
			<tr height="22">
				<td>
					- <a href="/_adm/stat/rsv3.asp"><span class="fc7">[예약]</span> 유입환경통계</a>
				</td>
			</tr>
			<tr height="22">
				<td>
					- <a href="https://analytics.google.com/analytics/web/?hl=ko&pli=1#report/defaultid/a96094512w141607950p146141021/%3Foverview-graphOptions.primaryConcept%3Danalytics.totalVisitors/" target="_blank">
					<span class="fc7">[웹로그]</span> 로그분석</a>
				</td>
			</tr>
			<tr height="22">
				<td>
					- <a href="/_adm/stat/capa.asp"><span class="fc7">[용량]</span> 서버용량확인</a>
				</td>
			</tr>
		</table>
	</div>
	<!--
	<tr>
		<td background="/img/adm/left_bx03.gif" style="padding:50px 0 50px 30px;">&nbsp;</td>
	</tr>
	//-->
	<div style="height:15px;" class="db">
		<img src="/img/adm/left_bx02.gif" />
	</div>
