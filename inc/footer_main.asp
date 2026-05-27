<div id="footer" style="position:absolute; bottom:0; z-index:500; width:100%;">
	<div class="" style="width:1200px; height:100%;">
		<div class=ib style="width:100px; height:100%; float:left;">
			<p class="mt5 ml10"><img src="/img/f_logo.gif" alt="로고" /></p>
		</div>
		<div class=ib style="width:1100px; height:100%; float:right;">
			<div style="width:100%; height:50%;">
				<ul class="ib mt5">
					<li style="width:250px;" class="pl20 ib"><font class="fc21 f12 ls">충청남도 태안군 근흥면 안흥1길 30-1 안흥낚시</font></li>
					<li style="width:90px;" class="pl20 vt ib"><font class="fc21 f12 ls">대표자 : 양주영</font></li>
					<li style="width:250px;" class="pl20 vt ib"><font class="fc21 f12 ls">사업자등록번호 : <span class="fc21 f12 ls">573-28-02010</span></font></li>
					<li class="vt rg ib">
						<a href="/info/info_shop.asp"><font class="fc21 f11 ls">안흥낚시소개</font></a>
						|
						<a href="/mem/clause.asp"><font class="fc21 f11 ls">이용약관</font></a>
						|
						<a href="/mem/private.asp"><font class="fc21 f11 ls">개인정보보호정책</font></a>
						|
						<a href="/mem/email.asp"><font class="fc21 f11 ls">이메일무단수집거부</font></a>
					</li>
				</ul>
			</div>
			<div class="ib" style="width:100%; height:50%;">
				<ul class="ib">
					<li style="width:500px;" class="pl20 ib">
						<font class="fz fc21">CopyRight(<a href="/_adm/" target="_blank"><span class="fz f12 fc21" style="cursor:none;">C</span></a>) 2002 badawa.co.kr All Right Reserved.</font>
					</li>
					<li style="width:400px;" class="ib rg">
						<select name="1" class="f11 fc21" style="width:140px; background:#555; border:solid 0px #fff;" onChange="GoSelect(this.value);">
						<option value="#">선박사이트 바로가기</option>
<%
	rso()
	SQL = " SELECT shipnm, link FROM _oshpt030 "
	rs.open SQL, dbcon
	While Not rs.eof
%>
						<option value="<%=rs("link")%>" target="_blank"><%=rs("shipnm")%></option>
<%
		rs.MoveNext
	Wend
	rsc()
%>
						</select>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
<div id="showimage"></div>
</body>

<script type="text/javascript">
function GoSelect(golink) {
	window.open(golink);
}
</script>

</html>
<%	dbc() %>