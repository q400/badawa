<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	dbo()
	yy							= SQLI(Request("yy"))
	mm							= SQLI(Request("mm"))
	dd							= SQLI(Request("dd"))
	ridx						= SQLI(Request("ridx"))
	shipid						= SQLI(Request("shipid"))
	op							= SQLI(Request("op"))				'회원mem/비회원nomem 예약수정
	tag							= 3

	If dd <> "" Then
		dd = setp(dd)
	Else
		dd = setp(Day(Date + 1))
	End If

	If mm <> "" Then
		mm = setp(mm)
	Else
		If dd > 28 Then				'매월 26일이 넘으면 다음달이 보이게
			mm = setp(Month(Date) + 1)
			dd = "01"
		Else
			mm = setp(Month(Date))
		End If
	End If

	If yy <> "" Then
		yy = yy
	Else
		If mm = 13 Then
			yy = Year(Date) + 1
		Else
			yy = Year(Date)
		End If
	End If

	If mm = 13 Then mm = "01"			'다음달이 13이면 1월로 처리

	vdate = CDate(yy &"/"& mm &"/01")	'Response.Write "vDate : "& CDate(vDate) &"<br>"
	vThisWeek = Weekday(CDate(yy &"/"& mm &"/"& dd))
%>

<script type="text/javascript">
<!--
function init() {
<%	If op = "mem" Then %>
//	return mpop5('rsv_ww.asp?ridx=<%=ridx%>&shipid=<%=shipid%>','ev','center',730,780,30);
<%	ElseIf op = "nomem" Then %>
//	return mpop('pwd.asp?ridx=<%=ridx%>&shipid=<%=shipid%>','ev','center',730,780,30);
<%	End If %>
}
//window.onload = init;
//-->
</script>


<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/rsv.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap4">
					<div class="mt20"><img src="/img/rsv_title.gif" width="197" height="24" alt="예약타이틀" /></div>
					<div class="mt10 mb20"><img src="/img/reser_list_tle.gif" width="239" height="18" title="낚시배예약"></div>
					<div style="width:810px; height:100%; border:0px solid #000;">

<form name="fm1" id="fm1" method="post"></form>

						<div class="mt20 mb10">
							<img src="/img/reser_s_tle02.gif" class="vm" alt="예약하기" title="예약하기" />&nbsp;&nbsp;&nbsp;&nbsp;
							<font class="fc5 f15 fb ls vt"><%=yy%>-<%=mm%>-<%=dd%></font>&nbsp;&nbsp;<b class="f15 fc5 vt">(<%=getMool1(yy,mm,dd)%>)</b>
						</div>

						<!-- #include file = "sub.asp" -->

					</div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->
