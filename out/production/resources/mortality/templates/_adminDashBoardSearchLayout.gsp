<div class="col-md-3">
    <g:form controller="mortality" name="adminSearchForm">
        <div class="form-group margin">
            <label class="control-label">Form Status</label>
            <br>
            <label id="unAssigned&incomplete" class="radio-inline">
                <input type="radio" id = "formStatus" name="formStatus" value="UNASSIGNED">Unassigned & Incomplete
            </label>
            <label class="radio-inline">
                <input name="formStatus" id = "complete" type="radio" value="SUBMITTED">Complete
            </label>
        </div>

        <div class="form-group margin">
            <label>MSHS Hospitals</label>
            <g:select class="form-control" from="${facilityMap}"
                      name="facility" optionKey="key" optionValue="value" value="${userFacility}"
                      onchange="updateDeptQl(this)" noSelection="['0': '-Select-']"></g:select>
        </div>

        <div id="form_dept_ql">
            <g:render template="/mortality/templates/adminSearchDeptQL"/>
        </div>

        <!-- start of first date part -->
        <div class="margin">
            <label id="dateOfDeathFirstLabel" class="radio-inline">
                <input type="radio" id="dateDeathFirstRadio" name="dateOfDeathRadio" value="dateOfDeath">Date of Death
            </label>
            <label id="dateOfDeathSecLabel" class="radio-inline">
                <input id="dateDeathSecRadio" name="dateOfDeathRadio" type="radio" value = "deathRange">Date of Death Range
            </label>
        </div>

        <div id="dateOfDeathFirstDiv">
            <p>
                <input type="text" id ='dateOfDeath'class="datePicker form-control" name ="dateOfDeath" value="">
            </p>
        </div>

        <div class="form-group text" id='dateOfDeathSecondDiv' style='display:none'>
                    <label>From:</label>
                    <input type="text" id = 'fromDeathDate' class="datePicker form-control" name = 'fromDeathDate' value="">
                     <span id ="align">
                         <label>To:</label>
                        <input type="text" id = 'toDeathDate' class="datePicker form-control" name = 'toDeathDate' value="">
                     </span>
        </div>
        <!-- swcond Date -->
        <div class="margin">
            <label id="dateCompletedFirstLabel" class="radio-inline">
                <input id="dateCompletedFirstRadio" type="radio" name="dateCompletedRadio" value="dateCompleted">Date Completed
            </label>
            <label id="dateCompletedSecLabel" class="radio-inline">
                <input id="dateCompletedSecRadio" name="dateCompletedRadio" type="radio" value="completedRange">Date Completed Range
            </label>
        </div>

        <div id="dateCompletedFirstDiv">
            <p>
                <input type="text" id ="dateCompleted" class="datePicker form-control" name="dateCompleted" value="">
            </p>
        </div>

        <div class="form-group text" id='dateCompletedSecDiv' style='display:none'>
            <label>From:</label>
            <input type="text" id ='fromDateCompleted' class="datePicker form-control" name="fromDateCompleted" value="">
            <span id = "align1">
            <label>To:</label>
            <input type="text" id='toDateCompleted' class="datePicker form-control" name="toDateCompleted" value="">
            </span>
        </div>

        <div class="margin">
            <label class="checkbox-inline">
                <input type="checkbox" id = "requiredFurtherReview" name="requiredFurtherReview">Does Death Require Further Review?
            </label>
        </div>

        <div class="margin">
            <label class="checkbox-inline">
                <input type="checkbox" id ="expectedPatToDieAdmission" name="expectedPatToDieAdmission">Would you have expected the patient to die during this admission?
            </label>
        </div>

        <div class="form-group row margin">
            <label class="col-sm-5 col-form-label">Patient MRN
            </label>

            <div class="col-sm-7  ">
                <input class="form-control" type="text" name="mrn">
            </div>
        </div>

        <div class="form-group row margin">
            <label class="col-sm-5 col-form-label">Patient Name
            </label>

            <div class="col-sm-7  ">
                <input class="form-control" type="text" name="patientName">
            </div>
        </div>

        <div class="">
            <button type="button" class="btn btn-primary"
                    id="search" onclick="adminSearch(this); showExport();"
                    value="">Display</button>
           %{-- <button type="submit" class="btn btn-primary" id="watch-Display" onclick="divVisibility('Div2'); adminSearch(this);" value = "">Display</button>--}%

         <button type="submit" class="btn btn-primary" id="watch-Cancel" onclick="divVisibility('Div1')">Cancel</button>

        %{-- <g:link controller=" Mortality" action="adminDashboard">
            <button type="button" class="btn btn-primary cancelButton" onclick="divVisibility('Div1')">Cancel</button>
        </g:link>
--}%
        </div>

    </g:form>
</div>