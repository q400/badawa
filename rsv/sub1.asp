<script type="text/JavaScript">
/* modal */
function popup1(rid){
	$.unoDialog({
		url: "rsv_pop5.asp?ridx="+ rid,
		dialogArguments: '',
		top: 0,
		width: 460,
		height: 360,
		scrollable: false,
		title: "예약정보확인",
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
function popup2(seq){
	$.unoDialog({
		url: "goodqa_r.asp?seq="+ seq +"&page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&flag=RM",
		dialogArguments: '',
		top: 0,
		width: 500,
		height: 600,
		scrollable: false,
		title: "답변수정",
		onClose: function() {
			if(this.returnValue == null) return;
		}
	});
}
</script>

<!-- 예약하기 -->
<div style="width:800px; border:0px solid #ccc;">
<%
		rso()
		SQL = " SELECT shipid, shipnm, capa FROM _oshpt010 ORDER BY shipid ASC "
		rs.open SQL, dbcon

		i = 1
		Do Until rs.EOF
%>
	<div style="width:260px; height:185px; border:0px solid #ccc;" class="vt ib">
		<ul>
			<li style="width:100%;border-top:5px solid #79f;"></li>
			<li style="width:47%;" class="ib pl5">
				<a href="rsv_detail5.asp?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>"><b class="f14 ls2"><%=rs("shipnm")%></b>&nbsp;
				<b class="ls">(<%=guestCount(rs("shipid"),yy & mm & dd)%>/<%=rs("capa")%>명)</b></a>
			</li>
			<li style="width:47%;" class="rg pr5 frt ib">
				<%=sstat3(rs("shipid"),yy & mm & dd,1)%>&nbsp;&nbsp;
<%			If shipStat(rs("shipid"), yy & mm & dd) = 1 Then				'마감/정비/탐사 - 출조 불가능 %>
				<span class="fcr f11">마감</span><%'=getIcon("마감")%>
<%
			Else
				'예약가능인원
				ccnt		= shipinfo(rs("shipid"),"capa") - guestCount(rs("shipid"),yy & mm & dd)
'				Response.Write "ccnt : "& docExist(rs("shipid"),yy & mm & dd) &"<br>"
				If docExist(rs("shipid"),yy & mm & dd) > 0 Then			'독배 존재
%>
				<img src="/img/icon/doc.png" class="vm" alt="" />
<%
				Else
					If ccnt <= 0 Then			'만원 => 마감처리
%>
				<span class="fcr f11">마감</span>
<%					Else %>

<%
						If CDate(yy &"-"& mm &"-"& dd) < Date() + 90 Then
							If standbyCnt(rs("shipid"),yy & mm & dd) = 0 Then
%>
				<a href="rsv_ww5.asp?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>"><img src="/img/icon/rsv.png" class="vm" alt="예약" /></a>
<%							Else %>
				<span class="fce f11">대기</span>
				<!-- <input type="button" value="예약" class="n6" onClick="location='rsv_ww.asp?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>'"> -->
<%
							End If
						End If
					End If
				End If
			End If
%>
			</li>
		</ul>
		<hr style="border:1px dotted #ccc;">
		<div style="height:95px; border:1px solid #ccc;">
<%
			Set rsv = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	ridx, rnm, inwon "_
				& " FROM	_orsvt010 "_
				& " WHERE	shipid = "& rs("shipid")_
				& " AND		rdate = '"& yy & mm & dd &"' "_
				& " AND		status IN ('C','Y') "_
				& " ORDER BY ddate "
			rsv.open SQL, dbcon

			If Not (rsv.eof And rsv.bof) Then
				k = 1
				Do Until rsv.EOF
%>
			<span class="pl5">
				<a href="javascript:;" onClick="popup1('<%=rsv("ridx")%>'); return false;" class=""><%=Trim(rsv("rnm"))%><b class="f10 ff fc7 ls">ㆍ<%=rsv("inwon")%></b></a>
			</span>
			&nbsp;
<%
					rsv.MoveNext
					If k Mod 3 = 0 Then
%>
			<br />
<%
					End If
					k = k + 1
				Loop
			End If
			Set rsv = Nothing
%>
		</div>
		<div class="f11 pr20" style="border:1px solid #cec; background:#dfefdf;">&nbsp;
<%			If cntNoti(rs("shipid"), yy & mm & dd) <> 0 Then %>
			<marquee behavior="ALTERNATIVE" scrollamount="3" scrolldelay="100" scrollAmount="100" direction="left;right;up;down;"><%=getnoti(rs("shipid"),yy & mm & dd)%></marquee>
<%			End If %>
		</div>
		<div class="vt" style="border:1px solid #ccc;">
				대기:
<%
			Set rsv = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	ridx, rnm, inwon, status "_
				& " FROM	_orsvt010 "_
				& " WHERE	shipid = "& rs("shipid")_
				& " AND		rdate = '"& yy & mm & dd &"' "_
				& " AND		status IN ('N','K','') "_
				& " ORDER BY ddate "
			rsv.open SQL, dbcon

			If Not (rsv.eof And rsv.bof) Then
				k = 1
				Do Until rsv.EOF
%>
			<a href="javascript:;" onClick="popup1('<%=rsv("ridx")%>'); return false;"><font class="fce ls <%If rsv("status") = "K" Then%>fc8<%End If%>"><%=Trim(rsv("rnm"))%>(<%=rsv("inwon")%>)</font></a>,
<%
					rsv.MoveNext
					k = k + 1
				Loop
			End If
			Set rsv = Nothing

			If shipStat(rs("shipid"), yy & mm & dd) <> 1 Then						'마감/정비/탐사가 아닌 경우
				If (ccnt = 0 Or rsvInfo(rs("shipid"),yy & mm & dd,"gubn") = "D") And Date() < CDate(yy &"-"& mm &"-"& dd) Then		'인원이 꽉 찼거나 독배 또는 과거
%>
			<a href="rsv_ww5.asp?shipid=<%=rs("shipid")%>&yy=<%=yy%>&mm=<%=mm%>&dd=<%=dd%>&op=SB"><img src="/img/icon/strsv.png" class="vm" title="대기예약"></a>
<%
				End If
			End If
%>
		</div>
	</div>
<%
			rs.MoveNext
			i = i + 1
		Loop

		rsc()
%>
</div>
