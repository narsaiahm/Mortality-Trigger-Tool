<div class="title">
    <p>
        <span>Cause of Death </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-7 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox  name="isBleeding"  value="${mReviewForm?.isBleeding}" />Bleeding
            </label>
            <label class="checkbox-inline">
                <g:checkBox  name="isDeathCauseCardiac"  value="${mReviewForm?.isDeathCauseCardiac}" />Cardiac</label>
            <label class="checkbox-inline">
                <g:checkBox  name="isDeathCauseHepatic" value="${mReviewForm?.isDeathCauseHepatic}" />Hepatic</label>
            <label class="checkbox-inline">
                <g:checkBox  name="isDeathCausePulmonary"  value="${mReviewForm?.isDeathCausePulmonary}" />Pulmanory</label>
            <label class="checkbox-inline" >
                <g:checkBox  name="isDeathCauseRenal"  value="${mReviewForm?.isDeathCauseRenal}" />Renal</label>
            <label class="checkbox-inline">
                <g:checkBox  name="isDeathCauseSepsis"  value="${mReviewForm?.isDeathCauseSepsis}" />Sepsis</label>

        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox  name="isDeathCauseOther" value="${mReviewForm?.isDeathCauseOther}" onclick="showHideTextarea(this)"/>Others
            </label>
            <div id="deathCauseOtherCommentDivId" ${!mReviewForm?.isDeathCauseOther ? "style=display:none" : ''} class="isDeathCauseOther_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea name="deathCauseOtherComment" class="ax_default text_area  ${mReviewForm?.isDeathCauseOther? "mandatory" : ''}"  maxlength="250" placeholder="Please specify" >${mReviewForm?.deathCauseOtherComment}</textarea>
            </div>
        </div>

        <table class="leftAlign">
            <tr>
                <td>
                    <label>   <span class="required">*&nbsp;</span> Was Patient admitted to ICU at time of admission? </label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input type="radio"  class="mandatory" name="wasPatICUTimeAdmission" value="true" ${mReviewForm?.wasPatICUTimeAdmission == true ? 'checked="checked"' : ''} >Yes
                    </label>
                    <label class="radio-inline">
                        <input type="radio" class="mandatory" name="wasPatICUTimeAdmission" value="false" ${mReviewForm?.wasPatICUTimeAdmission == false ? 'checked="checked"' : ''} >No
                    </label>
                </td>
            </tr>

            <tr>
                <td>
                    <label>
                        <span class="required">*&nbsp;</span>
                        Would you have expected the patient to die during this admission?
                    </label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input type="radio" class="mandatory" id="expectedPatToDieAdmissionYes" name="expectedPatToDieAdmission" value="true" ${mReviewForm?.expectedPatToDieAdmission == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input type="radio" class="mandatory" id="expectedPatToDieAdmissionNo" name="expectedPatToDieAdmission" value="false" ${mReviewForm?.expectedPatToDieAdmission == false ? 'checked="checked"' : ''} >No
                    </label>
                </td>
                <td>
                </td>

            </tr>
            <tr id="expectedPatToDieAdmissionYesDiv" ${!mReviewForm?.expectedPatToDieAdmission ? "style=display:none" : ''}>
                <td >

                    <label class="checkbox-inline checkboxTop">
                        <span class="required">*&nbsp;</span> If yes, was it due to:   </label>
                    <input type="radio" id="isNaturalCoursePatIllnessId" class="expectedPatToDieAdmissionYesOption ${mReviewForm?.expectedPatToDieAdmission? 'mandatory' : ''}" name="isNaturalCoursePatIllness"  value="true" ${mReviewForm?.isNaturalCoursePatIllness == true ? 'checked="checked"' : ''} />Natural Course of Patient Illness
                </td>
                <td>
                    <label class="checkbox-inline checkboxTop">
                        <input type="radio" id="isRelUnderlyingConditionsId" class="expectedPatToDieAdmissionYesOption ${mReviewForm?.expectedPatToDieAdmission? 'mandatory' : ''}" name="isRelUnderlyingConditions"  value="true" ${mReviewForm?.isRelUnderlyingConditions == true ? 'checked="checked"' : ''} />Related to Underlying
                    </label>

                </td>

            </tr>
            <tr id="expectedPatToDieAdmissionNoDiv"  ${mReviewForm?.expectedPatToDieAdmission != false ? "style=display:none" : ''}  class="checkbox-inline">
                <td >
                    <span class="required">*&nbsp;</span>
                    <textarea class="ax_default text_area ${mReviewForm?.expectedPatToDieAdmission == false ? "mandatory" : ''}" maxlength="250" placeholder="Please elaborate"  id="expPatDieAdmissionComment" name="expPatDieAdmissionComment" >${mReviewForm?.expPatDieAdmissionComment}</textarea>

                </td>
            </tr>

        </table>
    </div>

</div>