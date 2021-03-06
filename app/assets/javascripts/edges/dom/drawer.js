
/* global $ */

/* global accept */
/* global canvas */
/* global guide */

var dom = dom || {};


dom.addNodeList = function( node ) {
	var index = node.index;
	var $container = $("#nodes-index");
	var temp = "";
	temp += "<div id='from-node-index-" + index + "' class='panel panel-primary" + ((node.is_gaze)? ' gaze':'') + "'>";
	temp += "<a class='btn btn-primary btn-block panel-heading' role='button' data-toggle='collapse' data-parent='#nodes-index' href='#from-node-list-" + index + "' aria-expanded='false' aria-controls='from-node-list-" + index + "'>";
	temp += "<h4 class='panel-title'>";
	temp += "<span class='name'></span>";
	temp += "<span class='badge pull-right'>0</span>";
	temp += "</h4>";
	temp += "</a>";
	temp += "<div id='from-node-list-" + index + "' class='panel-collapse collapse' role='tabpanel' aria-labelledby='from-node-index-" + index + "' data-parent='#nodes-index'>";
	temp += "<div class='list-group'>";
	temp += "</div>";
	temp += "</div>";
	temp += "</div>";
	$container.append(temp).find("#from-node-index-" + index + " .name").text(node.name);
	
	$("#node-words").append("<option id='word-index-" + index + "'>").find("#word-index-" + index).attr("value", node.name);
	
	$container.find("#from-node-index-" + index).click( canvas.setFocusEvent );
};

dom.removeNodeList = function( node ) {
	$( "#from-node-index-" + node.index ).remove();
	$( "#word-index-" + node.index ).remove();
};

dom.scrollNodeList = function( from_node ) {
	var $box = $("#drawer .drawer-body");
	var $target = $("#from-node-index-" + from_node.index);
	var $list = $("#nodes-index");
	var index = $list.children(":visible").index($target);
	var pos = $box.scrollTop() + ($list.offset().top + 46 * index) - $box.offset().top - 10;

	$("#from-node-list-" + from_node.index).collapse("show");
	$box.stop().animate({ scrollTop: pos }, 500, "swing");
};

dom.addEdgeList = function( is_owner, edge ) {
	var from_node = edge.from_node;
	var to_node = edge.to_node;
	var $container = $( "#from-node-index-" + from_node.index );
	var $to_node = $container.find( "#to-node-index-" + from_node.index + "-" + to_node.index );
	
	var sum = 0;
	for( var key in from_node.to_edges ) {
		sum += from_node.to_edges[key].count;
	}
	$container.find(".panel-title .badge").text(sum);

	if( $to_node.find(".badge").length > 0 ) {
		$to_node.find(".badge").text(edge.count);
	} else {
		var temp = "";
		temp += "<a id='to-node-index-" + from_node.index + "-" + to_node.index + "' class='list-group-item'>";
		temp += "<span class='name'></span>";
		temp += "<span class='badge pull-right'>" + edge.count + "</span>";
		temp += "</a>";
		$container.find(".list-group").append(temp)
			.find("#to-node-index-" + from_node.index + "-" + to_node.index).attr("href", encodeURIComponent(from_node.name) + "/" + encodeURIComponent(to_node.name))
			.find(".name").text(to_node.name);
		
		$to_node = $container.find( "#to-node-index-" + from_node.index + "-" + to_node.index );
		$to_node.click( canvas.onClickEdgeEvent );
	}
	if( is_owner ) {
		$to_node.addClass("is-owner");
	}
};

dom.removeEdgeList = function( is_owner, edge ) {
	var from_node = edge.from_node;
	var to_node = edge.to_node;
	var $container = $( "#from-node-index-" + from_node.index );
	var $to_node = $container.find( "#to-node-index-" + from_node.index + "-" + to_node.index );

	var sum = 0;
	for( var key in from_node.to_edges ) {
		sum += from_node.to_edges[key].count;
	}
	$container.find(".panel-title .badge").text(sum);

	if( edge.count > 0 && ($to_node.find(".badge").length > 0) ) {
		$to_node.find(".badge").text(edge.count);
	} else {
		$to_node.remove();
	}
};


dom.filterEdgeList= function() {
	var text = $("#edge-list-filter").val();
	if( "" == text ) {
		$("#nodes-index .panel").show();
		return;
	}
	
	$("#nodes-index .panel").hide();
	$("#nodes-index .name:contains('" + text + "')").closest(".panel").show();
};

dom.resetEdgeList = function() {
	$("#edge-list-filter").val("");
	dom.filter();
};


/**
 * ドロワー初期化
 */
dom.initDrawer = function() {
	
	$("#edge-list-filter").keyup(function () {
		dom.filterEdgeList();
		return (13 !== event.which);
	});
	dom.filterEdgeList();
	
	$("#drawer .drawer-open").click(function() {
		var $div = $("#drawer .drawer-body");
		var $icon = $("#drawer .drawer-open span");
		if($div.hasClass("in")) {
			$div.removeClass("in");
			$icon.addClass("glyphicon-triangle-left");
			$icon.removeClass("glyphicon-triangle-right");
		} else {
			$div.addClass("in");
			$icon.removeClass("glyphicon-triangle-left");
			$icon.addClass("glyphicon-triangle-right");
			if( !accept.current_id ) return;
			guide.setTour(guide.step.OPEN_EMPATHY_USERS_FORM, [guide.step.OPEN_NODE_LIST]);
		}
	});
	
	if( window.innerWidth > 1500 ) {
		$("#drawer .drawer-open").click();
	}
	
};
