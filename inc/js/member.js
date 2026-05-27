/*===========================================================================================================================
File Name		:	/js/member.js
-----------------------------------------------------------------------------------------------------------------------------
Service Name	:	회원
Description		:	회원 시스템 관련 UI에 사용되는 함수
Create Date		:	2012년 02월 03일
Author			:	유재인
-----------------------------------------------------------------------------------------------------------------------------
History			:	[2011.11.0] [유재인] - 
===========================================================================================================================*/
(function($){
	Member = {
		Msg : function(key ,bitArr)
		{
			var	txt		= [];
				txt[0]	= '필수입력 항목에 잘못된 내용이 입력 되었습니다.\n\n항목별 상세 내용을 확인해 주세요.';
				txt[1]	= '서비스 약관에 동의 하셔야 합니다.';
				txt[2]	= '개인정보 수집·이용에 동의 하셔야 합니다.';
				txt[3]	= '개인정보 수집항목에 동의 하셔야 합니다.';
				txt[4]	= '정보보유/이용기간에 동의 하셔야 합니다.';
				txt[5]	= '개인정보위탁처리에 동의 하셔야 합니다.';
				txt[6]	= '성명을 입력하셔야 합니다.';
				txt[7]	= '주민등록번호를 입력하셔야 합니다.';
				txt[8]	= '성명은 2~20글자 한글, 영문으로 입력하셔야 합니다.';
				txt[9]	= '주민등록번호는 숫자로 입력하셔야 합니다.';
				txt[10]	= '유효하지 않은 주민등록번호 입니다.';
				txt[11]	= '5~15자의 영문(소문자)과 숫자만 사용할 수 있습니다.';
				txt[12]	= '사용가능한 아이디 입니다.';
				txt[13]	= '이미 사용중 이거나 사용할 수 없는 아이디 입니다.';
				txt[14]	= '5~15자의 영문(소문자)과 숫자, 특수문자(!@#$)만 사용할 수 있습니다.';
				txt[15]	= '비밀번호와 비밀번호확인이 일치하지 않습니다.';
				txt[16]	= '2~8자의 한글, 영문, 숫자만 사용할 수 있습니다.';
				txt[17]	= '사용가능한 별명 입니다.';
				txt[18]	= '이미 사용중 이거나 사용할 수 없는 별명 입니다.';
				txt[19]	= '아이디/비밀번호 찾기 및 인증수단으로 사용됩니다.';
				txt[20]	= '잘못된 이메일주소 입니다.';
				txt[21]	= '사용가능한 이메일 입니다.';
				txt[22]	= '이미 사용중 이거나 사용할 수 없는 이메일 입니다.';
				txt[23]	= '이메일 인증을 받으셔야 합니다.';
				txt[24]	= '인증되었습니다.';
				txt[25]	= '본인확인/인증수단 및 알림문자로 사용 됩니다.';
				txt[26]	= '사용할 수 없는 휴대전화번호 입니다.';
				txt[27]	= '가입되어 있지 않은 아이디입니다.';
				txt[28]	= '비밀번호가 틀렸습니다.';
				txt[29]	= '입력하신 정보와 일치하는 회원이 존재하지 않습니다.';
				txt[30]	= '계정정보가 입력하신 이메일로 발송되었습니다.';
			return ((bitArr) ? txt : txt[key]);
		}
	,	Rgx : function(){
			var rgx = {
				id		: /^[a-z0-9]{1,}$/
			,	pw		: /^[a-z0-9!@#$]{1,}$/
			,	nic		: /^[가-힣a-zA-Z0-9]{1,}$/
			,	email	: /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/
			,	rrn		: /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/
			,	name	: /^[가-힣a-zA-Z]{1,}$/
			,	mobile	: /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/
			};
			return rgx;
		}
	,	Overlap : {
			Submit : function(type)
			{
				mmr_olpType = type;
				var msg				= Member.Msg('' ,true);
				var check			= false;
				var procType		= '';
				var nvrMemId		= '';
				var nvrMemNicname	= '';
				var nvrMemInfoEmail	= '';
				
				if(type == 'id'){
					procType	= 'overlapId';
					nvrMemId	= Cmn.BlankClear($('#nvrMemId').val());
					if(nvrMemId.length < 5 || nvrMemId.length > 15 || !Regexp(nvrMemId ,/^[0-9a-z]{1,}$/ ,'test')){
						$('#nvrMemIdInfo').css('color' ,Color.err).text(msg[11]);
					} else{
						check = true;
					};
				} else if(type == 'nic'){
					procType		= 'overlapNic';
					nvrMemNicname	= Cmn.BlankClear($('#nvrMemNicname').val());
					if(nvrMemNicname.length < 2 || nvrMemNicname.length > 8 || !Regexp(nvrMemNicname ,/^[가-힣0-9a-zA-Z]{1,}$/ ,'test')){
						$('#nvrMemNicnameInfo').css('color' ,Color.err).text(msg[16]);
					} else{
						check = true;
					};
				} else if(type == 'email'){
					procType		= 'overlapEmail';
					nvrMemInfoEmail	= $('#nvrMemInfoEmail0').val() + '@' + $('#nvrMemInfoEmail1').val();
					if(!Regexp(nvrMemInfoEmail ,/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i ,'test')){
						$('#nvrMemInfoEmail0Info').css('color' ,Color.err).text(msg[20]);
					} else{
						check = true;
					};
				} else{
					Cmn.ErrAlert(0 ,true);
				};
				if(check){
					var data = {
						procType		: procType
					,	procTypeList	: 'list'
					,	nvrMemId		: nvrMemId
					,	nvrMemNicname	: nvrMemNicname
					,	nvrMemInfoEmail	: nvrMemInfoEmail
					};
					var options = {
						type		: 'POST'
					,	dataType	: 'JSON'
					,	url			: '/proc/member/axMember.asp'
					,	data		: data
					,	error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
					,	success		: function(data){ Member.Overlap.Paser(data); }
					};
					$.ajax(options);
				};
			}
		,	Paser : function(data)
			{
				var msg				= Member.Msg('' ,true);
				var data	= Cmn.Eval(data);
				var chk		= Cmn.Bool(data.ck.rs);
				var ele	 ,msgNum;
				if(mmr_olpType == 'id'){
					ele		= '#nvrMemId';
					msgNum	= 13;
				} else if(mmr_olpType == 'nic'){
					ele		= '#nvrMemNicname';
					msgNum	= 18;
				} else if(mmr_olpType == 'email'){
					ele		= '#nvrMemInfoEmail0';
					msgNum	= 22;
				} else{
					Cmn.ErrAlert(0 ,true);
				};
				if(chk){
					$(ele + 'Info').css('color' ,Color.err).text(msg[msgNum]);
				} else{
					$(ele + 'Olp').val($(ele).val());
					$(ele + 'Info').css('color' ,Color.ok).text(msg[msgNum - 1]);
				};
				mmr_olpType = null;
			}
		}
	,	EmailAuthentication : function(ele)
		{
			var toUrl = $('#nvrMemInfoEmail0').val() + '@' + $('#nvrMemInfoEmail1').val();
			if(!Regexp(toUrl ,/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/ ,'test')){
				$('#qCode').val('');
				$('#nvrMemInfoEmail0Info').css('color' ,Color.err).text(Member.Msg(20));
				return false;
			} else{
				$(ele).text('인증번호다시받기');
				Email.Authentication.Submit(toUrl ,20);
			};
		}
	,	Login : {
			Submit : function()
			{
				Modal.LoadingBar('정보 확인중...');
				var rgx		= Member.Rgx();
				var infoObj	= $('#loginInfo');
				var msg		= Member.Msg('' ,true);
				var obj		= {
					nvrMemId	: $('#nvrMemId')
				,	nvrMemPw	: $('#nvrMemPw')
				};
				var data	= {
					procType		: 'login'
				,	procTypeList	: 'list'
				,	nvrMemId		: obj.nvrMemId.val()
				,	nvrMemPw		: obj.nvrMemPw.val()
				};
				if((Cmn.BlankBool(data.nvrMemId) || !Cmn.LenCheck(data.nvrMemId ,5 ,15) || !Regexp(data.nvrMemId ,rgx.id ,'test')) && data.nvrMemId != 'inni'){
				//	infoObj.css('color' ,Color.err).text('아이디는 ' + msg[11]);	아이디 입력이 잘못 되었을 경우
					alert('아이디는 ' + msg[11]);
				} else if(Cmn.BlankBool(data.nvrMemPw) || !Cmn.LenCheck(data.nvrMemPw ,5 ,15) || !Regexp(data.nvrMemPw ,rgx.pw ,'test')){
				//	infoObj.css('color' ,Color.err).text('비밀번호는 ' + msg[14]);	비밀번호를 잘못 입력하였을 경우
					alert('비밀번호는 ' + msg[14]);
				} else{
					infoObj.removeAttr('style').text('');
					var options = {
						type		: 'POST'
						,dataType	: 'JSON'
						,url		: '/proc/member/axMember.asp'
						,data		: data
						,async		: false
						,error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
						,success	: function(data){ Member.Login.Paser(data); }
					};
					$.ajax(options);
				};
			}
		,	Paser : function(data)
			{
				var infoObj	= $('#loginInfo');
				var msg		= Member.Msg('' ,true);
				var data	= Cmn.Eval(data);
				var list	= data.list;
				var chk		= Cmn.Bool(data.ck.rs);
				if(chk){
					if(Cmn.StrCheck(list[0].d6 ,$('#nvrMemPw').val())){
						window.location.href = mmr_pu;
					} else{
					//	infoObj.css('color' ,Color.err).text(msg[28]);	비밀번호 일치하지 않을때
						alert(msg[28]);
					};
				} else{
				//	infoObj.css('color' ,Color.err).text(msg[27]);	아이디가 일치하지 않을때
					alert(msg[27]);
				};
				Modal.Close();
			}
		}
	,	Find : {	// 아이디/비밀번호 찾기
			Obj : function()
			{
				var obj = {
					nvrMemInfoName		: $('#nvrMemInfoName')
				,	nvrMemRrnRrn0		: $('#nvrMemRrnRrn0')
				,	nvrMemRrnRrn1		: $('#nvrMemRrnRrn1')
				,	nvrMemInfoEmail0	: $('#nvrMemInfoEmail0')
				,	nvrMemInfoEmail1	: $('#nvrMemInfoEmail1')
				,	nvrMemId_			: $('#nvrMemId_')
				,	nvrMemInfoName_		: $('#nvrMemInfoName_')
				,	nvrMemRrnRrn0_		: $('#nvrMemRrnRrn0_')
				,	nvrMemRrnRrn1_		: $('#nvrMemRrnRrn1_')
				,	nvrMemInfoEmail0_	: $('#nvrMemInfoEmail0_')
				,	nvrMemInfoEmail1_	: $('#nvrMemInfoEmail1_')
				};
				return obj;
			}
		,	check : function(obj ,data ,type)
			{
				var msg	= Member.Msg('' ,true);
				var rgx	= Member.Rgx();
				var result = true;
				if(type == 'pw'){
					if((!Cmn.LenCheck(data.nvrMemId ,5 ,15) || !Regexp(data.nvrMemId ,rgx.id ,'test')) && data.nvrMemId != 'inni'){
						alert(msg[11]);
						return false;
					};
				};
				if(!Cmn.LenCheck(data.nvrMemInfoName ,2 ,20) || !Regexp(data.nvrMemInfoName ,rgx.name ,'test')){
					alert(msg[8]);
					result = false;
				} else if(!Regexp(data.nvrMemRrnRrn ,rgx.rrn ,'test')){
					alert(msg[10]);
					result = false;
				} else if(!Regexp(data.nvrMemInfoEmail ,rgx.email ,'test')){
					alert(msg[20]);
					result = false;
				};
				return result;
			}
		,	Id : {
				Submit : function()
				{
					var obj = Member.Find.Obj();
					var data = {
						procType		: 'findId'
					,	procTypeList	: 'list'
					,	nvrMemInfoName	: obj.nvrMemInfoName.val()
					,	nvrMemRrnRrn	: obj.nvrMemRrnRrn0.val() + '-' + obj.nvrMemRrnRrn1.val()
					,	nvrMemInfoEmail	: obj.nvrMemInfoEmail0.val() + '@' + obj.nvrMemInfoEmail1.val()
					};
					var chk = Member.Find.check(obj ,data ,'id');
					if(!chk){
						return;
					} else{
						var options = {
							type		: 'POST'
							,dataType	: 'JSON'
							,url		: '/proc/member/axMember.asp'
							,data		: data
							,async		: false
							,error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
							,success	: function(data){ Member.Find.Id.Paser(data); }
						};
						$.ajax(options);
					};
				}
			,	Paser : function(data)
				{
					var msg		= Member.Msg('' ,true);
					var data	= Cmn.Eval(data);
					var list	= data.list;
					var chk		= Cmn.Bool(data.ck.rs);
					if(chk){
						//아래 내용은 실서버 이전할때 지워야 함.
					//	alert('회원님의 아이디는 ' + list[0].d5 + '입니다.');
						alert(msg[30]);
					} else{
						alert(msg[29]);
					};
				}
			}
		,	Pw : {
				Submit : function()
				{
					var obj = Member.Find.Obj();
					var data = {
						procType		: 'findPw'
					,	procTypeList	: 'list'
					,	nvrMemId		: obj.nvrMemId_.val()
					,	nvrMemInfoName	: obj.nvrMemInfoName_.val()
					,	nvrMemRrnRrn	: obj.nvrMemRrnRrn0_.val() + '-' + obj.nvrMemRrnRrn1_.val()
					,	nvrMemInfoEmail	: obj.nvrMemInfoEmail0_.val() + '@' + obj.nvrMemInfoEmail1_.val()
					};
					var chk = Member.Find.check(obj ,data ,'pw');
					if(!chk){
						return;
					} else{
						var options = {
							type		: 'POST'
							,dataType	: 'JSON'
							,url		: '/proc/member/axMember.asp'
							,data		: data
							,async		: false
							,error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
							,success	: function(data){ Member.Find.Pw.Paser(data); }
						};
						$.ajax(options);
					};
				}
			,	Paser : function(data)
				{
					var msg		= Member.Msg('' ,true);
					var data	= Cmn.Eval(data);
					var list	= data.list;
					var chk		= Cmn.Bool(data.ck.rs);
					if(chk){
						//아래 내용은 실서버 이전할때 지워야 함.
					//	alert('회원님의 비밀번호는 ' + list[0].d6 + '입니다.');
						alert(msg[30]);
					} else{
						alert(msg[29]);
					};
				}
			}
		}
	,	Save : {
			Obj : function()
			{
				var obj = {
					bitSetMemAgreeA			: (ck_bitSetMemAgreeA) ? $('#bitSetMemAgreeA') : ''
				,	bitSetMemAgreeB			: (ck_bitSetMemAgreeB) ? $('#bitSetMemAgreeB') : ''
				,	bitSetMemAgreeC			: (ck_bitSetMemAgreeC) ? $('#bitSetMemAgreeC') : ''
				,	bitSetMemAgreeD			: (ck_bitSetMemAgreeD) ? $('#bitSetMemAgreeD') : ''
				,	bitSetMemAgreeE			: (ck_bitSetMemAgreeE) ? $('#bitSetMemAgreeE') : ''
	
				,	fkMem_Category			: $('#fkMem_Category')
				,	nvrMemId				: $('#nvrMemId')
				,	nvrMemIdOlp				: $('#nvrMemIdOlp')
				,	nvrMemPw				: $('#nvrMemPw')
				,	nvrMemPwChk				: $('#nvrMemPwChk')
				,	nvrMemNicname			: $('#nvrMemNicname')
				,	nvrMemNicnameOlp		: $('#nvrMemNicnameOlp')
	
				,	nvrMemInfoName			: $('#nvrMemInfoName')
				,	nvrMemInfoEmail0		: $('#nvrMemInfoEmail0')
				,	nvrMemInfoEmail1		: $('#nvrMemInfoEmail1')
				,	nvrMemInfoEmail2		: $('#nvrMemInfoEmail2')
				,	emailAttct				: $('#emailAttct')
				,	qCode					: $('#qCode')
				,	nvrMemInfoMobile0		: $('#nvrMemInfoMobile0')
				,	nvrMemInfoMobile1		: $('#nvrMemInfoMobile1')
				,	nvrMemInfoMobile2		: $('#nvrMemInfoMobile2')
				,	bitMemInfoAgreeE		: $('#bitMemInfoAgreeE')
				,	bitMemInfoAgreeM		: $('#bitMemInfoAgreeM')
	
				,	nvrMemRrnAge			: $('#nvrMemRrnAge')
				//	block3
				,	nvrMemRrnRrn			: $('#nvrMemRrnRrn')
				,	nvrMemRrnRrn0			: $('#nvrMemRrnRrn0')
				,	nvrMemRrnRrn1			: $('#nvrMemRrnRrn1')
				,	bitMemRrnSex			: $('#bitMemRrnSex')
	
				,	fkMemOtr_zipcode		: $('#fkMemOtr_zipcode')
				,	ncrMemOtrZipcode		: $('#ncrMemOtrZipcode')
				,	nvrMemOtrSido			: $('#nvrMemOtrSido')
				,	nvrMemOtrGugun			: $('#nvrMemOtrGugun')
				,	nvrMemOtrDong			: $('#nvrMemOtrDong')
				,	nvrMemOtrBunji			: $('#nvrMemOtrBunji')
				,	nvrMemOtrPhone			: $('#nvrMemOtrPhone')
				,	nvrMemOtrMemo			: $('#nvrMemOtrMemo')
				,	bitMemOtrMarried		: $('#bitMemOtrMarried')
	
				,	sc_by					: $('#sc_by')
				,	sc_order				: $('#sc_order')
	
				,	sc_bitMemWdrCheck		: $('#sc_bitMemWdrCheck')
				,	sc_fkMem_Category		: $('#sc_fkMem_Category')
				,	sc_intCtgGroup			: $('#sc_intCtgGroup')
				,	sc_bitMemRrnSex			: $('#sc_bitMemRrnSex')
				,	sc_bitMemOtrMarried		: $('#sc_bitMemOtrMarried')
				,	sc_nvrMemInfoEmail		: $('#sc_nvrMemInfoEmail')
				,	sc_bitMemInfoAgreeE		: $('#sc_bitMemInfoAgreeE')
				,	sc_bitMemInfoAgreeM		: $('#sc_bitMemInfoAgreeM')
				,	sc_nvrMemRrnRrn			: $('#sc_nvrMemRrnRrn')
				,	sc_nvrMemRrnAgeSt		: $('#sc_nvrMemRrnAgeSt')
				,	sc_nvrMemRrnAgeEd		: $('#sc_nvrMemRrnAgeEd')
				,	sc_nvrMemId				: $('#sc_nvrMemId')
				,	sc_nvrMemNicname		: $('#sc_nvrMemNicname')
				,	sc_nvrMemInfoName		: $('#sc_nvrMemInfoName')
				,	sc_dtMemJoinSt			: $('#sc_dtMemJoinSt')
				,	sc_dtMemJoinEd			: $('#sc_dtMemJoinEd')
				};
				return obj;
			}
		,	Submit : {
				Step1 : function()
				{
					var obj		= Member.Save.Obj();
					var data = {
						procType				: 'overlap'
					,	procTypeList			: 'list'
					,	intPage					: ''
					,	intPagesize				: ''
					,	bitSetMemAgreeA			: (ck_bitSetMemAgreeA) ? obj.bitSetMemAgreeA.is(':checked') : ''
					,	bitSetMemAgreeB			: (ck_bitSetMemAgreeB) ? obj.bitSetMemAgreeB.is(':checked') : ''
					,	bitSetMemAgreeC			: (ck_bitSetMemAgreeC) ? obj.bitSetMemAgreeC.is(':checked') : ''
					,	bitSetMemAgreeD			: (ck_bitSetMemAgreeD) ? obj.bitSetMemAgreeD.is(':checked') : ''
					,	bitSetMemAgreeE			: (ck_bitSetMemAgreeE) ? obj.bitSetMemAgreeE.is(':checked') : ''

					,	nvrMemInfoName			: (tmpJoinStep == 1) ? obj.nvrMemInfoName.val() : ''

					,	nvrMemRrnAge			: (tmpJoinStep == 2) ? obj.nvrMemRrnAge.val() : ''
					,	nvrMemRrnRrn			: (tmpJoinStep == 1) ? (obj.nvrMemRrnRrn0.val() + '-' + obj.nvrMemRrnRrn1.val()) : ''
					,	bitMemRrnSex			: (tmpJoinStep == 1) ? Str.SexRrn(obj.nvrMemRrnRrn0.val() + '-' + obj.nvrMemRrnRrn1.val()) : ''
					};
					var chk		= Member.Check(obj ,data);
					//	이용약관 체크
					if(ck_bitSetMemAgreeA && !data.bitSetMemAgreeA){
						alert(Member.Msg(1));
						return false;
					} else if(ck_bitSetMemAgreeB && !data.bitSetMemAgreeB){
						alert(Member.Msg(2));
						return false;
					} else if(ck_bitSetMemAgreeC && !data.bitSetMemAgreeC){
						alert(Member.Msg(3));
						return false;
					} else if(ck_bitSetMemAgreeD && !data.bitSetMemAgreeD){
						alert(Member.Msg(4));
						return false;
					} else if(ck_bitSetMemAgreeE && !data.bitSetMemAgreeE){
						alert(Member.Msg(5));
						return false;
					};
					if(chk){
						$('#tmpJoinStep').val('2');
						$('#fmMember').submit();
					} else{
						alert(Member.Msg(0));
					};
				}
			,	Step2 : function(type)
				{
					var obj		= Member.Save.Obj();
					var data = {
						procType				: (type == "modi") ? 'update' : 'insert'
					,	procTypeList			: ''
					
					,	pkMember				: (type == 'modi') ? $('#pkMember').val() : ''
					,	fkMem_Category			: (type == "modi") ? '' : obj.fkMem_Category.val()
					,	nvrMemId				: (type == "modi") ? '' : obj.nvrMemId.val()
					,	nvrMemIdOlp				: (type == "modi") ? '' : obj.nvrMemIdOlp.val()
					,	nvrMemPw				: obj.nvrMemPw.val()
					,	nvrMemPwChk				: obj.nvrMemPwChk.val()
					,	nvrMemNicname			: (type == "modi") ? '' : obj.nvrMemNicname.val()
					,	nvrMemNicnameOlp		: (type == "modi") ? '' : obj.nvrMemNicnameOlp.val()

					,	nvrMemInfoName			: (type == "modi") ? '' : obj.nvrMemInfoName.val()
					,	qCode					: obj.qCode.val()
					,	emailAttct				: obj.emailAttct.val()
					,	nvrMemInfoEmail			: obj.nvrMemInfoEmail0.val() + '@' + obj.nvrMemInfoEmail1.val()
					,	nvrMemInfoMobile		: obj.nvrMemInfoMobile0.val() + '-' + obj.nvrMemInfoMobile1.val() + '-' + obj.nvrMemInfoMobile2.val()
					,	bitMemInfoAgreeE		: obj.bitMemInfoAgreeE.is(':checked') ? '1' : '0'
					,	bitMemInfoAgreeM		: obj.bitMemInfoAgreeM.is(':checked') ? '1' : '0'

					,	nvrMemRrnRrn			: obj.nvrMemRrnRrn0.val() + '-' + obj.nvrMemRrnRrn1.val()

					,	fkMemOtr_zipcode		: obj.fkMemOtr_zipcode.val()
					,	ncrMemOtrZipcode		: obj.ncrMemOtrZipcode.val()
					,	nvrMemOtrSido			: obj.nvrMemOtrSido.val()
					,	nvrMemOtrGugun			: obj.nvrMemOtrGugun.val()
					,	nvrMemOtrDong			: obj.nvrMemOtrDong.val()
					,	nvrMemOtrBunji			: obj.nvrMemOtrBunji.val()
					,	nvrMemOtrPhone			: obj.nvrMemOtrPhone.val()
					,	nvrMemOtrMemo			: obj.nvrMemOtrMemo.val()
					,	bitMemOtrMarried		: obj.bitMemOtrMarried.val()
					};
					var chk		= Member.Check(obj ,data ,type);
					if(chk){
						$('#tmpJoinStep').val('3');
						$('#fmMember').submit();
					} else{
						alert(Member.Msg(0));
					};
				}
			}
		,	Data : function(obj ,val)
			{
				var data = {
					procType				: val.procType
				,	procTypeList			: val.procTypeList
				,	intPage					: val.intPage
				,	intPagesize				: val.intPagesize
				,	bitSetMemAgreeA			: (ck_bitSetMemAgreeA) ? obj.bitSetMemAgreeA.is(':checked') : ''
				,	bitSetMemAgreeB			: (ck_bitSetMemAgreeB) ? obj.bitSetMemAgreeB.is(':checked') : ''
				,	bitSetMemAgreeC			: (ck_bitSetMemAgreeC) ? obj.bitSetMemAgreeC.is(':checked') : ''
				,	bitSetMemAgreeD			: (ck_bitSetMemAgreeD) ? obj.bitSetMemAgreeD.is(':checked') : ''
				,	bitSetMemAgreeE			: (ck_bitSetMemAgreeE) ? obj.bitSetMemAgreeE.is(':checked') : ''

				,	pkMember				: obj.pkMember.val()
				,	fkMem_Category			: obj.fkMem_Category.val()
				,	nvrMemId				: obj.nvrMemId.val()
				,	nvrMemIdOlp				: obj.nvrMemIdOlp.val()
				,	nvrMemPw				: obj.nvrMemPw.val()
				,	nvrMemNicname			: obj.nvrMemNicname.val()

				,	nvrMemInfoName			: obj.nvrMemInfoName.val()
				,	nvrMemInfoEmail			: obj.nvrMemInfoEmail.val()
				,	nvrMemInfoMobile		: obj.nvrMemInfoMobile.val()
				,	bitMemInfoAgreeE		: obj.bitMemInfoAgreeE.val()
				,	bitMemInfoAgreeM		: obj.bitMemInfoAgreeM.val()

				,	nvrMemRrnAge			: obj.nvrMemRrnAge.val()
				,	nvrMemRrnRrn			: obj.nvrMemRrnRrn.val()
				,	bitMemRrnSex			: obj.bitMemRrnSex.val()

				,	fkMemOtr_zipcode		: obj.fkMemOtr_zipcode.val()
				,	ncrMemOtrZipcode		: obj.ncrMemOtrZipcode.val()
				,	nvrMemOtrSido			: obj.nvrMemOtrSido.val()
				,	nvrMemOtrGugun			: obj.nvrMemOtrGugun.val()
				,	nvrMemOtrDong			: obj.nvrMemOtrDong.val()
				,	nvrMemOtrBunji			: obj.nvrMemOtrBunji.val()
				,	nvrMemOtrPhone			: obj.nvrMemOtrPhone.val()
				,	nvrMemOtrMemo			: obj.nvrMemOtrMemo.val()
				,	bitMemOtrMarried		: obj.bitMemOtrMarried.val()


				,	arr_pkMember			: val.arr_pkMember.val()
				,	arr_fkMem_Category		: val.arr_fkMem_Category.val()
				,	arr_nvrMemPw			: val.arr_nvrMemPw.val()
				,	arr_nvrMemNicname		: val.arr_nvrMemNicname.val()
				,	arr_nvrMemInfoName		: val.arr_nvrMemInfoName.val()
				,	arr_nvrMemInfoEmail		: val.arr_nvrMemInfoEmail.val()
				,	arr_nvrMemInfoMobile	: val.arr_nvrMemInfoMobile.val()
				,	arr_bitMemInfoAgreeE	: val.arr_bitMemInfoAgreeE.val()
				,	arr_bitMemInfoAgreeM	: val.arr_bitMemInfoAgreeM.val()
				,	arr_nvrMemRrnAge		: val.arr_nvrMemRrnAge.val()
				,	arr_nvrMemRrnRrn		: val.arr_nvrMemRrnRrn.val()
				,	arr_bitMemRrnSex		: val.arr_bitMemRrnSex.val()
				,	arr_fkMemOtr_zipcode	: val.arr_fkMemOtr_zipcode.val()
				,	arr_ncrMemOtrZipcode	: val.arr_ncrMemOtrZipcode.val()
				,	arr_nvrMemOtrSido		: val.arr_nvrMemOtrSido.val()
				,	arr_nvrMemOtrGugun		: val.arr_nvrMemOtrGugun.val()
				,	arr_nvrMemOtrDong		: val.arr_nvrMemOtrDong.val()
				,	arr_nvrMemOtrBunji		: val.arr_nvrMemOtrBunji.val()
				,	arr_nvrMemOtrPhone		: val.arr_nvrMemOtrPhone.val()
				,	arr_nvrMemOtrMemo		: val.arr_nvrMemOtrMemo.val()
				,	arr_bitMemOtrMarried	: val.arr_bitMemOtrMarried.val()
				,	arr_bitMemWdrCheck		: val.arr_bitMemWdrCheck.val()

				,	sc_by					: obj.sc_by.val()
				,	sc_order				: obj.sc_order.val()

				,	sc_bitMemWdrCheck		: obj.sc_bitMemWdrCheck.val()
				,	sc_fkMem_Category		: obj.sc_fkMem_Category.val()
				,	sc_intCtgGroup			: obj.sc_intCtgGroup.val()
				,	sc_bitMemRrnSex			: obj.sc_bitMemRrnSex.val()
				,	sc_bitMemOtrMarried		: obj.sc_bitMemOtrMarried.val()
				,	sc_nvrMemInfoEmail		: obj.sc_nvrMemInfoEmail.val()
				,	sc_bitMemInfoAgreeE		: obj.sc_bitMemInfoAgreeE.val()
				,	sc_bitMemInfoAgreeM		: obj.sc_bitMemInfoAgreeM.val()
				,	sc_nvrMemRrnRrn			: obj.sc_nvrMemRrnRrn.val()
				,	sc_nvrMemRrnAgeSt		: obj.sc_nvrMemRrnAgeSt.val()
				,	sc_nvrMemRrnAgeEd		: obj.sc_nvrMemRrnAgeEd.val()
				,	sc_nvrMemId				: obj.sc_nvrMemId.val()
				,	sc_nvrMemNicname		: obj.sc_nvrMemNicname.val()
				,	sc_nvrMemInfoName		: obj.sc_nvrMemInfoName.val()
				,	sc_dtMemJoinSt			: obj.sc_dtMemJoinSt.val()
				,	sc_dtMemJoinEd			: obj.sc_dtMemJoinEd.val()
				};
				return data;
			}
		}
	,	Check : function(obj ,data ,type)
		{
			var chk = true;
			if(tmpJoinStep == 0 || tmpJoinStep == 1){
				if(Cmn.BlankBool(data.nvrMemInfoName)){
					$('#' + obj.nvrMemInfoName.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(6));
					chk = false;
				} else if(data.nvrMemInfoName.length < 2 || !Regexp(data.nvrMemInfoName ,/^[가-힣a-zA-Z]{1,}$/ ,'test')){
					$('#' + obj.nvrMemInfoName.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(8));
					chk = false;
				} else{
					$('#' + obj.nvrMemInfoName.attr('id') + 'Info').text('');
				};
				if(Cmn.BlankBool(data.nvrMemRrnRrn.replace('-',''))){
					$('#' + obj.nvrMemRrnRrn0.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(7));
					chk = false;
				} else if(!Regexp(data.nvrMemRrnRrn.replace('-','') ,/^[0-9]{1,}$/ ,'test')){
					$('#' + obj.nvrMemRrnRrn0.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(9));
					chk = false;
				} else if(!Regexp(data.nvrMemRrnRrn ,/^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))-[1-4][0-9]{6}$/ ,'test')){
					$('#' + obj.nvrMemRrnRrn0.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(10));
					chk = false;
				} else{
					$('#' + obj.nvrMemRrnRrn0.attr('id') + 'Info').text('');
				};
			};
			if(tmpJoinStep == 0 || tmpJoinStep == 2){
				if(type != "modi" && (!Cmn.LenCheck(data.nvrMemId ,5 ,15) || !Regexp(data.nvrMemId ,/^[0-9a-z]{1,}$/ ,'test'))){
					$('#' + obj.nvrMemId.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(11));
					chk = false;
				} else if(type != "modi" && (data.nvrMemId != data.nvrMemIdOlp)){
					obj.nvrMemIdOlp.val('');
					$('#' + obj.nvrMemId.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(13));
					chk = false;
				};
				if(!Cmn.LenCheck(data.nvrMemPw ,5 ,15) || !Regexp(data.nvrMemPw ,/^[0-9a-z!@#$]{1,}$/ ,'test')){
					$('#' + obj.nvrMemPw.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(14));
					chk = false;
				} else{
					$('#' + obj.nvrMemPw.attr('id') + 'Info').text('');
				};
				if(data.nvrMemPw != data.nvrMemPwChk){
					$('#' + obj.nvrMemPwChk.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(15));
					chk = false;
				} else{
					$('#' + obj.nvrMemPwChk.attr('id') + 'Info').text('');
				};
				if(type != "modi" && (!Cmn.LenCheck(data.nvrMemNicname ,2 ,8) || !Regexp(data.nvrMemNicname ,/^[가-힣0-9a-zA-Z]{1,}$/ ,'test'))){
					$('#' + obj.nvrMemNicname.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(16));
					chk = false;
				};
				if(type != "modi" && (data.nvrMemNicname != data.nvrMemNicnameOlp)){
					$('#' + obj.nvrMemNicname.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(18));
					chk = false;
				};
				if(!Regexp(data.nvrMemInfoEmail ,/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/ ,'test')){
					$('#' + obj.nvrMemInfoEmail0.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(20));
					chk = false;
				} else{
					$('#' + obj.nvrMemInfoEmail0.attr('id') + 'Info').removeAttr('style').text(Member.Msg(19));
				};
//				if(Cmn.BlankBool(data.qCode) || data.qCode != data.emailAttct){
//					$('#' + obj.emailAttct.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(23));
//					chk = false;
//				};
				if(!Regexp(data.nvrMemInfoMobile ,/^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/ ,'test')){
					$('#' + obj.nvrMemInfoMobile0.attr('id') + 'Info').css('color' ,Color.err).text(Member.Msg(26));
					chk = false;
				} else{
					$('#' + obj.nvrMemInfoMobile0.attr('id') + 'Info').text('');
				};
			};
			return chk;
		}
	,	Withdraw : {
			Submit : function(ele)
			{
				var rgx			= Member.Rgx();
				var msg			= Member.Msg('' ,true);
				var nvrMemId	= $('#nvrMemId').val();
				var nvrMemPw	= $('#nvrMemPw').val();
				if(Cmn.BlankBool(nvrMemId) || !Cmn.LenCheck(nvrMemId ,5 ,15) || !Regexp(nvrMemId ,rgx.id ,'test') || nvrMemId == 'inni'){
					alert('아이디는 ' + msg[11]);
				} else if(Cmn.BlankBool(nvrMemPw) || !Cmn.LenCheck(nvrMemPw ,5 ,15) || !Regexp(nvrMemPw ,rgx.pw ,'test')){
					alert('비밀번호는 ' + msg[14]);
				} else{
					$(ele).submit();
				};
			}
		}
	,	Auto : {
			Rrn : function(ele1 ,ele2)
			{
				Auto.Focus.Rrn(ele1 ,ele2);
			}
		}
	,	SearchZipcode : function()
		{
			Modal.Address('Member.SearchAddressSelect()');
		}
	,	SearchAddress : function()
		{
			var data = {
				nvrDong		: $('#scDong').val()
			};
			if(Cmn.BlankBool(data.nvrDong))
			{
				alert('동,읍,면,리,건물명을 입력하셔야 합니다.');
			}
			else
			{
				var options = {
					type		: 'POST'
					,dataType	: 'JSON'
					,url		: '/proc/searchAddress.asp'
					,data		: data
					,async		: false
					,error		: function(data){ Cmn.ErrAlert(0 ,true); }//Cmn.ErrAlert(data.errMsg ,false); }
					,success	: function(data){ Member.SearchAddressPaser(data); }
				};
				$.ajax(options);
			};
		}
	,	SearchAddressPaser : function(data)
		{
			var data	= Cmn.Eval(data);
			var chk		= Cmn.Bool(data.ck.rs);
			var html	= [];
			if(chk)
			{
				var daList	= data.list;
				var val1 ,val2;
				for(var ix = 0; ix < daList.length; ++ix)
				{
					val1 = daList[ix].d1 + '`' + daList[ix].d2 + '`' + daList[ix].d3 + '`' + daList[ix].d4 + '`' + daList[ix].d5 + '`' + daList[ix].d6 + '`' + daList[ix].d7 + '';
					val2 = '[' + daList[ix].d2 + '] ' + daList[ix].d3 + ' ' + daList[ix].d4 + ' ' + daList[ix].d5 + ' ' + daList[ix].d6 + '';
					html[ix] = '<option value="' + val1 + '">' + val2 + '</option>';
				};
			}
			else
			{
				html[0] = '<option value="">검색주소가 없습니다.</option>';
			};
			$('#nvrAddressSearchList').html(html.join(''));
		}
	,	SearchAddressSelect : function()
		{
			var nvrAddressSearchList	= $('#nvrAddressSearchList option:selected').val();
			if(Cmn.BlankBool(nvrAddressSearchList))
			{
				alert('주소를 선택하셔야 합니다.');
			}
			else
			{
				var arrAddressSearchList	= nvrAddressSearchList.split('`');
				var nvrAddressSearchOther	= $('#nvrAddressSearchOther').val();
				if(Cmn.BlankBool(nvrAddressSearchOther))
				{
					alert('나머지 주소를 입력해 주세요.');
				}
				else
				{
					$('#fkMemOtr_zipcode').val(arrAddressSearchList[0]);
					$('#ncrMemOtrZipcode0').val((arrAddressSearchList[1].split('-'))[0]);
					$('#ncrMemOtrZipcode1').val((arrAddressSearchList[1].split('-'))[1]);
					var address = arrAddressSearchList[2] + ' ' + arrAddressSearchList[3] + ' ' + arrAddressSearchList[4] + ' ' + arrAddressSearchList[5];
					$('#nvrMemOtrAddress0').val(address);
					$('#nvrMemOtrAddress1').val(nvrAddressSearchOther);
					$('#nvrMemOtrSido').val(arrAddressSearchList[2]);
					$('#nvrMemOtrGugun').val(arrAddressSearchList[3]);
					$('#nvrMemOtrDong').val(arrAddressSearchList[4]);
					$('#nvrMemOtrBunji').val(arrAddressSearchList[5]);
					Modal.Close();
				};
			};
		}
	};
})(jQuery);