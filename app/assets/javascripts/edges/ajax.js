
/* global $ */
/* global guide */
/* global db */
/* global accept */

var ajax = ajax || {};

ajax.data = {
	notification_edges: {},
};


// 共感者一覧表示
ajax.viewUserList = function( from_node_name, to_node_name ) {
	// ログイン時のみ
	if( !accept.current_id ) return;
	
	var forward_data = db.getUserList( from_node_name, to_node_name );
	var backward_data = db.getUserList( to_node_name, from_node_name );

	$.ajax({
		url: "/edges/users",
		type: "GET",
		data: {from_node: from_node_name, to_node: to_node_name, forward_data, backward_data},
		datatype: "html",
	}).done(function(data) {
		guide.setTour(9, [8]);
	});
};


// 通知エッジ登録
ajax.setNotificationEdge = function( gaze, from_node_name, to_node_name, data ) {
	// 共感者がいないエッジはスルー
	if( !data["users"] ) return;
	
	if( !ajax.data.notification_edges[gaze] ) {
		ajax.data.notification_edges[gaze] = {};
	}
	
	ajax.data.notification_edges[gaze][from_node_name + "→" + to_node_name] = {
		"from_node": from_node_name,
		"to_node": to_node_name,
		"data": data
	};
	//console.log("add notification edge: ", gaze, from_node_name, to_node_name, data);
};

// 通知用エッジ送信
ajax.sendNotificationEdge = function() {
	if( Object.keys(ajax.data.notification_edges).length == 0 ) return;
	
	$.ajax({
		url: "/notification_logs",
		type: "POST",
		data: {data: ajax.data.notification_edges},
		datatype: "html",
	}).done(function(data) {
		//console.log("send notification edge: ", ajax.data.notification_edges);
		ajax.data.notification_edges = {};
		db.renewNotificateTimestamp();
	}).fail(function(data) {
		//console.log("fail notification edge: ", data);
	});
};