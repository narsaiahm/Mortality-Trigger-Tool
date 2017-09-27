<!DOCTYPE html>
<html>

<head>
    <head>
        <meta name="layout" content="main" />
        <asset:javascript src="dashboard.js"/>
    </head>
</head>

<body>
<g:form controller="mortality" name="runReport">
<div class="container">
    <div class="runReportMainContentArea row">
        <div class="runReportSidebar col-md-3">
            <a href="#" rel="mortalityTriggerToolSummary">
                <div class="fleft star ">
                    Mortality Trigger Tool Summary
                </div>
            </a>
            <a href="#" rel="timeToCompletion">
                <div class="fleft star">Time to Completion
                </div>
            </a>
        </div>
        <div class="runReportContentArea col-md-9">
            <div id="mortalityTriggerToolSummary">
                <div class="pageTitle">
                    Mortality Trigger Tool Summary Report
                </div>
                <div class="row summary_Content">
                    <div class="col-sm-4">
                        <form>
                            <table>
                                <tr>
                                    <td>
                                        <label>Hospital:</label>
                                    </td>
                                    <td>
                                        <g:select class="form-control"  from="${facilityMap}"
                                                  name="report" optionKey="key" optionValue="value" value="${userFacility}" onchange="updateDeptQl(this)"></g:select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Facility:</label>
                                    </td>
                                    <td>
                                        <select class="form-control">
                                            <option>-Select Facility-</option>
                                            <option>Facility #1</option>
                                            <option>Facility #2</option>
                                            <option>Facility #3</option>
                                            <option>Facility #4</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Division:</label>
                                    </td>
                                    <td>
                                        <g:select class="form-control"  from="${specialities}"
                                                  name="speciality" optionKey="id" optionValue="specialityName" noSelection="['':'-Select Division-']"></g:select>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <form class="form-inline">
                            <div>
                                <div class="fleft">
                                    <label id="firstDate" class="radio-inline">
                                        <input type="radio" name="dateVar" checked>Date of Death
                                    </label>
                                </div>
                                <div class="fleft dod">
                                    <label class="radio-inline">
                                        <input id="secondDate" name="dateVar" type="radio">Date of Death Range
                                    </label>
                                </div>
                            </div>
                            <!-- first datepart -->
                            <div id="firstDateDiv">
                                <input type="text" class="datePicker" value="">
                            </div>
                            <div class="form-group text" id='secondDateDiv' style='display:none'>
                                <label>From:</label>
                                <input type="text" class="datePicker" value="">
                                <label>To:</label>
                                <input type="text" class="datePicker" value="">
                            </div>
                            <!-- end of first date part -->
                            <!-- second datepart -->
                            <div>
                                <div class="fleft">
                                    <label id="thirdDate" class="radio-inline">
                                        <input type="radio" name="dateVar1" checked>Date Completed
                                    </label>
                                </div>
                                <div class="fleft">
                                    <label class="radio-inline">
                                        <input id="fourthDate" name="dateVar1" type="radio">Date Completed Range
                                    </label>
                                </div>
                            </div>
                            <div id="thirdDateDiv">
                                <input type="text" class="datePicker" value="">
                            </div>
                            <div class="form-group text" id='fourthDateDiv' style='display:none'>
                                <label>From:</label>
                                <input type="text" class="datePicker" value="">
                                <label>To:</label>
                                <input type="text" class="datePicker" value="">
                            </div>
                            <!-- end of second date part -->
                        </form>
                    </div>
                    <div class="col-sm-4">
                        <div class="marginbottom">
                            <label class="checkbox-inline">
                                <input type="checkbox" name="optradio">Does Death Require Further Review?
                            </label>
                        </div>
                        <div>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="optradio">Would you have expected the patient to die during this admission?
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
</div>
%{--<footer class="container-fluid">
    <div class="copyrights col-md-4">
        <p class="fleft">©2017 Mount Sinai Health System</p>
        <p class="fleft">Mortality Trigger Tool v1.0 (2017-08-07) </p>
    </div>
    <div class="col-md-7"></div>
    <div class="col-md-1" style="float:right">
        <a href=":" target="">Contact Us</a>
    </div>
</footer>--}%
%{--<--}%%{--script type="text/javascript">
    $('a').on('click', function() {
        var target = $(this).attr('rel');
        $("#" + target).show().siblings("div").hide();
    });


    $(document).ready(function() {
        $('input[type="radio"]').click(function() {
            if ($(this).attr('id') == 'firstDate') {
                $('#firstDateDiv').show();
                $('#secondDateDiv').hide();
                $("#secondDate input:radio").attr('checked', false);
            } else if ($(this).attr('id') == 'secondDate') {
                $("#firstDate input:radio").attr('checked', false);
                $('#secondDateDiv').show();
                $('#firstDateDiv').hide();
            } else {
                $('#firstDateDiv').show();
                $('#secondDateDiv').hide();

            }
        });
    });



    $(document).ready(function() {
        $('input[type="radio"]').click(function() {
            if ($(this).attr('id') == 'thirdDate') {
                $('#thirdDateDiv').show();
                $('#fourthDateDiv').hide();
                $("#fourthDate input:radio").attr('checked', false);
            } else if ($(this).attr('id') == 'fourthDate') {
                $("#thirdDate input:radio").attr('checked', false);
                $('#fourthDateDiv').show();
                $('#thirdDateDiv').hide();
            } else {
                $('#thirdDateDiv').show();
                $('#fourthDateDiv').hide();

            }
        });
    });


    $(document).on("click", ".datePicker", function() {
        var clickedBtnID = $(this); // or var clickedBtnID = this.id

        clickedBtnID.datepicker();
        clickedBtnID.datepicker("show");
        // alert('you clicked on button #' + clickedBtnID);
    });


    $(document).ready(function() {
        $('#showreport').hide();
        $("#watch_showreport").click(function() {
            $("#showreport").show();
        });
    });
</script>--}%
</g:form>
</body>
</html>