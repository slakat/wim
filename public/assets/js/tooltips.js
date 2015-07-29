$(document).ready(initializeTooltips);
$(document).on('page:load', initializeTooltips);

function initializeTooltips() {
    $('[data-toggle="tooltip"]').tooltip();
}