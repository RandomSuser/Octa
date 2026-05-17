function [Y] = dzialaj1 (W,X)
  #{
  transponowane będzie

>>> U = od -5 do 5 co 0.01              ^
>> U = od -5 do 5 co 0.01 : 5;
error: syntax error
>>> U = od -5 do 5 co 0.01 : 5;       ^
>> U =-5 : 0.01 : 5;
>> Y = 1 ./ (1+exp (-beta*U));
>> plot (U,Y)

  #}
  beta = 5;
  U = W' * X;
  Y = 1./(1+exp(-beta*U));

#{
ja = [2 ;0 ;0; 0; 0]
odp = dzialaj1 (Wpo,ja)
#}
