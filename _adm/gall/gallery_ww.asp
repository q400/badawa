<!--
'************************************************************************************
'* Program 명	: gallery_ww.asp (조황갤러리 NFupload 이용)
'************************************************************************************
-->
<!-- #include virtual = "/_adm/inc/header8.asp" -->
<%
	Call checkAdm(FID_AUTH, 10, Request.ServerVariables("PATH_INFO"))

	seq							= Request("seq")
	shipid						= SQLI(Request("shipid"))
	cd1							= SQLI(Request("cd1"))
	cd2							= SQLI(Request("cd2"))
	sdate						= Request("sdate")
	page						= Request("page")
	flag						= SQLI(Request("flag"))

	fcolor						= "#ffaa00"
	fontx						= 40
	fonty						= 40
	pcomment					= "www.badawa.co.kr"

	If cd1 = "" Then cd1 = "title"
	If page = "" Then page = 1
	If flag = "" Then flag = "W"
	If sdate = "" Then sdate = CDate(Date)
'	Response.Write "sdate : "& sdate &"<br>"

	If seq <> "" Then
		rso()
		SQL = " SELECT seq, title, uno, cnt, shipid, wdate, chuljo, multime, weather, pago, ipzil, jogwa, bestfish, fishsize, ddate, contents " _
			& "	FROM _ogalt020 " _
			& " WHERE seq = "& seq
		rs.open SQL, dbcon
		If Not rs.eof Then
			title				= rs("title")
			uno					= rs("uno")
			cnt					= rs("cnt")
			shipid				= rs("shipid")
			wdate				= rs("wdate")
			chuljo				= rs("chuljo")
			multime				= rs("multime")
			weather				= rs("weather")
			pago				= rs("pago")
			ipzil				= rs("ipzil")
			jogwa				= rs("jogwa")
			bestfish			= rs("bestfish")
			fishsize			= rs("fishsize")
			ddate				= rs("ddate")
			contents			= rs("contents")
		End If
		rsc()
		flag = "M"
		If wdate <> "" Then sdate = wdate
	End If

	Dim uploadUrl
	uploadUrl = "http://" & Request.ServerVariables("HTTP_HOST") & ":" & Request.ServerVariables("SERVER_PORT") & Request.ServerVariables("URL")
	uploadUrl = Mid(uploadUrl, 1, InStrRev(uploadUrl, "/"))

	'If shipid = "" Then shipid = 0
%>

<script type="text/javascript">
<!--
$(document).ready(function(){
	setMoolTime(FrmUpload);
});

