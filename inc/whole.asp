<!--METADATA type="typelib" file="c:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->
<%
'============================================================================================================================
'	File Name		:	/inc/whole.asp
'-----------------------------------------------------------------------------------------------------------------------------
'	Service Name	:	공통
'	Description		:	공통-기본함수
'	Create Date		:	2012년 02월 03일
'	Author			:	유재인
'-----------------------------------------------------------------------------------------------------------------------------
'	History			:	[2011.11.0] [유재인] -
'=============================================================================================================================


'-----------------------------------------------------------------------------------------------------------------------------
'--	자주사용 되는 변수 설정
DIM ix ,jx ,result ,returnUrl
DIM Cmd ,data

'-----------------------------------------------------------------------------------------------------------------------------
'--	DB 연결 Connection
PUBLIC SUB sbDbConn()
	SET dbCon			= Server.CreateObject("ADODB.CONNECTION")
	dbCon.Open dbStr
	SET Rs	= Server.CreateObject("ADODB.RECORDSET")
	SET Cmd	= Server.CreateObject("ADODB.COMMAND")
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	열어준 Rs , Cmd , dbConn 모두 닫기
PUBLIC SUB sbDbClose()
	dbCon.Close
	SET Rs		= NOTHING
	SET Cmd 	= NOTHING
	SET dbCon	= NOTHING
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	DB 연결 DEXT용
PUBLIC SUB sbDbConnDext()
	SET dbCon	= Server.CreateObject("ADODB.CONNECTION")
	SET uForm	= Server.CreateObject("DEXT.FileUpload")
	SET uImg	= Server.CreateObject("DEXT.ImageProc")
	SET Rs		= Server.CreateObject("ADODB.RECORDSET")
	SET Cmd		= Server.CreateObject("ADODB.COMMAND")
	dbCon.Open dbStr
	uForm.DefaultPath	= Server.MapPath(cfgRootUp)
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	열어준 Rs , Cmd , dbConn 모두 닫기 DEXT용
PUBLIC SUB sbDbCloseDext()
	dbCon.Close
	SET Rs		= NOTHING
	SET Cmd 	= NOTHING
	SET upImg	= NOTHING
	SET upForm	= NOTHING
	SET dbCon	= NOTHING
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	arr data
PUBLIC FUNCTION fnArrVal(str)
	IF NOT(IsNull(str) OR str = "") THEN
		str = str & "`"
	END IF
	fnArrVal = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	data getrows
