% 02.11.2022 Küsters
% Beispiel für Erkennung von Kreisen
% https://de.mathworks.com/help/images/ref/imfindcircles.html

A = imread('coins.png');        % Bild einlesen, muss im gleichen Ordner liegen ansonsten kompletten Pfad angeben
imshow(A)                       % Bild anzeigen
[centers, radii, metric] = imfindcircles(A,[15 30]); % findet Kreise zwischen 15 und 30 Pixeln

% Filterung nach den 5 besten Ergebnissen
centersStrong5 = centers(1:5,:); 
radiiStrong5 = radii(1:5);
metricStrong5 = metric(1:5);

%Visualisierung der 5 besten Ergebnisse+e
viscircles(centersStrong5, radiiStrong5,'EdgeColor','b');   %Zeichnet Kreise mit Angabe des Zentrums und Radius