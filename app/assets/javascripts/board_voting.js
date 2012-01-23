function is_activated(arrow) {
	return (arrow.style.borderWidth);
}
function activate(arrow) {
	arrow.style.border = '#222222 thin solid';
}
function deactivate(arrow) {
	arrow.style.border = '';
	arrow.style.borderWidth = '';
}
function vote(messageid, vote) {
	yes_arrow = document.getElementById(messageid+'y');
	no_arrow = document.getElementById(messageid+'n');
	counter = document.getElementById(messageid+'c');
	num_votes = document.getElementById(messageid+'i');
	if (vote == 'y') {
		if (is_activated(yes_arrow)) {
			deactivate(yes_arrow);
			vote = '';
			counter.innerHTML = parseInt(counter.innerHTML)-1;
			num_votes.innerHTML = parseInt(num_votes.innerHTML)-1;
		} else {
			activate(yes_arrow);
			if (is_activated(no_arrow)) {
				deactivate(no_arrow);
				counter.innerHTML = parseInt(counter.innerHTML)+2;
			} else {
				counter.innerHTML = parseInt(counter.innerHTML)+1;
				num_votes.innerHTML = parseInt(num_votes.innerHTML)+1;
			}
		}
	} else {
		if (is_activated(no_arrow)) {
			deactivate(no_arrow);
			vote = '';
			counter.innerHTML = parseInt(counter.innerHTML)+1;
			num_votes.innerHTML = parseInt(num_votes.innerHTML)-1;
		} else {
			activate(no_arrow);
			if (is_activated(yes_arrow)) {
				deactivate(yes_arrow);
				counter.innerHTML = parseInt(counter.innerHTML)-2;
			} else {
				counter.innerHTML = parseInt(counter.innerHTML)-1;
				num_votes.innerHTML = parseInt(num_votes.innerHTML)+1;
			}
		}
	}

	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}
	request.open("GET", "vote_thread.php?messageid="+messageid+"&vote="+vote, true);
	request.send(null);

}