PUBLIC SUB sbRsGetrows()
	SET Rs = Cmd.EXECUTE()
	data = NULL
	IF NOT (Rs.EOF OR Rs.BOF) THEN
		data = Rs.GetRows()
	END IF
	Rs.Close
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	data getrows
PUBLIC SUB sbRsSqlGetrows()
	SET Rs = DbCon.EXECUTE(SQL)
	data = NULL
	IF NOT (Rs.EOF OR Rs.BOF) THEN
		data = Rs.GetRows()
	END IF
	Rs.Close
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	오류 발생시 ajax 반환할 jSon 내용 출력
PUBLIC SUB sbErrAjax()
	str = "{""ck"":{""rs"":""false"",""err"":""true"",'errNum':'" & Err.Number & "'"
	str = str & ",""errMsg"":""" &Err.Description & """"
'	str = str & ",""errSoc"":""" & fnEncode(Err.Source) & """"
'	str = str & ",""errDbNum"":""" & fnEncode(Err.NativeError) & """"
'	str = str & ",""errFile"":""" & fnEncode(Err.HelpContext) & """"
	str = str & "}}"
	Response.Write str
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	프로시저에 넘겨줄 변수값 NULL 처리
PUBLIC FUNCTION fnValNull(str)
	IF IsNull(str) OR str = "" THEN
		str = NULL
	END IF
	fnValNull = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	빈값체크
PUBLIC FUNCTION fnBlankBool(str)
	result = FALSE
	IF IsNull(str) OR str = "" THEN
		result = TRUE
	END IF
	fnBlankBool = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	날짜 Format
PUBLIC FUNCTION fnDateYMD(str ,format)
	SELECT CASE format
		CASE "YY-MM-DD"
			str = Left(str ,10)
		CASE "YY.MM.DD"
			str = Replace(Left(str ,10) ,"-" ,".")
		CASE "YY-MM-DD h:m:s"
			str = Left(str ,19)
		CASE "YY.MM.DD h:m:s"
			str = Replace(Left(str ,19) ,"-" ,".")
		CASE "YY.MM.DD h.m.s"
			str = Replace(Replace(Left(str ,19) ,"-" ,".") ,":" ,".")
	END SELECT
	fnDateYMD = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	0 보다 작을때 0x 형태로...
PUBLIC FUNCTION fnStr10(str)
	IF CInt(str) < 10 THEN
		str = "0" & str
	END IF
	fnStr10 = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	주민등록번호로 나이추출
PUBLIC FUNCTION fnRrnAge(str)
	result		= CStr(datepart("yyyy",Now()) - (1900 + CInt(Left(str ,2))) + 1)
	fnRrnAge	= result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	주민등록번호로 성별추출
PUBLIC FUNCTION fnRrnSex(str)
	result	= "0"
	str		= MID(str ,8 ,1)
	IF CStr(str) = "1" OR CStr(str) = "3" THEN
		result = "1"
	END IF
	fnRrnSex = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	결혼유무 텍스트변환
PUBLIC FUNCTION fnMarriedText(str)
	IF LCase(str) = "true" THEN
		result = "기혼"
	ELSE
		result = "미혼"
	END IF
	fnMarriedText = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	성별 텍스트변환
PUBLIC FUNCTION fnSexText(str)
	IF LCase(str) = "true" THEN
		result = "남성"
	ELSE
		result = "여성"
	END IF
	fnSexText = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	문자열 길이 줄임
PUBLIC FUNCTION fnLeftCutLen(strString ,intCut)
	DIM intPos ,chrTemp ,strCut ,intLength
	intLength	= 0
	intPos		= 1
	DO WHILE (Len(strString) >= intPos)
		chrTemp = ASC(MID(strString ,intPos ,1))
		IF chrTemp < 0 THEN
			strCut = strCut & MID(strString ,intPos ,1)
			intLength = intLength + 2
		ELSE
			strCut = strCut & MID(strString ,intPos ,1)
			intLength = intLength + 1
		END IF
		IF intLength >= intCut THEN
			strCut = strCut & "..."
			EXIT DO
		END IF
		intPos = intPos + 1
	LOOP
	fnLeftCutLen = strCut
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'-- 인젝션 FORM
PUBLIC FUNCTION fnRqFm(fd)
	str = Trim(Request.Form(fd) & "")
	IF fnBlankBool(str) THEN
		str = NULL
	ELSE
		fnInjection(str)
	END IF
	fnRqFm = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'-- 인젝션 DEXT
PUBLIC FUNCTION fnUpFm(fd)
	str = Trim(uForm(fd) & "")
	IF fnBlankBool(str) THEN
		str = NULL
	ELSE
		fnInjection(str)
	END IF
	fnUpFm = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'-- 인젝션 QueryString
PUBLIC FUNCTION fnRqQs(fd)
	str = Trim(Request.QueryString(fd & ""))
	IF fnBlankBool(str) THEN
		str = NULL
	ELSE
		fnInjection(str)
	END IF
	fnRqQs = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'-- 인젝션 Replace
PUBLIC FUNCTION fnInjection(str)
	DIM txtMid
	str = Replace(str ,"-" ,"&#45;")
	str = Replace(str ,"""" ,"&#34;")
	str = Replace(str ,"'" ,"&#39;")
	str = Replace(str ,";" ,"&#1;")
	str = Replace(str ,"@" ,"&#64;")
	str = Replace(str ,"%" ,"&#37;")
