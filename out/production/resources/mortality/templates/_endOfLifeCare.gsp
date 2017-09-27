<div class="title">
    <p><span>End of Life Care</span>
    </p>
</div>

<div class="form-inline row">
    <div class="col-md-4 divContent">
        <div>
            <label class="checkbox-inline">
                <g:checkBox name="isHospice" value="${mReviewForm?.isHospice}"/>Hospice
            </label>

            <label class="checkbox-inline">
                <g:checkBox name="isPalliativeCare" value="${mReviewForm?.isPalliativeCare}"/>Palliative Care
            </label>

            <label class="checkbox-inline">
                <g:checkBox name="isEndLifeCareNA" class="naCheckbox" value="${mReviewForm?.isEndLifeCareNA}"/>N/A
            </label>
        </div>

         <table class="leftAlign">
             <tbody>
             <tr>
                 <td>
            <label class="removeBold">
                <span class="required">*&nbsp;</span>
                Was there an Advance Directive?</label>
                 </td>
                 <td>
            <label class="radio-inline">
                <input type="radio" name="wasThereAnAdvanceDirective" class="mandatory"
                       value="true" ${mReviewForm?.wasThereAnAdvanceDirective == true ? 'checked="checked"' : ''}>Yes
            </label>

            <label class="radio-inline">
                <input type="radio" name="wasThereAnAdvanceDirective" class="mandatory"
                       value="false" ${mReviewForm?.wasThereAnAdvanceDirective == false ? 'checked="checked"' : ''}>No
            </label>
                 </td>
             </tr>
             </tbody>
         </table>
    </div>
</div>