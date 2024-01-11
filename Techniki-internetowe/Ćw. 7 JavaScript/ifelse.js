let age = parseInt(prompt("Ile masz lat?"));
let message;

if (age < 3) {
    message = "Dzieci poniżej 3 lat wstęp wolny";
} else if (age < 12){
    message = "Bilet ulgowy kosztuje 5 zł";
} else if (age < 65){
    message = "Bilet normalny kosztuje 10 zł";
} else {
    message = "Bilet kosztuje 7 zł";
}
document.write(message);
console.log(typeof age);