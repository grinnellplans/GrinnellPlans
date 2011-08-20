// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
