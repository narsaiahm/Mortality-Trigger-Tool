<html>
<body>
Dear User,
<br>
<br>Please find below Mortality Review Form link for Patient Name - ${patientName}, MRN - ${mrn}.
<br>
<g:if test="${isQualityLead}">
    You may accept or reassign this form to other Quality Lead.
    <br>
    Should you choose to accept, please fill details in review form and submit.
</g:if>
<g:elseif test="${isAdmin}">
    You are required to review the form and add comments if patient info is not correct.
</g:elseif>
<br>
<br>
<g:link url="${reviewFormLink}">${reviewFormLink}</g:link>
<br>
<br>Thanks,
<br>Mortality Trigger Tool
</body>
</html>
