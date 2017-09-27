$(document).ready(function() {
        $('.table tbody tr').click(function(event) {
            if (event.target.type !== 'radio') {
                $(':radio', this).trigger('click');
            }
        });
 });


function assignFormReviewer(reviewId,status,patientName,mrn){

    var leadId = $("input[name='lead']:checked").val();
    var leadName = $("input[name='lead']:checked").data('leadname');
    var leadEmail=$("input[name='lead']:checked").data('leademail');

    var reviewerId = '';
    var reviewerName = '';
    if($("#reviewer").val()!= ''){
        reviewerId = $("#reviewerSelect").val();
        reviewerName = $("#reviewer").val().split(" (")[0];
    }

    $.ajax({
        url: 'assignLeadReviewer',
        cache:false,
        dataType:'',
        data:{leadId:leadId,leadName:leadName,leadEmail:leadEmail,reviewerId:reviewerId,reviewerName:reviewerName,reviewId:reviewId,status:status,patientName:patientName,mrn:mrn},
        success: function(data){
            toastr.success('Reviewer Updated Successfully');
            // var URL="${createLink(controller: 'Mortality', action: 'dashboard')}";
            //window.location.href=URL;

        },
        error: function () {
            toastr.error('errors messages');
        }
    });
}


