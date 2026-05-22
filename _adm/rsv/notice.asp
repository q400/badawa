<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	shipid						= SQLI(Request("shipid"))
	seq							= SQLI(Request("seq"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	flag						= SQLI(Request("flag"))

	If seq <> "" Then
		If flag = "" Then flag = "M"
	Else
		If flag = "" Then flag = "W"
	End If
'	Response.Write "seq : "& seq &"<br>"

	rso()
	SQL = " SELECT ISNULL(COUNT(*),0) FROM _onott010 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
	rs.open SQL, dbcon
		mcnt					= CInt(rs(0))
	rsc()

	If mcnt <> 0 Then
		rso()
		SQL = " SELECT seq, shipid, rdate, color, ddate, note FROM _onott010 WHERE shipid = "& shipid &" AND rdate = '"& yy & mm & dd &"' "
		rs.open SQL, dbcon
		If Not rs.eof Then
			seq					= rs("seq")
			shipid				= rs("shipid")
			rdate				= rs("rdate")
			color				= rs("color")
			ddate				= rs("ddate")
			note				= rs("note")
		End If
		rsc()
	End If
%>

<script language="javascript">
<!--
function goSave() {
	var f = document.fm1;
	f.action = "notice_x.asp";
	f.method = "post";
	f.submit();
}
function goDelete() {
	var f = document.fm1;
	if (confirm("삭제하시겠습니까?       ")) {
		f.flag.value = "D";
		f.seq.value = "<%=seq%>";
		f.action = "notice_x.asp";
		f.method = "post";
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post" onSubmit="return goSave()">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="yy" value="<%=yy%>">
<input type="hidden" name="mm" value="<%=mm%>">
<input type="hidden" name="dd" value="<%=dd%>">
<input type="hidden" name="flag">
<div id="wrap">
	<div id="mwrap3">
		<div id="poptitle2">
			<table style="width:100%;" id="list2">
				<colgroup>
					<col style="width:130px;" />
					<col width="*" />
				</colgroup>
				<tr>
					<td class="bdr-ds1 bdr-ds3">선택일자</td>
					<td class="bdr-ds3 lh26"><b class="ff f17 ls"><%=yy%>-<%=mm%>-<%=dd%></b></td>
				</tr>
				<tr>
					<td class="bdr-ds1">선택선박</td>
					<td class=""><b class="ff f15"><%=shipinfo(shipid,"shipnm")%></b> (기본출조 : <b class="fc7"><%=shipinfo(shipid,"chuljo0")%></b>)</td>
				</tr>
				<tr>
					<td class="bdr-ds1">내용</td>
					<td class=""><input type="text" name="note" value="<%=note%>" style="width:95%;"></td>
				</tr>
				<tr>
					<td colspan=2>
						<input type="radio" name="color" value="#333333"<%If color = "#333333" Then%> checked<%End If%>> <font style="color:#333333;">검정</font>
						<input type="radio" name="color" value="#ee2211"<%If color = "#ee2211" Then%> checked<%End If%>> <font style="color:#ee2211;">빨강</font>
						<input type="radio" name="color" value="#2211ee"<%If color = "#2211ee" Then%> checked<%End If%>> <font style="color:#2211ee;">파랑</font>
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
			<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%		If mcnt <> 0 Then %>
			<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%		End If %>
			<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>창닫기</span></a>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	dbc() %>
