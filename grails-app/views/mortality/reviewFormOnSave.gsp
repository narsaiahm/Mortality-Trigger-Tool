<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:javascript>
        $( document ).ready(function() {
            console.log( "ready!" );
            $('.mandatory').each(function () {
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
            var previousEle =$("isPatInfoAccurateYesDiv")
            $("input[type='radio']").click(function(){
                var previousEle =$("isPatInfoAccurateYesDiv")
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
                        }
                    }
                    previousEle = currentElement;
                });
            });

            var previousEle =$("isPatInfoAccurateYesDiv")
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
            if($('#isNaturalCoursePatIllnessId').hasClass('mandatory') && $('#isRelUnderlyingConditionsId').hasClass('mandatory')){
                if(!($('#isNaturalCoursePatIllnessId').is(':checked')&&$('#isRelUnderlyingConditionsId').is(':checked'))){
                    $('#isRelUnderlyingConditionsId').parent().after("<span class='errorMsg\t expectedPatToDieAdmissionYesErrorSpan" + "'>\t\tField is required</span> ")
                }
                else{
                    $('.expectedPatToDieAdmissionYesErrorSpan').hide();
                }
            }
            $('.expectedPatToDieAdmissionYesOption').on('change',function () {

                if($('#isNaturalCoursePatIllnessId').hasClass('mandatory') && $('#isRelUnderlyingConditionsId').hasClass('mandatory')){
                    if(!($('#isNaturalCoursePatIllnessId').is(':checked') || $('#isRelUnderlyingConditionsId').is(':checked'))){
                        $('#isRelUnderlyingConditionsId').parent().after("<td><span class=' errorMsg\t expectedPatToDieAdmissionYesErrorSpan" + "'>\t\tField is required</span> </td> ")
                    }
                    else{
                        $('.expectedPatToDieAdmissionYesErrorSpan').hide();
                    }
                }

            })

        });

    </g:javascript>
</head>

<body>
<div id="mortalityReviewFormDiv">
    <g:render template="/mortality/templates/reviewFormOnSave"></g:render>

</div>
</body>
</html>