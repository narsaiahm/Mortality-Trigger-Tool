<!DOCTYPE html>
<html>

<head>
    <head>
        <meta name="layout" content="main" />
        <asset:javascript src="dashboard.js"/>
    </head>
</head>

<body>

<div class="container">
    <div class="runReportSidebar col-md-3">
        <a href="#" onclick="divVisibility('mortalityTriggerToolSummary');"><div class="fleft star ">
            Mortality Trigger Tool Summary
        </div></a>

        <a href="#" onclick="divVisibility('timeToCompletion');"><div class="fleft star">Time to Completion
        </div></a>
    </div>
        <div class="runReportContentArea col-md-9">
            <div id="mortalityTriggerToolSummary">
                <div class="pageTitle">
                    Mortality Trigger Tool Summary Report
                </div>
                <div class="row summary_Content">
                    <div class="col-sm-4">

                        <div class="form-group margin">
                            <label>Hospital</label>
                            <g:select class="form-control" from="${facilityMap}"
                                      name="facility" optionKey="key" optionValue="value" value="${userFacility}"
                                      onchange="updateDeptQl(this)" noSelection="['0': '-Select-']"></g:select>
                        </div>
                        <div class="form-group margin">
                            <label> Division</label>
                            <g:select class="form-control"  from="${specialities}"
                                      name="speciality" optionKey="id" optionValue="specialityName" noSelection="['':'All']"></g:select>
                        </div>
                        %{--<div id="form_dept_ql">
                            <g:render template="/mortality/templates/adminSearchDeptQL"/>
                        </div>--}%
                        <div class="form-group margin">
                            <label>Quality Lead</label>
                            <g:select class="form-control"  from="${leads}"
                                      name="qualityLead" optionKey="id" optionValue="name" noSelection="['':'All']"></g:select>
                        </div>
                       %{-- <div class="form-group margin">
                            <label>Forms assigned to Quality Lead</label>
                            <g:select class="form-control"  from="${leads}"
                                      name="qualityLead" optionKey="id" optionValue="name" noSelection="['':'All']"></g:select>
                        </div>
                        <div class="margin">
                            <p><a href=""> Assign MSHS Employees to Quality Lead</a></p>
                        </div>
                        <div class="form-group margin">
                            <label>Forms assigned to Ad Hoc</label>
                            <g:select class="form-control" from="${adhocs}"
                                      name="adhoc" optionKey="id" optionValue="name" noSelection="['':'All']"></g:select>
                        </div>--}%
                    </div>
                    <div class="col-sm-5">
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
                    </div>

                    <div class="col-sm-3">
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
                        <form class="form-inline output">
                            <div class="form-group">
                                <label>Output:</label>
                                <select class="form-control">
                                    <option>Excel</option>
                                    <option>HTML</option>
                                    <option>PDF</option>
                                </select>
                            </div>
                            <button type="button" id="watch_showreport" class="btn btn-primary btn-xs btn-xs">Show Report</button>
                        </form>
                    </div>
                </div>
                <div class="row center">
                    <div class="col-md-12" id="showreport">
                        Mortality Trigger Summary Data
                    </div>
                </div>
            </div>
            <div id="timeToCompletion" style="display: none;">
                <form class=" time_to_completionArea form-inline">
                    <div class="form-group">
                        <label>Year/Month:</label>
                        <select class="form-control">
                            <option>2017/06</option>
                            <option>2017/07</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Output:</label>
                        <select class="form-control">
                            <option>Excel</option>
                            <option>HTML</option>
                            <option>PDF</option>
                        </select>
                    </div>
                    <button type="button" class="btn btn-primary btn-xs btn-xs">Show Report</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>