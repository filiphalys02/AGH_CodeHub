const box = document.getElementById('box');
const out = document.getElementById('out');

box.addEventListener('click', e => {
    out.textContent = `Pozycja myszki: ${e.clientX}, ${e.clientY}`;
});
