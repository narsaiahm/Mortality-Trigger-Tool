<div class="title">
    <p><span>Patient Information</span>
    </p>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="part1">
            <table class="personalInfoTable">
                <tr>
                    <td><span>Patient Name:</span>
                        <span><b>${mReviewForm?.patientName}</b></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>DOB:</span>
                        <span><b>${mReviewForm?.dob}</b></span>
                    </td>
                </tr>
                <tr><td>
                    <span>
                        Admit Date:</span>
                    <span><b>${mReviewForm?.admitDateTime}</b></span></td>
                </tr>
                <tr>
                    <td>
                        <span>
                            Primary reason for hospitalization at time of admission : ${mReviewForm?.primReasonTimeOfAdmission}</span>
                        <span></span>
                    </td>
                </tr>
            </table>
        </div>

        <div class="part1">
            <table class="personalInfoTable">
                <tr>
                    <td>

                        <span>Discharge Diagnosis:</span>
                        <span><b>${mReviewForm?.dischargeDiagnosis}</b></span></td></tr>

                <tr>
                    <td><span>Hospital:</span>
                        <span><b>${mReviewForm?.hospitalName}</b></span></td>
                </tr>
                <tr>
                    <td>
                        <span>
                            Discharge Attending:</span>
                        <span><b>${mReviewForm?.lastAttending}</b></span>
                    </td></tr>
                <tr><td>
                    <span>
                        Discharging Division:</span>
                    <span><b>${mReviewForm?.dischargingDivision}</b></span></td></tr>

            </table>
        </div>
    </div>
    <input type="hidden" name="mrn" value="${mReviewForm?.mrn}">

    <div class="col-md-6">
        <div class="part1">
            <table class="personalInfoTable">
                <tr>
                    <td>

                        <span>MRN:</span>
                        <span><b>${mReviewForm?.mrn}</b></span></td></tr>

                <tr><td>
                    <span>Sex:</span>
                    <span><b>${mReviewForm?.gender}</b></span></td></tr>

                <tr><td>
                    <span>
                        Admitting Diagnosis:</span>
                    <span><b>${mReviewForm?.admittingDiagnosis}</b></span>
                </td></tr>
                <tr><td colspan="5">&nbsp;</td></tr>
            </table>
        </div>

        <div class="part1">
            <table class="personalInfoTable">
                <tr>
                    <td>

                        <span>Discharge Date:</span>
                        <span><b>${mReviewForm?.dischargeDateTime}</b></span></td></tr>
                <tr><td>
                    <span>Patient Unit at Death:</span>
                    <span><b>${mReviewForm?.dischargeUnit}</b></span></td></tr>
                <tr><td>
                    <span>
                        Discharging Department:</span>
                    <span><b>${mReviewForm?.dischargingDepartment}</b></span></td></tr>
                <tr><td colspan="5">&nbsp;</td></tr>
            </table>

        </div>
    </div>
</div>

