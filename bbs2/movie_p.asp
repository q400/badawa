<!-- #include virtual = "/inc/header_pop.asp" -->
<%
	seq							= SQLI(Request("seq"))
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
	<tr>
		<td bgcolor="#ffffff">
						<table width="810" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="21"></td>
							</tr>
							<tr>
								<td><img src="/img/info_tle.gif" width="299" height="24"></td>
							</tr>
							<tr>
								<td height="15"></td>
							</tr>
							<tr>
								<td><img src="/img/info_ah_tle.gif" width="193" height="18"></td>
							</tr>
							<tr>
								<td height="10"></td>
							</tr>
<%
		rso()				'동영상
		SQL = " SELECT seq, shipid, title, cnt, wdate, ddate, tnm, fnm, onm, fsz, ext, recom FROM _obbst040 WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			ext = rs("ext")
			fnm = rs("fnm")
		End If
		rsc()
%>

							<tr>
								<td>
									<table>
										<tr>
											<td height="15"></td>
										</tr>
										<tr>
											<td width="410">
<%		If ext = "flv" Then %>
												<p id="player"><a href="http://www.adobe.com/kr/products/flashplayer/" target="_blank"><b>플래시플레이어9</b></a>를 다운받아야 정상적으로 작동됩니다</p>
												<script type="text/javascript">
												var s1 = new SWFObject("/inc/swf/jwplayer.swf","mp3","400","326","7");
												s1.addVariable("file","/data/vod/<%=fnm%>");
												s1.addVariable("start",'5');
												s1.addVariable("backcolor","0xffffff");
												s1.addVariable("frontcolor","0x222222");
												s1.addVariable("lightcolor","0xff3300");
												//s1.addVariable("image","/vod/clip/vod01_<%=code%>.jpg");
												//s1.addVariable("logo","http://www.idnose.co.kr/img/logo_id.jpg");
												s1.addVariable("overstretch","true");
												s1.addVariable("autostart","true");
												s1.addVariable("repeat","false");
												s1.addVariable("shuffle","true");
												s1.addVariable('showvolume','true');
												s1.addVariable("volume","20");
												s1.addVariable('usefullscreen','false');
												s1.addVariable('bufferlength','5');
												s1.addVariable('showdownload','false');
												s1.addVariable("enablejs","true");
												s1.addVariable("javascriptid","mp3");
												s1.write("player");
												</script>
<%		ElseIf ext = "wmv" Then %>
												<embed src="/data/intro/<%=fnm%>" width="400" height="270">
<%		End If %>
											</td>
										</tr>
									</table>

								</td>
							</tr>

							<tr>
								<td height="50">&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

		</td>
	</tr>
</table>

</body>
</html>
<!-- #include virtual = "/inc/footer_pop.asp" -->