'		InStr(val, "/*") <> 0 Or _
'		InStr(val, "*/") <> 0 Or _
'		InStr(val, "XP_") <> 0 Or _
'		InStr(val, "DECLARE") <> 0 Or _
'		InStr(val, "UNION") <> 0 Or _
'		InStr(val, "SELECT") <> 0 Or _
'		InStr(val, "UPDATE") <> 0 Or _
'		InStr(val, "DELETE") <> 0 Or _
'		InStr(val, "INSERT") <> 0 Or _
'		InStr(val, "SHUTDOWN") <> 0 Or _
'		InStr(val, "SP_") <> 0 Or _
'		InStr(val, "@VARIABLE") <> 0 Or _
'		InStr(val, "EXEC") <> 0 Or _
'		InStr(val, "SYSOBJECT") <> 0 Or _
'		InStr(val, "TRUNCATE") <> 0 Or _
'		InStr(val, "1=1") <> 0 Or _
'		InStr(val, " OR") <> 0 Or _
'		InStr(val, " AND") <> 0 Or _
	If InStr(LCase(str), "<script") > 0 then
		txtMid = Mid(str, InStr(LCase(str), "<script"), 7)
		str = Replace(str ,ReplaceCode ,"&lt;script")
		txtMid = Mid(RQ, InStr(LCase(RQ), "</script"), 7)
		str = Replace(str ,ReplaceCode ,"&lt;/script")
		txtMid = ""
	End If
	If InStr(UCase(str), "DECLARE") > 0 Then
		txtMid = Mid(str, InStr(UCase(str), "DECLARE"), 7)
		str = Replace(str, ReplaceCode, "&#68;eclare")
		txtMid = ""
	End If
	If InStr(UCase(str), "DELETE") > 0 Then
		txtMid = Mid(str, InStr(UCase(str), "DELETE"), 6)
		str = Replace(str, ReplaceCode, "&#68;ele&#116;e")
		txtMid = ""
	End If
	If InStr(UCase(str), "UPDATE") > 0 Then
		txtMid = Mid(str, InStr(UCase(str), "UPDATE"), 6)
		str = Replace(str, ReplaceCode, "up&#68;a&#116;e")
		txtMid = ""
	End If
	If InStr(UCase(str), "INSERT") > 0 Then
		txtMid = Mid(str, InStr(UCase(str), "INSERT"), 6)
		str = Replace(str, ReplaceCode, "inser&#116;")
		txtMid = ""
	End If
	fnInjection = str
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	이메일발송
PUBLIC SUB sbEmailCDOSend(fromUrl ,toUrl ,subject ,content)
	DIM objMail ,configMail
	SET objMail		= Server.CreateObject("CDO.Message")
	SET configMail	= Server.CreateObject("CDO.Configuration")
	DIM path	: path = "http://schemas.microsoft.com/cdo/configuration/"
	WITH configMail.Fields
		.Item(path & "sendusing")		= 1
		.Item(path & "smtpserver")		= cfgSmtpIp
		.Item(path & "smtpserverport")	= 25
		.Update
	END WITH
	objMail.Configuration = configMail

	WITH objMail
		.From		= fromUrl
		.To			= toUrl
		.Subject	= subject
		.HTMLBody	= content
		.HTMLBodyPart.Charset	= "ks_c_5601-1987"
		.HTMLBodyPart.Charset	= "ks_c_5601-1987"
		.Send
	END WITH
	SET configEmail = NOTHING
	SET objMail = NOTHING
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	인증번호 생성
PUBLIC FUNCTION qCodeCreate(lens ,str)
	CONST arrStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	DIM nCount ,sRet ,nNumber ,nLength

	RANDOMIZE
	IF str = "" THEN
		str = arrStr
	END IF

	nLength = Len(str)

	FOR nCount = 1 TO lens
		nNumber = Int((nLength * Rnd) + 1)
		sRet = sRet & Mid(str ,nNumber ,1)
	NEXT

	qCodeCreate = sRet
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	페이징
PUBLIC FUNCTION get_pagelist_js(ByVal page, ByVal pageSize, ByVal PageShowCount, ByVal AllCount,ByVal l_img,ByVal r_img, ByVal fnc_script )
		Dim i
		Dim PageStr : pageStr = ""
		Dim PageStart, PageEnd, pageCountAll
		Dim textsearchcode,textsearch,ccn,term_start,term_end

IF IsNull(page) OR page < 0 OR page = "" THEN
	page = 1
END IF
IF IsNull(pagesize) OR pagesize < 0 OR pagesize = "" THEN
	pagesize = 15
END IF

		PageStart  = Int((page - 1) / PageShowCount) * PageShowCount + 1
		PageEnd = PageShowCount + PageStart - 1
		pageCountAll = int(AllCount / pageSize)


		If ( int(AllCount / pageSize) < PageEnd) Then
			If (int(AllCount mod pageSize) >  0) then
				pageCountAll = pageCountAll + 1
				PageEnd = pageCountAll
			else
				PageEnd = pageCountAll
			End if
		End If

		If  Not(PageEnd = 1 Or PageEnd = 0) Then
			If pageStart > 1 Then

				PageStr = PageStr & "<a href='" & fnc_script & "&pn=" & pageStart-1 & "' class=""listMove moveOn""><img alt=""이전"" src=""/web/images/button/h15_wht_prev.gif"" /></a>"
				'PageStr = PageStr & "<a href='#none' onclick='"&Replace(fnc_script,"#page#",1)&"'>"&l_img&"</a>"
				'PageStr = PageStr & "<a href='#none' onclick='"&Replace(fnc_script,"#page#",pageStart-1)&"'><span style='letter-spacing:0px;'>이전10개</span></a>"
			Else
				PageStr = PageStr & "<a class=""listMove moveOff"">" & l_img & "<img alt=""이전"" src=""/web/images/button/h15_wht_prev_.gif"" /></a>"
			End if

	'		PageStr = PageStr & "<span>&#124;</span>"
			For i = PageStart To PageEnd
				If Int(page) = i Then
					PageStr = PageStr & "<a class='on'>" & i & "</a>"
				Else
					PageStr = PageStr & "<a href='" & fnc_script & "&pn=" & i & "'>" & i & "</a>"
