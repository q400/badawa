<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	oyear						= SQLI(Request("oyear"))
	omonth						= SQLI(Request("omonth"))
	oday						= SQLI(Request("oday"))
	nanumsu						= 200

	If Trim(oyear) <> "" Then oyear = Trim(oyear) Else oyear = Year(Date())
	If Trim(omonth) <> "" Then omonth = setP(Trim(omonth)) Else omonth = setP(Month(Date()))
	If Trim(oday) <> "" Then oday = setP(Trim(oday)) Else oday = setP(Day(Date()))

	If (CInt(oyear) < 2011) Then
		Call JSalert("이 통계는 2011년부터 존재합니다!")
	End If

	If (CInt(oyear) > 2012) Then
		nanumsu = 100
	End If

	If (CInt(oyear) > Year(Date())) Then
		Call JSalert("발생하지 않은 미래의 통계는 존재하지 않습니다!")
	End If

	If (CInt(oyear) = Year(Date())) And (CInt(omonth) > Month(Date())) Then
		Call JSalert("발생하지 않은 미래의 통계는 존재하지 않습니다!")
	End If

	vDate = CDate(oyear &"/"& omonth &"/01")

	prevYear = oyear - 1
	nextYear = oyear + 1
	'Response.Write oyear & omonth & "<br>"

	If (CInt(oyear) = Year(Date())) And (Month(Date()) = CInt(omonth)) And (Day(Date()) < 2) Then omonth = strPre_Mon

	'회원가입 숫자 파악
	rso()
	SQL = "	SELECT COUNT(*) FROM _omemt010 WHERE Year(ddate) = '"& oyear &"' "
	rs.open SQL, dbcon, 3
	If Not rs.eof Then
		intCnt = rs(0)
	End If
	rsc()

Function getMonthSum2(strYear, strMon)						'회원가입 숫자 파악
	Dim arrRs(0)
	Set rs1 = Server.CreateObject("ADODB.RecordSet")
	SQL = " SELECT COUNT(*) FROM _omemt010 WHERE Year(ddate) = '"& strYear &"' AND Month(ddate) = '"& setP(strMon) &"' "
	rs1.open SQL, dbcon, 3
	If rs1.Bof Or rs1.Eof Then
		rs1.close
		Set rs1 = Nothing
		Call JSalert("함수에 전달된 인자의 사용이 잘못되었습니다!")
	Else
		arrRs(0) = rs1(0)
		rs1.close
		Set rs1 = Nothing
	End If
	getMonthSum2 = arrRs
End Function
%>

<script type="text/javascript">
<!--
function unoPOP(rid, yy, mm, dd, sid, gubn){
	var urllink = "";
	var title = "회원목록";
	var wt, ht = "0";

	if(gubn == 1){			//예약신규등록
		urllink = "mem_pop.asp";
		title = "회원목록";
		wt = 500;
		ht = 700;
	}else if(gubn == 2){	//예약확인
		urllink = "rsv_m.asp?ridx="+ rid;
		title = "";
		wt = 750;
		ht = 600;
	}
	$.unoDialog({
		url: urllink + "?yy="+ yy +"&mm="+ mm,
		dialogArguments: '',
		top: 0,
		width: wt,
		height: ht,
		scrollable: false,
		title: title,
		onClose: function(){
			if(this.returnValue == null) return;
		}
	});
}
//-->
</script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		var data = google.visualization.arrayToDataTable([
				['해당년월', 'Mbyte']
//				,['2019.04', 807]
//				,['2019.07', 2120]
//				,['2019.08', 2400]
//				,['2019.09', 2570]
//				,['2019.10', 3000]
//				,['2019.11', 3390]
				,['2020.01', 3650]
				,['2020.03', 3870]
				,['2020.05', 4100]
				,['2020.07', 4850]
				,['2020.09', 5010]
				,['2020.10', 4950]
				,['2020.12', 4860]
				,['2021.01', 3500]
				,['2021.02', 3570]
				,['2021.04', 3730]
			]);
		var options = {
				title : '웹호스팅 HDD 용량 통계',
				vAxis: {title: 'Mbyte', textStyle: {fontSize: 11}},
				hAxis: {title: '해당년월', textStyle: {fontSize: 11}},
				seriesType: 'bars',
				series: {5: {type: 'line'}},
				colors: ['#e0440e']
			};

		var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>


<form name="fm1" method="post">
<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<center>
		<div id="admwrap0">
			<div class="ib vt" id="admLeft"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib vt" id="admwrap1">
				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">서버용량확인</span>
						<span class="ib fright"></span>
					</p>
					<div class="lf" style="margin:10px;">
						<span>※ 구매 용량에 대한 데이타 사용량 표시</span>
					</div>

					<div id="chart_div" style="width:1000px; height: 500px;"></div><!-- Chart -->
					<div class="rg pr10">전체용량 : <b><font color="#fa5555">5,000</font></b> Mbyte</div>

				</div>
				<!-- poptitle2 E -->
			</div>
			<!-- admwrap1 E -->
		</div>
	</center>
	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
</form>
