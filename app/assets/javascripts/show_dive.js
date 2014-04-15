$('.dives.show').ready(function(){
	$(".fancybox").fancybox();
	
	$(".thumb:last").hide();

	$(".uploader").bind("fileuploaddone", function (e, data) {
    console.log("WORK PLEASE");
    $(".fancybox").fancybox();    

	});

	$(".remove-icon").click(function(e){
		e.preventDefault();
		console.log($(this).data('photo-id'));
		$.ajax({
  		url: "/photos/" + $(this).data('photo-id'),
  		type: "post",
  		dataType: "json",
  		data: {"_method":"delete"}
		});
		$(this).closest("div").remove();

	});

	$('#fish_search').submit(function(event){

		event.preventDefault(); //prevent form submit

		var id = $('#fish_search').data('id');
		var fish_name = $('#name').val();

		$.post('/dives/'+id+'/fish', {name: fish_name}, function(dive_fish){
			console.log(dive_fish);

			$('#fish').empty();
			$.each(dive_fish, function(i, fish) {

				var this_fish =  '<div class="col-md-6">'+
						          '<div class="thumbnail">'+
						            '<img src="http://'+fish.picture_link+'">'+
						             '<div class="caption">'+
						              '<h3>'+fish.name+'</h3>'+
						            '</div>'+
						          '</div>'+
						        '</div>';

				$('#fish').append(this_fish);
			});

		});

	});

});