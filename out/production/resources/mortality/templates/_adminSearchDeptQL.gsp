<div class="form-group margin">
    <label>MSHS Discharging Division</label>
    <g:select class="form-control"  from="${specialities}"
              name="speciality" optionKey="id" optionValue="specialityName" noSelection="['':'All']"></g:select>
</div>
<div class="form-group margin">
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
</div>