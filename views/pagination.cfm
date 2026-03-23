<cfparam name="url.page" default="1">
<cfparam name="url.crm" default="">
<cfparam name="url.search" default="">
<cfparam name="url.department" default="">

<cfoutput>
<div style="text-align:center; margin-top:20px;">

<cfif url.page GT 1>
<a href="javascript:changePage('#url.crm#', #url.page-1#, #totalPages#, '#url.search#', '#url.department#')">
Previous
</a>
</cfif>

&nbsp;&nbsp;

<span>Page #url.page# of #totalPages#</span>

&nbsp;&nbsp;

<cfif url.page LT totalPages>
<a href="javascript:changePage('#url.crm#', #url.page+1#, #totalPages#, '#url.search#', '#url.department#')">
Next
</a>
</cfif>

</div>
</cfoutput>
<br>