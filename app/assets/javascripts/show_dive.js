$('.dives.show').ready(function(){
	$(".fancybox").fancybox();
	
	$(".image-container:last").hide();

	$("#fileupload").on("fileuploaddone", function (e, data) {
    console.log("fileuploaddone event fired");
	});

	$(".remove").click(function(e){
		e.preventDefault();
		$.ajax({
  		url: "/photos/" + $(this).data('photo-id'),
  		type: "post",
  		dataType: "json",
  		data: {"_method":"delete"}
		});
		$(this).closest("div").remove();

	});

});