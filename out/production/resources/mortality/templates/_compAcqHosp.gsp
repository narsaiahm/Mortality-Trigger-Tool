<div class="title">
    <p><span>Complication(s) Acquired in the Hospital (check all that apply)
    </span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">
        <div>
            <label class="checkbox-inline">

                <g:checkBox name="isAcuteKidneyInjury" value="${mReviewForm?.isAcuteKidneyInjury}"/>
                Acute Kidney Injury
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isAcuteMyocardialInfraction"
                            value="${mReviewForm?.isAcuteMyocardialInfraction}"/>Acute Myocardial Infraction

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isAlterredMentalStatus"
                            value="${mReviewForm?.isAlterredMentalStatus}"/>Alterred Mental Status

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospAtrialFibrillation"
                            value="${mReviewForm?.isHospAtrialFibrillation}"/>Atrial Fibrillation

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isChestPain" value="${mReviewForm?.isChestPain}"/>Chest Pain
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCOPD" value="${mReviewForm?.isCOPD}"/>COPD
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCVA" value="${mReviewForm?.isCOPD}"/>CVA
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isDVTOrVTE" value="${mReviewForm?.isDVTOrVTE}"/>DVT/VTE

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospitalFall" value="${mReviewForm?.isHospitalFall}"/>Fall
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isFever" value="${mReviewForm?.isFever}"/>Fever
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isGiBleed" value="${mReviewForm?.isGiBleed}"/>GI Bleed
            </label>
        </div>
    </div>

    <div class="col-md-7 divContent">

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospitalHeartFailure" value="${mReviewForm?.isHospitalHeartFailure}"/>Heart Failure

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospHospAcqInfection"
                            value="${mReviewForm?.isHospHospAcqInfection}"/>Hospital-acquired infection
            </label>
        </div>

        <div>
            <label class="checkboxTop">
                <g:checkBox name="isMedicalError" value="${mReviewForm?.isMedicalError}"
                            onclick="showHideTextarea(this)"/>Medical Error
            </label>

            <div id="medicalErrorCommentDivId" ${!mReviewForm?.isMedicalError ? "style=display:none" : ''}
                 class="isMedicalError_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isMedicalError ? "mandatory" : ''}"  maxlength="250" placeholder="Please elaborate"
                          name="medicalErrorComment" >${mReviewForm?.medicalErrorComment}</textarea>
            </div>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isPressureUlcer" value="${mReviewForm?.isPressureUlcer}"/>Pressure Ulcer
            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospitalSepsis" value="${mReviewForm?.isHospitalSepsis}"/>Sepsis

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isShortnessOfBreath" value="${mReviewForm?.isShortnessOfBreath}"/>Shortness of Breath

            </label>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isSyncope" value="${mReviewForm?.isSyncope}"/>Syncope

            </label>
        </div>

        <div>
            <label class="checkboxTop">
                <g:checkBox name="isTypeOrLocation" value="${mReviewForm?.isTypeOrLocation}"
                            onclick="showHideTextarea(this)"/>Type/Location
            </label>

            <div id="typeOrLocationCommentDivId" ${!mReviewForm?.isTypeOrLocation?"style=display:none":''} class="isTypeOrLocation_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isTypeOrLocation ? "mandatory" : ''}"  maxlength="250" placeholder="Please specify"
                          name="typeOrLocationComment" >${mReviewForm?.typeOrLocationComment}</textarea>
            </div>
        </div>


        <div>
            <label class="checkboxTop">
                <g:checkBox name="isHospitalOther" value="${mReviewForm?.isHospitalOther}"
                            onclick="showHideTextarea(this)"/>Other
            </label>

            <div id="hospitalOtherCommentDivId" ${!mReviewForm?.isHospitalOther?"style=display:none":''} class="isHospitalOther_div checkbox-inline">
                <span class="required">*&nbsp;</span>
                <textarea class="ax_default text_area ${mReviewForm?.isHospitalOther ? "mandatory" : ''}"  maxlength="250" placeholder="Please specify"   name="hospitalOtherComment" >${mReviewForm?.hospitalOtherComment}</textarea>
            </div>
        </div>

        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isCompAcqHospNA" class="naCheckbox" value="${mReviewForm?.isCompAcqHospNA}"/>N/A

            </label>
        </div>
    </div>

</div>