P = [
4 2 -1;         % ile ma nog
0.01 -1 3.5;    % czy zyje w wodzie
0.01 2 0.01;    % czy umie latac
-1 2.5 -2;      % czy ma piora
-1.5 2 1.5      % czy jest jajorodny
]


T = [
1 0 0;  %ssak
0 1 0;  %ptak
0 0 1   %ryba
]



Wprzed = init1 (5,3)
Yprzed = dzialaj1 (Wprzed,P)


Wpo = ucz1 (Wprzed,P,T,100) ;
Ypo = dzialaj1 (Wpo,P) ;
% final
