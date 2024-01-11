const body = document.body;

function addImage(imageSrc) {
    const img = new Image();
    img.src = imageSrc;

    img.addEventListener('load', ()=> {
        body.appendChild(img);
    });

    img.addEventListener('error', ()=> {
        const errorMsg = document.createElement('p');
        errorMsg.textContent = "ERROR 404";
        body.appendChild(errorMsg);
    });
}
addImage('https://source.unsplash.com/random/1');