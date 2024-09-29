document.addEventListener('DOMContentLoaded', () => {
    const slider = document.getElementById('painRange');
    const painValueSpan = document.getElementById('painValue');
    const hiddenPainLevelInput = document.getElementById('hiddenPainLevel');
  
    const increaseButton = document.getElementById('increase');
    const decreaseButton = document.getElementById('decrease');
  
    function updatePainValue(value) {
      painValueSpan.textContent = value;
      hiddenPainLevelInput.value = value;  // hiddenフィールドに値を設定
    }
  
    increaseButton.addEventListener('click', () => {
      if (parseInt(slider.value) < parseInt(slider.max)) {
        slider.value = parseInt(slider.value) + 1;
        updatePainValue(slider.value);
      }
    });
  
    decreaseButton.addEventListener('click', () => {
      if (parseInt(slider.value) > parseInt(slider.min)) {
        slider.value = parseInt(slider.value) - 1;
        updatePainValue(slider.value);
      }
    });
  
    slider.addEventListener('input', (event) => {
      updatePainValue(event.target.value);
    });
  });
  