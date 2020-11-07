$(document).ready(function() {
  const createInstruction = $('#addInstruction');

  createInstruction.click(function(){
      var date = new Date();
      var mSec = date.getTime();

      idOrder = 
         "recipe_instructions_0_order".replace("0", mSec);
      nameOrder = 
          "recipe[instructions][0][order]".replace("0", mSec);

      idInstruction = 
          "recipe_instructions_0_instruction_info".replace("0", mSec);
      nameInstruction = 
           "recipe[instructions][0][instruction_info]".replace("0", mSec);    

      $("ul").append("<li><div class='columns is-mobile'><div class='column is-3'><input class='input' " + nameOrder + " id=" + idOrder + " type='number' placeholder='Step'></div><div class='column'><input id=" + idInstruction + " name=" + nameInstruction + " class='input' type='text' placeholder='Instruction...'> </div></div></li>");
  });
});