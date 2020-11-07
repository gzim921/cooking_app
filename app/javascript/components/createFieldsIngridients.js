$(document).ready(function() {
  const createInstruction = $('#addIngridients');

  createInstruction.click(function(){
    var date = new Date();
    var mSec = date.getTime();

    idOrder = 
      "recipe_ingridients_attributes_0_name".replace("0", mSec);
    nameOrder = 
      "recipe[ingridients_attributes][0][name]".replace("0", mSec);

    const htmlElement = `
      <li>
        <div class='columns is-mobile'>
          <div class='column'>
            <input class='input' " + nameOrder + " id=" + idOrder + " type='text' placeholder='Ingridient'>
          </div>
          <div class='column is-1'>
            <div class='icon_times'>
              <i class='fa fa-times fa-2x' ></i>
            </div>
          </div>
        </div>
      </li>`
      $(".ingridients_list").append(htmlElement);
  });

  $(".ingridients_list").on('click', 'i',  function(){
    $(this).parent().parent().parent().remove()
  });
});