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

});