function goDelete(){
	var f = document.FrmUpload;
	if (confirm("삭제하겠습니까?")){
		f.flag.value = "D";
		f.action = "gallery_xx.asp";
		f.method = "post";
		f.submit();
	}
}
function delPhoto(xidx){
	var f = document.FrmUpload;
	if (confirm("이미지를 삭제하겠습니까?")){
		f.idx.value = xidx;
		f.flag.value = "DelPhoto";
		f.action = "gallery_xx.asp";
		f.method = "post";
		f.target = "nullframe";
		f.submit();
	}
}
function mool(op1,op2,op3){			//양력일자 입력 (_ocodt020)
	var f = document.FrmUpload;
	f.syear.value = op1;
	f.smon.value = op2;
	f.sday.value = op3;
	f.action = "mool_x.asp";
	f.method = "post";
//	f.target = "nullframe";
	f.submit();
}
function setMoolTime(form){			//양력일자 입력 (_ocodt020)
	var yy = form.syear.value;
	var mm = form.smon.value;
	var dd = form.sday.value;
//	console.log("__________ dd = "+ dd);
	form.action = "moolTimeSet.asp?yy="+ yy +"&mm="+ mm +"&dd="+ dd;
	form.target = "nullframe";
	form.submit();
}
//-->
</script>
<script language="JavaScript" type="text/javascript" src="/lib/nf/NFUpload/nfupload.js?d=20081028"></script>
<script language="JavaScript" type="text/javascript">
<!--
	// -----------------------------------------------------------------------------
	// Globals
	// -----------------------------------------------------------------------------
	var _NF_MaxFileSize = 102400;							// 업로드 제한 용량 (기본값: 10,240 Kb) (단위는 Kb)
	var _NF_MaxFileCount = 150;								// 업로드 파일 제한 갯수 (기본값: 10)
	var _NF_UploadUrl = "/lib/nf/Upload.asp";				// 업로드 소스파일 경로 (반드시 입력해야함)
	var _NF_FileFilter = "";								// 파일 필터링 값 ("이미지(*.jpg)|:|*.jpg;*.gif;*.png;*.bmp"); // 기본값 모든파일
	var _NF_DataFieldName = "DataFieldName";				// 업로드 폼에 사용되는 값 (기본값(UploadData))
	var _NF_Flash_Url = "/lib/nf/NFUpload/nfupload.swf?d=20081028";	// 업로드 컴포넌트 플래쉬 파일명
	var _NF_File_Overwrite = false;							// 업로드시 파일명 처리방법(true : 원본파일명 유지, 덮어씌우기 모드 / false : 유니크파일명으로 변환, 중복방지)
	var _NF_Limit_Ext = "asp;php;aspx;jsp;cs;html;htm;";		// 파일 제한 확장자

	// 플래시 업로더 화면 구성 설정 변수
	var _NF_Width = 780;									// 업로드 컴포넌트 넓이 (기본값 480)
	var _NF_Height = 162;									// 업로드 컴포넌트 폭 (기본값 150)
	var _NF_ColumnHeader1 = "파일명";						// 컴포넌트에 출력되는 파일명 제목 (기본값: File Name)
	var _NF_ColumnHeader2 = "용량";							// 컴포넌트에 출력되는 용량 제목 (기본값: File Size)
	var _NF_FontFamily = "굴림";								// 컴포넌트에서 사용되는 폰트 (기본값: Times New Roman)
	var _NF_FontSize = "11";								// 컴포넌트에서 사용되는 폰트 크기 (기본값: 11)

	// [2008-10-28] Flash 10 support
	var _NF_Img_FileBrowse = "images/btn_file_browse.gif";	// 파일찾기 이미지
	var _NF_Img_FileBrowse_Width = "59";					// 파일찾기 이미지 넓이 (기본값 59)
	var _NF_Img_FileBrowse_Height = "22";					// 파일찾기 이미지 폭 (기본값 22)
	var _NF_Img_FileDelete = "images/btn_file_delete.gif";	// 파일삭제 이미지
	var _NF_Img_FileDelete_Width = "59";					// 파일삭제 이미지 넓이 (기본값 59)
	var _NF_Img_FileDelete_Height = "22";					// 파일삭제 이미지 폭 (기본값 22)
	var _NF_TotalSize_Text = "전체용량 ";						// 파일용량 텍스트
	var _NF_TotalSize_FontFamily = "굴림";					// 파일용량 텍스트 폰트
	var _NF_TotalSize_FontSize = "12";						// 파일용량 텍스트 폰트 크기
	var frmUpload;

	window.onload = function(){
		frmUpload = document.FrmUpload;

		frmUpload.hidFileName.value = "";
		// [2008-10-28] Flash 10 support
		//sMaxSize.innerHTML = SizeCalc(_NF_MaxFileSize);
	}
	/*****************************************************************************
	/* 업로드가 완료 되었을 때 사용되는 함수
	/* (주의: 이 함수명은 변경하면 안됩니다.)
	/*
	/* 함수명을 변경하게 되면 업로드가 완료된 다음 다른 작업을 진행할 수 없습니다.
	/* value: 파일명들 (배열로 리턴됨. 단, 업로드가 진행되지 않으면 null값 리턴)
	/*****************************************************************************/
	function NFU_Complete(value){
		var files = frmUpload.hidFileName.value;
		var fileCount = 0;
		var i = 0;

		if (!frmUpload.shipid.value){				//선박체크
			alert("선박을 선택하세요.");
			frmUpload.shipid.focus();
			NfUpload.AllFileDelete();
			return;
		}
		// 이 부분을 수정해서 파일이 선택되지 않았을 때에도 submit을 하게 수정할 수 있습니다.
		if (value == null){
//			alert("업로드할 파일을 선택해 주세요.");
//			return;
		} else {
			fileCount = value.length;
			for (i = 0; i < fileCount; i++){
				var fileName = value[i].name;
				var realName = value[i].realName;
				var fileSize = value[i].size;

				// 분리자(|:|)는 다른 문자로 변경할 수 있다.
				files += fileName + "/" + realName + "|:|";
			}
			if (files.substring(files.length - 3, files.length) == "|:|")
				files = files.substring(0, files.length - 3);

			frmUpload.hidFileName.value = files;
		}

		frmUpload.flag.value = "<%=flag%>";
		frmUpload.action = "gallery_xx.asp";
		frmUpload.submit();
	}

	/******************************************************************************
	/* 파일 선택한 뒤 용량을 반환해 주는 함수
	/* (주의: 이 함수명은 변경하면 안됩니다.)
	/* 함수명을 변경하게 되면 업로드가 완료된 다음 다른 작업을 진행할 수 없습니다.
	/* value: 선택한 파일 용량 (용량은 KB, MB, GB 단위)
	/*****************************************************************************/
	function NF_ShowUploadSize(value){
		// value값에 실제 업로드된 용량이 넘어온다.
		sUploadSize.innerHTML = value;
	}

	function NFUpload_Debug(value){
		Debug("업로드 오류!!!\r\n\r\n" + value);
	}

	function Cancel(){				//초기화 할때는 첨부파일 리스트도 같이 초기화 시켜 준다.
		NfUpload.AllFileDelete();
		FrmUpload.reset();
	}
