let pytanie = prompt("Jakie jest Twoje pytanie?");
let los = Math.round(Math.random()*5);
let message;

switch (los) {
    case 0:
        odpowiedz = "Definitywnie nie";
    break;
    case 1:
        odpowiedz = "Raczej nie";
    break;
    case 2:
        odpowiedz = "50/50";
    break;
    case 3:
        odpowiedz = "Raczej tak";
    break;
    case 4:
        odpowiedz = "Definitywnie tak";
    break;
    case 5:
        odpowiedz = "Nie potrafię odpowiedzieć";
    break;
}

document.write("Zadano mi pytanie: " + pytanie);
document.write("<br>" + odpowiedz);