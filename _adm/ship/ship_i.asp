<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	shipid						= SQLI(Request("shipid"))
	idx							= SQLI(Request("idx"))
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	flag						= SQLI(Request("flag"))

	If idx <> "" Then
		If flag = "" Then flag = "M"
	Else
		If flag = "" Then flag = "W"
	End If
'	Response.Write "idx : "& idx &"<br>"

	If idx <> "" Then
		rso()
		SQL = " SELECT	idx, shipid, rdate, note, ddate FROM _oshpt020 WHERE idx = "& idx
		rs.open SQL, dbcon
		If Not rs.eof Then
			shipid					= rs("shipid")
			rdate					= rs("rdate")
			note					= rs("note")
			ddate					= rs("ddate")
		End If
		rsc()
	End If
%>

<script language="javascript">
<!--
function goSave(){
	var f = document.fm1;
	f.action = "ship_ix.asp";
	f.method = "post";
	f.submit();
}
function goDelete(){
	var f = document.fm1;
	if(confirm("삭제하시겠습니까?")){
		f.flag.value = "D";
		f.action = "ship_ix.asp";
		f.method = "post";
//		f.target = "nullframe";			//modal 창이므로 안씀
		f.submit();
	}
}
//-->
</script>


<form name="fm1" method="post" onSubmit="return goSave()">
<input type="hidden" name="shipid" value="<%=shipid%>">
<input type="hidden" name="idx" value="<%=idx%>">
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
					<td colspan=2>
						<table width="100%" border=0 id="list4">
							<tr>
<%
		rso()				'출조 종류선택
		SQL = "	SELECT code_nm FROM _ocodt010 WHERE gubn = '출조' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		i = 1
		Do Until rs.eof
%>
								<td height="25">
									<input type="radio" name="note" id="note<%=i%>" value="<%=rs("code_nm")%>"<%If note = rs("code_nm") Then%> checked<%End If%>>
									<label for="note<%=i%>"><%=rs("code_nm")%></label>
								</td>
<%
			If i Mod 3 = 0 Then
%>
							</tr>
							<tr>
<%
			End If
			rs.MoveNext
			i = i + 1
		Loop
		rsc()
%>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div id="btnarea1">
			<a href="javascript:goSave();" class="btn btn25"><span>저장</span></a>
<%		If idx <> "" Then %>
			<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%		End If %>
			<a href="javascript:;" onClick="simsClosePopup('close');" class="btn btn25"><span>닫기</span></a>
		</div>
	</div>
</div>
</form>

<div id="upload" style="top:0; left:0; width:220px; height:50px; position:absolute; visibility:hidden; z-index:10;"><img src="/img/icon/loader05.gif"></div>

<%	Set cx = Nothing %>
<%	dbc() %>
