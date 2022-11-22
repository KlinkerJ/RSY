% 02.11.2022 Küsters
% Beispiel für Erkennung von Kreisen
% https://de.mathworks.com/help/images/ref/imfindcircles.html

A = imread('C:\Users\domin\sciebo\Studium\Master\Robotersysteme\Testbild_Kreisgrößen.png');        % Bild einlesen, muss im gleichen Ordner liegen ansonsten kompletten Pfad angeben
gray=rgb2gray(A);
imshow(gray)                       % Bild anzeigen

d=drawline;
pos=d.Position;
diffPos=diff(pos);
diameter=hypot(diffPos(1),diffPos(2))

[centers, radii, metric] = imfindcircles(gray,[15 60], "Sensitivity",0.9, ObjectPolarity="bright"); % findet Kreise zwischen 15 und 30 Pixeln

% Filterung nach den 5 besten Ergebnissen
% centersStrong5 = centers(1:5,:); 
% radiiStrong5 = radii(1:5);
% metricStrong5 = metric(1:5);

%Visualisierung der 5 besten Ergebnisse+e
viscircles(centers, radii,'EdgeColor','b');   %Zeichnet Kreise mit Angabe des Zentrums und Radius

