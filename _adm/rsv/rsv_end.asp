<!-- #include virtual = "/inc/header_pop.asp" -->

<script src="/lib/jquery-1.7.1.js"></script>
<script src="/lib/ui/jquery.ui.core.js"></script>
<script src="/lib/ui/jquery.ui.widget.js"></script>
<script src="/lib/ui/jquery.ui.datepicker.js"></script>
<!-- <link rel="stylesheet" href="/lib/css/demos.css"> -->

<%
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
'	Response.Write "ridx : "& ridx &"<br>"

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, omoney, pwd, uip, ddate, memo FROM _orsvt010 WHERE ridx = "& ridx
		rs.open SQL, dbcon
		If Not rs.eof Then
			rdate				= rs("rdate")
			uno					= rs("uno")
			rnm					= rs("rnm")
			inwon				= rs("inwon")
			tel					= rs("tel")
			hp					= rs("hp")
			email				= rs("email")
			shipid				= rs("shipid")
			gubn				= rs("gubn")				'D-독배/G-개인(합승)
			status				= rs("status")
			rmoney				= rs("rmoney")				'예약금액
			omoney				= rs("omoney")				'실결제금액
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
		End If
		rsc()
	End If

	If omoney <> "" And omoney <> 0 Then
		opoint = omoney * 0.1
	End If

	If inwon <> "" And inwon <> 0 Then
		ipoint = (inwon - 1) * 500
	End If

	point = opoint + ipoint
%>

<script language="javascript">
<!--
$(function(){
	$("#datepicker").datepicker();
});

function upload(){
	document.all.upload.style.visibility = "visible";
}

function goSave(){
	var f = document.fm1;
	if(confirm("처리합니까?")){
//		upload();
		f.action = "rsv_ok.asp";
		f.method = "post";
		f.submit();
	}else{
		return;
	}
}
//-->
</script>


<form name="fm1" method="post" onSubmit="return upload()">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="uno" value="<%=uno%>">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap3">
		<div id="poptitle2">
			<table width=700 id="list2">
				<colgroup>
					<col style="width:130px;" />
					<col width="*" />
				</colgroup>
				<p class="fc8">※ 모든 예약을 완료하고 <b>회원예약</b>의 경우 포인트를 지급합니다.</p>
				<tr>
					<td class="bdr-ds1 bdr-ds3">선박이름</td>
					<td class="bdr-ds3 lh26">
						<b><%=shipinfo(shipid,"shipnm")%></b>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">예약자</td>
					<td class="">
						<b class="fcb"><%=meminfo(uno,"uname")%></b>
						&nbsp;&nbsp;&nbsp;
<%			If uno <> "0" And uno <> "" Then %>
						<input type="hidden" name="realchk" value="Y">
						<span class="fc5">회원예약</span>
<%			Else %>
						<input type="hidden" name="realchk" value="N">
						<span class="fc5">비회원예약</span>
<%			End If %>
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">실결제금액</td>
					<td class="">
						<b class="ff f11 fc7 ls"><%=FormatNumber(omoney,0)%></b> 원&nbsp;&nbsp;
						<input type="text" name="opoint" maxlength="7" class="bx1 ff fcb rg" value="<%=opoint%>" style="width:60px;"<%If uno = "0" Or uno = "" Then%> disabled<%End If%>> 포인트
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">동행인원</td>
					<td class="">
						<b class="ff f11 fc7 ls"><%=inwon - 1%></b> 명 × 500
						=
						<input type="text" name="ipoint" maxlength="7" class="bx1 ff fcb rg" value="<%=ipoint%>" style="width:60px;"<%If uno = "0" Or uno = "" Then%> disabled<%End If%>> 포인트
					</td>
				</tr>
				<tr>
					<td class="bdr-ds1">적립 쉽포인트</td>
					<td class="">
						<input type="text" name="point" maxlength="7" class="bx1 ff fcb rg" value="<%=point%>" style="width:80px;"<%If uno = "0" Or uno = "" Then%> disabled<%End If%>> 포인트
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
<%	If uno <> "0" And uno <> "" Then %>
			<a href="javascript:goSave();" class="btn btn25"><span>완료처리</span></a>
<%	End If %>
		</div>
	</div>
</table>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	Set cx = Nothing %>
<%	dbc() %>