'					PageStr = PageStr & "<a href='#none' onclick='"&Replace(fnc_script,"#page#",i)&"'>" & i & "</a>"
				End If
				'	PageStr = PageStr & "<span>&#124;</span>"
			Next

			if PageEnd < pageCountAll Then
				'PageStr = PageStr & "<a href='#none' onclick='"&Replace(fnc_script,"#page#",i)&"'><span style='letter-spacing:0px;'>다음 10개</span></a>"
				PageStr = PageStr & "<a href='" & fnc_script & "&pn=" & i & "' class=""listMove moveOn""'><img alt=""다음"" title="""" src=""/web/images/button/h15_wht_next.gif"" /></a>"
			'	PageStr = PageStr & "<a href='#none' onclick='"&Replace(fnc_script,"#page#",pageCountAll+1)&"'>"&r_img&"</a>"
			Else
				PageStr = PageStr & "<a class=""listMove moveOff""'><img alt=""다음"" title="""" src=""/web/images/button/h15_wht_next_.gif"" /></a>"
			End If
		End if
			get_pagelist_js = pageStr
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	이용권한 부족 JavaScript
PUBLIC SUB sbNoLevel(url)
	WITH Response
		.Write "<script type=""text/javascript"">" & vbCrLf
		.Write "//<![CDATA[" & vbCrLf
		.Write "alert(""이용권한이 부족 합니다.\n\n관리자에게 문의 하세요."");" & vbCrLf
		.Write "window.location.href = """ & url & """;" & vbCrLf
		.Write "//]]>" & vbCrLf
		.Write "</script>" & vbCrLf
	END WITH
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	이용권한 부족 JavaScript
PUBLIC SUB sbAlertRplace(url ,txt)
	WITH Response
		.Write "<script type=""text/javascript"">" & vbCrLf
		.Write "//<![CDATA[" & vbCrLf
		.Write "alert('" & txt & "');" & vbCrLf
		.Write "window.location.replace('" & url & "');" & vbCrLf
		.Write "//]]>" & vbCrLf
		.Write "</script>" & vbCrLf
	END WITH
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	URLEncode : 추후 변경을 손쉽게 하기 위해 전체 설정
PUBLIC FUNCTION fnEncode(str)
	fnEncode = Server.URLEncode(str + "")
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	프로시저 실행 후 데이타 값을 jSon으로 받아 온다
PUBLIC FUNCTION fnDataRsJson()
	result = "true"
	SET Rs = Cmd.EXECUTE()
	IF Rs.EOF OR Rs.BOF THEN
		data = NULL
	ELSE
		data = Rs.GetRows()
		IF data(0,0) <> "true" THEN
			result = "false"
		END IF
	END IF
	Rs.Close
	IF IsNull(data) THEN
		result = """ck"":{""rs"":""false"",""err"":""false"",""adm"":""true""}"
	ELSE
		result = """ck"":{""rs"":""" & result & """,""err"":""false"",""adm"":""true""},""list"":[" & fnJson(data) & "]"
	END IF
	fnDataRsJson = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	데이타 값을 jSon으로 받아 온다
PUBLIC FUNCTION fnDataJson(data ,result)
	IF IsNull(data) THEN
		result = """ck"":{""rs"":""false"",""err"":""false""}"
	ELSE
		result = """ck"":{""rs"":""" & result & """,""err"":""false""},""list"":[" & fnJson(data) & "]"
	END IF
	fnDataJson = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	Data GetRows를 json 형태로 포멧(변수값은 d0 ~ ... ~ d10 ~ ... 형태로 포멧)
PUBLIC FUNCTION fnJson(data)
	DIM jsonObj ,arrKey
	result	= ""
	SET jsonObj	= jsObject()
	FOR ix = 0 TO Ubound(data,2)
		FOR jx = 0 TO Ubound(data,1)
			IF IsNull(data(jx,ix)) THEN
				arrKey = ""
			ELSE
				arrKey = data(jx,ix)
			END IF
			jsonObj("d" & jx)	= arrkey
		NEXT
		result = result & jsonObj.Flush
		IF ix < Ubound(data,2) THEN
			result = result & ","
		END IF
	NEXT
	fnJson = result
END FUNCTION

'-----------------------------------------------------------------------------------------------------------------------------
'--	JavaScript alert 경고후 URL 이동
PUBLIC SUB fnAlertUrl(msg ,url)
	WITH Response
		.Write "<script type=""text/javascript"">" & vbCrLf
		.Write "//<![CDATA[" & vbCrLf
		.Write "alert(""" & msg & """);" & vbCrLf
		.Write "window.location.href = """ & url & """;" & vbCrLf
		.Write "//]]>" & vbCrLf
		.Write "</script>" & vbCrLf
	END WITH
END SUB

'-----------------------------------------------------------------------------------------------------------------------------
'--	태그제거
Function fnRemoveAllTag(byval strHTML)
 dim objRegExp,strOutput
    Set objRegExp = New Regexp
    objRegExp.IgnoreCase = True
    objRegExp.Global = True
    objRegExp.Pattern = "<.+?>"
    strOutput = objRegExp.Replace(strHTML & "", "")
    fnRemoveAllTag = strOutput
 Set objRegExp = Nothing
End Function

'=============================================================================================================================
' Description	:	데이타를 jSon 형태로 만들기 위한 ASPJOSN 함수
'					아래 내용의 원본은 http://code.google.com/p/aspjson/ 에서 구할 수 있습니다.
'-----------------------------------------------------------------------------------------------------------------------------
' History		:
'=============================================================================================================================
'	VBS JSON 2.0.3
'	Copyright (c) 2009 Tu?ul Topuz
'	Under the MIT (MIT-LICENSE.txt) license.
Const JSON_OBJECT	= 0
Const JSON_ARRAY	= 1

Class jsCore
	Public Collection
	Public Count
	Public QuotedVars
	Public Kind ' 0 = object, 1 = array

	Private Sub Class_Initialize
		Set Collection = CreateObject("Scripting.Dictionary")
		QuotedVars = True
		Count = 0
	End Sub

	Private Sub Class_Terminate
		Set Collection = Nothing
	End Sub

	' counter
	Private Property Get Counter
		Counter = Count
		Count = Count + 1
	End Property

	' - data maluplation
	' -- pair
	Public Property Let Pair(p, v)
		If IsNull(p) Then p = Counter
		Collection(p) = v
	End Property

	Public Property Set Pair(p, v)
		If IsNull(p) Then p = Counter
		If TypeName(v) <> "jsCore" Then
			Err.Raise &hD, "class: class", "Incompatible types: '" & TypeName(v) & "'"
		End If
		Set Collection(p) = v
	End Property

	Public Default Property Get Pair(p)
		If IsNull(p) Then p = Count - 1
		If IsObject(Collection(p)) Then
			Set Pair = Collection(p)
		Else
			Pair = Collection(p)
		End If
	End Property
	' -- pair
	Public Sub Clean
		Collection.RemoveAll
	End Sub

	Public Sub Remove(vProp)
		Collection.Remove vProp
	End Sub
	' data maluplation

	' encoding
	Function fnEncode(str)
		Dim charmap(127), haystack()
		charmap(8)  = "\b"
		charmap(9)  = "\t"
		charmap(10) = "\n"
		charmap(12) = "\f"
		charmap(13) = "\r"
		charmap(34) = "\"""
		charmap(47) = "\/"
		charmap(92) = "\\"

		Dim strlen : strlen = Len(str) - 1
		ReDim haystack(strlen)

		Dim i, charcode
		For i = 0 To strlen
			haystack(i) = Mid(str, i + 1, 1)

			charcode = AscW(haystack(i)) And 65535
			If charcode < 127 Then
				If Not IsEmpty(charmap(charcode)) Then
					haystack(i) = charmap(charcode)
				ElseIf charcode < 32 Then
					haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
				End If
			Else
				haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
			End If
		Next

		fnEncode = Join(haystack, "")
	End Function

	' converting
	Public Function toJSON(vPair)
		Select Case VarType(vPair)
			Case 0	' Empty
				toJSON = "null"
			Case 1	' Null
				toJSON = "null"
			Case 7	' Date
				' toJSON = "new Date(" & (vPair - CDate(25569)) * 86400000 & ")"	' let in only utc time
				toJSON = """" & CStr(vPair) & """"
			Case 8	' String
				toJSON = """" & fnEncode(vPair) & """"
			Case 9	' Object
				Dim bFI,i
				bFI = True
				If vPair.Kind Then toJSON = toJSON & "[" Else toJSON = toJSON & "{"
				For Each i In vPair.Collection
					If bFI Then bFI = False Else toJSON = toJSON & ","

					If vPair.Kind Then
						toJSON = toJSON & toJSON(vPair(i))
					Else
						If QuotedVars Then
							toJSON = toJSON & """" & i & """:" & toJSON(vPair(i))
						Else
							toJSON = toJSON & i & ":" & toJSON(vPair(i))
						End If
					End If
				Next
				If vPair.Kind Then toJSON = toJSON & "]" Else toJSON = toJSON & "}"
			Case 11
				If vPair Then toJSON = "true" Else toJSON = "false"
			Case 12, 8192, 8204
				toJSON = RenderArray(vPair, 1, "")
			Case Else
				toJSON = Replace(vPair, ",", ".")
		End select
	End Function

	Function RenderArray(arr, depth, parent)
		Dim first : first = LBound(arr, depth)
		Dim last : last = UBound(arr, depth)

		Dim index, rendered
		Dim limiter : limiter = ","

		RenderArray = "["
		For index = first To last
			If index = last Then
				limiter = ""
			End If

			On Error Resume Next
			rendered = RenderArray(arr, depth + 1, parent & index & "," )

			If Err = 9 Then
				On Error GoTo 0
				RenderArray = RenderArray & toJSON(Eval("arr(" & parent & index & ")")) & limiter
			Else
				RenderArray = RenderArray & rendered & "" & limiter
			End If
		Next
		RenderArray = RenderArray & "]"
	End Function

	Public Property Get jsString
		jsString = toJSON(Me)
	End Property

	Function Flush														'포멧을 받아서 처리하기 위해 Function으로 바꿈
		If TypeName(Response) <> "Empty" Then
			Flush = jsString	'Response.Write(jsString)				'값을 Return 받기위해 write 부분을 주석처리
		ElseIf WScript <> Empty Then
			WScript.Echo(jsString)
		End If
	End Function

	Public Function Clone
		Set Clone = ColClone(Me)
	End Function

	Private Function ColClone(core)
		Dim jsc, i
		Set jsc = new jsCore
		jsc.Kind = core.Kind
		For Each i In core.Collection
			If IsObject(core(i)) Then
				Set jsc(i) = ColClone(core(i))
			Else
				jsc(i) = core(i)
			End If
		Next
		Set ColClone = jsc
	End Function
