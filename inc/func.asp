<%
Response.Buffer = True													'HTML 캐싱 처리 대비
Response.Expires = 10

Session.CodePage = 65001
Response.Charset = "UTF-8"

Response.Expiresabsolute = Now() - 1
Response.AddHeader "pragma", "no-cache"
Response.AddHeader "cache-control", "Public"
Response.CacheControl = "Public"

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

Function directGo(myStr,url)											'alert message 보여준 후 url 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
'	Response.Write("	document.location.target = '_top';" &vbCr)
	Response.Write("	top.document.location.href = '"& url &"';" &vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function layerClose(myStr)												'alert message 보여준 후 layer Close
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	simsClosePopup('close');" &vbCr)
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
'--------------------------------------------------------------------------------------------------------------------------------------------------------
Function divReload()													'div 창닫고 부모화면 Reload
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	parent.document.getElementById('showimage').style.visibility='hidden'; parent.document.getElementById('overlay').style.visibility='hidden'; parent.document.location.reload();" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divAlertReload(msg)											'div 창닫고 부모화면 Reload + 경고
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""& msg &""");parent.document.getElementById('showimage').style.visibility='hidden'; parent.document.getElementById('overlay').style.visibility='hidden'; parent.document.location.reload();" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function unoAlertReload(msg)											'div 창닫고 부모화면 Reload + 경고
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""& msg &"""); simsClosePopup(); parent.document.location.reload();" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divClose(msg)													'경고 후 div 창닫기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""& msg &""");parent.document.getElementById('showimage').style.visibility='hidden'; parent.document.getElementById('overlay').style.visibility='hidden';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divCloseGo(url)												'div 창닫고 부모화면 URL 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	parent.document.getElementById('showimage').style.visibility='hidden'; parent.document.getElementById('overlay').style.visibility='hidden'; parent.document.location.href = '"& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divAlertCloseGo(msg,url)										'경고 후 div 창닫고 부모화면 URL 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""& msg &"""); parent.document.getElementById('showimage').style.visibility='hidden'; parent.document.getElementById('overlay').style.visibility='hidden'; parent.document.location.href = '"& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function divCloseopen(url)												'div 창닫고 로그인 div 띄우기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	document.location.href = '/mem/login_pp.asp?preURL="& url &"';" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function
'--------------------------------------------------------------------------------------------------------------------------------------------------------
Function db2html(checkvalue)											'일반 HTML 태그 허용 출력
	On Error resume Next
	checkvalue = Replace(checkvalue, "&amp;", "&")
	checkvalue = Replace(checkvalue, "&quot;", "'")
	checkvalue = Replace(checkvalue, "￦", "\")
	checkvalue = Replace(checkvalue, "\r\n", "<br>")
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
			Call JSalert("이 화면을 열람할 권한이 없습니다.")
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
			Call AlertGo("이 화면을 열람할 권한이 없습니다.         ","/_adm/login.asp?preURL="& pUrl)
'			Call noAlertGo("/_adm/login.asp?preURL="& pUrl)
			Response.End
		Else
			Call AlertGo("이 화면을 열람할 권한이 없습니다.         ","/_adm/login.asp?preURL="& pUrl)
			Response.End
		End If
	End If
	checkAdm = checkResult
End Function

Function TrimText(checkvalue,checknum)
	If Len(checkvalue) > checknum Then
		TrimText = Left(checkvalue,checknum) & ".."
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

Function setD(intTemp)													'자릿수 맞추기
	setD = Left(intTemp,4) &"-"& Mid(intTemp,5,2) &"-"& Right(intTemp,2)
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

Function getStat(op)													'상태설명//N-대기중/C-예약완료/Y-출조완료/K-예약대기/X-예약취소
		Select Case Trim(op)
			Case "N" : getStat = "대기중"
			Case "C" : getStat = "예약완료"
			Case "Y" : getStat = "출조완료"
			Case "K" : getStat = "예약대기"
			Case "X" : getStat = "예약취소"
		End Select
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

Function memInfo(no,op)													'회원정보추출
	If no <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _omemt010 WHERE seq = "& no
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			memInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function shipInfo(sid,op)												'선박정보
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT "& op &" FROM _oshpt010 WHERE shipid = "& sid
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			shipInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function gallInfo(sid,wdate)											'특정일자 조황갤러리 seq 추출
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	seq FROM _obbst020 WHERE shipid = "& shipid &" AND wdate = '"& wdate &"'"
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			gallInfo = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function photoInfo(pid,gubn)											'사진정보 (gubn = gallery | ps)
	Select Case gubn
		Case "gallery"		: tbl = "_obbst021"
		Case "ps"			: tbl = "_obbst051"
	End Select
	If pid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT fpath, fnm FROM "& tbl &" WHERE idx = "& pid
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			photoInfo = rs3(0) &"/"& rs3(1)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function guestCount(sid,rdate)											'해당일자 탑승자(손님) 수
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(SUM(inwon),0) FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' AND status IN ('N','C','Y') "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			guestCount		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function guestGrpCnt(sid,rdate)											'해당일자 탑승 그룹 수
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(count(*),0) FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' AND status IN ('N','C','Y','K') "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			guestGrpCnt		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function standbyCnt(sid,rdate)											'해당일자 대기예약자 수
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	ISNULL(SUM(inwon),0) FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' AND status = 'K' "
'		Response.Write "<br>"& SQL &"<br>"
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			standbyCnt		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function rsvInfo(sid,rdate,op)											'예약정보
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' "
'		Response.Write SQL &"<br>"
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			rsvInfo		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function rsvInfo3(rid,op)												'예약정보(예약번호)
	If rid <> "" Then
		Set rs5 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	"& op &" FROM _orsvt010 WHERE ridx = "& rid
'		Response.Write SQL &"<br>"
		rs5.open SQL, dbcon
		If Not rs5.eof Then
			rsvInfo3		= rs5(0)
		End If
		rs5.close
		Set rs5 = Nothing
	End If
End Function

Function rsvInfo5(sid,rdate,uno)										'예약정보
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT ridx FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' AND uno = "& uno
'		Response.Write SQL &"<br>"
		rs3.open SQL, dbcon

		If Not rs3.eof Then
			rsvInfo5		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
End Function

Function docExist(sid,rdate)											'해당일자에 독배 구분자 존재 여부
	If sid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT COUNT(*) FROM _orsvt010 WHERE shipid = "& sid &" AND rdate = '"& rdate &"' AND gubn = 'D' AND status NOT IN ('N','X') "
		rs3.open SQL, dbcon

		If Not rs3.eof Then
			docExist		= CInt(rs3(0))
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getext(op)														'파일확장자
		Select Case op
			Case 1 : getext = "bmp"
			Case 2 : getext = "gif"
			Case 3 : getext = "jpg"
			Case 4 : getext = "png"
		End Select
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

Function memPhoto(mno)													'회원 대표사진
	If mno <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	fnm FROM _omemt011 WHERE seq = "& mno &" AND best = 'Y' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			memPhoto		= "/data/mem/"& rs3(0)
		Else
			memPhoto		= "/data/noimage80.jpg"
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function payGubn(op)													'완결/미결 구분
		Select Case op
			Case "Y" : payGubn = "<font color=#cacaca>(완결)</font>"
			Case "N" : payGubn = "<font color=#dd3344>(미결)</font>"
		End Select
End Function

Function cntNoti(sid,dt)												'한줄공지 개수
	If dt <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	COUNT(*) FROM _onott010 WHERE shipid = "& sid &" AND rdate = '"& dt &"' "
'		Response.Write SQL &"<br>"
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			cntNoti		= CInt(rs3(0))
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getNoti(sid,dt)												'한줄공지
	If dt <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	seq, color, note FROM _onott010 WHERE shipid = "& sid &" AND rdate = '"& dt &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getNoti		= "<font color='"& rs3(1) &"'>"& rs3(2) &"</font>"
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

Function chkPoint(xno,op)												'사용가능한 적립금 (op = ship/talk 구분)
	If xno <> "" Then
		chkPoint = Clng(accPoint(xno,op,"+")) - Clng(accPoint(xno,op,"-"))
	End If
End Function

Function accPoint(xno,op1,op2)											'회원 적립금 계산 (op1 = ship/talk 구분 // op2 = +/-구분)
	If xno <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		If op1 = "ship" Then
			SQL = "	SELECT ISNULL(SUM(point),0) FROM _opntt020 WHERE uno = "& xno &" AND op = '"& op2 &"'"
		Else
			SQL = "	SELECT ISNULL(SUM(point),0) FROM _opntt010 WHERE uno = "& xno &" AND op = '"& op2 &"'"
		End If
		'Response.Write SQL &"<br>"
		rs3.open SQL, dbcon

		If Not rs3.eof Then
			accPoint		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getPoint(xno,idx)												'특정 출조에 대한 적립금 (xno = 회원번호 / idx = 예약번호)
	If xno <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT ISNULL(SUM(point),0) FROM _opntt020 WHERE uno = "& xno &" AND rsvid = "& idx
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getPoint		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function minusPoint(oid)												'구매시 사용한 적립금
	If oid <> "" Then
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT pnt FROM _opntt010 WHERE odr_idx = '"& oid &"' AND gubn = '-' AND LEFT(odr_idx,1) <> 'C' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			minusPoint		= rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getIcon(op)													'상태icon
	Select Case op
		Case "공지"		: getIcon = "<img src='/img/icon/notice.png' class='vm'>"
		Case "마감"		: getIcon = "<img src='/img/icon/magam1.png' class='vm'>"
		Case "정비"		: getIcon = "<img src='/img/icon/jungbi.png' class='vm'>"
		Case "탐사"		: getIcon = "<img src='/img/icon/tamsa.png' class='vm'>"
		Case Else		: getIcon = "<font class='f11 ls fc4'>"& op &"</font>"
	End Select
End Function

Function sstat(sid,dt)													'선박상태 (return 0 또는 1)
		Set rs30 = Server.CreateObject("ADODB.Recordset")
		SQL30 = " SELECT ISNULL(COUNT(*),0) FROM _oshpt020 WHERE shipid = "& sid &" AND rdate = '"& dt &"' "
		rs30.open SQL30, dbcon
			rcnt = CInt(rs30(0))
		rs30.close
		Set rs30 = Nothing

		If rcnt = 0 Then							'_oshpt020 내용이 없을때 => 기본출조 정상운행 return = 2
			sstat = 2
		Else
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = "	SELECT	note, etc FROM _oshpt020 WHERE shipid = "& sid &" AND rdate = '"& dt &"' "
			rs3.open SQL, dbcon
			If Not rs3.eof Then
				If rs3("etc") = "3" Then			'마감/정비/탐사 return = 1
					sstat = 1
				ElseIf rs3("etc") = "1" Then
					sstat = 0						'기본출조 정상운행 return = 0
				End If
			End If
			rs3.close
			Set rs3 = Nothing
		End If
End Function

Function shipStat(sid,dt)												'선박상태 (return 0 또는 1)
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL = "	SELECT note, etc FROM _oshpt020 WHERE shipid = "& sid &" AND rdate = '"& dt &"' "
			rs3.open SQL, dbcon

			If Not rs3.eof Then
				shipStat = rs3("etc") & rs3("note")
			Else
				shipStat = "0"
			End If
'Response.Write "shipStat : "& shipStat &"<br>"
			rs3.close
			Set rs3 = Nothing
End Function

Function sstat3(sid,dt,op)												'선박상태 (op = 3 이면 마감/정비/탐사 op = 1 이면 출조종류)
	If sstat(sid,dt) = 2 Then						'기본출조 출력
			sstat3 = "<font class='f11 ls fc4'>"& shipInfo(sid,"chuljo0") &"</font>"
	Else
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			SQL3 = " SELECT note, etc FROM _oshpt020 WHERE shipid = "& sid &" AND rdate = '"& dt &"' AND etc = "& op
			rs3.open SQL3, dbcon
			If Not rs3.eof Then
				sstat3 = getIcon(rs3(0))
			End If
			rs3.close
			Set rs3 = Nothing
	End If
End Function

Function getMool0(dt)													'음력일자에 따른 물때 정보추출
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE etc = '"& dt &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getMool0 = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
End Function

Function getMool1(yy,mm,dd)												'_ocodt020 물때 정보추출 (dbo7)
	If Year(Date) & Month(Date) & Day(Date) < "20141229" Then
		dbo7()
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	mtime7 FROM _ocodt020 WHERE yy = '"& yy &"' AND mm = '"& mm &"' AND dd = '"& dd &"' "
		rs3.open SQL, dbco
		If Not rs3.eof Then
			getMool1 = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
		dbc7()
	Else
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = " SELECT	mtime7 FROM mooltime WHERE yy = '"& yy &"' AND mm = '"& mm &"' AND dd = '"& dd &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getMool1 = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
	End If
End Function

Function getMool(dt)													'음력일자에 따른 물때 정보추출
	If Year(Date) & Month(Date) & Day(Date) < "20141229" Then
		dbo7()
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE etc = '"& dt &"' "
		rs3.open SQL, dbco
		If Not rs3.eof Then
			getMool = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
		dbc7()
	Else
		dbo()
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	mtime7 FROM mooltime WHERE moon = '"& dt &"' "
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			getMool = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
		dbc()
	End If
End Function

Function getMool3(yy,mm,dd)												'_ocodt020 물때 정보추출
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	mtime7 FROM _ocodt020 WHERE yy = '"& yy &"' AND mm = '"& mm &"' AND dd = '"& dd &"' "
		rs3.open SQL, dbco
		If Not rs3.eof Then
			getMool3 = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
End Function

Function suminwon(idx)													'예약인원
		Set rs3 = Server.CreateObject("ADODB.Recordset")
		SQL = "	SELECT	COUNT(*) FROM _orsvt020 WHERE ridx = "& idx
		rs3.open SQL, dbcon
		If Not rs3.eof Then
			suminwon = rs3(0)
		End If
		rs3.close
		Set rs3 = Nothing
End Function

Function calc_last_day(in_year, in_month)
	Select Case in_month
		Case 1	: calc_last_day = 31
		Case 2	:
			If (((in_year Mod 4 = 0) And (in_year Mod 100 <> 0)) Or (in_year Mod 400 = 0)) Then
				calc_last_day = 29
			Else
				calc_last_day = 28
			End If
		Case 3	: calc_last_day = 31
		Case 4	: calc_last_day = 30
		Case 5	: calc_last_day = 31
		Case 6	: calc_last_day = 30
		Case 7	: calc_last_day = 31
		Case 8	: calc_last_day = 31
		Case 9	: calc_last_day = 30
		Case 10 : calc_last_day = 31
		Case 11 : calc_last_day = 30
		Case 12	: calc_last_day = 31
	End Select
End Function

Function calc_now_week(in_now_weekday, in_day1)
	Select Case in_now_weekday
		Case 1
			calc_now_week = in_day1
			sch_day2 = in_day1 + 7
		Case 2
			calc_now_week = in_day1 - 1
			sch_day2 = in_day1 + 6
		Case 3
			calc_now_week = in_day1 - 2
			sch_day2 = in_day1 + 5
		Case 4
			calc_now_week = in_day1 - 3
			sch_day2 = in_day1 + 4
		Case 5
			calc_now_week = in_day1 - 4
			sch_day2 = in_day1 + 3
		Case 6
			calc_now_week = in_day1 - 5
			sch_day2 = in_day1 + 2
		Case 7
			calc_now_week = in_day1 - 6
			sch_day2 = in_day1 + 1
	End Select
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
		JSalert("특정 문자는 넣으실 수 없습니다. 죄송합니다.")
		Response.End
	Else
		SQLI = str
	End If
End Function

Function extcheck(note)						'extcheck = False 면 다음 동작이 취해짐
	BlackList = Array("ASP","PHP","EXE","JSP",".C","BAT","XML","ASPX","PHP3","FLA","SWF","CSS","JS")
	extcheck = False
	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			extcheck = True
			Exit For
		End If
	Next
End Function

Function blackyn(note)						'blackyn = False 면 다음 동작이 취해짐
	BlackList = Array("꽁짜","섹스","누드","음모","유명브렌드","대출","홍보대행","게임","바둑이","포커","고스톱","카지노","마카오","라이브","솔루션","poker","인생","겜","go777","입ㅅㅏ","입ㅅ ㅏ","얼ㅅㅏ","얼ㅅ ㅏ","don.ff","2 0 살","바카라","비아","그라","겅짜","캐동","ㅈ ㅣ원","잭팟","월드게임","gogem","랭키","모텔","엔조이","바다이야기","부업","viagra","남근확대","viag","경마","출주표","KRA","경-마","카­지­노","카 지 노","안마","달림가자")
	blackyn = False

	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			blackyn = True
			Exit For
		End If
	Next
End Function

Function blackFile(file)					'blackFile = False 면 다음 동작이 취해짐
	BlackFileList = Array(".asp",".php",".jsp",".asa")
	blackFile = False

	For inum = 0 To Ubound(BlackFileList)
		If InStr(1,LCase(file),BlackFileList(inum)) > 0 Then
			blackFile = True
			Exit For
		End If
	Next
End Function

Public Sub getrows()
	Set rs = dbcon.EXECUTE(SQL)
	data = Null
	If Not (rs.EOF Or rs.BOF) Then
		data = rs.GetRows()
	End If
	rs.close
End Sub

Function tagv(no)
	If tag = no Then
		tagv = setp(no) & "b"
	Else
		tagv = setp(no) & "a"
	End If
End Function

Function aspLog(value)
	Response.Write("<script language=javascript>console.log('"& value &"');</script>")
End Function

Function fnPaging(totalpage, page, pagincnt, strParam)					'get방식 페이징( 전체페이지수, 현재페이지, 페이지나열수(10으로 고정), 파라미터)
	strPaging = "" : If strParam <> "" Then strParam = "&"& strParam
	blockpage = Int((page-1)/pagincnt)*pagincnt + 1
	If blockpage > 1 Then
		strPaging = strPaging & "<a href='?page=1"& strParam &"' id=first class='btn btn18'><span>처음</span></a>"
		strPaging = strPaging & "<a href='?page="& (blockpage-pagincnt) &""& strParam &"' id=prev class='btn btn18 mr10'><span>이전</span></a>"
	End If
	i = 0
	Do Until i = pagincnt Or (blockpage + i) > totalpage
		If Int(page) = blockpage+i Then
			strPaging = strPaging & "<a href='?page="& (blockpage+i) &""& strParam &"' id=middle class='ff fb vm ls mr10'><span>"& setP(blockpage+i) &"</span></a>"
		Else
			strPaging = strPaging & "<a href='?page="& (blockpage+i) &""& strParam &"' id=middle class='ff vm ls mr10'><span>"& setP(blockpage+i) &"</span></a>"
		End If
		i = i + 1
	Loop
	if(blockpage + i - 1) < totalpage Then
		strPaging = strPaging & "<a href='?page="& (blockpage+pagincnt) &""& strParam &"' id=next class='btn btn18'><span>다음</span></a>"
		strPaging = strPaging & "<a href='?page="& totalpage &""& strParam &"' id=end class='btn btn18'><span>마지막</span></a>"
	End If
	fnPaging = strPaging
End Function
%>