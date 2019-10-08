var tabButtons = document.querySelectorAll(".buttonContainer a")
var tabPanels = document.querySelectorAll(".tabPanel")

const showPanels = (tabIndex) =>{
  tabButtons.forEach(function(node){
    if (node.classList.contains('show-button')){
      node.classList.remove('show-button')
    }
  });
  tabPanels.forEach(function(node){
    if (node.classList.contains('show-panel')){
      node.classList.remove('show-panel')
    }
  });
  if (tabPanels.length) {
    tabPanels[tabIndex].classList.add('show-panel')
    tabButtons[tabIndex].classList.add('show-button')
  }
}
showPanels(0)

const setupTabEventListeners = () => {
  var aElements = document.querySelectorAll('.tab-button');
  aElements.forEach(function(node){
    node.addEventListener('click', () => showPanels(node.attributes["data-tab-index"].value) )
  });
}

// 1. add data-tab-id attr to each tab in the html;
//.   add data-color attr to each tab
// <a href="---" data-tab-index="2" data-color="#ff44336">Tab 1</a>
// 2. on document ready (event listener):
//.     find all tabs by a css class selector
// 3.     for each of these, add an event listener for click event:
// 4.         when clicked, call showPanels()
//                with panel index & color that you take from the clicked element's data attributes (dataset)

export { setupTabEventListeners };

