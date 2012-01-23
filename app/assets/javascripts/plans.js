//= require jquery

function checkPlanLength() {
	var editText = $('#edit_textarea');
	var planLength = editText.val().length;
	var perc = Math.round( planLength * 100 / 65535 );
	if (perc != editText.data('perc')) {
		var fillMeter = $('#edit_fill_meter');
		// Add or remove danger warning as appropriate
		if (perc >= 100 && editText.data('perc') < 100) {
			fillMeter.addClass('danger');
		} else if (window.perc >= 100 && perc < 100) {
			fillMeter.removeClass('danger');
		}
		// Set the values of the progress bar and percent text
        $('#edit_fill_meter .full_amount').css('width', Math.min(perc, 100) + '%');
        $('#edit_fill_meter .fill_percent').text(perc + '%');
        // Store the current percent so we don't bother to edit the DOM until this changes
		editText.data('perc', perc);
	}
}
$(document).ready(checkPlanLength);
