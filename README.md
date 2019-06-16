# Fortran - Zadanie 2
---
## Opis zadania
Dokładny opis zadania znajduje się [tutaj](http://home.agh.edu.pl/~macwozni/fort/zadanie2.pdf). 
Pliki modułów znajdują się w folderze **src/** a wykresy wynikowe wygenerowane przy pomocy *gnuplota* znajdują się w folderze **res/**.

## Część pierwsza
Dla sygnału postaci wykonano FFT.

![](res/signal.png)

Wynik działania programu widoczny jest na wykresie poniżej:

![](res/after_fft_png.png)

## Część druga
Wykres wybranej funkcji cosinus:

![](res/cos.png)

Wykres powyższej funkcji po dodaniu szumu:

![](res/cos_with_rand.png)

Po wykonaniu FFT:

![](res/no_noise.png)

Po wykonaniu odwróconej FFT:

![](res/inversed.png)

Jak widać powyżej, usuwanie szumów przebiegło pomyślnie.
