<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	ridx						= SQLI(Request("ridx"))

	If ridx <> "" Then
		rso()
		SQL = " SELECT	ridx, rdate, uno, rnm, inwon, tel, hp, email, shipid, gubn, status, rmoney, pwd, uip, ddate, memo FROM _orsvt010 WHERE ridx = "& ridx
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
			rmoney				= rs("rmoney")
			pwd					= rs("pwd")
			uip					= rs("uip")
			ddate				= rs("ddate")
			memo				= rs("memo")
		End If
		rsc()
	End If

'	If email <> "" Then
'		If trim(email) = "@" Then
'				email1			= ""
'				email2			= ""
'		Else
'			If InStr(email,"@") > 0 Then
'				email0			= email
'				email1			= Left(email0, InStr(email0, "@")-1)
'				email2			= Right(email0, Len(email0)-Len(email1)-1)
'			Else
'				email0			= cx.SetDecode(email)
'				email1			= Left(email0, InStr(email0, "@")-1)
'				email2			= Right(email0, Len(email0)-Len(email1)-1)
'			End If
'		End If
'	End If

	hp1							= onTel(hp,1)
	hp2							= onTel(hp,2)
	hp3							= onTel(hp,3)

	yy							= Left(rdate,4)
	mm							= Mid(rdate,4,2)
	dd							= Right(rdate,2)

	diff						= CLng(rdate) - CLng(Replace(Date(),"-",""))
//'	Response.Write "diff : "& diff &"<br>"
%>

<script language="javascript">
<!--
//-->
</script>


<form name="fm1" method="post">
<input type="hidden" name="ridx" value="<%=ridx%>">
<input type="hidden" name="flag" value="<%=flag%>">
<div id="wrap">
	<div class="mt10 mb10 ml20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약" /></div>
	<hr style="border:1px dotted #ccc;">
	<div class="mt10 mb10">
		<ul>
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약자이름</li>
			<li style="width:290px;" class="ib"><%=rnm%><%If status = "K" Then%>&nbsp;&nbsp;<font class="fc7 ls">(예약 대기 상태입니다.)</font><%End If%></li>
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약자연락처</li>
			<li style="width:290px;" class="ib">***-****-<%=hp3%></li>
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약일자</li>
			<li style="width:290px;" class="ib"><b><%=setd(rdate)%></b></li>
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약인원</li>
			<li style="width:290px;" class="ib"><%=inwon%> 명 (본인포함)</li>
			<!--<a href="#" onClick="return mpop5('book.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&man=<%=inwon%>','ev','center',620,530,0);"><img src="/img/rsv/namebook.gif" align="absmiddle"></a>-->
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약선박명</li>
			<li style="width:290px;" class="ib"><%=shipinfo(shipid,"shipnm")%></li>
			<li style="width:120px;" class="pl20 pt3 pb3 fc9 ib">예약구분</li>
			<li style="width:290px;" class="ib">
<%	If gubn = "G" Or gubn = "" Then %>
				개인/합승
<%	Else %>
				독배
<%	End If %>
			</li>
		</ul>
	</div>
	<hr style="border:1px dotted #ccc;">

	<center class="mt10">
<%
	If CLng(diff) > 0 Then
		If FID_AUTH = "" Then												'비회원 예약수정
			If pwd <> "" And (status = "N" Or status = "K") Then			'대기/예약대기
%>
		<a href="rsv_pwd.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=Left(rdate,4)%>&mm=<%=Mid(rdate,5,2)%>&dd=<%=Right(rdate,2)%>" class="btn btn25"><span>예약수정</span></a>
<%
			End If
		Else																'회원 예약수정
			If FID_NO = CInt(uno) Then										'본인예약
				If FID_AUTH = "50" Then										'선장/VIP
%>
		<a href="rsv_ww5.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=Left(rdate,4)%>&mm=<%=Mid(rdate,5,2)%>&dd=<%=Right(rdate,2)%>" target="_top" class="btn btn25"><span>예약수정</span></a>
<%
				Else														'일반회원
					If status = "N" Or status = "K" Then					'대기/예약대기
%>
		<a href="rsv_ww5.asp?ridx=<%=ridx%>&shipid=<%=shipid%>&yy=<%=Left(rdate,4)%>&mm=<%=Mid(rdate,5,2)%>&dd=<%=Right(rdate,2)%>" target="_top" class="btn btn25"><span>예약수정</span></a>
<%
					End If
				End If
			End If
		End If
	End If
%>
		<!-- <a href="javascript:goClose(0);" class="btn btn25"><span>창닫기</span></a> -->
		<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>창닫기</span></a>
	</center>

</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;">
<div><center><img src="/img/icon/loader05.gif" alt="LOADING" /></center></div>
<%	dbc() %>
