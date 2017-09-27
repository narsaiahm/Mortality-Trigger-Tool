<div class="title">
    <p>
        <span>Contributing Factors (check all that apply)</span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">
        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isAdverseDrugEvent" value="${mReviewForm?.isAdverseDrugEvent}"/>Adverse Drug Event
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isDelayInTreatment"
                            value="${mReviewForm?.isDelayInTreatment}"/>Delay in Treatement/Intervantion
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isElectronicMedicalRecord"
                            value="${mReviewForm?.isElectronicMedicalRecord}"/>Electronic Medical Record
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isContributingFall" value="${mReviewForm?.isContributingFall}"/>Fall
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isFailureToAftercare"
                            value="${mReviewForm?.isFailureToAftercare}"/>Failure to Aftercare
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isFailureToEscalate" value="${mReviewForm?.isFailureToEscalate}"/>Failure to Escalate
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospAcqCondition"
                            value="${mReviewForm?.isHospAcqCondition}"/>Hospital Acquired Condition
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isContributingHospInfection"
                            value="${mReviewForm?.isContributingHospInfection}"/>Hospital Acquired Infection
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isOmissionOfCare" value="${mReviewForm?.isOmissionOfCare}"/>Omission of Care
            </label>
        </div>
    </div>

    <div class="col-md-4 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPatientCompliance" value="${mReviewForm?.isPatientCompliance}"/>Patient Compliance
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPoorCommunication" value="${mReviewForm?.isPoorCommunication}"/>Poor Communication
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPoorHandoff" value="${mReviewForm?.isPoorHandoff}"/>Poor Handoff
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPoorDocumentation"
                            value="${mReviewForm?.isPoorDocumentation}"/>Poor/Missing Documentation
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSupervision" value="${mReviewForm?.isSupervision}"/>Supervision
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSurgicalError" value="${mReviewForm?.isSurgicalError}"/>Surgical/Procedure Error
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isTechniqueError" value="${mReviewForm?.isTechniqueError}"/>Technique Error
            </label>
        </div>

        <div>
            <label class=" checkbox-inline checkboxTop ">
                <g:checkBox name="isContFactOther" value="${mReviewForm?.isContFactOther}"
                            onclick="showHideTextarea(this)"/>Other
            </label>


        <div id="contFactOtherCommentDivId" ${!mReviewForm?.isContFactOther ? "style=display:none" : ''}
             class="isContFactOther_div checkbox-inline">
            <span class="required">*&nbsp;</span>
            <textarea name="contFactOtherComment" class="ax_default text_area ${mReviewForm?.isContFactOther? "mandatory" : ''}"  maxlength="250"
                    class="  "  placeholder="Please specify" >${mReviewForm?.contFactOtherComment}</textarea>
        </div>
        </div>
    </div>

    %{--<div class="row">
        <div class="col-md-6">

            <label class="removeBold">
                Does Death Require Further Review?</label>

            <label class="radio-inline">
                <input type="radio" name="optradio" value="${mReviewForm?.isProcedureCardiac}" />Yes
            </label>
            <label class="radio-inline">
                <input type="radio" name="optradio" value="${mReviewForm?.isProcedureCardiac}" />No
            </label>
        </div>
    </div>--}%

</div>