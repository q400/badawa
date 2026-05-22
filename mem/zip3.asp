<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	dboz()
	sValue						= SQLI(Request("cValue"))
	op							= SQLI(Request("op"))	'layer / winpop

	If op = "" Then op = "layer"

	If sValue = "" Then
		sMsg = "우편번호를 입력하세요."
	Else
		rso()
		SQL = " SELECT * FROM zip.dbo.zipcode WHERE dong LIKE '"& sValue &"%' "
		rs.open SQL, dbconz
		If Not(rs.Eof Or rs.Bof) Then
			sMsg = "이미 사용중인 우편번호입니다."		'동일 주민번호 존재O
		Else
			sMsg = "사용가능한 우편번호입니다."			'동일 주민번호 존재X
		End If
		rsc()
	End If
%>

<script type="text/javascript">
<!--
function goSearch(){
	var f = document.fm;
	if(!f.cValue.value){
		alert("주소를 입력해 주세요.");
		f.cValue.focus();
		return;
	}
	//f.target = "_blank";
	f.action = "zip3.asp";
	f.submit();
}
//-->
</script>
</head>


<form name="fm" method="post">
<input type="hidden" name="op" id="op" value="<%=op%>" />
<div id="wrap">
	<div>
		<ul>
			<li class="ib vt">
				<div style="width:446px;">
					<div style="margin:0 auto;">
						<img src="/img/zip_bx01.gif" class="db" alt="우편번호찾기" title="우편번호찾기" />
					</div>
					<div style="background-image:url(/img/zip_bx03.gif); background-repeat:repeat-y;">
						<center>
							<img src="/img/zip_cnt01.gif" class="vm" alt="검색할 동 이름 입력" title="검색할 동 이름 입력" />
							<input type="text" name="cValue" id="cValue" value="<%=sValue%>" style="width:100px;" maxlength="20">
							<a href="javascript:goSearch();" class="btn btn25"><span>검색</span></a>
							<img src="/img/zip_cnt02.gif" class="vm" alt="설명글" title="설명글" />
							<img src="/img/zip_cnt03.gif" alt="해당 주소를 클릭하세요" title="해당 주소를 클릭하세요" />
							<iframe src="zip_sub3.asp?cValue=<%=sValue%>&op=<%=op%>" width="397" height="325" frameborder=0 style="border:1px solid #dcdcdc;"></iframe>
						</center>
					</div>
					<div>
						<img src="/img/zip_bx02.gif" class="db" />
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>
<%	dbcz() %>