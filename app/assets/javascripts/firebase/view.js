
/* global $ */
/* global firebase */

var imaginnection = imaginnection || {};


/** 
 * edge関連
 */

// 共感者一覧表示
imaginnection.viewUserList = function( from_node_name, to_node_name ) {
	// ログイン時のみ
  if( !imaginnection.current_id ) return;
	
  var data = imaginnection.dbdata.edges[from_node_name][to_node_name];
  var post_data = [];
  var count = 0;
  var is_hide_user = false;
  
  if( data["users"] ) {
    var users = data["users"];
    for( var key in users ) {
      count++;
      if( key == imaginnection.current_id ) is_hide_user = users[key].is_hide_user;
      if( !users[key].is_hide_user ) post_data.push(key);
    }
  }
  
  $.ajax({
    url: "/edges/users",
    type: "GET",
    data: {from_node: from_node_name, to_node: to_node_name, is_hide_user: is_hide_user, content: post_data, count: count},
    datatype: "html",
  }).done(function(data) {
  	if( imaginnection.tour && imaginnection.tour.getCurrentStep() == 8 ) {
  		setTimeout( function() {
  			imaginnection.setTour(9);
  		}, 500);
  	}
  });
};
