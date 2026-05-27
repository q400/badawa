/*===========================================================================================================================
File Name		:	/js/whole.js
-----------------------------------------------------------------------------------------------------------------------------
Service Name	:	공통
Description		:	공통적으로 사용되는 함수
Create Date		:	2012년 02월 03일
Author			:	유재인
-----------------------------------------------------------------------------------------------------------------------------
History			:	[2011.11.0] [유재인] - 
===========================================================================================================================*/
(function($){
	$.fn.reset = function(){
		$(this).each(function(){
			if($(this).is('form')){
				this.reset();
			};
		});
	};
	Color =	{
		err : '#C50005'
	,	ok : '#76B6E4'
	};
	Cmn = {
		BlankClear : function(str)
		{
			return ((str + '').replace(/ /g ,''));
		}
	,	Bool : function(str)
		{
			var str = (str + '').toLowerCase();
			return eval(str);
		}
	,	BlankBool : function(str)
		{
			var str = Cmn.BlankClear(str);
			return ((str.toLowerCase() == null || str.toLowerCase() == 'null' || str == 'undefined' || str == '') ? true : false);
		}
	,	TxtNoData : function(str)
		{
			var	str = str.replace(/'/g ,'&#39;');
				str = str.replace(/-/g ,'&#45;');
				str = str.replace(/`/g ,'&#96;');
			return str;
		}
	,	TxtCutRight	: function(str ,leng){	// 문자열 오른쪽에서 자르기
			var leng = (Cmn.BlankBool(leng)) ? 1 : leng;
			return str.substring(str.length - leng);
		}
	,	TextCutLeft	: function(str ,leng){	// 문자열 왼쪽에서 자르기
			return ((str.length > 0) ? String(str).substring(0 ,leng) : '');
		}
	,	Eval : function(data)
		{
			return eval(data);
		}
	,	ErrAlert : function(txt ,bit)
		{
			var msg = (bit) ? ErrMessage(txt) : txt;
			alert(msg);
		}
	,	Decode : function(str)
		{
			return decodeURIComponent(str);
		}
	,	Encode : function(str)
		{
		//	return escape(str);
			return encodeURIComponent(str);
		}
	,	StrCheck : function(str1 ,str2)
		{
			var str1 = (Cmn.BlankClear(str1)).toLowerCase();
			var str2 = (Cmn.BlankClear(str2)).toLowerCase();
			return ((str1 == str2) ? true : false);
		}
	,	LenCheck : function(str ,minLen ,maxLen)
		{
			var len = str.length;
			return ((len < minLen || len > maxLen) ? false : true);
		}
	,	DateSet : function(type)
		{
			var	dt = new Date();
			var	YY = dt.getFullYear();
			var	MM = dt.getMonth() + 1;
			var	DD = dt.getDate();
			var	hh = dt.getHours();
			var	mn = dt.getMinutes();
			var	sc = dt.getSeconds();
			MM = (parseInt(MM) < 10) ? '0' + MM : MM;
			DD = (parseInt(DD) < 10) ? '0' + DD : DD;
			hh = (parseInt(hh) < 10) ? '0' + hh : hh;
			mn = (parseInt(mn) < 10) ? '0' + mn : mn;
			sc = (parseInt(sc) < 10) ? '0' + sc : sc;
			var	result				= [];
				result['YY-MM-DD']	= YY + '-' + MM + '-' + DD;
			return result[type];
		}
	};
	Str = {
		SexRrn : function(str)
		{
			var result = '1';
			var num = parseInt(String(str).substring(7 ,8));
			if(num == 2 || num == 4){
				result = '0';
			};
			return result;
		}
	,	SexText : function(str)
		{
			return (((str + '').toLowerCase() == 'true') ? '남성' : '여성');
		}
	,	MarriedText : function(str)
		{
			
			return (((str + '').toLowerCase() == 'true') ? '기혼' : '미혼');
		}
	};
	Email = {
		Authentication : {	// 인증메일
			Submit : function(toUrl ,qCodeLen)
			{
				var data = {
					toUrl		: toUrl
				,	qCodeLen	: qCodeLen
				};
				var options = {
					type		: 'POST'
				,	dataType	: 'JSON'
				,	url			: '/proc/emailAuthentication.asp'
				,	data		: data
				,	error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
				,	success		: function(data){ Email.Authentication.Paser(data); }
				};
				$.ajax(options);
			}
		,	Paser : function(data)
			{
				var data	= Cmn.Eval(data);
				var qCode	= data.qCode;
				//	차후 실서버로 들어가 SMTP가 사용 가능 할 경우 아래 내용은 삭제
				//$('#nvrMemInfoEmail0Info').text(qCode);
				
				$('#qCode').val(qCode);
			}
		}
	};
	Auto = {
		Allcheck : function(ele1 ,ele2)
		{
			var checked		= ($(ele1).is(':checked')) ? true : false;
			var targetObj	= $('body').find('input[name="' + ele2 + '"]');
			for(var ix = 0; ix < targetObj.length; ++ix){
				targetObj.eq(ix).attr('checked' ,checked);
			};
		}
	,	Focus : {
			Rrn : function(eleBefore ,eleAfter)
			{
				var val = $(eleBefore).val();
				if(val.length == 6){
					$(eleAfter).focus();
				};
			}
		}
	,	Html : {
			Email : function(bitSt ,txtSt ,cicSt ,bitSf)
			{
				var	txt = [];
					txt[0]	= 'naver.com`네이버';
					txt[1]	= 'nate.com`네이트';
					txt[2]	= 'hanmail.net`한메일';
					txt[3]	= 'daum.net`다음';
					txt[4]	= 'gmail.com`지메일';
					txt[5]	= 'paran.com`파란';
					txt[6]	= 'hotmail.com`핫메일';
					txt[7]	= 'empas.com`엠파스';
					txt[8]	= 'yahoo.com`야후';
					txt[9]	= 'yahoo.co.kr`야후';
					txt[10]	= 'chol.com`천리안';
					txt[11]	= 'lycos.co.kr`라이코스';
					txt[12]	= 'dreamwiz.com`드림위즈';
					txt[13]	= 'hanafos.com`하나포스';
					txt[14]	= 'hitel.net`하이텔';
					txt[15]	= 'korea.com`코리아닷컴';
					txt[16]	= 'hanmir.com`한미르';
					txt[17]	= 'netian.com`네티앙';
					txt[18]	= 'freechal.com`프리첼';
					txt[15]	= 'netsgo.com`넷츠고';
				return Auto.Html.Option(txt ,bitSt ,txtSt ,cicSt ,bitSf);
			}
		,	Mobile : function(bitSt ,txtSt ,cicSt ,bitSf ,val)
			{
				var	txt = [];
					txt[0]	= '010';
					txt[1]	= '011';
					txt[2]	= '016';
					txt[3]	= '017';
					txt[4]	= '018';
					txt[5]	= '019';
				return Auto.Html.Option(txt ,bitSt ,txtSt ,cicSt ,bitSf ,val);
			}
		,	Phone : function(bitSt ,txtSt ,cicSt ,bitSf ,val)
			{
				var	txt = [];
					txt[0]	= '02`서울';
					txt[1]	= '031`경기';
					txt[2]	= '032`인천·부천';
					txt[3]	= '033`강원';
					txt[4]	= '041`충남';
					txt[5]	= '042`대전';
					txt[6]	= '043`충북';
					txt[7]	= '051`부산';
					txt[8]	= '052`울산';
					txt[9]	= '053`대구';
					txt[10]	= '054`경북';
					txt[11]	= '055`경남';
					txt[12]	= '061`전남';
					txt[13]	= '062`광주';
					txt[14]	= '063`전북';
					txt[15]	= '064`제주';
				return Auto.Html.Option(txt ,bitSt ,txtSt ,cicSt ,bitSf ,val);
			}
		,	Option : function(arrTxt ,bitSt ,txtSt ,cicSt ,bitSf ,val)
			{
				var html = [];
				if(bitSt)
				{
					html[0] = '<option value="">' + txtSt + '</option>';
				};
				var arrIx	= (bitSt) ? 1 : 0;
				for(var ix = 0; ix < arrTxt.length; ++ix)
				{
					tmpTxt		= (arrTxt[ix]).split('`');
					tmpText		= (cicSt == 0) ? tmpTxt[0] : ((cicSt == 1) ? tmpTxt[1] : tmpTxt[0] + ' ' + tmpTxt[1]);
					if(Cmn.BlankBool(val) && val == tmpTxt[0]){
						alert(val + '//' + tmpTxt[0]);
						var cls = ' selected="selected"';
					};
					html[arrIx]	= '<option value="' + tmpTxt[0] + '"' + cls + '>' + tmpText + '</option>';
					++arrIx
				};
				if(bitSf)
				{
					html[arrIx] = '<option value="sfw">직접입력</option>';
				};
				return html.join('');
			}
		}
	,	SelfWrite : function(eventEle ,targetEle){
			var evtobj	= $(eventEle);
			var evtVal	= evtobj.val();
			var tgtObj	= $(targetEle);
			if(evtVal == 'sfw'){
				tgtObj.removeAttr('readonly').select();
			} else{
				tgtObj.attr('readonly' ,true).val(evtVal);
			};
		}
	};
	Datepicker = function()
	{
		var options = {
			showOn				: 'button'
		,	buttonImage			: '/web/images/icon/calendar.png'
		,	buttonImageOnly		: true
		,	showOtherMonths		: true
		,	selectOtherMonths	: true
		};
		$('.datepicker').datepicker(options).next().css('cursor', 'pointer');
	};
	Modal =	{
		Ready : function(ele ,txt)
		{
			$('.ui-dialog').remove();
			$('#LoadingBar').remove();
			var obj = $('<div id="LoadingBar">' + ((Cmn.BlankBool(txt)) ? '로딩중...' : txt) + '</div>');
			$(ele).append(obj);	
		}
	,	Close : function()
		{
			$('.ui-dialog').remove();
			$('#LoadingBar').remove();
		}
	,	Form : function(ele ,html ,title ,fn)
		{
			$('.ui-dialog').remove();
			$('#LoadingBar').remove();
				
			var obj = $(html.join(''));
			$(ele).append(obj);	

			$('#LoadingBar').dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: title
			,	buttons			:
				{
					'저장'		: function(){ eval(fn); }
				,	'취소'		: function(){ $(this).dialog('close'); }
				}
			,	close		: function(){ $(this).remove(); }
			});
		}
	,	Secret : function(ele ,ele2 ,title ,atUrl)
		{
			$(ele).dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: title
			,	buttons			:
				{
					'확인'		: function(){
						var fmObj = $(ele2);
						$('#pwd').val($('#pwds').val());
						fmObj.attr('action' ,atUrl);
						fmObj.submit();
					}
				,	'취소'		: function(){ $(this).dialog('close'); }
				}
			,	close		: function(){ $(ele2).reset(); }
			});
		}
	,	Address : function(fn)
		{
			Modal.Close();
			$('#bxSearchAddress').dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: '주소검색'
			,	buttons			:
				{
					'선택'		: function(){ eval(fn); }
				,	'취소'		: function(){ $(this).dialog('close'); }
				}
			});
		}
	,	LoadingBar : function(ele ,txt)
		{
			Modal.Ready(ele ,txt);
			$('#LoadingBar').dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	minHeight		: 10
			,	closeOnEscape	: false
			,	resizable		: false
			});
			$('div.ui-dialog-titlebar').remove();
		}
	,	Alert : function(ele ,txt ,title)
		{
			Modal.Ready(ele ,txt);
			$('#LoadingBar').dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: title
			,	buttons			: {
					"OK"		: function()
					{
						$(this).dialog("close");
					}
				}
			,	close		: function(){ $(this).remove(); }
			});
		}
	,	Message : function(ele ,txt ,title)
		{
			$(ele).dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: title
			,	buttons			: {
					"닫기"		: function()
					{
						$(this).dialog("close");
					}
				}
			,	close		: function(){ $(this).remove(); }
			});
		}
	,	AlertFn : function(ele ,txt ,title ,fn)
		{
			Modal.Ready(ele ,txt);
			$('#LoadingBar').dialog({
				modal			: true
			,	width			: 'auto'
			,	height			: 'auto'
			,	closeOnEscape	: false
			,	resizable		: false
			,	title			: title
			,	buttons			: { '확인' : function(){ Modal.Eval(fn); } }
			});
		}
	,	Eval : function(fn)
		{
			eval(fn);
		}
	};
	ErrMessage = function(ix)
	{
		var msg = [];
		msg[0]	= '일시적 오류 입니다.\n\n새로고침 후 다시 이용해 주세요.';
		return msg[ix];
	};
	Regexp = function(str ,ptn ,types){
		var result;
		var patt = new RegExp(ptn);
		switch (types) {
			case 'test'	: result  = patt.test(str + ''); break;
			case 'match': result  = str.match(ptn); break;
		};
		return result;
	};
})(jQuery);
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