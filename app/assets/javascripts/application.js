//= require jquery
//= require jquery_ujs

function toggleShowHide(target, caller, showText, hideText) {
	// Where's my dollar sign :(
	target = document.getElementById(target);

	if (target.style.display != 'none') {
		target.style.display = 'none';
		linkText = showText;
	} else {
		target.style.display = '';
		linkText = hideText;
	}
	caller.innerHTML = linkText;
}
