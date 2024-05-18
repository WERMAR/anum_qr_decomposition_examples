clear, close all;

% Dieses Beispiel folgt dem Rechenbeispiel

function [Q, R] = householderQR(A)
    [m, n] = size(A);
    Q = eye(m); % Initialisiere Q als Einheitsmatrix

    for k = 1:min(m-1, n)
        % Wähle den Vektor x ab dem k-ten Diagonalelement
        x = A(k:end, k);
        e1 = zeros(length(x), 1);
        e1(1) = norm(x);
        
        % Berechne den Householder-Vektor v
        v = x + sign(x(1)) * e1;
        w1 = v / norm(v); % Normalisierung des Vektors v, um die vereinfachte Formel I-2uu^t nutzen zu können

        
        % Erzeuge die Householder-Matrix H
        H = eye(length(x)) - 2 * (w1 * w1'); % eye(length(x)) -> erstellt eine Einheitsmatrix (I)
        
        % Erweiterte Householder-Matrix H_full erzeugen
        H_full = eye(m);
        H_full(k:end, k:end) = H; % Überschreiben des ausgewählten Bereichs durch berechnete Householder-Matrix
        
        % Wende H_full auf A an
        A = H_full * A;
        
        % Update von Q
        Q = Q * H_full;
    end

    R = A;
end

% Beispiel zur Verwendung der Funktion
A = [-2, -2, -2; -2, -1, -1; 1,0,-1];
[Q, R] = householderQR(A);

disp('Q = ');
disp(Q);
disp('R = ');
disp(R);
disp('QR = ');
disp(Q * R); % Sollte die ursprüngliche Matrix A ergeben

