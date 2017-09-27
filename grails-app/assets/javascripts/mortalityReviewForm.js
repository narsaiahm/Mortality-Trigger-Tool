var str ='\n'
function divVisibility(divId) {
    if(!$("#"+divId).is(":visible")){
        $(".tabDiv").hide()
        $("#"+divId).show()
    }
    hideShowPrevNextBtn()
}

function moveTab(isNext){
    var nextActiveDivId = ''
    if(isNext == 1){
        var activeDivId = $(".innertop_div.clicked").data('divid')
        $('.inner_div>div').hide()
        nextActiveDivId = $('#'+activeDivId).next().attr('id')
        $('#'+activeDivId).next().show()

    }else{
        var activeDivId = $(".innertop_div.clicked").data('divid')
        $('.inner_div>div').hide()
        nextActiveDivId = $('#'+activeDivId).prev().attr('id')
        $('#'+activeDivId).prev().show()
    }
    $('.star').removeClass('clicked');
    $("[data-divid="+nextActiveDivId+"]").addClass('clicked')
    hideShowPrevNextBtn()
}

function hideShowPrevNextBtn(){
    if($(".innertop_div.clicked").hasClass('first')){
        $('.prevBtn').addClass('hide')
        $('.nextBtn').removeClass('hide')
    }else if(!$(".innertop_div.clicked").hasClass('first') && !$(".innertop_div.clicked").hasClass('last')){
        $('.prevBtn').removeClass('hide')
        $('.nextBtn').removeClass('hide')
    }else if($(".innertop_div.clicked").hasClass('last')){
        $('.prevBtn').removeClass('hide')
        $('.nextBtn').addClass('hide')
    }
}

$(document).ready(function() {

    $('.tabDiv').each(function(){
        if($(this).find('input[type=checkbox]:checked').length > 0){
            $(this).find('.naCheckbox').attr('disabled',true)
        }else{
            $(this).find('.naCheckbox').attr('disabled',false)
        }
    })

     if($('#isFormEditable').val() == 'false'){
        var allInputs = $( ":input" );
        allInputs.each(function () {
            if(!$(this).is(":button"))
                $(this).attr('disabled', true);
        });
    }
    //patient Info

    $('#isPatInfoAccurateYesDiv').click(function() {
        $('#isPatInfoAccurateCommDiv').hide();
        $('#patInfoComment').removeClass('mandatory');
    });
    $('#isPatInfoAccurateNoDiv').click(function() {
        $('#patInfoComment').addClass('mandatory');
        $('#isPatInfoAccurateCommDiv').show();

    });

    $('#wasPatTransferredFacilityYesdiv').click(function() {
        $('#patTransferredCommentDiv').show();
        $('#patTransferredComment').addClass('mandatory');


    });
    $('#wasPatTransferredFacilityNodiv').click(function() {
        $('#patTransferredComment').removeClass('error');
        $('#patTransferredComment').removeClass('mandatory');
        $('#patTransferredCommentDiv').hide();
    });
    $('#isIcuStayYesDiv').click(function() {
        $('input[type=\'radio\']').each(function () {
            var currentElement=$(this)
            if(currentElement.attr('name')=='isPatDiedLt24hrsDischarge')
                currentElement.addClass('mandatory');

        })
        $('#isPatDiedLt24hrsDischargeRowId').show();

    });
    $('#isIcuStayNoDiv').click(function() {
        $('input[type=\'radio\']').each(function () {
            var currentElement=$(this)
            if(currentElement.attr('name')=='isPatDiedLt24hrsDischarge')
                currentElement.removeClass('mandatory');

        })
        $('#isPatDiedLt24hrsDischargeRowId').hide();

    });

    $('#wasCaseAptMEYesDiv').click(function() {
        $('#wasCaseAptMEComment').addClass('mandatory');
        $('#appropriateCaseYes').show();
        $('#appropriateCaseYesDiv').show()
        $('#appropriateCaseNo').hide();
    });
    $('#wasCaseAptMENoDiv').click(function() {
        $('#appropriateCaseYesDiv').show()
        $('#wasCaseAptMEComment').addClass('mandatory');
        $('#appropriateCaseYes').hide();
        $('#appropriateCaseNo').show();

    });

    $('#expectedPatToDieAdmissionYes').click(function () {
        $('#expectedPatToDieAdmissionYesDiv').show();
        $('#expPatDieAdmissionComment').removeClass('mandatory');
        $('.expectedPatToDieAdmissionYesOption').each(function () {
            var currentElement=$(this)
            currentElement.addClass('mandatory');
            currentElement.addClass('error');
        })
        $('#expectedPatToDieAdmissionNoDiv').hide();
    });

    $('#expectedPatToDieAdmissionNo').click(function () {
        $('#expectedPatToDieAdmissionNoDiv').show();
        $('#expPatDieAdmissionComment').addClass('mandatory');
        $('.expectedPatToDieAdmissionYesOption').each(function () {
            var currentElement=$(this)
            currentElement.removeClass('mandatory');
            currentElement.removeClass('error');

        })
        $('#expectedPatToDieAdmissionYesDiv').hide();

    });

    $('.naCheckbox').click(function () {
        if(this.checked) {
            $(this).closest('div.tabDiv').find(':checkbox').attr('checked', false);
            $(this).prop('checked', true);
        }
    });

    $("input:checkbox:not(.naCheckbox)").click(function () {
        if(this.checked) {
            $(this).closest('div.tabDiv').find('.naCheckbox').attr('checked', false).attr('disabled', true);
        }else{
            if($(this).closest('div.tabDiv').find('input[type=checkbox]:checked').length == 0){
                $(this).parents('div').find('.naCheckbox').attr('disabled', false);
            }
        }
    });

    $('#show-Submit').hide();

    $('.star').click(function(){
        $('.star').removeClass('clicked');
        $(this).toggleClass('clicked');
    });

    $("#watch-Submit").on("click",function() {
        console.log("patInfoAcc :"+document.getElementsByName('isPatInfoAccurate'))
        if(document.getElementsByName('isPatInfoAccurate').val == false) {

            console.log("isPatInfoAccurate next value :" + document.getElementsByName('isPatInfoAccurate').next.text);
            if(document.getElementsByName('isPatInfoAccurate').next.val == ''){
                alert('please enter isPatInfoAccurate comment ')
            }
        }
        else {
            $("#show-Submit").show();
            var dataString = $('#mReviewForm').serialize();
            console.log("serialized data submitting" )

            $.ajax({
                type: 'POST',
                data: dataString,
                url: 'saveMortalityReviewForm',

                success: function (data) {
                    toastr["success"]('Form has been updated Successfully')
                },
                error: function () {
                    toastr["error"]('There is some error, please contact your system administrator')
                }

            })
        }

    });

  });

