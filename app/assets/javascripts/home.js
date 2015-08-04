
$(document).ready(initializeHome);
$(document).on('page:load', initializeHome);

function initializeHome() {
    initializeQuery();
    initializeDnD();
    first = $('img.sprite')[0];
    $(first).click();
}

function initializeDnD() {
    $('img.sprite').on('click',updateSelect);
}

function initializeQuery() {
    $('#query').on('input', updateSprites);

    $('#query').on('keydown', function(e) {
        if (e.which == 9) {
            $('#query').val($('#query-hint').attr('original-value'));
            $('#query-hint').val($('#query-hint').attr('original-value'));
            updateSprites();
            e.preventDefault();
        }
    });
}

function updateSprites() {
    var query = $('#query').val();
    var lowerQuery = query.toLowerCase();

    var hintSet = false;
    $('.actor-img .sprite').each(function() {
        var name = $(this).attr('name');
        var lowerName = name.toLowerCase();

        if(lowerName.includes(lowerQuery)) {
            $(this).removeClass('disabled');
            $(this).draggable('enable');

            if(!hintSet && query.length > 0 && lowerName.startsWith(lowerQuery)) {
                $('#query-hint').val(query + name.substring(query.length));
                $('#query-hint').attr('original-value', name);
                hintSet = true;
            }
        }
        else {
            $(this).addClass('disabled');
            $(this).draggable('disable');
        }
    });

    if (!hintSet) {
        $('#query-hint').val(query);
        $('#query-hint').attr('original-value', query);
    }
}

function updateSelect(){
    select = $(".selected");
    select.removeClass("selected");
    var parent = $(this).parent();
    $(parent).addClass("selected");
    $('#selected-actor-image').removeClass();
    $('#selected-actor-image').addClass($(parent).attr('data-username')+' sprite lazy hover-effect-img');
    $('#selected-actor-name').html($(this).attr('name'));
    $('#selected-actor-username').text($(parent).attr('data-username'));
    $('#selected-actor-username').attr('href','http://twitter.com/'+$(parent).attr('data-username'));
    $('#selected-actor-profile').attr('href',$(this).attr('data-href'));
}