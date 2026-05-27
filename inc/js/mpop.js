///bbs/gallery.asp 사용
var ie = document.all
var ns6 = document.getElementById&&!document.all

function ietruebody(){
	return (document.compatMode!="BackCompat")? document.documentElement : document.body;
}
function mpop (which, e, position, imgwidth, imgheight, ttop){
	if (ie||ns6){
		crossobj = document.getElementById? document.getElementById("showimage") : document.all.showimage;
		if (position == "center"){
			pgyoffset = ns6? parseInt(pageYOffset) : parseInt(ietruebody().scrollTop);
			horzpos = ns6? pageXOffset+window.innerWidth/2-imgwidth/2 : ietruebody().scrollLeft+ietruebody().clientWidth/2-imgwidth/2;
			vertpos = ns6? pgyoffset+window.innerHeight/2-imgheight/2-50 : pgyoffset+ietruebody().clientHeight/2-imgheight/2-50;
			if (window.opera && window.innerHeight)
				vertpos = pgyoffset+window.innerHeight/2-imgheight/2;
				vertpos = Math.max(pgyoffset, vertpos);
		} else {
			var horzpos = ns6? pageXOffset+e.clientX : ietruebody().scrollLeft+event.clientX;
			var vertpos = ns6? pageYOffset+e.clientY : ietruebody().scrollTop+event.clientY;
		}
		if (ttop == 0) ttop = vertpos;
		crossobj.style.left			= horzpos + "px";
		crossobj.style.top			= ttop + "px";
		crossobj.innerHTML = "<div class='rg' id='dragbar' style='width:"+ imgwidth +"px;'><span id='closetext' onClick='closepreview()'><img src='/img/icon/close6.gif'></span></div>"
		+ "<iframe src="+ which +" name='myiframe' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' width="+ imgwidth +" height="+ imgheight +"></iframe>"
		+ "";
		crossobj.style.visibility = "visible";
		return false;
	} else
		return true;
}
function mpop3 (which, e, position, imgwidth, imgheight, ttop){
	if (ie||ns6){
		crossobj = document.getElementById? document.getElementById("showimage") : document.all.showimage;
		overobj = document.getElementById? document.getElementById("overlay") : document.all.overlay;
		if (position == "center"){
			pgyoffset = ns6? parseInt(pageYOffset) : parseInt(ietruebody().scrollTop);
			horzpos = ns6? pageXOffset+window.innerWidth/2-imgwidth/2 : ietruebody().scrollLeft+ietruebody().clientWidth/2-imgwidth/2;
			vertpos = ns6? pgyoffset+window.innerHeight/2-imgheight/2-50 : pgyoffset+ietruebody().clientHeight/2-imgheight/2-50;
			if (window.opera && window.innerHeight)
				vertpos = pgyoffset+window.innerHeight/2-imgheight/2;
				vertpos = Math.max(pgyoffset, vertpos);
		} else {
			var horzpos = ns6? pageXOffset+e.clientX : ietruebody().scrollLeft+event.clientX;
			var vertpos = ns6? pageYOffset+e.clientY : ietruebody().scrollTop+event.clientY;
		}
		if (ttop == 0) ttop = vertpos;
		crossobj.style.left			= horzpos + "px";
		crossobj.style.top			= ttop + "px";
		crossobj.innerHTML = "<div class='rg' id='dragbar' style='width:"+ imgwidth +"px;z-index:99999;'><span id='closetext' onClick='closepreview3()'><img src='/img/icon/close6.gif'></span></div>"
		+ "<iframe src="+ which +" name='myiframe' scrolling='yes' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' width="+ imgwidth +" height="+ imgheight +"></iframe>"
		+ "";
		crossobj.style.visibility = "visible";
		overobj.style.visibility = "visible";
		return false;
	} else
		return true;
}
function mpop5 (which, e, position, imgwidth, imgheight, ttop){
	if (ie||ns6){
		crossobj = document.getElementById? document.getElementById("showimage") : document.all.showimage;
		overobj = document.getElementById? document.getElementById("overlay") : document.all.overlay;
		if (position == "center"){
			pgyoffset = ns6? parseInt(pageYOffset) : parseInt(ietruebody().scrollTop);
			horzpos = ns6? pageXOffset+window.innerWidth/2-imgwidth/2 : ietruebody().scrollLeft+ietruebody().clientWidth/2-imgwidth/2;
			vertpos = ns6? pgyoffset+window.innerHeight/2-imgheight/2-50 : pgyoffset+ietruebody().clientHeight/2-imgheight/2-50;
			if (window.opera && window.innerHeight)
				vertpos = pgyoffset + window.innerHeight/2-imgheight/2;
				vertpos = Math.max(pgyoffset, vertpos);
		} else {
			var horzpos = ns6? pageXOffset+e.clientX : ietruebody().scrollLeft+event.clientX;
			var vertpos = ns6? pageYOffset+e.clientY : ietruebody().scrollTop+event.clientY;
		}
		if (ttop == 0) ttop = vertpos;
		crossobj.style.left			= horzpos + "px";
		crossobj.style.top			= ttop + "px";
		crossobj.innerHTML = "<div class='rg' id='dragbar' style='width:"+ imgwidth +"px;'><span id='closetext' onClick='closepreview3()'><img src='/img/icon/close6.gif'></span></div>"
		+ "<iframe src="+ which +" name='uframe' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' width="+ imgwidth +" height="+ imgheight +"></iframe>"
		+ "";
		crossobj.style.visibility = "visible";
		overobj.style.visibility = "visible";
//		overobj.style.height = "1500";
		return false;
	} else
		return true;
}
function mpop7 (which, e, position, imgwidth, imgheight, ttop){
	if (ie||ns6){
		crossobj = document.getElementById? document.getElementById("showimage") : document.all.showimage;
		overobj = document.getElementById? document.getElementById("overlay") : document.all.overlay;
		if (position == "center"){
			pgyoffset = ns6? parseInt(pageYOffset) : parseInt(ietruebody().scrollTop);
			horzpos = ns6? pageXOffset+window.innerWidth/2-imgwidth/2 : ietruebody().scrollLeft+ietruebody().clientWidth/2-imgwidth/2;
			vertpos = ns6? pgyoffset+window.innerHeight/2-imgheight/2-50 : pgyoffset+ietruebody().clientHeight/2-imgheight/2-50;
			if (window.opera && window.innerHeight)
				vertpos = pgyoffset + window.innerHeight/2-imgheight/2;
				vertpos = Math.max(pgyoffset, vertpos);
		} else {
			var horzpos = ns6? pageXOffset+e.clientX : ietruebody().scrollLeft+event.clientX;
			var vertpos = ns6? pageYOffset+e.clientY : ietruebody().scrollTop+event.clientY;
		}
		if (ttop == 0) ttop = vertpos;
		crossobj.style.left			= horzpos + "px";
		crossobj.style.top			= ttop + "px";
		crossobj.innerHTML = "<div class='rg' id='dragbar' style='padding:0;'></div>"
		+ "<iframe src="+ which +" name='uframe' scrolling='no' marginwidth='0' marginheight='0' frameborder='0' vspace='0' hspace='0' width="+ imgwidth +" height="+ imgheight +"></iframe>"
		+ "";
		crossobj.style.visibility = "visible";
		overobj.style.visibility = "visible";
//		overobj.style.height = "1500";
		return false;
	} else
		return true;
}
function closepreview(){
	crossobj.style.visibility = "hidden";
}
function closepreview3(){
	overobj.style.visibility = "hidden";
	crossobj.style.visibility = "hidden";
}
function drag_drop(e){
	if (ie&&dragapproved){
		crossobj.style.left = tempx+event.clientX-offsetx+"px";
		crossobj.style.top = tempy+event.clientY-offsety+"px";
	} else if (ns6&&dragapproved){
		crossobj.style.left = tempx+e.clientX-offsetx+"px";
		crossobj.style.top = tempy+e.clientY-offsety+"px";
	}
	return false
}
function initializedrag(e){
	if (ie&&event.srcElement.id == "dragbar"||ns6&&e.target.id == "dragbar"){
		offsetx = ie? event.clientX : e.clientX;
		offsety = ie? event.clientY : e.clientY;

		tempx = parseInt(crossobj.style.left);
		tempy = parseInt(crossobj.style.top);

		dragapproved = true;
		document.onmousemove = drag_drop;
	}
}
document.onmousedown = initializedrag;
document.onmouseup = new Function("dragapproved=false");