End Class

Function jsObject
	Set jsObject = new jsCore
	jsObject.Kind = JSON_OBJECT
End Function

Function jsArray
	Set jsArray = new jsCore
	jsArray.Kind = JSON_ARRAY
End Function

Function toJSON(val)
	toJSON = (new jsCore).toJSON(val)
End Function

'-----------------------------------------------------------------------------------------------------------------------------
'--	김수현 사용 function

Function JSalert(myStr)													'경고 메시지
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	history.go(-1);"&vbCr)
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
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	document.location.href = '"& url &"'" &vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function AlertGo5(myStr,url)											'alert message 보여준 후 url 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	if (confirm("""&myStr&""")) {"&vbCr)
	Response.Write("	document.location.href = '"& url &"'" &vbCr)
	Response.Write("	} else {" &vbCr)
	Response.Write("	history.go(-1);"&vbCr)
	Response.Write("	}" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function noAlertGo(url)													'바로 url 이동하기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	document.location.href = '"& url &"'" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function noAlertGo3(url)												'바로 url 이동하기 (target = _top)
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	document.location.target = '_top'" &vbCr)
	Response.Write("	document.location.href = '"& url &"'" &vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function AlertSubmit(myStr,url,form)									'alert message 보여준 후 Form Submit
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
'	Response.Write("<!--"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	" & form &".action = '" & url &"'" &vbCr)
	Response.Write("	" & form &".submit();"&vbCr)
'	Response.Write("//-->"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function JSalertClose(myStr)											'경고 메시지 후 창닫기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	alert("""&myStr&""");"&vbCr)
	Response.Write("	window.close();"&vbCr)
	Response.Write("</script>"&vbCr)
	Response.End
End Function

Function popClose()														'Loading popup 닫기
	Response.Write(vbCr&"<script language=javascript>"&vbCr)
	Response.Write("	parent.preview.window.close();"&vbCr)
	Response.Write("</script>"&vbCr)
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

Function TrimText(checkvalue,checknum)
	If Len(checkvalue) > checknum Then
		TrimText = Left(checkvalue,checknum) & ".."
	Else
		TrimText = checkvalue
	End If
End Function

Function TrimText3(checkvalue,checknum)
	If Len(checkvalue) > checknum Then
		TrimText3 = Left(checkvalue,checknum)
	Else
		TrimText3 = checkvalue
	End If
End Function

Function ResizeImg(checkvalue,maxsize)
	If (checkvalue >= maxsize) Then
		ResizeImg = maxsize
	Else
		ResizeImg = checkvalue
	End If
End Function

Function checkLevel(userLevel, permitLevel)								'권한체크
	If Int(userLevel) <= Int(permitLevel) Then
		checkResult = True
	Else
		checkResult = False
		Call AlertGo ("권한이 없습니다.", "/")
	End If
	checkLevel = checkResult
End Function

Function setP(intTemp)													'자릿수 맞추기 (1월인 경우 01로 리턴)
	If Len(intTemp) = 1 Then
		setP = "0" & intTemp
	Else
		setP = intTemp
	End If
End Function

Public Function TelNumHyphen(TelNum)									'전화번호 하이픈 넣기
	Dim sTmpNum
	TelNumHyphen = TelNum:
	sTmpNum = Replace(TelNum, "-", ""):
	sTmpRes = Replace(TelNum, " ", ""):
	'Response.Write "sTmpNum : "& sTmpNum &"<br>"

	If IsNumeric(sTmpNum) Then
		Select Case Len(sTmpNum)
			Case 7
				TelNumHyphen = Mid(sTmpNum,1,3) & "-" & Right(sTmpNum,4):
			Case 8
				TelNumHyphen = Mid(sTmpNum,1,4) & "-" & Right(sTmpNum,4):
			Case 9
				TelNumHyphen = Mid(sTmpNum,1,2) & "-" & Mid(sTmpNum,3,3) & "-" & Right(sTmpNum,4):
			Case 10
				If Mid(sTmpNum,1,2) = "02" Then
					TelNumHyphen = Mid(sTmpNum,1,2) & "-" & Mid(sTmpNum,3,4) & "-" & Right(sTmpNum,4):
				Else
					TelNumHyphen = Mid(sTmpNum,1,3) & "-" & Mid(sTmpNum,4,3) & "-" & Right(sTmpNum,4):
				End If
			Case 11
				TelNumHyphen = Mid(sTmpNum,1,3) & "-" & Mid(sTmpNum,4,4) & "-" & Right(sTmpNum,4):
				'Response.Write "TelNumHyphen : "& TelNumHyphen &"<br>"
		End Select
	End If
End Function

Public Function TelSeparate(TelNum,op)									'전화번호 3단계 분할
	vTemp2 = Len(TelNum) - Len(Left(TelNum, InStr(TelNum,"-")))						'전체 길이 빼기 국번(-포함)까지 길이
	vTemp3 = Right(TelNum, Len(TelNum) - Len(Left(TelNum, InStr(TelNum,"-"))))		'국번을 제외한 번호
	If TelNum <> "" Then
		If op = 1 Then													'국번
			TelSepapate			= Left(TelNum,InStr(TelNum,"-")-1)
		ElseIf op = 2 Then												'가운데 번호
			Select Case vTemp2
				Case 8 : TelSepapate = Left(vTemp3,3)
				Case 9 : TelSepapate = Left(vTemp3,4)
			End Select
		ElseIf op = 3 Then												'끝자리
			TelSepapate			= Right(TelNum,4)
		Else															'휴대전화번호 가운데
			Select Case vTemp2
				Case 8 : TelSepapate = Left(vTemp3,3)
				Case 9 : TelSepapate = Left(vTemp3,4)
			End Select
		End If
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
			Case "doc" : ext_img = "/images/icon/icon_doc.gif"
			Case "hwp" : ext_img = "/images/icon/icon_hwp.gif"
			Case "pdf" : ext_img = "/images/icon/icon_pdf.gif"
			Case "ppt" : ext_img = "/images/icon/icon_ppt.gif"
			Case "xls" : ext_img = "/images/icon/icon_xls.gif"
			Case "zip" : ext_img = "/images/icon/icon_zip.gif"
			Case "psd" : ext_img = "/images/icon/icon_psd.gif"
			Case "gif" : ext_img = "/images/icon/icon_gif.gif"
			Case "jpg" : ext_img = "/images/icon/icon_jpg.gif"
			Case "bmp" : ext_img = "/images/icon/icon_bmp.gif"
			Case Else : ext_img = "/images/icon/icon_file0.gif"
		End Select
		getFileImg = ext_img
End Function

Public Function ReadNumColor(n)											'조회수 컬러지정
	Dim num:
	Dim color:
	Dim return:

	num = n:
	If (num="" Or IsEmpty(num) Or IsNull(num) Or Not IsNumeric(num)) Then num = 0:

	If (num > 1000) Then
		color = "red":
	ElseIf (num >= 500 And num < 1000) Then
		color = "blue":
	ElseIf (num >= 100 And num < 500) Then
		color = "green"
	Else
		color = "black"
	End If
	return = "<font color='" & color & "'>" & num & "</font>":
	readNumColor = return:
End Function

Function imgWd(wd0,wd1)													'이미지 폭 결정
	If wd0 <> 0 Then
		If wd0 > wd1 Then			'원래폭이 희망폭보다 큰 경우
			imgWd = wd1
		Else
			imgWd = wd0
		End If
	Else
		imgWd = wd1					'원래폭이 0인 경우 희망폭으로 설정
	End If
End Function

Function smsTime()														'문자발송(시간차)
		If Hour(Now) < 1 Then
			smsTime = "DateAdd(hh,8,getdate())"
		ElseIf Hour(Now) < 2 Then
			smsTime = "DateAdd(hh,7,getdate())"
		ElseIf Hour(Now) < 3 Then
			smsTime = "DateAdd(hh,6,getdate())"
		ElseIf Hour(Now) < 4 Then
			smsTime = "DateAdd(hh,5,getdate())"
		ElseIf Hour(Now) < 5 Then
			smsTime = "DateAdd(hh,4,getdate())"
		ElseIf Hour(Now) < 6 Then
			smsTime = "DateAdd(hh,3,getdate())"
		ElseIf Hour(Now) < 7 Then
			smsTime = "DateAdd(hh,2,getdate())"
		ElseIf Hour(Now) < 8 Then
			smsTime = "DateAdd(hh,1,getdate())"
		ElseIf Hour(Now) > 20 And Hour(Now) <= 22 Then
			smsTime = "DateAdd(hh,11,getdate())"
		ElseIf Hour(Now) > 22 And Hour(Now) <= 24 Then
			smsTime = "DateAdd(hh,9,getdate())"
		Else
			smsTime = "getdate()"
		End If
End Function

Function callPage(path, params, async)
	Dim xmlhttp, status, result
	Set xmlhttp = Server.CreateObject("MSXML2.ServerXMLHTTP")
'	Set xmlhttp = Server.CreateObject("Microsoft.XMLHTTP")
	xmlhttp.Open "POST", path & "?" & params, async
	xmlhttp.Send
	status = xmlhttp.Status
	result = xmlhttp.ResponseText
	Set xmlhttp = Nothing
'	Response.Write "callPage : "& result &"<br>"
	callPage = result
End Function

Function chkWord(Str)													'문자열 검열
	str = Replace(str,"&","&amp;")
	str = Replace(str,"""","&quot;")'chr(34)
	str = Replace(str,"'","&#039;")
	str = Replace(str,"<","&lt;")
	str = Replace(str,">","&gt;")
	chkWord = Str
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
		JSalert("특정 문자는 넣으실 수 없습니다. 다시 시도해 주세요.         ")
		Response.End
	Else
		SQLI = str
	End If
