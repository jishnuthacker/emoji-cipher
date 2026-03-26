% IS PROJECT 
%  23BIT042,23BIT026, 23BIT038
clc; clear all; close all;

M = 95;                          
magic = 'JMK@42_38_26';          
playfairKey = 'Project';         

emojiList = { ...
'😀','😁','😂','🤣','😃','😄','😅','😆','😇','😉', ...
'😊','🙂','🙃','😌','😍','😘','😗','😙','😚','😋', ...
'😛','😜','🤪','😝','🤑','🤗','🤭','🤫','🤔','🤐', ...
'🤨','😐','😑','😶','😏','😒','🙄','😬','😮','🤥', ...
'🤤','😴','🤯','😳','😲','😟','😥','😢','😭','😨', ...
'😰','😱','🥶','🥵','😠','😡','🤬','😤','🤮','🤢', ...
'🤧','🤒','🤕','🥴','😵','🥳','🎊','🎉','🎁','🎈', ...
'🎂','🎀','🎄','🎅','🌟','⭐','✨','💫','💖','💘', ...
'💔','❤','🧡','💛','💚','💙','💜','🤎','🖤','🤍', ...
'🤖','👾','🛸','🚀','🪐'};

fprintf("----- EMOJI DUAL CIPHER -----\n");
choice = input("1) Encrypt\n2) Decrypt\nChoose: ");

% ----- BUILD PLAYFAIR MATRIX -----
pfk = upper(playfairKey);
pfk = strrep(pfk,'J','I');
uniq = '';
for i = 1:length(pfk)
    if ~contains(uniq, pfk(i))
        uniq = [uniq pfk(i)];
    end
end
alpha = 'ABCDEFGHIKLMNOPQRSTUVWXYZ';
for i = 1:length(alpha)
    if ~contains(uniq, alpha(i))
        uniq = [uniq alpha(i)];
    end
end
PF = reshape(uniq,5,5)';

% ---------- ENCRYPT ----------
if choice == 1
    txt = input("Enter text: ", 's');
    key = input("Enter key: ", 's');
    if isempty(key), error("Key required!"); end

    txt = [magic txt];
    N = length(txt);
    K = length(key);
    
    % ---- Vigenere Encrypt ----
    p = double(txt) - 32;
    k = double(key) - 32;
    c = zeros(1,N);
    for i = 1:N
        c(i) = mod(p(i) + k(mod(i-1,K)+1), M);
    end
    vigOut = char(c + 32);

    % ---- Playfair Encrypt ----
    pfOut = vigOut;
    L = find(isletter(vigOut));
    for i = 1:2:length(L)-1
        a = vigOut(L(i));
        b = vigOut(L(i+1));
        A = upper(a); 
        B = upper(b);
        if A=='J', A='I'; end
        if B=='J', B='I'; end
        [r1,c1] = find(PF==A);
        [r2,c2] = find(PF==B);
        
        if r1 == r2
            A2 = PF(r1,mod(c1,5)+1);
            B2 = PF(r2,mod(c2,5)+1);
        elseif c1 == c2
            A2 = PF(mod(r1,5)+1,c1);
            B2 = PF(mod(r2,5)+1,c2);
        else
            A2 = PF(r1,c2);
            B2 = PF(r2,c1);
        end
        
        if isstrprop(a,'lower'), A2 = lower(A2); end
        if isstrprop(b,'lower'), B2 = lower(B2); end
        
        pfOut(L(i)) = A2;
        pfOut(L(i+1)) = B2;
    end

    % ---- Emoji Encode ----
    v = double(pfOut) - 32;
    v(v<0) = 0;
    cipher = emojiList(v + 1);
    cipher = strjoin(string(cipher), ' ');

    fprintf("\nEncrypted Emoji Text:\n%s\n", cipher);
    fprintf("\n**Copy exactly with spaces!**\n");

% ---------- DECRYPT ----------
elseif choice == 2
    cipher = input("Paste emoji cipher: ",'s');
    key = input("Enter key: ", 's');
    if isempty(key), error("Key required!"); end

    tokens = strsplit(strtrim(cipher));
    N = length(tokens);
    K = length(key);
    c = zeros(1,N);
    for i = 1:N
        idx = find(strcmp(emojiList, tokens{i}));
        if isempty(idx)
            error(" **Invalid emoji at position** %d", i);
        end
        c(i) = idx - 1;
    end
    pfIn = char(mod(c, M) + 32);

    % ---- Playfair Decrypt ----
    vigIn = pfIn;
    L = find(isletter(pfIn));
    for i = 1:2:length(L)-1
        a = pfIn(L(i));
        b = pfIn(L(i+1));
        A = upper(a); 
        B = upper(b);
        if A=='J', A='I'; end
        if B=='J', B='I'; end
        [r1,c1] = find(PF==A);
        [r2,c2] = find(PF==B);

        if r1 == r2
            A2 = PF(r1,mod(c1-2,5)+1);
            B2 = PF(r2,mod(c2-2,5)+1);
        elseif c1 == c2
            A2 = PF(mod(r1-2,5)+1,c1);
            B2 = PF(mod(r2-2,5)+1,c2);
        else
            A2 = PF(r1,c2);
            B2 = PF(r2,c1);
        end
        
        if isstrprop(a,'lower'), A2 = lower(A2); end
        if isstrprop(b,'lower'), B2 = lower(B2); end
        
        vigIn(L(i))   = A2;
        vigIn(L(i+1)) = B2;
    end

    % ---- Vigenère Decrypt ----
    k = double(key) - 32;
    p = double(vigIn) - 32;
    px = zeros(1,N);
    for i = 1:N
        px(i) = mod(p(i) - k(mod(i-1,K)+1), M);
    end

    plain = char(px + 32);

    % ---- Check magic header ----
    if startsWith(plain, magic)
        plain = plain(length(magic)+1:end);
        fprintf("Decrypted Text: %s\n", plain);
    else
        fprintf("\n Wrong key or corrupted message\n");
    end

else
    disp("Invalid choice!");
end