function Layer_Div(Con, Num1, Num2){
	if (Num1 > Num2){
		PlusNum = PlusNum + 3;
		if (PlusNum < (Num1 - Num2)){
			document.all["footerDiv"].style.top = Num1 - PlusNum;
			setTimeout("Layer_Div('"+ Con +"',"+ Num1 +","+ Num2 +")",1);
		}
	} else if (Num1 < Num2){
		PlusNum = PlusNum + 3;
		if (PlusNum < (Num2 - Num1)){
			document.all["footerDiv"].style.top = Num1 + PlusNum;
			setTimeout("Layer_Div('"+ Con +"',"+ Num1 +","+ Num2 +")",1);
		}
	}
}

/* 레이어 전체화면 덮기 */
function getPageSize(){
	var xScroll, yScroll;
	if (window.innerHeight && window.scrollMaxY){
		xScroll = window.innerWidth + window.scrollMaxX;
		yScroll = window.innerHeight + window.scrollMaxY;
	} else if (document.body.scrollHeight > document.body.offsetHeight){		// all but Explorer Mac
		xScroll = document.body.scrollWidth;
		yScroll = document.body.scrollHeight;
	} else {		// Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
		xScroll = document.body.offsetWidth;
		yScroll = document.body.offsetHeight;
	}
	var windowWidth, windowHeight;
	if (self.innerHeight){
		// all except Explorer
		if (document.documentElement.clientWidth){
			windowWidth = document.documentElement.clientWidth;
		} else {
			windowWidth = self.innerWidth;
		}
		windowHeight = self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight){		// Explorer 6 Strict Mode
		windowWidth = document.documentElement.clientWidth;
		windowHeight = document.documentElement.clientHeight;
	} else if (document.body){			// other Explorers
		windowWidth = document.body.clientWidth;
		windowHeight = document.body.clientHeight;
	}
	//for small pages with total height less then height of the viewport
	if (yScroll < windowHeight){
		pageHeight = windowHeight;
	} else {
		pageHeight = yScroll;
	}
	//for small pages with total width less then width of the viewport
	if (xScroll < windowWidth){
		pageWidth = xScroll;
	} else {
		pageWidth = windowWidth;
	}
//	alert(pageWidth);
//	alert(pageHeight);
	return [pageWidth, pageHeight];
}
//리사이즈시 다시체크
function CheckTicket(){
	//alert("리사이즈체크")
	var arrayPageSize = getPageSize();
	document.getElementById("overlay").style.width = arrayPageSize[0];
	document.getElementById("overlay").style.height = arrayPageSize[1];
}
//덮기
function Fulllayer(){
	var arrayPageSize = getPageSize();
//	alert(arrayPageSize[1]);
	document.getElementById("overlay").style.width = arrayPageSize[0];
	document.getElementById("overlay").style.height = arrayPageSize[1];
}
window.onresize = CheckTicket;			//사용자가 윈도우 크기를 조정하면 다시 그사이즈에 맞게 덮어줍니다.*/