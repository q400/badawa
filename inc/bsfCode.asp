<%
Class BsfCode			'Base64 암호화 클래스

	Private MAP_INIT:
	Private encMap(63):
	Private decMap(127):
	Private strValue:

	Public Property Let SetValue(value)
		If (Not IsEmpty(value)) Then
			strValue = value:
		Else
			strValue = "":
		End If
	End Property

	Private Sub Class_Initialize()			'//must be called before using anything else
		Dim max, idx:
		MAP_INIT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/": '//init vars
		max = Len(MAP_INIT):

		For idx = 0 To max - 1
			encMap(idx) = Mid(MAP_INIT, idx + 1, 1): '//one based string
		Next
		For idx = 0 To max - 1
			decMap(Asc(encMap(idx))) = idx:
		Next
	End Sub

	Private Sub Class_Terminate()
		MAP_INIT = "":
	End Sub

	Public Property Get SetValue()
		SetValue = strValue:
	End Property

	Public Function SetEncode(byRef str)
		strValue = Encode(str):
		SetEncode = strValue:
	End Function

	Public Function SetDecode(byRef str)
		strValue = Decode(str):
		SetDecode = strValue:
	End Function

	Private Function Encode(byRef plain)	'//encode base 64 encoded string

		If (Len(plain) = 0) Then
			Encode = "":
			Exit Function:
		End If

		Dim ret, ndx, by3, first, second, third:
		by3 = (Len(plain) \ 3) * 3:
		ndx = 1:
		Do While ndx <= by3
			first  = Asc(Mid(plain, ndx+0, 1)):
			second = Asc(Mid(plain, ndx+1, 1)):
			third  = Asc(Mid(plain, ndx+2, 1)):
			ret = ret & encMap(  (first \ 4) And 63 ):
			ret = ret & encMap( ((first * 16) And 48) + ((second \ 16) And 15 ) ):
			ret = ret & encMap( ((second * 4) And 60) + ((third \ 64) And 3 ) ):
			ret = ret & encMap( third And 63):
			ndx = ndx + 3:
		Loop

		'//check for stragglers
		If (by3 < Len(plain)) Then
			first  = Asc(Mid(plain, ndx+0, 1)):
			ret = ret & encMap(  (first \ 4) And 63 ):
			If ((Len(plain) Mod 3 ) = 2) Then
				Second = Asc(Mid(plain, ndx+1, 1)):
				ret = ret & encMap( ((first * 16) And 48) + ((Second \ 16) And 15 ) ):
				ret = ret & encMap( ((Second * 4) And 60) ):
			Else
				ret = ret & encMap( (first * 16) And 48):
				ret = ret & "=":
			End If
			ret = ret & "=":
		End If
		Encode = ret:
	End Function

	Private Function Decode(scrambled) '//decode base 64 encoded string

		If (Len(scrambled) = 0) Then
			Decode = "":
			Exit Function:
		End If

		'//ignore padding
		Dim realLen:
		realLen = Len(scrambled):
		Do While Mid(scrambled, realLen, 1) = "=":
			realLen = realLen - 1:
		Loop

		Dim ret, ndx, by4, first, Second, third, fourth:
		ret = "":
		by4 = (realLen \ 4) * 4:
		ndx = 1:

		Do While ndx <= by4
			first  = decMap(Asc(Mid(scrambled, ndx+0, 1))):
			second = decMap(Asc(Mid(scrambled, ndx+1, 1))):
			third  = decMap(Asc(Mid(scrambled, ndx+2, 1))):
			fourth = decMap(Asc(Mid(scrambled, ndx+3, 1))):
			ret = ret & Chr( ((first * 4) And 255) +   ((Second \ 16) And 3)):
			ret = ret & Chr( ((Second * 16) And 255) + ((third \ 4) And 15) ):
			ret = ret & Chr( ((third * 64) And 255) +  (fourth And 63) ):
			ndx = ndx + 4:
		Loop

		'//check for stragglers, will be 2 or 3 characters
		If (ndx < realLen) Then
			first  = decMap(Asc(Mid(scrambled, ndx+0, 1))):
			second = decMap(Asc(Mid(scrambled, ndx+1, 1))):
			ret = ret & Chr( ((first * 4) And 255) +   ((Second \ 16) And 3)):
			If (realLen Mod 4 = 3) Then
				third = decMap(Asc(Mid(scrambled,ndx+2,1))):
				ret = ret & Chr( ((Second * 16) And 255) + ((third \ 4) And 15) ):
			End If
		End If
		Decode = ret:
	End Function

End Class
%>