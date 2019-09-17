#Measure
get-CimInstance win32_Physicalmemory -ComputerName P0TB2
(get-Ciminstance win32_Physicalmemory -ComputerName P0TB2).Capacity
(get-Ciminstance win32_Physicalmemory -ComputerName P0TB2).capacity | measure -Sum
(((get-Ciminstance win32_Physicalmemory -ComputerName P0TB2).Capacity | measure -Sum).Sum)
((((get-ciminstance win32_physicalmemory -ComputerName P0TB2).Capacity | measure -Sum).Sum)/1gb)