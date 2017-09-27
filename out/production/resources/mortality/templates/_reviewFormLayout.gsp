<%@ page import="org.mountsinai.mortalitytriggersystem.MortalityConstants" %>
<g:if test="${mReviewForm}">
    <form id="mReviewForm">
        <div class="container">
            <div>
                <div class="main_div" style="min-height: 620px">
                    <div class="top_div row">
                        <a href="#" onclick="divVisibility('patInfo');"><div
                                class="innertop_div col-md-1 center textPadding star clicked first"
                                data-divid="patInfo">
                            Patient Information</div></a>

                        <a href="#" onclick="divVisibility('majComorb');"><div
                                class="innertop_div col-md-1 center textPadding star"
                                data-divid="majComorb">Major Comorbidities POA</div></a>

                        <a href="#" onclick="divVisibility('compAcqHosp');"><div
                                class="innertop_div col-md-1 center textPadding star"
                                data-divid="compAcqHosp">Complication Acquired in  Hospital</div></a>

                        <a href="#" onclick="divVisibility('majSuppInter');"><div
                                class="innertop_div col-md-1 center textPadding star" data-divid="majSuppInter">Major
                            Supportive Interventions
                        </div></a>
                        <a href="#" onclick="divVisibility('majInvInter');"><div
                                class="innertop_div col-md-1 center textPadding star" data-divid="majInvInter">Major
                            Invasive Interventions
                        </div></a>

                        <a href="#" onclick="divVisibility('procRelComp');"><div
                                class="innertop_div col-md-1 center textPadding star" data-divid="procRelComp">Procedure
                            Related Complication
                        </div></a>

                        <a href="#" onclick="divVisibility('endOfLifeCare');"><div
                                class="innertop_div col-md-1 center textPadding star"
                                data-divid="endOfLifeCare">End of Life Care
                        </div></a>

                        <a href="#" onclick="divVisibility('causeOfDeath');"><div
                                class="innertop_div col-md-1 center textPadding star"
                                data-divid="causeOfDeath">Cause of Death
                        </div></a>
                        <a href="#" onclick="divVisibility('contrFactors');"><div
                                class="innertop_div col-md-1 center textPadding star"
                                data-divid="contrFactors">Contributing Factors</div></a>

                        <a href="#" onclick="divVisibility('addRevReq');"><div
                                class="innertop_div col-md-1 center textPadding star last"
                                data-divid="addRevReq">Additional Review Required
                        </div></a>
                    </div>

                    <div class="inner_div row">

                        <div id="patInfo" class="tabDiv">
                            <g:render template="templates/patInfo"></g:render>
                        </div>

                        <div id="majComorb" class="tabDiv" style="display: none;">
                            <g:render template="templates/majComorb"></g:render>
                        </div>

                        <div id="compAcqHosp" class="tabDiv" style="display: none;">
                            <g:render template="templates/compAcqHosp"></g:render>
                        </div>

                        <div id="majSuppInter" class="tabDiv" style="display: none;">
                            <g:render template="templates/majSuppInter"></g:render>
                        </div>

                        <div id="majInvInter" class="tabDiv" style="display: none;">
                            <g:render template="templates/majInvInter"></g:render>
                        </div>

                        <div id="procRelComp" class="tabDiv" style="display: none;">
                            <g:render template="templates/procRelComp"></g:render>
                        </div>

                        <div id="endOfLifeCare" class="tabDiv" style="display: none;">
                            <g:render template="templates/endOfLifeCare"></g:render>
                        </div>

                        <div id="causeOfDeath" class="tabDiv" style="display: none;">
                            <g:render template="templates/causeOfDeath"></g:render>
                        </div>

                        <div id="contrFactors" class="tabDiv" style="display: none;">
                            <g:render template="templates/contrFactors"></g:render>
                        </div>

                        <div id="addRevReq" class="tabDiv" style="display: none;">
                            <g:render template="templates/addRevReq"></g:render>
                        </div>

                    </div>
                </div>

                <div class="">
                    <g:link action="dashboard" params=" ">
                        <button type="button" class="btn btn-primary cancelButton">Cancel</button>
                    </g:link>

                    <g:if test="${mReviewForm?.status.status.equals(MortalityConstants.ASSIGNED) || mReviewForm?.status.status.equals(MortalityConstants.REASSIGNED)}">
                        <button type="button" class="btn btn-primary cancelButton"
                                onclick="acceptReviewForm(${mReviewForm.id}, '${mReviewForm.status}');">Accept</button>
                    </g:if>

                    <g:if test="${(mReviewForm?.status.status.equals(MortalityConstants.ASSIGNED) || mReviewForm?.status.status.equals(MortalityConstants.ACCEPTED) || mReviewForm?.status.status.equals(MortalityConstants.UPDATED))}">
                        <g:link action="assignReviewForm" params=" " onclick="return formStatus()">
                            <button type="button" class="btn btn-primary ">Reassign</button>
                        </g:link>
                    </g:if>
                    <g:if test="${mReviewForm?.status.status.equals(MortalityConstants.ACCEPTED) || mReviewForm?.status.status.equals(MortalityConstants.UPDATED)}">
                        <button type="button" id="watch-Submit" class="btn btn-primary ">Save</button>
                    </g:if>
                    <g:if test="${mReviewForm?.status.status.equals(MortalityConstants.UPDATED)}">
                        <g:link params="[reviewId: mReviewForm?.id]" action="reviewFormOnSave"><button type="button"
                                value="Save and Submit" id="show-Submit"
                                class="btn btn-primary ">Save and Review</button></g:link>
                    </g:if>


                    <div class="fright">
                        <button type="button" class="btn btn-primary hide prevBtn" onclick="moveTab(0)"><span
                                class="glyphicon glyphicon-backward"></span> Prev</button>
                        <button type="button" class="btn btn-primary nextBtn" onclick="moveTab(1)">Next <span
                                class="glyphicon glyphicon-forward"></span></button>
                    </div>

                </div>
            </div>
        </div>
        <g:hiddenField  id ="isFormEditable" name="isFormEditable" value="${isFormEditable}"></g:hiddenField>
        <g:hiddenField name="reviewId" value="${mReviewForm.id}"></g:hiddenField>
        <g:hiddenField name="status" id="status" value="${mReviewForm.status}"></g:hiddenField>
    </form>
</g:if>
<g:else>
    No Data To Show
</g:else>