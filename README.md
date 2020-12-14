# Neutron_AnalyticBand

Code solves a 1D two-group neutron problem analytically. Domain consists of a source surrounded
on bth sides by material we can specify. The code consists of three parts

1. angles.m : performs the angular discretization and provides the necessary weights.
2. meshcell.m : contains material properties of mesh element as well as the analytic method for 
calculating the outgoing flux and scalar flux contributions.
3. Analytic_2group.m : produces plots of the solution.
