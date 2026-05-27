function MM_preloadImages(){ //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	if(a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore(){ //v3.0
	var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d){ //v4.01
	var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length){
	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_swapImage(){ //v3.0
	var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_showHideLayers(){ //v6.0
	var i,p,v,obj,args = MM_showHideLayers.arguments;
	for(i=0; i<(args.length-2); i+=3)
		if((obj = MM_findObj(args[i]))!=null){
			v = args[i+2];
			if(obj.style){
				obj = obj.style;
				v = (v == 'show')?'visible':(v == 'hide')?'hidden':v;
			}
			obj.visibility = v;
		}
}
function setPng24(obj){
	obj.width=obj.height=1;
	obj.className=obj.className.replace(/\bpng24\b/i,'');
	obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
	obj.src='';
	return '';
}
function bt(id,after){
	eval(id+'.filters.blendTrans.stop();');
	eval(id+'.filters.blendTrans.Apply();');
	eval(id+'.src="'+after+'";');
	eval(id+'.filters.blendTrans.Play();');
//	eval('this.document.getElementById("'+id+'").filters.blendTrans.stop();');
//	eval('this.document.getElementById("'+id+'").filters.blendTrans.Apply();');
//	eval('this.document.getElementById("'+id+'").src="'+after+'";');
//	eval('this.document.getElementById("'+id+'").filters.blendTrans.Play();');
}
function onlyNumber(){					//숫자만을 허용함
	if((event.keyCode<48)||(event.keyCode>57))
		event.returnValue = false;
}
function IsNumber(formname){
	var form = eval("document.fm1." + formname);
	for (var i = 0; i < form.value.length; i++){
		var chr = form.value.substr(i,1);
		if(chr < '0' || chr > '9'){
			return false;
		}
	}
	return true;
}
function isHangul(str){				//한글체크
	var re = /[a-zA-Z0-9\s~!@#\$%\^&\*\(\)_\+\{\}|:"<>\?`\-=\[\]\\;',\.\/]/;
	//matches a alphanumeric character or space
	if(re.test(str))
		return false;
	return true;
}
function Popup(url,w,h,l,t,s,r,p){
	window.open(url,"win2"+p,"width="+w+",height="+h+",left="+l+",top="+t+",location=0,menubar=0,toolbar=0,directories=0,resizable="+r+",scrollbars="+s);
}
function changeBox(cbox){
	box = eval(cbox);
	box.checked = !box.checked;
}
function clearText(thefield){			// 클릭하면 내용 지우기
	if(thefield.defaultValue == thefield.value)
		thefield.value = ""
}
function checkLength(obj, min, max, nullable){		//길이 check
	if(!nullable){
		len = obj.value.length;
		if(len < min || len > max)
			return false;
	}
	return true;
}
function checkName(obj){											//이름 Check
	if(!checkLength(obj, 2, 10, false)){
		alert("이름이 등록되지 않았거나 유효한 이름이 아닙니다.");
		obj.focus();
		return false;
	}
	if(!isHangul(obj.value)){
		alert("이름은 공백없이 한글로 써 주세요.");
		obj.focus();
		return false;
	}
	return true;
}
function goMenu(name){
	if(eval(name) == ""){
		alert("서비스 준비중입니다.");
		return;
	}else {
		document.location.href = eval(name);
	}
}

var home						= "";								//홈
var index02						= "";								//로그인
var index03						= "";								//인트라넷
var index04						= "";								//회원가입
var logout						= "";								//로그아웃

var m10							= "/info/info.asp";					//낚시배소개
	var m11						= "/info/info.asp";					//낚시배소개
	var m12						= "/info/info_shop.asp";			//안흥낚시소개
    var m13						= "/info/map.asp";					//오시는길

var m20							= "/rsv/";							//예약메인
	var m21						= "/rsv/info.asp";					//출조안내
	var m22						= "/info/type01.asp";				//출조종류
	var m23						= "/rsv/";							//예약메인
	var m24						= "/rsv/check.asp";					//예약확인

var m30							= "/bbs2/gallery3.asp";				//조황정보
	var m31						= "/bbs2/gallery3.asp";				//조황정보
	var m32						= "/bbs2/ps.asp";					//조황후기
	var m33						= "/bbs2/gallery3.asp";				//액자신청

var m40							= "/info/weather01.asp";			//낚시자료실
//	var m41						= "/bbs2/gallery.asp";				//조석물때표
	var m42						= "/info/weather01.asp";			//한국기상정보
	var m43						= "/info/weather02.asp";			//일본기상정보
	var m44						= "/info/weather03.asp";			//미국기상정보

var m50							= "/bbs1/notice.asp";				//커뮤니티
	var m51						= "/bbs1/notice.asp";				//공지사항
	var m52						= "/bbs1/faq.asp";					//FAQ
	var m53						= "/bbs1/qna.asp";					//문의게시판
	var m54						= "/bbs1/beginner.asp";				//초보자교실
	var m55						= "/bbs1/knowhow.asp";				//낚시노하우
	var m56						= "/bbs1/cook.asp";					//요리교실
	var m57						= "/bbs1/mania.asp";				//매니아방
	var m58						= "/bbs1/full.asp";					//카풀
	var m59						= "/bbs1/market.asp";				//중고장터

var m60							= "";				//주변관광지
	var m61						= "";				//주변볼거리
	var m62						= "";					//추천음식점
	var m63						= "";				//추천숙박업소

var m70							= "/my/rsv.asp";					//마이페이지
	var m71						= "/mem/mod_chk.asp";				//회원정보수정
	var m72						= "/my/rsv.asp";					//나의 예약내역
	var m73						= "/my/point.asp";					//포인트현황
	var m74						= "/my/ps.asp";						//나의 조황후기
	var m75						= "/my/chuljo.asp";					//나의 출조내역
	var m76						= "/my/frame.asp";					//액자신청내역
	var m77						= "/my/friend.asp";					//일행관리

function goLogin(){
	var f = document.login;
	if(f.uid.value == ""){
		alert("아이디를 입력하세요.");
		f.uid.focus();
		return;
	}
	if(f.pwd.value == ""){
		alert("비밀번호를 입력하세요.");
		f.pwd.focus();
		return;
	}
	f.action = "/mem/login_x.asp";
	f.submit();
}

function chkLogin(){
	if(document.loginfm.memid.value == ""){
		alert("아이디를 입력하세요.");
		document.loginfm.memid.focus();
		return;
	}
	if(document.loginfm.passwd.value == ""){
		alert("비밀번호를 입력하세요.");
		document.loginfm.passwd.focus();
		return;
	}
	document.loginfm.action = "/login_xx.asp";
	document.loginfm.submit();
}
function writeKeyDown(){
	if(event.keyCode == 13)	chkLogin();
}
function goClose(op){
	if(op == "0"){
		parent.document.getElementById("showimage").style.visibility = "hidden";
		parent.document.getElementById("overlay").style.visibility = "hidden";
	}else if(op == "1"){
		parent.document.getElementById("showimage").style.visibility = "hidden";
		parent.document.getElementById("overlay").style.visibility = "hidden";
		parent.document.location.reload();
	}else if(op == "2"){				//비회원예약수정
		parent.document.getElementById("showimage").style.visibility = "hidden";
		//parent.document.all.overlay.style.visibility = "hidden";
		mpop('pwd.asp?ridx=<%=ridx%>&shipid=<%=ship%>','ev2','center',460,328,0);
	}else if(op == "3"){				//회원예약수정
		//parent.document.all.showimage.style.visibility = "hidden";
		parent.document.getElementById("overlay").style.visibility = "hidden";
		mpop('rsv_w.asp?ridx=<%=ridx%>&shipid=<%=ship%>','ev2','center',460,328,0);
	}
}

/* SNS */
function getArticleTitle_(){
	var metas = document.getElementsByTagName("META");
	var titl = "";
	for (var i=0;i<metas.length;i++){
		if(metas[i].name && metas[i].name == "description"){
			titl = metas[i].content;
			break;
		}
	}
	if(titl == "") titl = document.title;

	return titl;
}

function getArticleLink_(){
	var link = location.protocol + "//" + location.hostname + "" + (location.port!="" ? ":"+location.port : "") + location.pathname;
	return link;
}
function windowOpen (){
	var nUrl; var nWidth; var nHeight; var nLeft; var nTop; var nScroll;
	nUrl = arguments[0];
	nWidth = arguments[1];
	nHeight = arguments[2];
	nScroll = (arguments.length > 3 ? arguments[3] : "no");
	nLeft = (arguments.length > 4 ? arguments[4] : (screen.width/2 - nWidth/2));
	nTop = (arguments.length > 5 ? arguments[5] : (screen.height/2 - nHeight/2));

	winopen=window.open(nUrl, 'outContent', "left="+nLeft+",top="+nTop+",width="+nWidth+",height="+nHeight+",scrollbars="+nScroll+",toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no");
}

//페이스북 내보내기
function facebookOut(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url		= "http://www.facebook.com/sharer/sharer.php?u=" + link + "&title=" + encodeURIComponent('안녕');//title;
	windowOpen(url, 900, 450, 'no');
};

//twitter
function _getArticleID(){
	var artid = "";
	var tmp_host = location.hostname;
	try {
		tmp_host = tmp_host.substring(0,tmp_host.indexOf(".chosun.com"));
		if(typeof(ArtID) != "undefined") artid = ArtID;
		if(artid == ""){
			var tmp_path = location.pathname;
			if(tmp_path.indexOf(".html") != -1)
				artid = tmp_path.substring(tmp_path.lastIndexOf("/")+1, tmp_path.indexOf(".html"));
		}
		if(artid != "" && tmp_host != "") artid = (tmp_host != "news" ? tmp_host+"*" : "") + artid;
	} catch (e){}
	return artid;
}
function twitterOpen(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);

	//var url = "http://twitter.com/home?status=" + titl + "+" + link;
	var url = "http://twitter.com/share?text=" + title + "&url=" + link;
	windowOpen (url, 800, 400, 'yes');
}

//요즘
function yozmOpen(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://yozm.daum.net/api/popup/prePost?prefix=" + title + "&link=" + link;
	windowOpen (url, 400, 364, 'no');
	(new Image).src = _getHitlogLink("sec_00013");
}

//미투데이
function me2DayOpen(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://me2day.net/posts/new?new_post[body]=" + title + " " + link;
	windowOpen (url, 1000, 400, 'no');
}

//싸이월드
function cyworldOpen(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://csp.cyworld.com/bi/bi_recommend_pop.php?url=" + link;
	windowOpen (url, 400, 364, 'no');
	(new Image).src = _getHitlogLink("sec_00014");
}
function doBlink(){
	var blink = document.all.tags("BLINK")
	for (var i=0; i < blink.length; i++)
		blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
}
function startBlink(){
	if(document.all)
		setInterval("doBlink()",800)
}

/**
* 설명 		: view(.jsp)내부의 object(type=text, radio, checkbox, textarea, password 등의 값을 설정합니다.
*       	  getElementById()와 동일하게 작동됩니다.
*      		  trim()이 적용됩니다
* 사용방식 	: setSimsValueObj(값을 적용할 object의 id명, 적용될 값)
*          	  <input type="text" id="txtRegId" value="rrrrr"....
*
*          	  setUnoValueObj('txtRegId', 'ㅈㅈㅈㅈㅈㅈ');
*
* 주의 		: object에 id attribute가 반드시 존재해야 합니다
* 리턴 		: 없음
*/
function setUnoValueObj(ObjId, Value){
	$('#' + ObjId).attr('value', $.trim(Value));
}

function unoRequest(frmId, Url, mTarget){
	var retFrmId = '#' + frmId;

	if(mTarget != 'undefined'){
		$(retFrmId).attr({action:Url, method:'post', target:mTarget}).submit();
	}else{
		$(retFrmId).attr({action:Url, method:'post'}).submit();
	}
}