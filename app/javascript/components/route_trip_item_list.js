// $(".option").click(function(){
//    $(".option").removeClass("active");
//    $(this).addClass("active");

// });


const flipRouteItems = () => {
  $(".option").click(function(){
   $(".option").removeClass("active");
   $(this).addClass("active");

  });

  // const nodes = document.querySelectorAll
  // nodes.(".option").addEventListener('click', function(event){
  //   console.log(event)

  // })
};

export { flipRouteItems };
