<!-- #include virtual = "/inc/header.asp" -->
<!-- #include virtual = "/inc/top.asp" -->
<%
	tag							= 4
	yy							= SQLI(Year(Date))
	mm							= SQLI(setp(Month(Date)))
	dd							= SQLI(setp(Day(Date)))
	op							= SQLI(Request("op"))

	If op = "" Then op = "04"
'	Response.Write "<font color=#ffffff>date : "& hour(Now) &"</font><br>"
%>

<div id="wrap">
	<div>
		<ul>
			<li class="ib vt" style="width:230px;"><!-- #include virtual = "/inc/left/data.asp" --></li>
			<li class="ib vt">
				<div id="mainwrap1">
					<div class="mt20"><img src="/img/data_tle.gif" alt="기상정보" /></div>
					<div class="mt10 mb10"><img src="/img/data_weather02_tle.gif" alt="일본기상정보" /></div>
					<div style="width:710px; border:0px solid #000;" class="mt30 mb5">

<%	If Hour(Now) => 0 And Hour(Now) < 6 Then					'0시 ~ 6시 %>

						<div class="ct">
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date - 1%></b><br><%=WeekdayName(Weekday(Now()-1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date%></b><br><%=WeekdayName(Weekday(Now()))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 1%></b><br><%=WeekdayName(Weekday(Now()+1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 2%></b><br><%=WeekdayName(Weekday(Now()+2))%></span>
						</div>
						<div class="ct">
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=00">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=02">03시</a>
								|
								<a href="?op=04">09시</a>
								|
								<a href="?op=06">15시</a>
								|
								<a href="?op=08">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=10">03시</a>
								|
								<a href="?op=12">09시</a>
								|
								<a href="?op=14">15시</a>
								|
								<a href="?op=16">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=18">03시</a>
								|
								<a href="?op=20">09시</a>
								|
								<a href="?op=22">15시</a>
								|
								<a href="?op=24">21시</a>
							</span>
						</div>

<%	ElseIf hour(Now) => 6 And hour(Now) < 13 Then			'6시 ~ 13시 %>

						<div class="ct">
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date%></b><br><%=WeekdayName(Weekday(Now()))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 1%></b><br><%=WeekdayName(Weekday(Now()+1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 2%></b><br><%=WeekdayName(Weekday(Now()+2))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 3%></b><br><%=WeekdayName(Weekday(Now()+3))%></span>
						</div>
						<div class="ct">
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=00">03시</a>
								|
								<a href="?op=02">09시</a>
								|
								<a href="?op=04">15시</a>
								|
								<a href="?op=06">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=08">03시</a>
								|
								<a href="?op=10">09시</a>
								|
								<a href="?op=12">15시</a>
								|
								<a href="?op=14">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=16">03시</a>
								|
								<a href="?op=18">09시</a>
								|
								<a href="?op=20">15시</a>
								|
								<a href="?op=22">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=24">03시</a>
							</span>
						</div>

<%	ElseIf hour(Now) => 13 And hour(Now) < 15 Then				'13시 ~ 15시 %>

						<div class="ct">
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date%></b><br><%=WeekdayName(Weekday(Now()))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date+1%></b><br><%=WeekdayName(Weekday(Now()+1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date+2%></b><br><%=WeekdayName(Weekday(Now()+2))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date+3%></b><br><%=WeekdayName(Weekday(Now()+3))%></span>
						</div>
						<div class="ct">
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=00">09시</a>
								|
								<a href="?op=02">15시</a>
								|
								<a href="?op=04">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=06">03시</a>
								|
								<a href="?op=08">09시</a>
								|
								<a href="?op=10">15시</a>
								|
								<a href="?op=12">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=14">03시</a>
								|
								<a href="?op=16">09시</a>
								|
								<a href="?op=18">15시</a>
								|
								<a href="?op=20">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=22">03시</a>
								|
								<a href="?op=24">09시</a>
							</span>
						</div>

<%	ElseIf hour(Now) => 15 And hour(Now) < 19 Then			'15시 ~ 19시 %>

						<div class="ct">
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date%></b><br><%=WeekdayName(Weekday(Now()))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 1%></b><br><%=WeekdayName(Weekday(Now()+1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 2%></b><br><%=WeekdayName(Weekday(Now()+2))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 3%></b><br><%=WeekdayName(Weekday(Now()+3))%></span>
						</div>
						<div class="ct">
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=00">09시</a>
								|
								<a href="?op=02">15시</a>
								|
								<a href="?op=04">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=06">03시</a>
								|
								<a href="?op=08">09시</a>
								|
								<a href="?op=10">15시</a>
								|
								<a href="?op=12">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=14">03시</a>
								|
								<a href="?op=16">09시</a>
								|
								<a href="?op=18">15시</a>
								|
								<a href="?op=20">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=22">03시</a>
								|
								<a href="?op=24">09시</a>
							</span>
						</div>

<%	ElseIf hour(Now) => 19 And hour(Now) < 24 Then			'19시 ~ 24시 %>

						<div class="ct">
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date%></b><br><%=WeekdayName(Weekday(Now()))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 1%></b><br><%=WeekdayName(Weekday(Now()+1))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 2%></b><br><%=WeekdayName(Weekday(Now()+2))%></span>
							<span class="ib ct pt5 pb5" style="width:170px; background-color:#eee;"><b><%=Date + 3%></b><br><%=WeekdayName(Weekday(Now()+3))%></span>
						</div>
						<div class="ct">
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=00">15시</a>
								|
								<a href="?op=02">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=04">03시</a>
								|
								<a href="?op=06">09시</a>
								|
								<a href="?op=08">15시</a>
								|
								<a href="?op=10">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=12">03시</a>
								|
								<a href="?op=14">09시</a>
								|
								<a href="?op=16">15시</a>
								|
								<a href="?op=18">21시</a>
							</span>
							<span class="ib ct" style="width:170px; line-height:30px;">
								<a href="?op=20">03시</a>
								|
								<a href="?op=22">09시</a>
								|
								<a href="?op=24">15시</a>
							</span>
						</div>
<%	End If %>
					</div>
					<div class="pl20 pt10 pb10 mr10 rg"><span class="divTime"></span></div>

<script language="JavaScript">
function getFullToday(){
	var yIdx = "일월화수목금토";
	var today = new Date();
	var buf = "";

	mm = today.getMonth() + 1;
	dd = today.getDate();
	h = today.getHours(); if(h>12){h-=12;ap='오후';}else{ap='오전';}
	m = today.getMinutes();
	s = today.getSeconds();

	yo = yIdx.charAt(today.getDay())+'요일';

	buf = "<%=yy%>년 "+mm+"월 "+dd+"일 "+yo+" "+ap+" "+h+"시 "+m+"분 "+s+"초";
	return buf;
}
function putsTime(){
	//if (typeof(document.all.divTime) == "object") {
		//document.all.divTime.innerHTML = "" + getFullToday() + " ";
		//document.all.divTime.value= "" + getFullToday() + " ";
	//}
	$(".divTime").text(getFullToday());
	setTimeout("putsTime()", 1000);
}
putsTime();
</script>

					<div class="ct"><img src="http://www.imocwx.com/cwm/cwmsjp_<%=op%>.png" width="640" height="640"></div>
					<div class="pt20 pb20">&nbsp;</div>
				</div>
			</li>
			<li class="ib vt"><!-- #include virtual = "/inc/quick.asp" --></li>
		</ul>
	</div>
</div>
<!-- #include virtual = "/inc/footer.asp" -->