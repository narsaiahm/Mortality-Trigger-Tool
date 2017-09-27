<div class="title">
    <p><span>Major Supportive Interventions (check all that apply)

    </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCentralLine" value="${mReviewForm?.isCentralLine}"/>Central Line

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCPR" value="${mReviewForm?.isCPR}"/>CPR

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSupportiveHemodialysis"
                            value="${mReviewForm?.isSupportiveHemodialysis}"/>Hemodialysis
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHemodialysisCatheter"
                            value="${mReviewForm?.isHemodialysisCatheter}"/>Hemodialysis catheter

            </label>
        </div>
    </div>

    <div class="col-md-4 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isIntubation" value="${mReviewForm?.isIntubation}"/>Intubation
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isMechanicalVent" value="${mReviewForm?.isMechanicalVent}"/>Mechanical Vent

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSupportiveVasopressors"
                            value="${mReviewForm?.isSupportiveVasopressors}"/>Vasopressors
            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isSupportiveOther" value="${mReviewForm?.isSupportiveOther}"
                            onclick="showHideTextarea(this)"/>Other &nbsp;&nbsp;&nbsp;&nbsp;
            </label>
                <div id="supportiveOtherCommentDivId" ${!mReviewForm?.isSupportiveOther ? "style=display:none" : ''}
                     class="isSupportiveOther_div checkbox-inline">
                    <span class="required">*&nbsp;</span>
                    <textarea class="ax_default text_area ${mReviewForm?.isSupportiveOther ? "mandatory" : ''}"  maxlength="250"
                              placeholder="Please specify" name="supportiveOtherComment">${mReviewForm?.supportiveOtherComment}</textarea>
                </div>

        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isMajSuppInterNA" class="naCheckbox" value="${mReviewForm?.isMajSuppInterNA}"/>N/A
            </label>
        </div>
    </div>

</div>