function showHideTextarea(obj){
    $this = $(obj)
    var prefix = $this.attr('name')
    $('.'+prefix+'_div').toggle();
    $('.'+prefix+'_div').find('textarea').toggleClass('mandatory');
    $('.'+prefix+'_div').find('textarea').val('')
}


function showHistory(reviewId, obj) {
    $this = $(obj)
    $.ajax({
        type: 'POST',
        data: {reviewId: reviewId},
        url: 'showHistory',
        success: function (data) {
            if (data == '') {
                $("#dialog").html('No History to Show');
            } else {
                $("#dialog").html(data);
            }
            updateDialog($this.attr('id'))
        },
        error: function () {
            toastr["error"]('There is some error, please contact your system administrator')
        }
    });
}

function updateDialog(id) {
    $("#dialog").dialog({
        position: {
            my: 'right-50 top-100',
            at: 'center bottom',
            of: '#' + id
        },
        draggable: false,
        resizable: false,
        height: 300,
        modal: true,
    });
}
function  reviewAndSubmit() {

    var hasError = false
    var allInputs = $( ":input" );

    $('.mandatory').each(function () {
        var currentElement = $(this);
        if (currentElement.is('textarea') && currentElement.val().length > 0) {
            currentElement.removeClass('error')
            $('.' + currentElement.attr('name')).hide();
        }
        else if (currentElement.is('textarea') && currentElement.val().length == 0) {
            if($('.'+currentElement.attr('name')).is(':visible')){

            }
                else
            {
                currentElement.addClass('error')
                currentElement.after("<br/><span class='errorMsg\t" + currentElement.attr('name') + "'>Field is required</span> ");

            }}
    });
    allInputs.each(function (e) {

        var currentInput =$(this)
        if(currentInput.hasClass('mandatory') && currentInput.hasClass('error'))
            hasError = true
    });
      if (!hasError) {
         var isConfirmed = confirm('Submitting the form');
         if(!isConfirmed)
          return false;
         else
             return true;
    }
    else {
        alert('please check for mandatory fields');
        return false
    }
}
$('.error').on('change', function () {
    var currentElement = $(this);
    if (currentElement.is('textarea') && currentElement.val().length > 0) {
        currentElement.removeClass('error')
        currentElement.removeClass('mandatory')

        $('.' + currentElement.attr('name')).hide();
    }
    else if (currentElement.is('textarea') && currentElement.val().length == 0) {
        currentElement.addClass('error')
        currentElement.after("<br/><span class='errorMsg\t" + currentElement.attr('name') + "'>Field is required</span> ");
    }
});
$("input[type='radio']").each(function(){
    var currentElement=$(this);
    if(previousEle == currentElement){
    }
    else{
        if( currentElement.attr('name') == previousEle.attr('name') && currentElement.hasClass('mandatory') && previousEle.hasClass('mandatory')){
            if(currentElement.is(':checked') || previousEle.is(':checked')){
                currentElement.removeClass('error')
                previousEle.removeClass('mandatory')
                previousEle.removeClass('mandatory')
                previousEle.removeClass('error')
                $('.' + currentElement.attr('name')).hide();
            }
            else{
                currentElement.addClass('error')
                currentElement.parent().after("<span class='errorMsg\t" + currentElement.attr('name') +'\tradio-inline'+ "'>\t\tField is required</span> ")
            }
        }
    }
    previousEle = currentElement;
});