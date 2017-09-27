<div class="heading_2 "><center><span class="titleName ">Mortality Review Form</span></center></div>

<div class="main_div" style="margin-right: 40px;margin-left: 40px;">
<div class="inner_div row">
   <form id="mReviewForm" >
   <div  >
        <g:render template="templates/patInfo"></g:render>
    </div>
    <div   >
        <g:render template="templates/majComorb"></g:render>
    </div>
    <div   >
        <g:render template="templates/compAcqHosp"></g:render>
    </div>
    <div   >
        <g:render template="templates/majSuppInter"></g:render>
    </div>
    <div   >
        <g:render template="templates/majInvInter"></g:render>
    </div>
    <div   >
        <g:render template="templates/procRelComp"></g:render>
    </div>
    <div   >
        <g:render template="templates/endOfLifeCare"></g:render>
    </div>
    <div   >
        <g:render template="templates/causeOfDeath"></g:render>
    </div>
    <div   >
        <g:render template="templates/contrFactors"></g:render>
    </div>
    <div   >
        <g:render template="templates/addRevReq"></g:render>
    </div>

     %{--   <div style="margin-top: 4%;">
            <left> <g:actionSubmit value="Cancel" action="review" class="btn btn-primary " > Cancel</g:actionSubmit></left>&nbsp;&nbsp;&nbsp;&nbsp;
            <left><g:actionSubmit value="Save and Submit" action="submitMortalityForm" class="btn btn-primary " > Save and Submit</g:actionSubmit></left>
        </div>--}%
       <div style="margin-top: 4%;">
           <left> <g:actionSubmit value="Cancel" action="review" class="btn btn-primary " > Cancel</g:actionSubmit></left>&nbsp;&nbsp;&nbsp;&nbsp;
           <left><g:actionSubmit value="Save and Submit" id="submitReviewFormButtonId" action="submitMortalityForm" class="btn btn-primary " onclick="return reviewAndSubmit()"> Save and Submit</g:actionSubmit></left>
       </div>



   </form>
</div>
</div>
