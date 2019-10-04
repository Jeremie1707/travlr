document.querySelector('add-trip-card')


const setupButtonEventListeners = () => {
  var aElements = document.querySelectorAll('#card-add-button');
  aElements.forEach(function(node){
    node.addEventListener('click', (event) => console.log(node.dataset.target) )
  });
}


export { setupButtonEventListeners };
