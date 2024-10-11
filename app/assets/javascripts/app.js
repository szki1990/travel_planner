document.addEventListener("turbolinks:load", () => {
  const heading = document.querySelector('#heading');
  const headingText = document.querySelector('#heading-text');
  
  if (headingText) {
    headingText.style.opacity = 0;
  }

  if (heading) {
    const keyframes = {
      opacity: [0, 1],
      translate: ['0 50px', 0],
    };

    const options = {
      duration: 2000,
      easing: 'ease',
    };

    heading.animate(keyframes, options).onfinish = () => {
      
      if (headingText) {
        headingText.style.opacity = '1';
        headingText.animate(
          {
            opacity: [0, 1],
            translate: ['0 50px', 0],
          },
          {
            duration: 2000,
            easing: 'ease',
          }
        );
      }
    };
  }

  if (window.location.pathname === '/about') {
    const items = document.querySelectorAll('.img-item');

    for (let i = 0; i < items.length; i++) {
      const keyframes = {
        opacity: [0, 1],
      };
      const options = {
        duration: 600,
        delay: i * 300,
        fill: 'forwards',
      };
      items[i].animate(keyframes, options);
    }
  }
});
