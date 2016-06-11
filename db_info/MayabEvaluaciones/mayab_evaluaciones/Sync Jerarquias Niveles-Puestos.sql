UPDATE jerarquias j SET nivel = (SELECT nivel FROM empleados e WHERE e.empleado = j.subordinado);
UPDATE jerarquias j SET puesto = (SELECT puesto FROM empleados e WHERE e.empleado = j.subordinado);