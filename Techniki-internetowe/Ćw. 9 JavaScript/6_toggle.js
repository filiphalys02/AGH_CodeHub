const container = document.querySelector('.container');
container.addEventListener('click', e => {
    const el = e.target;
    if(el.className === 'option') {
        document.querySelector(`.${el.className}${el.dataset.number}`).classList.toggle('hidden');
    }
});