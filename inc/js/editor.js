(function($){
	Editors = {
		Options : function()
		{
			var options	= {
				language					: 'ko'
			//	,	filebrowserImageBrowseUrl	: '/ckfinder/ckfinder.html?type=Images'
			,	filebrowserImageUploadUrl	: '/ckfinder/core/connector/asp/connector.asp?command=QuickUpload&type=Images'
			,	toolbar : [
			//['Source','-','Save','NewPage','Preview','-','Templates'],
			//['Cut','Copy','Paste','PasteText','PasteFromWord','-','Print', 'SpellChecker', 'Scayt'],
			//['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			//['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
			//'/',
			//['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			//['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			//['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			//['Link','Unlink','Anchor'],
			//['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
			//'/',
			//['Styles','Format','Font','FontSize'],
			//['TextColor','BGColor'],
			//['Maximize', 'ShowBlocks','-','About']
			//['Preview','Templates'],
			//['Cut','Copy','Paste','PasteFromWord','-','Print'],
			//['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
			['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
			//['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],
			//'/',
			['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
			['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
			['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
			//['Link','Unlink','Anchor'],
			'/',
			['Source','Templates'],
			['Styles','Format','Font','FontSize'],
			['TextColor','BGColor'],
			['About']
				]
			,	font_defaultLabel		: '돋움'
			,	fontSize_defaultLabel	: '12px'
			,	font_names				: '돋움/돋움;굴림/굴림;맑은고딕/맑은고딕;바탕/바탕;궁서/궁서;Arial/Arial;Courier;Georgia/Georgia;Helvetica;sans-serif;'
			,	enterMode				: '2'
			,	shiftEnterMode			: '1'
			};
			return options;
		}
	,	Create : function(el)
		{
			CKEDITOR.replace(el ,Editors.Options());
		}
	}
})(jQuery);