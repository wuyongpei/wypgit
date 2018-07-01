document
		.write('<script type="text/javascript" src="static/laydate/laydate.js"></script>');
function resetForm(id) {
	if (confirm("确认清空？")) {
		document.getElementById(id).reset();
	}
}

function slideNext(id) {
	$(id).next().slideToggle("slow");
	$(id).find("i").each(function() {
		if ($(this).hasClass('dpn')) {
			$(this).removeClass('dpn');
		} else {
			$(this).addClass('dpn');
		}

	})
}

function getDate(id) {
	$(id).datepicker({
		autoclose : true,
		format : 'yyyy-mm-dd'
	});
}

function getDateTime(id) {
	laydate.render({
		elem : id,
		theme : 'molv',
		type : 'datetime'
	});
}

function getAllCity(id, id1, id2) {
	getCity($(id).val(), id1, id2);

	$(id).change(function() {
		getCity($(this).val(), id1, id2);
	})
	$(id1).change(function() {
		getCountry($(this).val(), id2);
	})
}

function getCity(parentID, id1, id2) {
	$.post("zone/getCity.do", {
		parentID : parentID
	}, function(result) {
		$(id1).find("option").remove();
		var ofArray = new Object();
		ofArray = result;
		if (ofArray != '') {
			$(id1).append(
					"<option value=" + ofArray[0].ID + " selected='selected'>"
							+ ofArray[0].CName + "</option>");
			for (var i = 1; i < ofArray.length; i++) {
				$(id1).append(
						"<option value=" + ofArray[i].ID + ">"
								+ ofArray[i].CName + "</option>");
			}
			if (id2 != '') {
				getCountry($(id1).val(), id2);
			}
		}
	});
}

function getCountry(parentID, id1) {
	$.post("zone/getCity.do", {
		parentID : parentID
	}, function(result) {
		$(id1).find("option").remove();
		var ofArray = new Object();
		ofArray = result;
		if (ofArray != '') {
			$(id1).append(
					"<option value=" + ofArray[0].ID + " selected='selected'>"
							+ ofArray[0].CName + "</option>");
			for (var i = 1; i < ofArray.length; i++) {
				$(id1).append(
						"<option value=" + ofArray[i].ID + ">"
								+ ofArray[i].CName + "</option>");
			}
		}
	});
}

function submit(form) {
	ifSubmit = true;
	$(form).find('[required="required"]').each(function() {
		if ($(this).val() == '' || $(this).val() == null) {
			$(this).tips({
				side : 3,
				msg : '这是必填字段',
				bg : '#AE81FF',
				time : 2
			});

			if (ifSubmit) {
				$(this).focus();
				ifSubmit = false;
			}
		}
	});
	if (ifSubmit) {
		$(form).submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
		alert("保存成功！")
	} else {
		return ifSubmit;
	}
}
