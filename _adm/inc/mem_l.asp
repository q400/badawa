<!-- #include virtual = "/adm/inc/header.asp" -->

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="68" align="center" valign="top"><!-- #include virtual = "/adm/inc/top.asp" --></td>
	</tr>
	<tr>
		<td height="11"></td>
	</tr>
	<tr>
		<td align="center" valign="top">
			<table width="1040" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="176" valign="top"><!-- #include virtual = "/adm/inc/left.asp" --></td>
					<td width="10"></td>
					<td width="854" valign="top">
						<table width="854" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="854" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td><img src="/img/adm/box01.gif" width="854" height="14"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="30" class="fc2 fb">회원정렬 및 검색</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">

												<!-- 회원정렬 및 검색 시작 -->
												<table width="790" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#CCCCCC" style="border-collapse:collapse;">
													<tr>
														<td width="500" bgcolor="F4F4F4" style="padding-left:6px;">
															<input type="radio" name="src01" id="radio" value="radio" align="absmiddle">전체 &nbsp;
															<input type="radio" name="src01" id="radio" value="radio" align="absmiddle">승인 &nbsp;
															<input type="radio" name="src01" id="radio" value="radio" align="absmiddle">비승인 &nbsp;<br>
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">전체 &nbsp;
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">학생 &nbsp;
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">선생님 &nbsp;
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">학부모 &nbsp;
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">졸업생 &nbsp;
															<input type="radio" name="src02" id="radio" value="radio" align="absmiddle">일반인 &nbsp;
														</td>
														<td height="48" bgcolor="F4F4F4">
															<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="10"></td>
																	<td width="90" height="46">
																		<select name="mem_s" class="box" id="mobile" style="width:90;height=18">
																		<option value="" selected>선택</option>
																		<option value="name" >회원 이름</option>
																		<option value="id" >회원 아이디</option>
																		<option value="add" >주소</option>
																		<option value="tell01" >전화번호</option>
																		<option value="tell02" >휴대폰번호</option>
																		</select>
																	</td>
																	<td width="10"></td>
																	<td width="100"><input type="text" name="user2" maxlength="12" class="bx1" style="width:100;height:20;ime-mode:active;" align="absmiddle"></td>
																	<td width="10"></td>
																	<td width="46"><img src="/img/adm/btn_src.gif" width="46" height="22"></td>
																	<td>&nbsp;</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
												<!-- 회원정렬 및 검색 끝 -->

											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="30" class="fc2 fb">회원리스트</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="2" align="center" background="/img/adm/box03.gif">
												<table width="790" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td height="2" bgcolor="666666"></td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<table width="790" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#CCCCCC" style="border-collapse:collapse;">
													<tr>
														<td align="center">

															<!-- 회원리스트 시작 -->
															<table width="788" border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td width="30" align="center" bgcolor="f1f1f1" class="fc3 fb"><input type="checkbox" name="checkbox2" id="checkbox2"></td>
																	<td width="45" align="center" bgcolor="f1f1f1" class="fc3 fb">번호</td>
																	<td width="50" align="center" bgcolor="f1f1f1" class="fc3 fb">구분</td>
																	<td width="60" align="center" bgcolor="f1f1f1" class="fc3 fb">이름</td>
																	<td width="90" align="center" bgcolor="f1f1f1" class="fc3 fb">아이디</td>
																	<td width="96" align="center" bgcolor="f1f1f1" class="fc3 fb">연락처</td>
																	<td width="150" align="center" bgcolor="f1f1f1" class="fc3 fb">이메일</td>
																	<td width="120" align="center" bgcolor="f1f1f1" class="fc3 fb">주소</td>
																	<td width="90" align="center" bgcolor="f1f1f1" class="fc3 fb">최종로그인</td>
																	<td height="32" align="center" bgcolor="f1f1f1" class="fc3 fb">승인</td>
																</tr>
																<tr>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																	<td height="1" bgcolor="B0B0B0"></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																</tr>
																<tr>
																	<td align="center" bgcolor="f1f1f1"><input type="checkbox" name="checkbox" id="checkbox"></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">1066</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">선생님</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">서보익</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">marf815</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">010-2645-8259<br>02-354-8259</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">marf@paran.com</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">서울시 은평구 갈현..</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">2011/01/30</td>
																	<td height="40" align="center" bgcolor="f1f1f1" class="fc2">완료</td>
																</tr>
																<tr>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																	<td height="1" bgcolor="DDDDDD"></td>
																</tr>
																<tr>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																	<td height="1" bgcolor="FAFAFA"></td>
																</tr>
																<tr>
																	<td align="center" bgcolor="f1f1f1"><input type="checkbox" name="checkbox3" id="checkbox3"></td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">1065</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">학생</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">김수현</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">q400</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">010-2222-3333<br>02-354-8259</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">snuffer815@naver.com</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">서울시 은평구 역촌..</td>
																	<td align="center" bgcolor="f1f1f1" class="fc2">2011/01/30</td>
																	<td height="40" align="center" bgcolor="f1f1f1" class="fc5 fb">비승인</td>
																</tr>
															</table>
															<!-- 회원리스트 끝 -->

														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td align="center" background="/img/adm/box03.gif">
												<!-- 버튼 시작 -->
												<table width="790" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td width="62"><a href="#"><img src="/img/adm/btn_delete.gif" width="62" height="24"></a></td>
														<td width="6"></td>
														<td>&nbsp;</td>
													</tr>
												</table>
												<!-- 버튼 끝 -->
											</td>
										</tr>
										<tr>
											<td height="10" background="/img/adm/box03.gif"></td>
										</tr>
										<tr>
											<td><img src="/img/adm/box02.gif" width="854" height="14"></td>
										</tr>
									</table>
								</td>
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="50"><!-- #include virtual = "/_adm/inc/footer.asp" --></td>
	</tr>
</table>
</body>
</html>
