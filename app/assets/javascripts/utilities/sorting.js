document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.sort-by-title');

  // checking for the existence of the sort-by-title class on the page
  if (control) { control.addEventListener('click', sortRowsByTitle) }
});

function sortRowsByTitle() {
  var table = document.querySelector('table')

  // NodeList
	// https://developer.mozilla.org/ru/docs/Web/API/NodeList
  var rows = table.querySelectorAll('tr')
  // console.log(rows)
  var sortedRows = []
  
  // select all table rows except the first one which is the header
  for (var i = 1; i < rows.length; i++) {
    sortedRows.push(rows[i])
  }

  // check if the arrow is hidden then the grade is in ascending order
  // control visibility of the arrows
  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc)
    this.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.querySelector('.octicon-arrow-down').classList.add('hide')
  } else {
      sortedRows.sort(compareRowsDesc)
      this.querySelector('.octicon-arrow-down').classList.remove('hide')
      this.querySelector('.octicon-arrow-up').classList.add('hide')
  }

  // creating a new html document in memory
  var sortedTable = document.createElement('table')

  // adding a css class using JS
  sortedTable.classList.add('table')
  // adding the first row of the title from the rows collection
  sortedTable.appendChild(rows[0])

  // add the sorted array to the table in memory
  for (var i = 0; i < sortedRows.length; i++) {
    sortedTable.appendChild(sortedRows[i])
  }

  // put a table from memory into an existing
  table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent
  var testTitle2 = row2.querySelector('td').textContent

  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0
}

function compareRowsDesc(row1, row2) {
  var testTitle1 = row1.querySelector('td').textContent
  var testTitle2 = row2.querySelector('td').textContent

  if (testTitle1 < testTitle2) { return 1 }
  if (testTitle1 > testTitle2) { return -1 }
  return 0
}
