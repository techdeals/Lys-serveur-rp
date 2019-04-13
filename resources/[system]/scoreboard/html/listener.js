$(function()
{
    window.addEventListener('message', function(event)
    {
        var item = event.data;
        var buf = $('#wrap');
        
				$('#ems').html(event.data.ems);
		$('#police').html(event.data.police);
		$('#taxi').html(event.data.taxi);
		$('#mecano').html(event.data.mek);
		$('#bil').html(event.data.bil);
		$('#maklare').html(event.data.maklare);
		$('#ica').html(event.data.ica);
		$('#spelare').html(event.data.spelare);
	//	$('#ptbl').html(event.data.text);
		
        if (item.meta && item.meta == 'close')
        {
            $('#wrap').hide();
            return;
        }
        $('#wrap').show();
    }, false);
	
});