// -->
</script>


<div id="wrap">
	<div>
		<!-- #include virtual = "/_adm/inc/top.asp" -->
	</div>
	<div>
		<center>
			<div class="ib vt"><!-- #include virtual = "/_adm/inc/left.asp" --></div>
			<div class="ib" id="admwrap1">

<form name="FrmUpload" method="post" enctype="multipart/form-data">
<input type="hidden" name="seq" value="<%=seq%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="cd1" value="<%=cd1%>">
<input type="hidden" name="cd2" value="<%=cd2%>">
<input type="hidden" name="flag">
<input type="hidden" name="idx">

				<div id="poptitle2">
					<p class="lf">
						<span class="tt2">갤러리 관리</span>
						<span class="ib fright"></span>
					</p>

					<!-- 선박정보 시작 -->
					<table id="list2" class="wrapSub">
						<colgroup>
							<col style="width:120px;" />
							<col style="width:280px;" />
							<col style="width:120px;" />
							<col style="width:280px;" />
						</colgroup>
						<tbody>
							<tr>
								<th class="ct">선박선택</th>
								<td>
									<select name="shipid" id="shipid" style="width:120px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	shipid, shipnm FROM _oshpt010 ORDER BY shipid ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("shipid")%>"<%If CStr(shipid) = CStr(rs("shipid")) Then%> selected<%End If%>><%=rs("shipnm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
								<th class="ct">출조일자</th>
								<td>
									<select name="syear" id="syear" style="width:60px;">
<%		For u = year(Date)-2 To year(Date) Step 1 %>
										<option value="<%=u%>"<%If Year(sdate) = u Then%> selected<%End If%>><%=u%></option>
<%		Next %>
									</select> 년&nbsp;
									<select name="smon" id="smon" style="width:45px;" onchange="mool(''+ document.FrmUpload.syear.value +'',''+ this.options[this.selectedIndex].value +'',''+ document.FrmUpload.smon.value +'');">
<%		For j = 1 To 12 Step 1 %>
										<option value="<%=setp(j)%>"<%If setp(Month(sdate)) = setp(j) Then%> selected<%End If%>><%=setp(j)%></option>
<%		Next %>
									</select> 월&nbsp;
									<select name="sday" id="sday" style="width:45px;" onchange="setMoolTime(this.form);">
<%		For k = 1 To 31 Step 1 %>
										<option value="<%=setp(k)%>"<%If Day(sdate) = k Then%> selected<%End If%>><%=setp(k)%></option>
<%		Next %>
									</select> 일
									<!-- <a href="javascript:carcmool();">물때</a> -->
								</td>
							</tr>
							<tr>
								<th class="ct">출조</th>
								<td>
									<select name="chuljo" id="chuljo" style="width:120px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '출조' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If chuljo = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
								<th class="ct">물때</th>
								<td>
									<input type="text" name="multime" id="multime" maxlength="20" value="<%=multime%>" style="width:60px;" />&nbsp;
									<span class="f11 fcr ls">출조일 선택시 자동 입력</span>
								</td>
							</tr>
							<tr>
								<th class="ct">날씨</th>
								<td>
									<input type="radio" name="weather" id="weather1" value="맑음"<%If weather = "맑음" Then%> checked<%End If%> /><label for="weather1">맑음</label>
									<input type="radio" name="weather" id="weather2" value="흐림"<%If weather = "흐림" Then%> checked<%End If%> /><label for="weather2">흐림</label>
									<input type="radio" name="weather" id="weather3" value="안개"<%If weather = "안개" Then%> checked<%End If%> /><label for="weather3">안개</label>
									<input type="radio" name="weather" id="weather4" value="비"<%If weather = "비" Or weather = "" Then%> checked<%End If%> /><label for="weather4">비</label>
									<input type="radio" name="weather" id="weather5" value="눈"<%If weather = "눈" Then%> checked<%End If%> /><label for="weather5">눈</label>
									<input type="radio" name="weather" id="weather6" value="바람"<%If weather = "바람" Then%> checked<%End If%> /><label for="weather6">바람</label>
								</td>
								<th class="ct">파고</th>
								<td>
									<select name="pago" style="width:130px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '파고' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If pago = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ct">입질</th>
								<td>
									<input type="radio" name="ipzil" id="ipzil1" value="대박"<%If ipzil = "대박" Then%> checked<%End If%> /><label for="ipzil1">대박</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil2" value="호조"<%If ipzil = "호조" Then%> checked<%End If%> /><label for="ipzil2">호조</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil3" value="좋음"<%If ipzil = "좋음" Then%> checked<%End If%> /><label for="ipzil3">좋음</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil4" value="보통"<%If ipzil = "보통" Then%> checked<%End If%> /><label for="ipzil4">보통</label>&nbsp;
									<input type="radio" name="ipzil" id="ipzil5" value="저조"<%If ipzil = "저조" Then%> checked<%End If%> /><label for="ipzil5">저조</label>
								</td>
								<th class="ct">조과</th>
								<td>
									<select name="jogwa" style="width:130px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '조과' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If jogwa = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
							</tr>
							<tr>
								<th class="ct">최대어종</th>
								<td>
									<select name="bestfish" style="width:130px;">
										<option value="" selected>선택</option>
<%
		rso()
		SQL = "	SELECT	code_nm FROM _ocodt010 WHERE gubn = '어종' ORDER BY idx ASC "
		rs.open SQL, dbcon, 3
		Do Until rs.eof
%>
										<option value="<%=rs("code_nm")%>"<%If bestfish = rs("code_nm") Then%> selected<%End If%>><%=rs("code_nm")%></option>
<%
			rs.MoveNext
		Loop
		rsc()
%>
									</select>
								</td>
								<th class="ct">최대크기</th>
								<td>
									<input type="text" name="fishsize" maxlength="10" value="<%=fishsize%>" style="width:50px;" /> 센티미터
								</td>
							</tr>
							<!--
							<tr>
								<th class="ct">이미지 삽입Font</th>
								<td colspan=6>
									<div style="padding:5px 0 5px 0;">
										색상 :&nbsp;<input type="text" name="fcolor" maxlength="7" value="<%=fcolor%>" style="width:60px; ime-mode:disabled;">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										정렬 :&nbsp;<input type="radio" name="farray" value="left" checked> 좌측
										&nbsp;&nbsp;<input type="radio" name="farray" value="right"> 우측
										&nbsp;&nbsp;<input type="radio" name="farray" value="center"> 세로출력
									</div>
									<div style="padding:5px 0 10px 0;">
										가로위치(x) :&nbsp;<input type="text" name="fontx" maxlength="3" value="<%=fontx%>" style="width:30px;">
										&nbsp;&nbsp;&nbsp;
										세로위치(y) :&nbsp;<input type="text" name="fonty" maxlength="3" value="<%=fonty%>" style="width:30px;">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										삽입문구 :&nbsp;<input type="text" name="pcomment" maxlength="50" value="<%=pcomment%>" style="width:200px;">
									</div>
								</td>
							</tr>
							-->
							<tr>
								<td colspan=10 class="fc4 lf pl10">
									※ 이미지 사이즈 <b>800×533</b> 로 &nbsp;<b>JPG</b> 를 권장합니다.
									<!-- ※ <b>FTP를 이용</b>하여 이미지를 등록한 후 이미지 목록을 <b>엑셀로 작성하여 업로드</b>합니다. -->
<input type="hidden" name="hidFileName"/>
</form>
								</td>
							</tr>

							<tr>
								<td align="center" colspan=10 style="padding:3px 0 3px 0;">
<script type="text/javascript">
<!--
	// Flash 업로더 객체를 생성하는 자바 스크립트 입니다.
	// 이 스크립트는 Form 태그내에 들어가게 되면 오류가 발생하기 때문에
	// 반드시 Form 태그 밖에서 사용해야 합니다.
	// [2008-10-28] Flash 10 support
	NfUpload = new NFUpload({
			nf_upload_id : _NF_Uploader_Id,
			nf_width : _NF_Width,
			nf_height : _NF_Height,
			nf_field_name1 : _NF_ColumnHeader1,
			nf_field_name2 : _NF_ColumnHeader2,
			nf_max_file_size : _NF_MaxFileSize,
			nf_max_file_count : _NF_MaxFileCount,
			nf_upload_url : _NF_UploadUrl,
			nf_file_filter : _NF_FileFilter,
			nf_data_field_name : _NF_DataFieldName,
			nf_font_family : _NF_FontFamily,
			nf_font_size : _NF_FontSize,
			nf_flash_url : _NF_Flash_Url,
			nf_file_overwrite : _NF_File_Overwrite,
			nf_limit_ext : _NF_Limit_Ext,
			nf_img_file_browse : _NF_Img_FileBrowse,
			nf_img_file_browse_width : _NF_Img_FileBrowse_Width,
			nf_img_file_browse_height : _NF_Img_FileBrowse_Height,
			nf_img_file_delete : _NF_Img_FileDelete,
			nf_img_file_delete_width : _NF_Img_FileDelete_Width,
			nf_img_file_delete_height : _NF_Img_FileDelete_Height,
			nf_total_size_text : _NF_TotalSize_Text,
			nf_total_size_font_family : _NF_TotalSize_FontFamily,
			nf_total_size_font_size : _NF_TotalSize_FontSize
	});
//-->
</script>
								</td>
							</tr>
							<!--
							<tr>
								<td height="1" bgcolor="#dddddd" colspan="10"></td>
							</tr>
							<tr>
								<td height="1" bgcolor="#fafafa" colspan="10"></td>
							</tr>
							-->
							<tr>
								<td height="20" bgcolor="#fafafa" colspan="10" class="fcr">※ 이미지 등록 후 반드시 대표 이미지를 선택하세요. (이미지를 클릭하면 대표이미지로 선택할 수 있습니다.)</td>
							</tr>
							<tr>
								<td bgcolor="#f1f1f1" class="lf" colspan="10" style="padding:10px;">
<%
		If seq <> "" Then
			rso()
			SQL = " SELECT	idx, seq, fpath, fnm, fsz, fwd, ext, best FROM _ogalt021 WHERE seq = "& seq
			rs.open SQL, dbcon
			k = 1
			While Not rs.eof
%>
									<a href="javascript:;" onclick="unoPop('/inc/imgv_gall.asp?seq=<%=seq%>&idx=<%=rs("idx")%>&op=gallery','이미지보기',820,770);return false;">
									<img src="<%=rs("fpath") &"/"& rs("fnm")%>" width="100" align="absmiddle"<%If rs("best") Then%> style="border:3px dotted #f00;"<%End If%>></a>
									<input type="checkbox" name="cbox" value="<%=rs("idx")%>" onClick="delPhoto(<%=rs("idx")%>)"><!-- background-color:#cc0000; padding:3px; -->
									<%If k Mod 5 = 0 Then%><br><%End If%>
<%
				k = k + 1
				rs.MoveNext
			Wend
			rsc()
		End If
%>
								</td>
							</tr>

						</tbody>
					</table>
					<!-- 리스트 끝 -->
					<div id="btnarea1">
<%			If flag = "W" Then %>
						<a href="javascript:NfUpload.FileUpload();" class="btn btn25"><span>저장</span></a>
<%			Else %>
						<a href="javascript:NfUpload.FileUpload();" class="btn btn25"><span>수정</span></a>
						<a href="javascript:goDelete();" class="btnr btn25"><span>삭제</span></a>
<%			End If %>
						<!-- <a href="javascript:Cancel();" class="btn btn25"><span>취소</span></a> -->
						<!-- <a href="?seq=<%=seq%>&sdate=<%=sdate%>&cd1=<%=cd1%>&cd2=<%=cd2%>&page=<%=page%>" class="btn btn25"><span>새로고침</span></a> -->
						<a href="gallery3.asp?page=<%=page%>&cd1=<%=cd1%>&cd2=<%=cd2%>&shipid=<%=shipid%>" class="btn btn25"><span>목록</span></a>
					</div>
				</div><!-- poptitle2 E -->
			</div><!-- admwrap1 E -->
		</center>
	</div>

	<div>
		<!-- #include virtual = "/_adm/inc/footer.asp" -->
	</div>
</div>
<%	Set cx = Nothing %>
