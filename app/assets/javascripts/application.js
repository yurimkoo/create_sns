function createBackground(depth) {
  return new Promise((resolve, reject) => {
    const canvas = document.createElement("canvas");
    canvas.width = 256;
    canvas.height = 256;
    const context = canvas.getContext("2d");
    context.clearRect(0,0,canvas.width,canvas.height);
    for (let i = 0; i < 100; i++) {
      const x = (Math.random() * canvas.width);
      const y = (Math.random() * canvas.height);
      context.fillStyle = `rgb(${depth},${depth},${depth})`;
      context.fillRect(x,y,1,1);
    }
    canvas.toBlob((blob) => {
      return resolve(URL.createObjectURL(blob));
    }, "image/png");
  });  
}

const bgs = [];

let sx = 0, sy = 0;

function frame() {
  sx += 2;
  sy += 2;
  
  document.body.style.backgroundPositionX = bgs.map((bg, index, list) => {
    return `${sx * (index + 1) * (1 / list.length)}px`;
  }).join(",");
  document.body.style.backgroundPositionY = bgs.map((bg, index, list) => {
    return `${sy * (index + 1) * (1 / list.length)}px`;
  }).join(",");
  
  requestAnimationFrame(frame);
}

Promise.all([
  createBackground(128),
  createBackground(192),
  createBackground(256)
]).then(([bg0,bg1,bg2]) => {
  requestAnimationFrame(frame);
  bgs.push([bg0],[bg1],[bg2]);
  document.body.style.backgroundImage = bgs.map(([url]) => `url(${url})`).join(",");
  console.log(bg0,bg1,bg2);
});


/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}