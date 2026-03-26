% IS PROJECT 
%  23BIT042,23BIT026, 23BIT038
clc;
clear all;


% Emoji list (95 entries)
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
'🤖','👾','🛸','🚀','🪐' ...
};

M = 95; 
magic = 'JMK@42_38_26';   % Security header

fprintf('--- Information Security Project ---\n\n');
choice = input('1. Encrypt\n2. Decrypt\nChoose: ');

if choice == 1
    % ---------- ENCRYPT ----------
    plaintext = input('Enter text to encrypt: ', 's');
    key = input('Enter key: ', 's');

    if isempty(key)
        error('Key cannot be empty.');
    end

    % Add security header
    plaintext = [magic plaintext];

    N = length(plaintext);
    K = length(key);

    % Convert chars to 0-94 range & validate ASCII
    p = zeros(1,N);
    for i = 1:N
        code = double(plaintext(i));
        if code < 32 || code > 126
            error('Plaintext contains non-printable-ASCII character at position %d.', i);
        end
        p(i) = code - 32;
    end

    k = zeros(1,K);
    for i = 1:K
        code = double(key(i));
        if code < 32 || code > 126
            error('Key contains non-printable-ASCII character at position %d.', i);
        end
        k(i) = code - 32;
    end

    c = zeros(1,N);
    for i = 1:N
        c(i) = mod(p(i) + k(mod(i-1,K)+1), M);
    end

    encrypted = emojiList(c+1);
    cipher = strjoin(string(encrypted), ' ');

    fprintf('\nEncrypted Emoji Text:\n%s\n\n', cipher);
    fprintf(' **Keep spaces when copying for decryption️ **\n');

elseif choice == 2
    % ---------- DECRYPT ----------
    cipher = input('Enter emoji cipher text (space-separated): ', 's');
    key = input('Enter key: ', 's');

    if isempty(key)
        error('Key cannot be empty.');
    end
    tokens = strsplit(strtrim(cipher));
    N = length(tokens);
    K = length(key);

    k = zeros(1,K);
    for i = 1:K
        code = double(key(i));
        if code < 32 || code > 126
            error('Key contains non-printable-ASCII character at position %d.', i);
        end
        k(i) = code - 32;
    end

    c = zeros(1,N);
    for i = 1:N
        idx = find(strcmp(emojiList, tokens{i}), 1);
        if isempty(idx)
            error("Invalid emoji detected: %s\nCheck spacing!", tokens{i});
        end
        c(i) = idx - 1;
    end

    p = zeros(1,N);
    for i = 1:N
        p(i) = mod(c(i) - k(mod(i-1,K)+1), M);
    end

    plaintext = char(p + 32);

    % Check magic header
    if startsWith(plaintext, magic)
        plaintext = plaintext(length(magic)+1:end);
        fprintf("\nDecrypted Text:\n%s\n\n", plaintext);
    else
        fprintf("\n **Wrong key or corrupted message** .\n\n");
    end

else
    disp("Invalid choice.");
end
