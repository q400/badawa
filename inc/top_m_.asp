<script type="text/javascript">
$(document).ready(function(){
	$("#sub01,#sub02,#sub03,#sub04,#sub05,#sub06,#sub07").hide();		//최초 숨김
	//$("#topmenu ul:eq(0) li:eq(1)").mouseover(function(){
	$("#s01,#sub01").mouseover(function(){ $("#sub01").show(); }).mouseout(function(){ $("#sub01").hide(); });
	$("#s02,#sub02").mouseover(function(){ $("#sub02").show(); }).mouseout(function(){ $("#sub02").hide(); });
	$("#s03,#sub03").mouseover(function(){ $("#sub03").show(); }).mouseout(function(){ $("#sub03").hide(); });
	$("#s04,#sub04").mouseover(function(){ $("#sub04").show(); }).mouseout(function(){ $("#sub04").hide(); });
	$("#s05,#sub05").mouseover(function(){ $("#sub05").show(); }).mouseout(function(){ $("#sub05").hide(); });
	$("#s06,#sub06").mouseover(function(){ $("#sub06").show(); }).mouseout(function(){ $("#sub06").hide(); });
	$("#s07,#sub07").mouseover(function(){ $("#sub07").show(); }).mouseout(function(){ $("#sub07").hide(); });
});
</script>

<div style="position:absolute; z-index:300; top:0px; left:0px;">
	<div id="topmenu" style="z-index:30; width:1100px; top:0px; left:0px;">
		<ul class="lf">
			<li class="vt ib"><a href="/index.asp?op=pc"><img src="img/logo.gif" class="db" alt="바다와" /></a></li>
			<li style="width:98px; height:30px;" class="vb ct ib" id="s01"><a href="javascript:goMenu('m10');"><span class="fcw fz f14">낚시배소개</span></a></li>
			<li style="width:98px; height:30px;" class="vb ct ib" id="s02"><a href="javascript:goMenu('m20');"><span class="fcw fz f14">낚시배예약</span></a></li>
			<li style="width:90px; height:30px;" class="vb ct ib" id="s03"><a href="javascript:goMenu('m30');"><span class="fcw fz f14">조황정보</span></a></li>
			<li style="width:95px; height:30px;" class="vb ct ib" id="s04"><a href="javascript:goMenu('m40');"><span class="fcw fz f14">낚시자료실</span></a></li>
			<li style="width:86px; height:30px;" class="vb ct ib" id="s05"><a href="javascript:goMenu('m50');"><span class="fcw fz f14">커뮤니티</span></a></li>
			<li style="width:98px; height:30px;" class="vb ct ib" id="s06"><a href="javascript:goMenu('m60');"><span class="fcw fz f14">주변관광지</span></a></li>
			<li style="width:95px; height:30px;" class="vb ct ib" id="s07"><a href="javascript:goMenu('m70');"><span class="fcw fz f14">마이페이지</span></a></li>
			<li style="width:20px; height:30px;" class="vb ct ib"><img src="/img/m_cir.png" class="db" alt="바다와" /></li>
		<%If FID_ID = "" Then%>
			<li style="width:45px;" class="vb ct mb10 ib">
				<a href="/mem/login.asp" class="fcw f11">로그인</a>
			</li>
			<li style="width:50px;" class="vb ct mb10 ib">
				<a href="/mem/mem_agree.asp" class="fcw f11">회원가입</a>
			</li>
		<%Else%>
			<li style="width:45px;" class="vb ct mb10 ib">
				<a href="/mem/logout.asp" class="fcw f11">로그아웃</a>
			</li>
			<li style="width:50px;" class="vb ct mb10 ib">
				<a href="/mem/mem_agree.asp" class="fcw f11">정보수정</a>
			</li>
		<%End If%>
			<li class="vb ct mb10 ib">
				<a href="/info/map.asp" class="fcw f11">오시는 길</a>
			</li>
		</ul>
	</div>
</div>

<div id="sub01">
	<ul class="lf pt8 op65" style="margin-left:0px;"><!-- 낚시배소개 //-->
		<li style="width:80px;" class="ct ib"><a href="/info/info.asp"><span class="fcw fz f13">선박소개</span></a></li>
		<li style="width:120x;" class="ct ib"><a href="/info/info_shop.asp"><span class="fcw fz f13">안흥낚시소개</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="/info/map.asp"><span class="fcw fz f13">오시는길</span></a></li>
	</ul>
</div>
<div id="sub02">
	<ul class="lf pt8 op65" style="margin-left:50px;"><!-- 낚시배예약 //-->
		<li style="width:60px;" class="ct ib"><a href="/rsv/info.asp"><span class="fcw fz f13">출조안내</span></a></li>
		<li style="width:60px;" class="ct ib"><a href="/info/type01.asp"><span class="fcw fz f13">출조종류</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="javascript:Popup('/info/help.asp',900,900,300,30,1,0,98);"><span class="fcw fz f13">예약도우미</span></a></li>
		<li style="width:60px;" class="ct ib"><a href="/rsv/"><span class="fcw fz f13">예약하기</span></a></li>
		<li style="width:60px;" class="ct ib"><a href="/rsv/check.asp"><span class="fcw fz f13">예약확인</span></a></li>
	</ul>
