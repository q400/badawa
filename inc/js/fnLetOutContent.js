function getArticleTitle_() {
	var metas = document.getElementsByTagName("META");
	var titl = "";
	for (var i=0;i<metas.length;i++){
		if (metas[i].name && metas[i].name == "description"){
			titl = metas[i].content;
			break;
		}
	}
	if (titl == "") titl = document.title;

	return titl;
}

function getArticleLink_() {
	var link = location.protocol + "//" + location.hostname + "" + (location.port!="" ? ":"+location.port : "") + location.pathname;
	return link;
}

function windowOpen () {
	var nUrl; var nWidth; var nHeight; var nLeft; var nTop; var nScroll;
	nUrl = arguments[0];
	nWidth = arguments[1];
	nHeight = arguments[2];
	nScroll = (arguments.length > 3 ? arguments[3] : "no");
	nLeft = (arguments.length > 4 ? arguments[4] : (screen.width/2 - nWidth/2));
	nTop = (arguments.length > 5 ? arguments[5] : (screen.height/2 - nHeight/2));
	
	winopen=window.open(nUrl, 'outContent', "left="+nLeft+",top="+nTop+",width="+nWidth+",height="+nHeight+",scrollbars="+nScroll+",toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no");
}

//	페이스북 내보내기
function facebookOut(urls){
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url		= "http://www.facebook.com/sharer/sharer.php?u=" + link + "&title=" + encodeURIComponent('안녕');//title;
	windowOpen(url, 900, 450, 'no');
};


//twitter
function _getArticleID() {
	var artid = "";
	var tmp_host = location.hostname;
	try { 
		tmp_host = tmp_host.substring(0,tmp_host.indexOf(".chosun.com"));
		if (typeof(ArtID) != "undefined") artid = ArtID;
		if (artid == "") {
			var tmp_path = location.pathname;
			if (tmp_path.indexOf(".html") != -1)
				artid = tmp_path.substring(tmp_path.lastIndexOf("/")+1, tmp_path.indexOf(".html"));
		}
		if (artid != "" && tmp_host != "") artid = (tmp_host != "news" ? tmp_host+"*" : "") + artid;
	} catch (e) {}
	return artid;
}
function twitterOpen(urls) {
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);

	//var url = "http://twitter.com/home?status=" + titl + "+" + link;
	var url = "http://twitter.com/share?text=" + title + "&url=" + link;
	windowOpen (url, 800, 400, 'yes');
}

//요즘
function yozmOpen(urls) {
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://yozm.daum.net/api/popup/prePost?prefix=" + title + "&link=" + link;
	windowOpen (url, 400, 364, 'no');
	(new Image).src = _getHitlogLink("sec_00013");
}

//미투데이
function me2DayOpen(urls) {
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://me2day.net/posts/new?new_post[body]=" + title + " " + link;
	windowOpen (url, 1000, 400, 'no');
}

//싸이월드
function cyworldOpen(urls) {
	var title	= encodeURIComponent(getArticleTitle_());
//	var link	= encodeURIComponent(getArticleLink_());
//	var link	= encodeURIComponent(window.location.href);
	var link	= encodeURIComponent(urls);
	var url = "http://csp.cyworld.com/bi/bi_recommend_pop.php?url=" + link;
	windowOpen (url, 400, 364, 'no');
	(new Image).src = _getHitlogLink("sec_00014");
}