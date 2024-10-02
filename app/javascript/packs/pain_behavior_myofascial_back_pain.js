document.addEventListener("DOMContentLoaded", function() {
    var form = document.getElementById('dynamicForm');
    var nothingCheckBox = document.getElementById('nothing');

    form.addEventListener('submit', function(event) {
      var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      
      if (nothingCheckBox.checked) {
        form.action = "<%= pain_behavior_intervertebral_disk_path %>"; // 「どれも当てはまらない」が選ばれたとき
      } else {
        form.action = "<%= diagnostic_result_myofascial_back_pain_path %>"; // 他のチェックが選ばれたとき
      }
      
      // CSRFトークンを動的にフォームに追加
      var input = document.createElement('input');
      input.type = 'hidden';
      input.name = 'authenticity_token';
      input.value = token;
      form.appendChild(input);
    });
});


  
  

  