</div>
<div id="sub03">
	<ul class="lf pt8 op65" style="margin-left:140px;"><!-- 조황정보 //-->
		<li style="width:80px;" class="ct ib"><a href="/bbs2/gallery3.asp"><span class="fcw fz f13">조황갤러리</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="/bbs2/movie.asp"><span class="fcw fz f13">낚시동영상</span></a></li>
		<!-- <li style="width:60px;" class="ct ib"><a href="/bbs2/ps.asp"><span class="fcw fz f13">조황후기</span></a></li> -->
		<li style="width:80px;" class="ct ib"><a href="/bbs1/news.asp"><span class="fcw fz f13">제임스이야기</span></a></li>
	</ul>
</div>
<div id="sub04">
	<ul class="lf pt8 op65" style="margin-left:180px;"><!-- 낚시자료실 //-->
		<li style="width:80px;" class="ct ib"><a href="/info/time.asp"><span class="fcw fz f13">물때표보기</span></a></li>
		<li style="width:90px;" class="ct ib"><a href="/info/weather01.asp"><span class="fcw fz f13">한국기상정보</span></a></li>
		<li style="width:90px;" class="ct ib"><a href="/info/weather02.asp"><span class="fcw fz f13">일본기상정보</span></a></li>
		<li style="width:90px;" class="ct ib"><a href="/info/weather03.asp"><span class="fcw fz f13">미국기상정보</span></a></li>
	</ul>
</div>
<div id="sub05">
	<ul class="lf pt8 op65" style="margin-left:260px;"><!-- 커뮤니티 //-->
		<li style="width:60px;" class="ct ib"><a href="/bbs1/notice.asp"><span class="fcw fz f13">공지사항</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="/bbs1/faq.asp"><span class="fcw fz f13">자주하는질문</span></a></li>
		<li style="width:70px;" class="ct ib"><a href="/bbs1/qna.asp"><span class="fcw fz f13">문의게시판</span></a></li>
		<li style="width:70px;" class="ct ib"><a href="/bbs1/beginner.asp"><span class="fcw fz f13">초보자교실</span></a></li>
		<!-- <li style="width:70px;" class="ct ib"><a href="/bbs1/knowhow.asp"><span class="fcw fz f13">낚시노하우</span></a></li> -->
		<li style="width:60px;" class="ct ib"><a href="/bbs1/cook.asp"><span class="fcw fz f13">요리교실</span></a></li>
		<!-- <li style="width:80px;" class="ct ib"><a href="/bbs1/recipe.asp"><span class="fcw fz f13">나의레시피</span></a></li>
		<li style="width:60px;" class="ct ib"><a href="/bbs1/mania.asp"><span class="fcw fz f13">매니아방</span></a></li>
		<li style="width:50px;" class="ct ib"><a href="/bbs1/full.asp"><span class="fcw fz f13">카풀</span></a></li>
		<li style="width:60px;" class="ct ib"><a href="/bbs1/market.asp"><span class="fcw fz f13">중고장터</span></a></li>-->
		<li style="width:60px;" class="ct ib"><a href="/bbs1/shop.asp"><span class="fcw fz f13">상품소개</span></a></li>
	</ul>
</div>
<div id="sub06">
	<ul class="lf pt8 op65" style="margin-left:480px;"><!-- 주변볼거리 //-->
		<li style="width:80px;" class="ct ib"><a href="javascript:goMenu('m60');"><span class="fcw fz f13">주변볼거리</span></a></li>
		<li style="width:70px;" class="ct ib"><a href="javascript:goMenu('m60');"><span class="fcw fz f13">추천음식점</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="javascript:goMenu('m60');"><span class="fcw fz f13">추천숙박업소</span></a></li>
	</ul>
</div>
<div id="sub07">
	<ul class="lf pt8 op65" style="margin-left:350px;"><!-- 마이페이지 //-->
		<li style="width:90px;" class="ct ib"><a href="/my/rsv.asp"><span class="fcw fz f13">나의예약내역</span></a></li>
		<li style="width:80px;" class="ct ib"><a href="/my/point01.asp"><span class="fcw fz f13">포인트현황</span></a></li>
		<!-- <li style="width:90px;" class="ct ib"><a href="/my/ps.asp"><span class="fcw fz f13">나의조황후기</span></a></li> -->
		<li style="width:90px;" class="ct ib"><a href="/my/chuljo.asp"><span class="fcw fz f13">나의출조내역</span></a></li>
		<!-- <li style="width:60px;" class="ct ib"><a href="/my/album.asp"><span class="fcw fz f13">나의앨범</span></a></li> -->
		<!-- <li style="width:90px;" class="ct ib"><a href="/my/order.asp"><span class="fcw fz f13">액자신청내역</span></a></li> -->
		<li style="width:60px;" class="ct ib"><a href="/my/friend.asp"><span class="fcw fz f13">일행관리</span></a></li>
		<li style="width:90px;" class="ct ib"><a href="/mem/mod.asp"><span class="fcw fz f13">회원정보수정</span></a></li>
	</ul>
</div>