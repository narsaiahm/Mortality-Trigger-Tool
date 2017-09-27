<div class="form-group margin">
    <label>MSHS Discharging Division</label>
    <g:select class="form-control"  from="${specialities}"
              name="speciality" optionKey="id" optionValue="specialityName" noSelection="['':'All']"></g:select>
</div>
<div class="form-group margin">

    <label>Forms assigned to </label>
    <br>
    <label id="all" class="radio-inline">
        <input type="radio" id = "assignedTo_all" name="assignedTo" value="ALL" checked="checked" onclick="updateQl(this)">All
    </label>
    <label id="qualityId" class="radio-inline">
        <input type="radio" id = "assignedTo_ql" name="assignedTo" value="QUALITY_LEAD" onclick="updateQl(this)">Quality Lead
    </label>
    <label class="radio-inline">
        <input name="assignedTo" id = "assignedTo_otherReviewer" type="radio" value="ADHOC" onclick="updateQl(this)">Other Reviewer
    </label>
    <br>
    <div id="form_ql">
        <g:render template="/mortality/templates/adminSearchQL"></g:render>
    </div>
    %{--<div class="form-group margin">
        <label>Forms assigned to Ad Hoc</label>
        <g:select class="form-control" from="${adhocs}"
                  name="adhoc" optionKey="id" optionValue="name" noSelection="['':'All']"></g:select>
    </div>
--}%
</div>
%{--<div class="margin">
    <p><a href=""> Assign MSHS Employees to Quality Lead</a></p>
</div>--}%
%{--
<div class="form-group margin">
    <label>Forms assigned to Ad Hoc</label>
    <g:select class="form-control" from="${adhocs}"
              name="adhoc" optionKey="id" optionValue="name" noSelection="['':'All']"></g:select>
</div>--}%
