<div class="title">
    <p><span>Procedure‐Related Complication(s) (check all that apply)

    </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">

        <div>
            <label class="checkbox-inline  checkboxTop">
                <g:checkBox name="isProcedureCardiac" value="${mReviewForm?.isProcedureCardiac}"
                            onclick="showHideTextarea(this)"/>Cardiac
            </label>

            <div id="cardiacCommentDivId" ${!mReviewForm?.isProcedureCardiac ? "style=display:none" : ''}
                 class="isProcedureCardiac_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <g:textArea name="cardiacComment" class="ax_default text_area ${mReviewForm?.isProcedureCardiac ? "mandatory" : ''}"  maxlength="250"
                            placeholder="Please specify" >${mReviewForm?.cardiacComment}</g:textArea>
            </div>

        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isDeadWithin72HoursOfProc"
                            value="${mReviewForm?.isDeadWithin72HoursOfProc}"/>Dead within 72 hours of a procedure
            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isProcedurePulmonary" value="${mReviewForm?.isProcedurePulmonary}"
                            onclick="showHideTextarea(this)"/>Pulmonary
            </label>

            <div id="pulmonaryCommentDivId" ${!mReviewForm?.isProcedurePulmonary ? "style=display:none" : ''}
                 class="isProcedurePulmonary_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <g:textArea name="pulmonaryComment" class="ax_default text_area ${mReviewForm?.isProcedurePulmonary ? "mandatory" : ''}" maxlength="250"
                            placeholder="Please specify" >${mReviewForm?.pulmonaryComment}</g:textArea>
            </div>

        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isExcessiveBleeding"
                            value="${mReviewForm?.isExcessiveBleeding}"/>Excessive or unexpected Bleeding
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isProcedureHepatic" value="${mReviewForm?.isProcedureHepatic}"/>Hepatic
            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isInfection" value="${mReviewForm?.isInfection}"
                            onclick="showHideTextarea(this)"/>Infection
            </label>

            <div id="infectionCommentDivId" ${!mReviewForm?.isInfection ? "style=display:none" : ''}
                 class="isInfection_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea name="infectionComment" class="ax_default text_area ${mReviewForm?.isInfection ? "mandatory" : ''}" maxlength="250"
                          placeholder="Please specify" >${mReviewForm?.infectionComment}</textarea>
            </div>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isProcedureOther" value="${mReviewForm?.isProcedureOther}"
                            onclick="showHideTextarea(this)"/>Other
            </label>

            <div id="procedureOtherCommentDivId" ${!mReviewForm?.isProcedureOther ? "style=display:none" : ''}
                 class="isProcedureOther_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea name="procedureOtherComment" class="ax_default text_area ${mReviewForm?.isProcedureOther ? "mandatory" : ''}" maxlength="250"
                          placeholder="Please specify" >${mReviewForm?.procedureOtherComment}</textarea>
            </div>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSupportiveVasopressors" class="naCheckbox"
                            value="${mReviewForm?.isMajInvInterNA}"/>N/A
            </label>
        </div>
    </div>

    <div class="col-md-7 divContent">
        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isNeurologicalInjury" value="${mReviewForm?.isNeurologicalInjury}"
                            onclick="showHideTextarea(this)"/>Neurological Injury
            </label>

            <div id="neuroInjuryCommentDivId" ${!mReviewForm?.isNeurologicalInjury ? "style=display:none" : ''}
                 class="isNeurologicalInjury_div checkbox-inline ">
                <span class="required">*&nbsp;</span>
                <textarea name="neuroInjuryComment" class="ax_default text_area ${mReviewForm?.isNeurologicalInjury ? "mandatory" : ''}" maxlength="250"
                          placeholder="Please specify" >${mReviewForm?.neuroInjuryComment}</textarea>
            </div>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isRenalFailure" value="${mReviewForm?.isRenalFailure}"/>Renal Failure

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isUnanticipatedTransfusion"
                            value="${mReviewForm?.isUnanticipatedTransfusion}"/>Unanticipated Transfusion

            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isProcedureVasopressors" value="${mReviewForm?.isProcedureVasopressors}"/>Vasopressors

            </label>
        </div>
    </div>
</div>

<div class="form-inline row checkbox-inline">
    <div >
        <label class="checkbox-inline checkboxTop">Post Op Summary:
        </label>
        <textarea name="postOpSummary" class="ax_default text_area" maxlength="250">${mReviewForm?.postOpSummary}</textarea>
    </div>
  </div>

































