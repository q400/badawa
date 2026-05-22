<%
Response.Buffer = True													'HTML 캐싱 처리 대비
Response.Expires = 0
Response.Expiresabsolute = Now() - 1
Response.AddHeader "pragma", "no-cache"
Response.AddHeader "cache-control", "private"
Response.CacheControl = "no-cache"

Function JSalert(myStr)													'경고 메시지
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&"""); history.go(-1);"&vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function OnlyAlert(myStr)												'경고 메시지
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("</script>"&vbCr)
End Function

Function AlertGo(myStr,url)												'alert message 보여준 후 url 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&"""); document.location.href = '"& url &"'" &vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function noAlertGo(url)													'바로 url 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	document.location.href = '"& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function AlertSubmit(myStr,url,form)									'alert message 보여준 후 Form Submit
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	" & form &".action = '" & url &"';" &vbCr)
	Response.Write("	" & form &".submit();"&vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function AlertClose(myStr)												'경고 메시지 후 창닫기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""&myStr&"""); window.close();"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function AlertReload()													'창닫고 부모화면 Reload
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	this.window.close(); opener.document.location.reload();" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divReload()													'div 창닫고 부모화면 Reload
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	parent.document.all.showimage.style.visibility='hidden'; parent.document.all.overlay.style.visibility='hidden'; parent.document.location.reload();" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divCloseGo(url)												'div 창닫고 부모화면 URL 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	parent.document.all.showimage.style.visibility='hidden'; parent.document.all.overlay.style.visibility='hidden'; parent.document.location.href = '"& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divCloseopen(url)												'div 창닫고 로그인 div 띄우기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	document.location.href = '/mem/login_pp.asp?preURL="& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function db2html(checkvalue)											'일반 HTML 태그 허용 출력
	On Error resume Next
	checkvalue = Replace(checkvalue, "&amp;", "&")
	checkvalue = Replace(checkvalue, "&quot;", "'")
	checkvalue = Replace(checkvalue, "￦", "\")
	checkvalue = Replace(checkvalue, vbcrlf, "<br>")
	db2html = checkvalue
End Function

Function html2db(checkvalue)											'일반 HTML 태그 허용 입력
	checkvalue = Replace(checkvalue, "&", "&amp;")
	checkvalue = Replace(checkvalue, "'", "&quot;")
	checkvalue = Replace(checkvalue, "\", "￦")
	html2db = checkvalue
End Function

Function db2rawHtml(checkvalue)											'순수 HTML 출력
	On Error resume Next
	checkvalue = Replace(checkvalue, "&amp;", "&")
	checkvalue = Replace(checkvalue, "&quot;", "'")
	checkvalue = Replace(checkvalue, "￦", "\")
	db2rawHtml = checkvalue
End Function

Function rawHtml2db(checkvalue)											'순수 HTML 입력
	checkvalue = Replace(checkvalue, "&", "&amp;")
	checkvalue = Replace(checkvalue, "'", "&quot;")
	checkvalue = Replace(checkvalue, "\", "￦")
	rawHtml2db = checkvalue
End Function

Function db2Text(checkvalue)											'순수 Text 출력 (html 방지)
	On Error resume Next
	checkvalue = Replace(checkvalue, "<", "&lt;")
	checkvalue = Replace(checkvalue, ">", "&gt;")
	checkvalue = Replace(checkvalue, "&amp;", "&")
	checkvalue = Replace(checkvalue, "&quot;", "'")
	checkvalue = Replace(checkvalue, """", "")
	checkvalue = Replace(checkvalue, "￦", "\")
	checkvalue = Replace(checkvalue, vbcrlf, "<br>")
	db2Text = checkvalue
End Function

Function db2TextJ(checkvalue)											'순수 Text 출력 (html 방지 / 자바스크립트 에러방지)
	On Error resume Next
	checkvalue = Replace(checkvalue, "<", "&lt;")
	checkvalue = Replace(checkvalue, ">", "&gt;")
	checkvalue = Replace(checkvalue, "&amp;", "&")
	checkvalue = Replace(checkvalue, "&quot;", "")
	checkvalue = Replace(checkvalue, """", "")
	checkvalue = Replace(checkvalue, "￦", "\")
	checkvalue = Replace(checkvalue, vbcrlf, "<br>")
	db2TextJ = checkvalue
End Function

Function Text2db(checkvalue)											'순수 Text 입력 (html 방지)
	checkvalue = Replace(checkvalue, "&", "&amp;")
	checkvalue = Replace(checkvalue, "'", "&quot;")
	checkvalue = Replace(checkvalue, "\", "￦")
	Text2db = checkvalue
End Function

Function checkLevel(userLevel, permitLevel, pUrl)						'권한체크
	If Int(userLevel) <> 0 And Int(userLevel) <= Int(permitLevel) Then
		checkResult = True
	Else
		checkResult = False
		If Int(userLevel) = 0 Then
			Call noAlertGo("/mem/login.asp?preURL="& pUrl)
			Response.End
		Else
			Call JSalert("이 화면을 열람할 권한이 없습니다.         ")
			Response.End
		End If
	End If
	checkLevel = checkResult
End Function

Function checkAdm(userLevel, permitLevel, pUrl)							'권한체크
	If Int(userLevel) <> 0 And Int(userLevel) <= Int(permitLevel) Then
		checkResult = True
	Else
		checkResult = False
		If Int(userLevel) = 0 Then
			Call noAlertGo("/_adm/login.asp?preURL="& pUrl)
			Response.End
		Else
			Call JSalert("이 화면을 열람할 권한이 없습니다.         ")
			Response.End
		End If
	End If
	checkAdm = checkResult
End Function

Function TrimText(checkvalue,checknum)
	If Len(checkvalue) > checknum Then
		TrimText = Left(checkvalue,checknum) & "..."
	Else
		TrimText = checkvalue
	End If
End Function

Function ResizeImg(checkvalue,maxsize)
	If (checkvalue >= maxsize) Then
		ResizeImg = maxsize
	Else
		ResizeImg = checkvalue
	End If
End Function

Function setP(intTemp)													'자릿수 맞추기
	If Len(intTemp) = 1 Then
		setP = "0" & intTemp
	Else
		setP = intTemp
	End If
End Function

Function ChangeFile(file_ext)											'확장자 추출
		Select Case Trim(LCase(file_ext))
			Case "doc" : change_file = "MS워드문서"
			Case "hwp" : change_file = "한글문서"
			Case "pdf" : change_file = "pdf문서"
			Case "ppt" : change_file = "파워포인트문서"
			Case "xls" : change_file = "엑셀문서"
			Case "zip" : change_file = "zip파일"
			Case "psd" : change_file = "psd파일"
			Case "gif" : change_file = "gif파일"
			Case "jpg" : change_file = "jpg파일"
			Case "bmp" : change_file = "bmp파일"
			Case Else : change_file = "기타파일"
		End Select
		ChangeFile = change_file
		ext_img = ext_img
End function

Function getFileImg(file_ext)											'확장자 추출 - 이미지
		Select Case Trim(LCase(file_ext))
			Case "doc" : ext_img = "/img/icon/icon_doc.gif"
			Case "hwp" : ext_img = "/img/icon/icon_hwp.gif"
			Case "pdf" : ext_img = "/img/icon/icon_pdf.gif"
			Case "ppt" : ext_img = "/img/icon/icon_ppt.gif"
			Case "xls" : ext_img = "/img/icon/icon_xls.gif"
			Case "zip" : ext_img = "/img/icon/icon_zip.gif"
			Case "psd" : ext_img = "/img/icon/icon_psd.gif"
			Case "gif" : ext_img = "/img/icon/icon_gif.gif"
			Case "jpg" : ext_img = "/img/icon/icon_jpg.gif"
			Case "bmp" : ext_img = "/img/icon/icon_bmp.gif"
			Case Else : ext_img = "/img/icon/icon_file0.gif"
		End Select
		getFileImg = ext_img
End Function

Function expMang(gubn)													'판매등급설명//20-가족/40-친구/60-이웃/90-손님
		Select Case Trim(gubn)
			Case "99" : expMang = "일반"
			Case "95" : expMang = "업체(신청)"
			Case "91" : expMang = "협력사(신청)"
			Case "60" : expMang = "업체"
			Case "40" : expMang = "협력사"
			Case "9" : expMang = "일반관리자"
			Case "1" : expMang = "슈퍼관리자"
			Case Else : expMang = "기타"
		End Select
End Function

Function explainImg(gubn)												'이미지설명
		Select Case Trim(gubn)
			Case "EX1" : explainImg = "설명1"
			Case "EX2" : explainImg = "설명2"
			Case "D1" : explainImg = "첫번째500"
			Case "D190" : explainImg = "첫번째130"
			Case "D1300" : explainImg = "첫번째300"
			Case "D2" : explainImg = "두번째500"
			Case "D290" : explainImg = "두번째130"
			Case "D2300" : explainImg = "두번째300"
			Case "D3" : explainImg = "세번째500"
			Case "D390" : explainImg = "세번째130"
			Case "D3300" : explainImg = "세번째300"
			Case "D4" : explainImg = "투명이미지"
			Case "SM" : explainImg = "샘플이미지"
			Case "Y" : explainImg = "요리500"
			Case "Y90" : explainImg = "요리130"
			Case "Y300" : explainImg = "요리300"
		End Select
End Function

Function goodsImgExist(gcode,op)										'제품이미지 존재여부
	If gcode <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	file_nm FROM _ogodt021 WHERE gcode = '"& gcode &"' AND gubn = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			file_nm		= rs3("file_nm")
		End If
		rs3.close
		Set rs3 = Nothing
		If file_nm <> "" Then goodsImgExist = True Else goodsImgExist = False End If
	End If
End Function

Function goodsImg(gcode,op)												'제품이미지
	If gcode <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	file_nm FROM _ogodt021 WHERE gcode = '"& gcode &"' AND gubn = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			file_nm		= rs3("file_nm")
		End If
		rs3.close
		Set rs3 = Nothing
		If file_nm <> "" Then
			goodsImg = "/data/goods/"& file_nm
		Else
			If op = "D190" Or op = "D290" Or op = "D390" Or op = "Y90" Then
				goodsImg = "/img/shop/noimage80.jpg"
			ElseIf op = "D1300" Or op = "D2300" Or op = "D3300" Or op = "Y300" Then
				goodsImg = "/img/shop/noimage300.jpg"
			ElseIf op = "D1" Or op = "D2" Or op = "D3" Or op = "Y" Then
				goodsImg = "/img/shop/noimage500.jpg"
			ElseIf op = "EX1" Or op = "EX2" Or op = "SM" Then
				goodsImg = "/img/shop/noimage300.jpg"
			Else
				goodsImg = "/img/shop/noimage300.jpg"
			End If
		End If
	Else
			If op = "D190" Or op = "D290" Or op = "D390" Or op = "Y90" Then
				goodsImg = "/img/shop/noimage80.jpg"
			ElseIf op = "BL" Then
				goodsImg = "/img/shop/noimage80.jpg"
			ElseIf op = "D1300" Or op = "D2300" Or op = "D3300" Or op = "Y300" Then
				goodsImg = "/img/shop/noimage300.jpg"
			ElseIf op = "D1" Or op = "D2" Or op = "D3" Or op = "Y" Then
				goodsImg = "/img/shop/noimage500.jpg"
			ElseIf op = "EX1" Or op = "EX2" Or op = "SM" Then
				goodsImg = "/img/shop/noimage300.jpg"
			Else
				goodsImg = "/img/shop/noimage300.jpg"
			End If
	End If
End Function

Public Function onTel(hpnum,op)											'휴대전화번호 분할
	hplen = Len(hpnum)
	If hpnum <> "" Then
		If op = 1 Then													'국번
			onTel				= Left(hpnum,3)
		ElseIf op = 2 Then												'가운데 번호
			Select Case hplen
				Case 10 : onTel = Mid(hpnum,4,3)
				Case 11 : onTel = Mid(hpnum,4,4)
			End Select
		ElseIf op = 3 Then												'끝자리
			onTel				= Right(hpnum,4)
		End If
	End If
End Function

Public Function TelSepa(tel,op)											'일반전화번호 분할
	If tel <> "" Then
		tellen = Len(tel)
		If Left(tel,2) = "02" Then
				If op = 1 Then
					TelSepa = "02"
				ElseIf op = 2 Then
					Select Case tellen
						Case 9 : TelSepa = Mid(tel,3,3)
						Case 10 : TelSepa = Mid(tel,3,4)
					End Select
				ElseIf op = 3 Then
					TelSepa = Right(tel,4)
				End If
		ElseIf Left(tel,3) = "050" Then
				If op = 1 Then
					TelSepa = Left(tel,4)
				ElseIf op = 2 Then
					Select Case tellen
						Case 11 : TelSepa = Mid(tel,5,3)
						Case 12 : TelSepa = Mid(tel,5,4)
					End Select
				ElseIf op = 3 Then
					TelSepa = Right(tel,4)
				End If
		ElseIf Left(tel,3) = "080" Or Left(tel,3) = "070" Then
				If op = 1 Then
					TelSepa = Left(tel,3)
				ElseIf op = 2 Then
					Select Case tellen
						Case 10 : TelSepa = Mid(tel,4,3)
						Case 11 : TelSepa = Mid(tel,4,4)
					End Select
				ElseIf op = 3 Then
					TelSepa = Right(tel,4)
				End If
		Else
				If op = 1 Then
					TelSepa = Left(tel,3)
				ElseIf op = 2 Then
					Select Case tellen
						Case 10 : TelSepa = Mid(tel,4,3)
						Case 11 : TelSepa = Mid(tel,4,4)
					End Select
				ElseIf op = 3 Then
					TelSepa = Right(tel,4)
				End If
		End If
	End If
End Function

Function memInfo(uid,op)												'회원정보추출
	If uid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _omemt010 WHERE uid = '"& uid &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			memInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function goodsInfo(gcode,op)											'제품정보
	If gcode <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT "& op &" FROM _ogodt020 WHERE gcode = '"& gcode &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			goodsInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function orderInfo(oid,op)												'주문정보
	If oid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _obuyt010 WHERE odr_idx = '"& oid &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			orderInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function payInfo(op,vw)													'결제방식
	If vw = 1 Then
		Select Case op
			Case "Card" : payInfo = "<font color=#993399>신용카드 (안심클릭)</font>"
			Case "VCard" : payInfo = "<font color=#993399>신용카드 (ISP)</font>"
			Case "VBank" : payInfo = "<font color=#993399>무통장입금</font>"
			Case "DirectBank" : payInfo = "<font color=#993399>무통장입금</font>"
		End Select
	ElseIf vw = 3 Then
		Select Case op
			Case "Card" : payInfo = "<font color=#bb5555>카드</font>"
			Case "VCard" : payInfo = "<font color=#bb5555>카드</font>"
			Case "VBank" : payInfo = "<font color=#5555bb>무통장</font>"
			Case "DirectBank" : payInfo = "<font color=#5555bb>무통장</font>"
		End Select
	Else
		Select Case op
			Case "Card" : payInfo = "<font color=#993399>신용카드<br>(안심클릭)</font>"
			Case "VCard" : payInfo = "<font color=#993399>신용카드<br>(ISP)</font>"
			Case "VBank" : payInfo = "<font color=#993399>무통장입금</font>"
			Case "DirectBank" : payInfo = "<font color=#993399 style='letter-spacing:-1;'>무통장입금</font>"
		End Select
	End If
End Function

Function statusInfo(op)													'주문상태정보
		Select Case op
			Case "S" : statusInfo = "<font color=#999999>주문접수</font>"
			Case "R" : statusInfo = "<font color=#bd8d8d>준비중</font>"
			Case "I" : statusInfo = "<font color=#df6510>배송중</font>"
			Case "Y" : statusInfo = "<font color=#77cc77>주문취소중</font>"
			Case "X" : statusInfo = "<font color=red>주문취소</font>"
			Case "C" : statusInfo = "<font color=#dddddd>구매완료</font>"
			Case "D" : statusInfo = "<font color=#ccccff>삭제</font>"
		End Select
End Function

Function getext(op)														'파일확장자
		Select Case op
			Case 1 : getext = "bmp"
			Case 2 : getext = "gif"
			Case 3 : getext = "jpg"
			Case 4 : getext = "png"
		End Select
End Function

Function deliveryInfo(oid,col)											'배송상태정보(관리자)
	If oid <> "" Then
		If OVE_AUTH < 10 Then
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = "	SELECT	"& col &" FROM _obuyt012 WHERE odr_idx = '"& oid &"' "
			rs3.open SQL, dbcon
			While Not rs3.eof
				deliveryInfo	= rs3(0)
				rs3.MoveNext
			Wend
			rs3.close
			Set rs3 = Nothing
		Else
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = "	SELECT	"& col &" FROM _obuyt012 WHERE odr_idx = '"& oid &"' AND seller = '"& OVE_ID &"' "
			rs3.open SQL, dbcon
			If Not rs3.eof Then
				deliveryInfo	= rs3(0)
			End If
			rs3.close
			Set rs3 = Nothing
		End If
	End If
End Function

Function zoneInfo(zone)													'관할지역정보
	If zone <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	code1, code2, code3 FROM _ocodt010 WHERE code3 = '"& zone &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			zoneInfo	= rs3("code1") &" "& rs3("code2")
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function cateInfo0(cate)												'카테고리이름
	If cate <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	code_nm FROM _ogodt010 WHERE code1 = "& cate
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cateInfo0	= rs3("code_nm")
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function cateInfo(cate,op)												'카테고리정보
	If cate <> "" Then
		If op = 1 Then
			SQL0 = " SELECT	code_nm FROM _ogodt010 WHERE LEN(code1) = 2 AND code1 = "& Left(cate,2)
		ElseIf op = 2 Then
			SQL0 = " SELECT	code_nm FROM _ogodt010 WHERE LEN(code1) = 4 AND code1 = "& Left(cate,4)
		ElseIf op = 3 Then
			SQL0 = " SELECT	code_nm FROM _ogodt010 WHERE LEN(code1) = 6 AND code1 = "& Left(cate,6)
		End If
		Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = SQL0
			rs3.open SQL, dbcon
			If Not rs3.eof Then
				cateInfo	= rs3("code_nm")
			End If
			rs3.close
			Set rs3 = Nothing
	End If
End Function

Function categoryCnt(cate)												'카테고리수(2차)
	If cate <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _ogodt010 WHERE LEFT(code1,2) = '"& cate &"' AND LEN(code1) = 4 "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			categoryCnt	= rs3(0)
		End If
		Set rs3 = Nothing
	End If
End Function

Function goodsCnt(cate)													'등록상품수
	If cate <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _ogodt024 WHERE category = '"& cate &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			goodsCnt	= rs3(0)
		End If
		Set rs3 = Nothing
	End If
End Function

Function goodsGroupCnt(cate)											'그룹상품수
	If cate <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _ogodt024 WHERE category LIKE '"& cate &"%' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			goodsGroupCnt	= rs3(0)
		End If
		Set rs3 = Nothing
	End If
End Function

Function thumbinfo(sseq,op,nn)
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		If nn = "Y" Then
			SQL = " SELECT "& op &" FROM _obbst011 WHERE seq = "& sseq &" AND thumb = 'Y' "
		Else
			SQL = " SELECT "& op &" FROM _obbst011 WHERE seq = "& sseq &" AND thumb = 'N' "
		End If
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			thumbinfo		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
End function

Function bbsCnt(gcode,op)												'게시물수
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		Select Case op
			Case "after" :
				SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst020 WHERE gcode = '"& gcode &"' "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					bbsCnt		= rs3(0)
				End If
			Case "qna" :
				SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst010 WHERE gcode = '"& gcode &"' "
				rs3.open SQL, dbcon
				If Not rs3.eof Then
					bbsCnt		= rs3(0)
				End If
		End Select
		Set rs3 = Nothing
End Function

Function delImage(gcode,op)												'실제경로 파일 지우기
	If gcode <> "" Then
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = " SELECT	* FROM _ogodt021 WHERE gcode = '"& gcode &"' AND gubn = '"& op &"' "
			rs3.open SQL, dbcon, 3
			If Not rs3.eof Then					'실제 경로 파일 지우기
				Set fs = Server.CreateObject("Scripting.FileSystemObject")
				While Not rs3.eof
						If fs.FileExists(Server.MapPath("/data/goods") & "\" & rs3("file_nm")) Then
							fs.DeleteFile Server.MapPath("/data/goods") & "\" & rs3("file_nm"), True
						End If
					rs3.MoveNext
				Wend
				Set fs = Nothing
			End If
			Set rs3 = Nothing
			SQL = " DELETE FROM _ogodt021 WHERE gcode = '"& gcode &"' AND gubn = '"& op &"' "
			dbcon.Execute SQL
	End If
End Function

Function cateDepth(cate0)												'카테고리 깊이산출
	If cate0 <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(MAX(LEN(code1)),0) FROM _ogodt010 WHERE code1 LIKE '"& cate0 &"%' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cateDepth		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
		'cateDepth = 4 이면 2차
		'cateDepth = 6 이면 3차
	End If
End Function

Function newCnt(tblnm,colmn,op)											'신규게시물
	Set rs3 = Server.CreateObject("ADODB.Recordset")
	If tblnm = "_obbst060" Then
		If colmn = "60" Then				'자유게시판
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst060 WHERE bbs_id = "& colmn &" AND DATALENGTH(answer) = 0 "
		ElseIf colmn = "65" Then			'회원게시판
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst060 WHERE bbs_id = "& colmn &" AND ddate > DATEADD(d,-2,'"& Date &"') "
		ElseIf colmn = "69" Then			'작업게시판
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst060 WHERE bbs_id = "& colmn &" AND ddate > DATEADD(d,-2,'"& Date &"') "
		End If
	ElseIf tblnm = "_obbst020" Then
		If colmn = "75" Then				'상품문의
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst020 WHERE bbs_id = "& colmn &" AND DATALENGTH(answer) = 0 "
		End If
	ElseIf tblnm = "_obbst010" Then
		If colmn = "80" Then				'문의게시판
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst010 WHERE bbs_id = "& colmn &" AND gubn <> 'N' AND DATALENGTH(answer) = 0 "
		End If
		If colmn = "85" Then				'문화센터Q&A
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obbst010 WHERE bbs_id = "& colmn &" AND DATALENGTH(answer) = 0 "
		End If
	ElseIf tblnm = "_obuyt010" Then
		If colmn = "" Then
			SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obuyt010 WHERE status = '"& op &"' "
		End If
	ElseIf tblnm = "_omemt010" Then
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _omemt010 WHERE "& colmn &" IN ("& op &") "
	ElseIf tblnm = "_omemt030" Then
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _omemt030 WHERE "& colmn &" = '"& op &"' "
	ElseIf tblnm = "_ommot010" Then
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _ommot010 WHERE "& colmn &" = '"& op &"' AND chk = 'N' "
	ElseIf tblnm = "전체회원수" Then
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _omemt010 "
	End If
	rs3.open SQL, dbcon
	newCnt		= rs3(0)
	rs3.close
	Set rs3 = Nothing
	If tblnm = "전체회원수" Then
		newCnt = "<b class=txt61>"& FormatNumber(newCnt,0) &"</b>"
	Else
		If colmn = "20" Then
			If newCnt <> 0 Then newCnt = "<b style='color:#ff6722;'>"& newCnt &"</b>" Else newCnt = 0
		Else
			If newCnt <> 0 Then newCnt = "<b class=txt61>ㆍ"& newCnt &"</b>" Else newCnt = ""
		End If
	End If
End Function

Function payGubn(op)													'완결/미결 구분
		Select Case op
			Case "Y" : payGubn = "<font color=#cacaca>(완결)</font>"
			Case "N" : payGubn = "<font color=#dd3344>(미결)</font>"
		End Select
End Function

Function getRegion(op)													'지역명
	If op <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	code1, code2, code3, code4 FROM _ocodt010 WHERE code3 = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getRegion		= rs3(0) &" "& rs3(1)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function sendSMS()														'문자발송(시간차)
		If Hour(Now) < 1 Then
			sendSMS = "DateAdd(hh,8,getdate())"
		ElseIf Hour(Now) < 2 Then
			sendSMS = "DateAdd(hh,7,getdate())"
		ElseIf Hour(Now) < 3 Then
			sendSMS = "DateAdd(hh,6,getdate())"
		ElseIf Hour(Now) < 4 Then
			sendSMS = "DateAdd(hh,5,getdate())"
		ElseIf Hour(Now) < 5 Then
			sendSMS = "DateAdd(hh,4,getdate())"
		ElseIf Hour(Now) < 6 Then
			sendSMS = "DateAdd(hh,3,getdate())"
		ElseIf Hour(Now) < 7 Then
			sendSMS = "DateAdd(hh,2,getdate())"
		ElseIf Hour(Now) < 8 Then
			sendSMS = "DateAdd(hh,1,getdate())"
		ElseIf Hour(Now) > 20 And Hour(Now) <= 22 Then
			sendSMS = "DateAdd(hh,11,getdate())"
		ElseIf Hour(Now) > 22 And Hour(Now) <= 24 Then
			sendSMS = "DateAdd(hh,9,getdate())"
		Else
			sendSMS = "getdate()"
		End If
End Function

Function getSeller(op)													'협력사명
	If op <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	etc FROM _ocodt020 WHERE gubn = '협력사' AND code_nm = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getSeller		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function sumPurchase(oid,op)											'거래완료된 회원 구매금액
	If oid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(SUM("& op &"),0) FROM _obuyt010 WHERE uid = '"& oid &"' AND status = 'C' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			sumPurchase		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getPoint(uid,vvalue)											'주문금액에 따른 적립금액
	If uid <> "" Then
		Select Case meminfo(uid,"mem_type")
			Case 90 : getPoint = vvalue * 0.02
			Case 60 : getPoint = vvalue * 0.03
			Case 40 : getPoint = vvalue * 0.04
			Case 20 : getPoint = vvalue * 0.05
			Case Else : getPoint = 0
		End Select
	End If
End Function

Function chkPoint(oid)													'사용가능한 적립금
	If oid <> "" Then
		chkPoint = accPoint(oid,"+") - accPoint(oid,"-")
	End If
End Function

Function accPoint(xid,op)												'회원 적립금 계산 (+/-구분)
	If xid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(SUM(pnt),0) FROM _opntt010 WHERE uid = '"& xid &"' AND gubn = '"& op &"' AND LEFT(odr_idx,1) <> 'C' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			accPoint		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function minusPoint(oid)												'구매시 사용한 적립금
	If oid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	pnt FROM _opntt010 WHERE odr_idx = '"& oid &"' AND gubn = '-' AND LEFT(odr_idx,1) <> 'C' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			minusPoint		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function cntBuy(xid,op)													'회원구매횟수
	If xid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obuyt010 WHERE uid = '"& xid &"' AND status = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cntBuy			= rs3(0)
			If cntBuy = 0 Then cntBuy = "" Else cntBuy = cntBuy &" 회"
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function accBuyDate(xid,oid)											'현재구매일자 - 이전구매일자
	If xid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")				'이전구매
		SQL = "	SELECT	TOP 1 ddate2 FROM _obuyt010 WHERE uid = '"& xid &"' AND status = 'C' AND odr_idx <> '"& oid &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			lastbuydate		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing

		Set rs4 = Server.CreateObject("ADODB.Recordset")				'현재구매
		SQL = "	SELECT	ddate1 FROM _obuyt010 WHERE uid = '"& xid &"' AND odr_idx = '"& oid &"' "
		rs4.open SQL, dbcon
		If Not rs4.eof Then
			nowbuydate		= rs4(0)
		End If
		rs4.close
		Set rs4 = Nothing

		accBuyDate = DateDiff("d",lastbuydate,nowbuydate)
	End If
End Function

Function cntCoupon(xid,op)												'회원보유쿠폰
	If xid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _opntt010 WHERE uid = '"& xid &"' AND LEFT(odr_idx,1) = 'C' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cntCoupon		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function cntOption(gcode)												'상품옵션수
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _ogodt023 WHERE gcode = '"& gcode &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cntOption		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
		If cntOption = 0 Then cntOption = "" Else cntOption = cntOption
End Function

Function orderStatus(uid,op)											'특정 user 주문상태
	If uid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(COUNT(*),0) FROM _obuyt010 WHERE uid = '"& uid &"' AND status = '"& op &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			orderStatus = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function chkWord(Str)													'문자열 검열
'	str = Replace(str,"&","&amp;")
	str = Replace(str,"""","&quot;")'chr(34)
	str = Replace(str,"'","&#039;")
'	str = Replace(str,"<","&lt;")
'	str = Replace(str,">","&gt;")
	chkWord = Str
End Function

Function html0(doc)
	pattern0 = "[^가-힣 ]"
	Set crex = new regexp
	crex.pattern = pattern0
	crex.ignorecase = True
	crex.global = True
	html0 = crex.Replace(doc,"")
	Set crex = Nothing
End Function

Function SQLI(str)														'SQL Injection 막기
	val = UCase(str)
	If	InStr(val, "'") <> 0 Or _
		InStr(val, "--") <> 0 Or _
		InStr(val, "/*") <> 0 Or _
		InStr(val, "*/") <> 0 Or _
		InStr(val, "XP_") <> 0 Or _
		InStr(val, "DECLARE") <> 0 Or _
		InStr(val, "UNION") <> 0 Or _
		InStr(val, "SELECT") <> 0 Or _
		InStr(val, "UPDATE") <> 0 Or _
		InStr(val, "DELETE") <> 0 Or _
		InStr(val, "INSERT") <> 0 Or _
		InStr(val, "SHUTDOWN") <> 0 Or _
		InStr(val, "SP_") <> 0 Or _
		InStr(val, "@VARIABLE") <> 0 Or _
		InStr(val, "EXEC") <> 0 Or _
		InStr(val, "SYSOBJECT") <> 0 Or _
		InStr(val, "TRUNCATE") <> 0 Or _
		InStr(val, "1=1") <> 0 Or _
		InStr(val, " OR") <> 0 Or _
		InStr(val, " AND") <> 0 Or _
		InStr(val, "<SCRIPT") <> 0 Or _
		InStr(val, "</SCRIPT>") <> 0 Or _
		InStr(val, "DROP") <> 0 Then
		JSalert("특정 문자는 넣으실 수 없습니다. 죄송합니다.        ")
		Response.End
	Else
		SQLI = str
	End If
End Function

Function extcheck(note)													'extcheck = False 면 다음 동작이 취해짐
	BlackList = Array("ASP","PHP","EXE","JSP",".C","BAT","XML","ASPX","PHP3","FLA","SWF","CSS","JS")
	extcheck = False
	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			extcheck = True
			Exit For
		End If
	Next
End Function

Function blackyn(note)													'blackyn = False 면 다음 동작이 취해짐
	BlackList = Array("꽁짜","섹스","누드","음모","유명브렌드","대출","홍보대행","게임","바둑이","포커","고스톱","poker","인생","겜","go777","입ㅅㅏ","입ㅅ ㅏ","얼ㅅㅏ","얼ㅅ ㅏ","don.ff","2 0 살","바카라","비아","그라","겅짜","캐동","ㅈ ㅣ원","잭팟","월드게임","gogem","랭키","모텔","엔조이","바다이야기","부업","viagra","남근확대","viag")
	blackyn = False

	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			blackyn = True
			Exit For
		End If
	Next
End Function

Function fnPaging(totalpage, page, pagincnt, strParam)					'get방식 페이징( 전체페이지수, 현재페이지, 페이지나열수(10으로 고정), 파라미터)
	strPaging = "" : If strParam <> "" Then strParam = "&"& strParam
	blockpage = Int((page-1)/pagincnt)*pagincnt + 1
	If blockpage > 1 Then
		strPaging = strPaging & "<a href='?page=1"& strParam &"' id=first class='btn btn18'><span>처음으로</span></a>"
		strPaging = strPaging & "<a href='?page="& (blockpage-pagincnt) &""& strParam &"' id=prev class='btn btn18'><span>이전</span></a>"
	End If
	i = 0
	Do Until i = pagincnt Or (blockpage + i) > totalpage
		strPaging = strPaging & "<a href='?page="& (blockpage+i) &""& strParam &"' id=middle class='btn btn18'><span>"& setP(blockpage+i) &"</span></a>"
		i = i + 1
	Loop
	if(blockpage + i - 1) < totalpage Then
		strPaging = strPaging & "<a href='?page="& (blockpage+pagincnt) &""& strParam &"' id=next class='btn btn18'><span>다음</span></a>"
		strPaging = strPaging & "<a href='?page="& totalpage &""& strParam &"' id=end class='btn btn18'><span>마지막</span></a>"
	End If
	fnPaging = strPaging
End Function
%>