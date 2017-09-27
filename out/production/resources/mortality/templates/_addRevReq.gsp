
<div class="title">
    <p><span>Additional Review Required</span></p>
</div>
<div class="form-inline row">
    <div class="row">
        <div class="col-md-6">

            <label class="radio-inline">
                <span class="required">*&nbsp;</span>
                Does Death Require Further Review?</label>

            <label class="radio-inline">
                <input type="radio" class="mandatory"  name="doesDeathRequireFurtherRev" value="true" ${mReviewForm?.doesDeathRequireFurtherRev == true ? 'checked="checked"' : ''} >Yes
            </label>
            <label class="radio-inline">
                <input type="radio" class="mandatory" name="doesDeathRequireFurtherRev" value="false" ${mReviewForm?.doesDeathRequireFurtherRev == false ? 'checked="checked"' : ''} >No
            </label>
        </div>
    </div>
</div>