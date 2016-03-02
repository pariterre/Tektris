function out = multitrace(M)
% M is a square by Q matrix (CxCxQ)

    if size(M, 1) ~= size(M,2)
        error('M must be square')
    end

    base = repmat(eye(size(M,1)), [1,1,size(M,3)]);
    diagonal = base .* M;
    out = sum(sum(diagonal, 1), 2);

end
