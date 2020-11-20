$(document).on('turbolinks:load', function() {
  const createInstruction = $('#addInstruction');

  createInstruction.click(function(){
    var date = new Date();
    var mSec = date.getTime();

    idOrder = 
      "recipe_instructions_attributes_0_order".replace("0", mSec);
    nameOrder = 
      "recipe[instructions_attributes][0][order]".replace("0", mSec);

    idInstruction = 
      "recipe_instructions_attributes_0_instruction_info".replace("0", mSec);
    nameInstruction = 
      "recipe[instructions_attributes][0][instruction_info]".replace("0", mSec);    

    const htmlElement = `
      <li>
        <div class='columns is-mobile'>
          <div class='column is-2'>
            <input class='input' name=${nameOrder} id=${idOrder} type='number' placeholder='Step'>
          </div>
          <div class='column'>
            <input id=${idInstruction} name=${nameInstruction} class='input' type='text' placeholder='Instruction...'>
          </div>
          <div class='column is-1'>
            <div class='icon_times'>
              <i class='fa fa-times fa-2x' ></i>
            </div>
          </div>
        </div>
      </li>`
    $(".instructions_list").append(htmlElement);
  });

  $(".instructions_list").on('click', 'i',  function(){
    $(this).parent().parent().parent().parent().remove()
  });
});