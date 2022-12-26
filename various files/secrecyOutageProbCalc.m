function sop = secrecyOutageProbCalc(Cth, ebno, ck, K)
    % Call as sop = secrecyOutageProbCalc(Cth, ebno, ck, K)
    % Cth is a scalar
    % ebno is a vector
    % ck is a scalar
    % K is a vector
    ge = ck.*ebno;
    gd = ge.*K;
    l = 2^Cth;
    % SOP
    sop = 1-exp((-l+1)./gd).*(gd./(l*ge+gd));
end