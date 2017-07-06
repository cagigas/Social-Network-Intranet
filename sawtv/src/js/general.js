/*$(document).ready(function(){
	$('.menu a').click(function(){

		elem = this;
/*
		$('.menu a').removeClass('active');
		$(this).addClass('active');*/

/*		$('.container-middle').find('.visible').slideUp('normal', function(){
			$(this).addClass('hide');
			$(this).removeClass('visible');
			$('.container-middle').find($(elem).attr('href')).slideDown('normal', function(){
				$(this).removeClass('hide');
				$(this).addClass('visible');
			});
			$('.container-middle').find('#r3').slideDown('normal', function(){
				$(this).removeClass('hide');
				$(this).addClass('visible');
			});

		});

		return false;
	});
});*/

$(document).ready(function(){
	$('.categories2 a').click(function(){
		elem = this;
		if($('.container-middle3').find($(elem).attr('href')).is(":visible")) {
			$('.container-middle3').find($(elem).attr('href')).slideUp('normal', function () {
				$(this).removeClass('visible');
				$(this).addClass('hide');
			});
		}else
			$('.container-middle3').find($(elem).attr('href')).slideDown('normal', function () {
				$(this).removeClass('hide');
				$(this).addClass('visible');
			});

		return false;
	});
});

$(document).ready(function(){
	$('.categories a').click(function(){
		elem = this;

		$('.container-middle3').find('.visible').slideUp('normal', function(){
			$(this).addClass('hide');
			$(this).removeClass('visible');
			$('.container-middle3').find($(elem).attr('href')).slideDown('normal', function(){
				$(this).removeClass('hide');
				$(this).addClass('visible');
			});

		});
		return false;
	});
});


