let currentPage = 1;
let perPage = 5;
let globalData = [];
let tableSelector = "";
let paginationSelector = "";

function initPagination(data, tableId, paginationId) {
  globalData = data;
  tableSelector = tableId;
  paginationSelector = paginationId;
  currentPage = 1;

  displayData();
  setupPagination();
}

function displayData() {
  let start = (currentPage - 1) * perPage;
  let end = start + perPage;

  let pageData = globalData.slice(start, end);

  $(tableSelector).html("");

  if(pageData.length === 0){
    $(tableSelector).html(
      `<tr><td colspan="4" align="center">No Data</td></tr>`
    );
    return;
  }

  $.each(pageData, function(i, item){
    $(tableSelector).append(generateRow(item));
  });
}

function setupPagination(){
  let totalPages = Math.ceil(globalData.length / perPage);

  $(paginationSelector).html("");

  let visiblePages = 5;
  let startPage = Math.max(1, currentPage - 2);
  let endPage = Math.min(totalPages, startPage + visiblePages - 1);

  // Prev
  if(currentPage > 1){
    $(paginationSelector).append(
      `<button onclick="goToPage(${currentPage-1})">Prev</button>`
    );
  }

  // Page Numbers
  for(let i = startPage; i <= endPage; i++){
    $(paginationSelector).append(
      `<button onclick="goToPage(${i})"
        style="${i===currentPage?'background:#333;color:#fff':''}">
        ${i}
      </button>`
    );
  }

  // Next
  if(currentPage < totalPages){
    $(paginationSelector).append(
      `<button onclick="goToPage(${currentPage+1})">Next</button>`
    );
  }

  //  ADD THIS LINE
  $(paginationSelector).append(
    `<div style="margin-top:10px;">Page ${currentPage} of ${totalPages}</div>`
  );
}

function goToPage(page){
  currentPage = page;
  displayData();
  setupPagination();
}