<div class="form-inline row">
    <div class="col-md-12">
        <table class="leftAlign">
            %{-- <tr>
                 <td class="form-group">
                     <label>Comment:</label>
                 </td>
                 <td>
                     <textarea class="form-control" name="comments" value="${mReviewForm?.comments}">${mReviewForm?.comments}</textarea>
                 </td>
             </tr>--}%
            <tr>
                <td>
                    <span class="required">*&nbsp;</span>
                    <label>Is patient information above accurate?</label>

                </td>
                <td>
                    <label class="radio-inline">
                        <input id="isPatInfoAccurateYesDiv" type="radio" name="isPatInfoAccurate" class="mandatory"
                               value="true" ${mReviewForm?.isPatInfoAccurate == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input id="isPatInfoAccurateNoDiv" type="radio" id="isPatInfoAccurate" name="isPatInfoAccurate"
                               class="mandatory"
                               value="false" ${mReviewForm?.isPatInfoAccurate == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>

            </tr>

            <tr id='isPatInfoAccurateCommDiv' ${mReviewForm?.isPatInfoAccurate == false ? "" : "style=display:none"}>
                <td><span class="required check">*&nbsp;</span><label>If No,specify:</label></td>
                <td >

                    <textarea id="patInfoComment"
                              class="ax_default text_area ${mReviewForm?.isPatInfoAccurate == false ? "mandatory" : ''}"
                              maxlength="250"
                              placeholder="Please fill out the correct Information"
                              name="patInfoComment">${mReviewForm?.patInfoComment}</textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="required">*&nbsp;</span>
                    <label>Was patient transferred from another facility?</label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input id="wasPatTransferredFacilityYesdiv" type="radio" name="wasPatTransferredFacility"
                               class="mandatory"
                               value="true" ${mReviewForm?.wasPatTransferredFacility == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input id="wasPatTransferredFacilityNodiv" type="radio" name="wasPatTransferredFacility"
                               class="mandatory"
                               value="false" ${mReviewForm?.wasPatTransferredFacility == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>
            </tr>
            <tr id="patTransferredCommentDiv" ${mReviewForm?.wasPatTransferredFacility ? "" : 'style=display:none'}>
                <td><span class="required check">*&nbsp;</span>
                    <label class="checkboxTop">If yes,specify:</label>
                </td>
                <td >

                    <textarea id="patTransferredComment"
                              class="ax_default text_area ${mReviewForm?.wasPatTransferredFacility ? "mandatory" : ''}"
                              maxlength="250"
                              placeholder="Please specify"
                              name="patTransferredComment">${mReviewForm?.patTransferredComment}</textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="required">*&nbsp;</span>
                    <label>ICU stay?</label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input id="isIcuStayYesDiv" type="radio" name="isIcuStay" class="mandatory"
                               value="true" ${mReviewForm?.isIcuStay == true ? 'checked="checked"' : ''} s()">Yes
                    </label>
                    <label class="radio-inline">
                        <input id="isIcuStayNoDiv" type="radio" name="isIcuStay" class="mandatory"
                               value="false" ${mReviewForm?.isIcuStay == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>
            </tr>

            <tr id="isPatDiedLt24hrsDischargeRowId" ${mReviewForm?.isIcuStay ? "" : 'style=display:none'}>
                <td>
                    <span class="required check">*&nbsp;</span>
                    <label>Did the patient die &lt;24 hours of discharge from ICU?</label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input type="radio" name="isPatDiedLt24hrsDischarge"
                               class="${mReviewForm?.isIcuStay ? "mandatory" : ''}"
                               value="true" ${mReviewForm?.isPatDiedLt24hrsDischarge == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isPatDiedLt24hrsDischarge"
                               class="${mReviewForm?.isIcuStay ? "mandatory" : ''}"
                               value="false" ${mReviewForm?.isPatDiedLt24hrsDischarge == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>
            </tr>

            <tr>
                <td>
                    <span class="required check">*&nbsp;</span>
                    <label>Did death occur with 24 hours of admission?</label>
                </td>
                <td>
                    <label class="radio-inline">

                        <input type="radio" name="isDeathWt24hrAdmission" class="mandatory"
                               value="true" ${mReviewForm?.isDeathWt24hrAdmission == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isDeathWt24hrAdmission" class="mandatory"
                               value="false" ${mReviewForm?.isDeathWt24hrAdmission == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="required">*&nbsp;</span>
                    <label>Was case appropriate for the ME?</label>
                </td>

                <td>
                    <label class="radio-inline">
                        <input id="wasCaseAptMEYesDiv" type="radio" name="wasCaseAptME" class="mandatory"
                               value="true" ${mReviewForm?.wasCaseAptME == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input id="wasCaseAptMENoDiv" type="radio" name="wasCaseAptME" class="mandatory"
                               value="false" ${mReviewForm?.wasCaseAptME == false ? 'checked="checked"' : ''}>No
                    </label>
            </tr>
            <tr ${mReviewForm?.wasCaseAptME == true || mReviewForm?.wasCaseAptME == false ? "" : 'style=display:none'}
                    id="appropriateCaseYesDiv"">
            <td>
                <span class="required check">*&nbsp;</span>
                <label id='appropriateCaseYes'
                       class="checkboxTop" ${!mReviewForm?.wasCaseAptME == true ? "style=display:none" : ''}>If Yes, was case referred and accepted?:</label>
                <label id='appropriateCaseNo'
                       class="checkboxTop" ${!mReviewForm?.wasCaseAptME == false ? "style=display:none" : ''}>If No, why not?:</label>
            </td>
            <td class="">
                <textarea id="wasCaseAptMEComment"
                          class="ax_default text_area ${mReviewForm?.wasCaseAptME != null ? "mandatory" : ''}"
                          maxlength="250"
                          placeholder="Please specify"
                          name="wasCaseAptMEComment">${mReviewForm?.wasCaseAptMEComment}</textarea>
            </td>
        </tr>

        </tr>
            <br>
            <tr>
                <td>
                    <span class="required">*&nbsp;</span>
                    <label>If case met autopsy criteria (but not ME criteria or rejected by the ME), was an autosy performed?</label>
                </td>
                <td>
                    <label class="radio-inline">
                        <input type="radio" name="isAutopsyPerformed" class="mandatory"
                               value="true" ${mReviewForm?.isAutopsyPerformed == true ? 'checked="checked"' : ''}>Yes
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isAutopsyPerformed" class="mandatory"
                               value="false" ${mReviewForm?.isAutopsyPerformed == false ? 'checked="checked"' : ''}>No
                    </label>
                </td>

            </tr>
            <br/><br/><br/>
            <tr>
                <td class="form-group" style="margin-left: 62%;">
                    <label>Brief Summary of Hospital Course:</label>
                </td>
                <td>
                    <textarea class="ax_default text_area"
                              name="summaryOfHospCourse">${mReviewForm?.summaryOfHospCourse}</textarea>
                </td>
            </tr>

        </table>

    </div>
</div>
