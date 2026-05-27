function MM_preloadImages() { //v3.0
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
	var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_swapImage() { //v3.0
	var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_showHideLayers() { //v6.0
	var i,p,v,obj,args=MM_showHideLayers.arguments;
	for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
	if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
	obj.visibility=v; }
}
function setPng24(obj) {
	obj.width=obj.height=1;
	obj.className=obj.className.replace(/\bpng24\b/i,'');
	obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
	obj.src='';
	return '';
}
function bt(id,after) {
	eval(id+'.filters.blendTrans.stop();');
	eval(id+'.filters.blendTrans.Apply();');
	eval(id+'.src="'+after+'";');
	eval(id+'.filters.blendTrans.Play();');
}
function onlyNumber() {					//숫자만을 허용함
	if ((event.keyCode<48)||(event.keyCode>57))
		event.returnValue = false;
}
function IsNumber(formname) {
	var form = eval("document.fm1." + formname);
	for (var i = 0; i < form.value.length; i++) {
		var chr = form.value.substr(i,1);
		if (chr < '0' || chr > '9') {
			return false;
		}
	}
	return true;
}
function isHangul(str) {				//한글체크
	var re = /[a-zA-Z0-9\s~!@#\$%\^&\*\(\)_\+\{\}|:"<>\?`\-=\[\]\\;',\.\/]/;
	//matches a alphanumeric character or space
	if (re.test(str))
		return false;
	return true;
}
function Popup(url,w,h,l,t,s,p) {
	window.open(url,"win2"+p,"width="+w+",height="+h+",left="+l+",top="+t+",location=0,menubar=0,toolbar=0,directories=0,resizable=1,scrollbars="+s);
}
function changeBox(cbox) {
	box = eval(cbox);
	box.checked = !box.checked;
}
function clearText(thefield) {			// 클릭하면 내용 지우기
	if (thefield.defaultValue == thefield.value)
		thefield.value = ""
}
function checkLength(obj, min, max, nullable) {		//길이 check
	if (!nullable) {
		len = obj.value.length;
		if (len < min || len > max)
			return false;
	}
	return true;
}
function checkName(obj) {											//이름 Check
	if (!checkLength(obj, 2, 10, false)) {
		alert("이름이 등록되지 않았거나 유효한 이름이 아닙니다.     ");
		obj.focus();
		return false;
	}
	if (!isHangul(obj.value)) {
		alert("이름은 공백없이 한글로 써 주세요.      ");
		obj.focus();
		return false;
	}
	return true;
}
function goMenu(name) {
	if (eval(name) == "") {
		alert("서비스 준비중입니다.");
		return;
	} else {
		document.location.href = eval(name);
	}
}

function goLogin() {
	var f = document.login;
	if (f.uid.value == "") {
		alert("아이디를 입력하세요.       ");
		f.uid.focus();
		return;
	}
	if (f.pwd.value == "") {
		alert("비밀번호를 입력하세요.        ");
		f.pwd.focus();
		return;
	}
	f.action = "/mem/login_x.asp";
	f.submit();
}

function chkLogin() {
	if (document.loginfm.memid.value == "") {
		alert("아이디를 입력하세요.       ");
		document.loginfm.memid.focus();
		return;
	}
	if (document.loginfm.passwd.value == "") {
		alert("비밀번호를 입력하세요.        ");
		document.loginfm.passwd.focus();
		return;
	}
	document.loginfm.action = "/login_xx.asp";
	document.loginfm.submit();
}

function writeKeyDown() {
	if (event.keyCode == 13)	chkLogin();
}

function unoRequest(frmId, Url, mTarget) {
	var retFrmId = '#' + frmId;

	if(mTarget != 'undefined'){
		alert("1");
		$(retFrmId).attr({action:Url, method:'post', target:mTarget}).submit();
	}else{
		alert("2");
		$(retFrmId).attr({action:Url, method:'post'}).submit();
	}
}