End Function

Function extcheck(note)													'extcheck = False 면 다음 동작이 취해짐
	BlackList = Array("ASP","PHP","EXE","JSP","C","BAT","XML","ASPX","PHP3","FLA","SWF","CSS","JS")
	extcheck = False
	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			extcheck = True
			Exit For
		End If
	Next
End Function

Function blackyn(note)
	BlackList = Array("sex","섹스","누드","유명브렌드","대출","홍보대행","게임","맞고","바둑이","포커","고스톱","실전","poker","겜","go777","입ㅅㅏ","입ㅅ ㅏ","얼ㅅㅏ","얼ㅅ ㅏ","don.ff","2 0 살","바카라","캐동","ㅈ ㅣ원","잭팟","월드게임","gogem","랭키","좆","새끼","염산","카지노","로얄","스타카,","카,지노","∑","카,지,노","카지,노","월,드","월드")
'	BlackList = Array("공짜","꽁짜","섹스","누드","성인","음모","유명브렌드","대출","홍보대행","게임","맞고","바둑이","포커","고스톱","실전","poker","역전","겜","go777","입ㅅㅏ","입ㅅ ㅏ","얼ㅅㅏ","얼ㅅ ㅏ","don.ff","2 0 살","바카라","비아","그라","겅짜","캐동","ㅈ ㅣ원","잭팟","월드게임","gogem","랭키","좆","새끼")
	blackyn = False
	For inum = 0 To Ubound(BlackList)
		If InStr(1,note,BlackList(inum)) > 0 Then
			blackyn = True
			Exit For
		End If
	Next
End Function


PUBLIC SUB sbNoneText(str)
	IF blackyn(str) THEN
		Response.Write """ck"":{""rs"":""false""}"
		Response.End()
	END IF
END SUB
%>