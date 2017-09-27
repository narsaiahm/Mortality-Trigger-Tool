function acceptPatient(id,status){


  $.ajax({ url: 'updateAcceptPatient',
        cache:false,
        dataType: 'html',
        data: {reviewId:id,status:status},
        success: function(data){
            refreshPatientList();
            toastr.success('Accepted Patient');
        },
        error: function () {
            toastr.error('errors messages');
        }
    });
}

function adminSearch(obj){
    $this = $(obj)
    $.ajax({ url: 'displaySearchResults',
        cache:false,
        dataType: 'html',
        data: $('[name=adminSearchForm]').serialize(),
        success: function(data){
            $("#adminDashboard").html(data)
            toastr.success('search success');
        },
        error: function () {
            toastr.error('errors messages');
        }
    });
}

function refreshPatientList(){
    $( "#refresh" ).load(window.location.href + " #refresh" );
}

function updateDeptQl(obj){
    $this = $(obj)
    $.ajax({
        url: 'fetchDeptQlForFacility',
        cache:false,
        dataType: 'html',
        data: {facilityId:$this.val()},
        success: function(data){
            $("#form_dept_ql").html(data)
        },
        error: function () {
            toastr.error('errors messages');
        }
    });
}

function updateQl(obj){
    $this = $(obj);
    var role = $this.val();
    var facilityId = $("#facility").val()
    $.ajax({
        url: 'fetchQlForFacility',
        cache:false,
        dataType: 'html',
        data: {facilityId:facilityId,role:role},
        success: function(data){
            $("#form_ql").html(data)
        },
        error: function () {
            toastr.error('errors messages');
        }
    });
}

$(document).ready(function(){
    jQuery.browser = {};
    (function () {
        jQuery.browser.msie = false;
        jQuery.browser.version = 0;
        if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
            jQuery.browser.msie = true;
            jQuery.browser.version = RegExp.$1;
        }
    })();

    //Validation for from and to date
    $(function () {
        $("#fromDateCompleted, #dateCompleted, #fromDeathDate , #dateOfDeath, #toDateCompleted, #toDeathDate").datepicker({
            numberOfMonths: 1,
            maxDate: 0,
            onSelect: function (selected) {
                var dt = new Date(selected);
                dt.setDate(dt.getDate() + 1);
                if($(this).attr('id')=='fromDateCompleted'){
                    $("#toDateCompleted").datepicker("option", "minDate", dt);
                }else if($(this).attr('id')=='fromDeathDate'){
                    $("#toDeathDate").datepicker("option", "minDate", dt);
                }
            }
        });
    });

    var reviewers = [];

    $("#reviewerSelect option").each(function(){
        reviewers.push({
            'value':$(this).val(),
            'label':$(this).text()}
        )
    });

    $( "#reviewer" ).autocomplete({
        minLength: 0,
        source: reviewers,
        focus: function( event, ui ) {
            $( "#reviewer" ).val( ui.item.label );
            return false;
        },
        select: function( event, ui ) {
            $( "#reviewer" ).val( ui.item.label );
            $( "#reviewerSelect" ).val( ui.item.value );
            return false;
        }
    })
});

// Run Report to show Mortality Trigger Tool Summary Report/Time to Completion Divs

var divs = ["mortalityTriggerToolSummary", "timeToCompletion"];
var visibleDivId = null;

function divVisibility(divId) {
    if (visibleDivId === divId) {
        visibleDivId = null;
    } else {
        visibleDivId = divId;
    }
    hideNonVisibleDivs();
}
function hideNonVisibleDivs() {
    var i, divId, div;
    for (i = 0; i < divs.length; i++) {
        divId = divs[i];
        div = document.getElementById(divId);
        if (visibleDivId === divId) {
            div.style.display = "block";
        } else {
            div.style.display = "none";
        }
    }
}

$('a').on('click', function() {
    var target = $(this).attr('rel');
    $("#" + target).show().siblings("div").hide();
});

// Admin screen From date and to date hide and show fields
$(document).ready(function() {
    $('input[type="radio"]').click(function() {
        if ($(this).attr('id') == 'dateDeathFirstRadio') {
            $('#dateOfDeathFirstDiv').show();
            $('#dateOfDeathSecondDiv').hide();
            $("#dateDeathSecRadio input:radio").attr('checked', false);
            $("#fromDeathDate").val("")
            $("#toDeathDate").val("")
        } else if ($(this).attr('id') == 'dateDeathSecRadio') {
            $('#dateOfDeathFirstDiv').hide();
            $('#dateOfDeathSecondDiv').show();
            $("#dateOfDeath").val("")
        }else if ($(this).attr('id') == 'dateCompletedFirstRadio') {
            $('#dateCompletedFirstDiv').show();
            $('#dateCompletedSecDiv').hide();
            $("#dateCompletedSecRadio input:radio").attr('checked', false);
            $("#fromDateCompleted").val("")
            $("#toDateCompleted").val("")
        }else if ($(this).attr('id') == 'dateCompletedSecRadio') {
            $('#dateCompletedFirstDiv').hide();
            $('#dateCompletedSecDiv').show();
            $("#dateCompleted").val("")
        }
    });
});


$(document).on("click", ".datePicker", function() {
    var clickedBtnID = $(this); // or var clickedBtnID = this.id

    clickedBtnID.datepicker();
    clickedBtnID.datepicker("show");
    // alert('you clicked on button #' + clickedBtnID);
});


$(document).ready(function() {
    $('#showreport').hide();
    $("#watch_showreport").click(function() {
        $("#showreport").show();
    });
});