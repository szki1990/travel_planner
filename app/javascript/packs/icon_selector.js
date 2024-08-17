document.addEventListener('turbolinks:load', () => {
  const iconElements = document.querySelectorAll('.icon-selection i');
  const iconSelect = document.getElementById('icon-select');

  if (iconElements.length && iconSelect) {
    iconElements.forEach(icon => {
      icon.addEventListener('click', () => {
        const selectedIconClass = icon.getAttribute('data-icon');
        iconSelect.value = selectedIconClass;
        iconElements.forEach(el => el.classList.remove('selected'));
        icon.classList.add('selected');
      });
    });
  }
});
