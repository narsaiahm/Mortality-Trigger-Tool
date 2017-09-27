<div class="title">
    <p><span>Major Comorbidities Present on Admission (check all that apply)
    </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">
        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isComorbAtrialFibrillation"
                            value="${mReviewForm?.isComorbAtrialFibrillation}"/>Atrial Fibrillation
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCerebrovascularAccident"
                            value="${mReviewForm?.isCerebrovascularAccident}"/>Cerebrovascular Accident
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isChronicKidneyDisease"
                            value="${mReviewForm?.isChronicKidneyDisease}"/>Chronic/End Stage Kidney Disease
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCirrhosis" value="${mReviewForm?.isCirrhosis}"/>Cirrhosis
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCognitiveImpairment"
                            value="${mReviewForm?.isCognitiveImpairment}"/>Cognitive Impairment
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isAsthma" value="${mReviewForm?.isAsthma}"/>COPD/Asthma
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCoronaryArteryDisease"
                            value="${mReviewForm?.isCoronaryArteryDisease}"/>Coronary Artery Disease
            </label>
        </div>

        <div class="">
            <label class="checkbox-inline">
                <g:checkBox name="isDiabetes" value="${mReviewForm?.isDiabetes}"/>Diabetes
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isDementia" value="${mReviewForm?.isDementia}"/>Dementia
            </label>
        </div>
    </div>

    <div class="col-md-4 divContent">
        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isComorbHeartFailure" value="${mReviewForm?.isComorbHeartFailure}"/>Heart Failure
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHyperTension" value="${mReviewForm?.isHyperTension}"/>Hypertension
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isMalignancy" value="${mReviewForm?.isMalignancy}"/>Malignancy
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isMorbidObesity" value="${mReviewForm?.isMorbidObesity}"/>Morbid Obesity

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isNeurologicalDisorders"
                            value="${mReviewForm?.isNeurologicalDisorders}"/>Neurological Disorders

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isObstructiveSleepApnea"
                            value="${mReviewForm?.isObstructiveSleepApnea}"/>Obstructive Sleep Apnea

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPeripheralVascularDisease"
                            value="${mReviewForm?.isPeripheralVascularDisease}"/>Peripheral Vascular Disease

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isValvularHeartDisease"
                            value="${mReviewForm?.isValvularHeartDisease}"/>Valvular Heart Disease

            </label>
        </div>

        <div>
            <label class="checkbox-inline checkboxTop">
                <g:checkBox name="isComorbiditiesOther" value="${mReviewForm?.isComorbiditiesOther}"
                            onclick="showHideTextarea(this)"/>Other

            </label>

            <div id="comorbiditiesOtherCommentDivId" ${!mReviewForm?.isComorbiditiesOther ? "style=display:none" : ''}
                 class="isComorbiditiesOther_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isComorbiditiesOther ? "mandatory" : ''}" maxlength="250" placeholder="Please specify"
                          name="comorbiditiesOtherComment">${mReviewForm?.comorbiditiesOtherComment}</textarea>
            </div>

        </div>
    </div>

</div>