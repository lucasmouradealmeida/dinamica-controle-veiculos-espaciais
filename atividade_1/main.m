# Satélite 1
s1_i = [0.4519 0.1764 -0.8745]';
s1_b = [0.7953 0.2372 -0.5580]';
m1_i = [-0.3473 0.9363 0.0527]';
m1_b = [-0.1363 0.9510 0.2778]';

triad_sat1 = triad(s1_i, s1_b, m1_i, m1_b);
quat = quaternion(triad_sat1);
q_method_sat1 = q_method(s1_i, s1_b, m1_i, m1_b);


# Satélite 2
s2_i = [0.4474 0.1571 -0.8804]';
s2_b = [0.7985 0.2375 -0.5532]';
m2_i = [-0.3456 0.9372 0.0482]';
m2_b = [-0.1406 0.9519 0.2724]';


triad_sat2 = triad(s2_i, s2_b, m2_i, m2_b);
q_method_sat1 = q_method(s2_i, s2_b, m2_i, m2_b);
