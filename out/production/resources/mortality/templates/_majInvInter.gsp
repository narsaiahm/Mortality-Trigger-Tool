<div class="title">
    <p><span>
        Major Invasive Interventions

    </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isBronchoscopy" value="${mReviewForm?.isBronchoscopy}"/>Bronchoscopy
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCardiacCatheterization"
                            value="${mReviewForm?.isCardiacCatheterization}"/>Cardiac Catheterization
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isInvasiveHemodialysis" value="${mReviewForm?.isInvasiveHemodialysis}"/>Hemodialysis
            </label>
        </div>
    </div>

    <div class="col-md-7 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isInterventionalRadioProc"
                            value="${mReviewForm?.isInterventionalRadioProc}"/>Interventional Radiologocal Procedure
            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isSergicalProcedure" value="${mReviewForm?.isSergicalProcedure}"
                            onclick="showHideTextarea(this)"/>Sergical Procedure
            </label>

            <div id="sergicalProcedureCommentDivId" ${!mReviewForm?.isSergicalProcedure ? "style=display:none" : ''}
                 class="isSergicalProcedure_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isSergicalProcedure ? "mandatory" : ''}"  maxlength="250" placeholder="Please specify"
                          name="sergicalProcedureComment" >${mReviewForm?.sergicalProcedureComment}</textarea>
            </div>

        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isInvasiveOther" value="${mReviewForm?.isInvasiveOther}"
                            onclick="showHideTextarea(this)"/>Other (e.g., bedside paracentesis, lumbar puncture, etc)
            </label>

            <div id="invasiveOtherCommentDivId" ${!mReviewForm?.isInvasiveOther ? "style=display:none" : ''}
                 class="isInvasiveOther_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isInvasiveOther ? "mandatory" : ''}" maxlength="250" placeholder="Please specify"
                          name="invasiveOtherComment" >${mReviewForm?.invasiveOtherComment}</textarea>
            </div>

        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isMajInvInterNA" class="naCheckbox"
                            value="${mReviewForm?.isMajInvInterNA}"/>N/A
            </label>
        </div>
    </div>

</div>