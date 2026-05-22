<!-- #include virtual = "/_db.asp" -->
<!-- #include virtual = "/inc/func.asp" -->
<%
	dboz()
	sValue						= SQLI(Request("cValue"))
	op							= SQLI(Request("op"))	'layer / winpop

	If sValue = "" Then
		sValue = "-------------------------------------"
	End If

	If op = "" Then op = "layer"
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>우편번호검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="/inc/css/base.css">
<script type="text/javascript" src="/lib/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="/inc/js/common.js"></script>
<script type="text/javascript" src="/inc/js/shared.js"></script>
<script type="text/javascript" src="/inc/js/modal.js"></script>
<script type="text/javascript">
<!--
function zipSelect(pZipCode, pZipName, op){
	var arrZipCode = pZipCode.split("-");
	if(op == "layer"){
		parent.parent.document.fm1.zip1.value = arrZipCode[0];
		parent.parent.document.fm1.zip2.value = arrZipCode[1];
		parent.parent.document.fm1.addr1.value = pZipName;
		parent.parent.document.fm1.addr2.focus();
		simsClosePopup('');
		//parent.parent.self.close();
	}else{
		parent.opener.document.fm1.zip1.value = arrZipCode[0];
		parent.opener.document.fm1.zip2.value = arrZipCode[1];
		parent.opener.document.fm1.addr1.value = pZipName;
		parent.opener.document.fm1.addr2.focus();
		parent.window.close();
	}
}
-->
</script>


<div style="width:375px;margin-top:10px;">
	<div style="width:370px;">
<%
		rso()
		SQL = " SELECT	zipcode, sido, gugun, dong, bunji " _
			& " FROM	zipcode " _
			& " WHERE	dong LIKE '"& sValue &"%' "
		rs.open SQL, dbconz
		While Not(rs.Eof Or rs.Bof)
			zipname = rs("sido") &" "& rs("gugun") &" "& rs("dong") &" "& rs("bunji")
			zipname2 = rs("sido") &" "& rs("gugun") &" "& rs("dong")
%>
		<ul>
			<li class="ls">
				&nbsp;[<%=rs("ZipCode")%>]&nbsp;&nbsp;
				<a href="javascript:;" onfocus="blur();" onClick="zipSelect('<%=Left(rs("ZipCode"),3) &"-"& Right(rs("ZipCode"),3)%>','<%=zipname2%>','<%=op%>')" title="<%=op%>"><%=zipname%></a>
			</li>
		</ul>
<%
			rs.MoveNext
		Wend
		rsc()
%>
	</div>
</div>
</body>
</html>
<%	dbcz() %>