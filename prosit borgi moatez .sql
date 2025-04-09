--partie 1
--1
DECLARE
    -- Variables pour b)
    v_num1 REAL := 44.5;
    v_num2 REAL := 61.8;
    
    -- Variables pour d)
    v_a INTEGER;
    v_b INTEGER;
    
    -- Variables pour e)
    v_a_comp INTEGER;
    v_b_comp INTEGER;
    v_c_comp INTEGER;
    
    -- Variable pour f)
    v_num INTEGER;
    v_factoriel INTEGER := 1;
    
BEGIN
    -- a) Afficher la date d'aujourd'hui
    DBMS_OUTPUT.PUT_LINE('Date d''aujourd''hui : ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY'));
    
    -- b) Somme de deux réels
    DBMS_OUTPUT.PUT_LINE('Somme de ' || v_num1 || ' et ' || v_num2 || ' = ' || (v_num1 + v_num2));
    
    -- c) Afficher les deux listes
    DBMS_OUTPUT.PUT_LINE('Première liste :');
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT(i || ' ');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    DBMS_OUTPUT.PUT_LINE('Deuxième liste :');
    FOR i IN REVERSE 0..100 LOOP
        IF MOD(i, 2) = 0 THEN
            DBMS_OUTPUT.PUT(i || ' ');
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    
    -- d) Lecture et calculs sur A et B
    v_a := 10; 
    v_b := 5;  
    DBMS_OUTPUT.PUT_LINE('A = ' || v_a || ', B = ' || v_b);
    DBMS_OUTPUT.PUT_LINE('Somme = ' || (v_a + v_b));
    DBMS_OUTPUT.PUT_LINE('Produit = ' || (v_a * v_b));
    
    -- e) Comparaison de trois entiers
    v_a_comp := 15; 
    v_b_comp := 10; 
    v_c_comp := 5;  
    DBMS_OUTPUT.PUT_LINE('A = ' || v_a_comp || ', B = ' || v_b_comp || ', C = ' || v_c_comp);
    IF v_a_comp > v_b_comp AND v_b_comp > v_c_comp THEN
        DBMS_OUTPUT.PUT_LINE('C < B < A');
    ELSIF v_a_comp < v_b_comp AND v_b_comp < v_c_comp THEN
        DBMS_OUTPUT.PUT_LINE('A < B < C');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Les nombres ne sont pas dans un ordre strict');
    END IF;
    
    -- f) Calcul du factoriel
    v_num := 5; 
    FOR i IN 1..v_num LOOP
        v_factoriel := v_factoriel * i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Factoriel de ' || v_num || ' = ' || v_factoriel);
END;
/
--2
DECLARE
    -- Variables pour a)
    v_nom employees.last_name%TYPE;
    
    -- Variables pour b)
    v_nb_employes NUMBER;
    
    -- Variables pour c)
    v_sal_min employees.salary%TYPE;
    v_sal_max employees.salary%TYPE;
    
BEGIN
    -- a) Nom de l'employé avec id 110
    SELECT last_name 
    INTO v_nom
    FROM employees
    WHERE employee_id = 110;
    DBMS_OUTPUT.PUT_LINE('Nom de l''employé 110 : ' || v_nom);
    
    -- b) Nombre d'employés du département 50
    SELECT COUNT(*)
    INTO v_nb_employes
    FROM employees
    WHERE department_id = 50;
    DBMS_OUTPUT.PUT_LINE('Nombre d''employés dans le dept 50 : ' || v_nb_employes);
    
    -- c) Salaires min et max du département 50
    SELECT MIN(salary), MAX(salary)
    INTO v_sal_min, v_sal_max
    FROM employees
    WHERE department_id = 50;
    DBMS_OUTPUT.PUT_LINE('Salaire minimum dept 50 : ' || v_sal_min);
    DBMS_OUTPUT.PUT_LINE('Salaire maximum dept 50 : ' || v_sal_max);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucune donnée trouvée');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/
--partie 2
--1
--a.i) Curseur implicite
BEGIN
    FOR dept_rec IN (SELECT department_id, department_name, AVG(salary) as avg_salary 
                    FROM employees 
                    JOIN departments USING (department_id) 
                    GROUP BY department_id, department_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || dept_rec.department_id || 
                           ', Nom: ' || dept_rec.department_name || 
                           ', Salaire moyen: ' || ROUND(dept_rec.avg_salary, 2));
    END LOOP;
END;
/
--a.ii) Curseur explicite
DECLARE
    CURSOR dept_cursor IS
        SELECT department_id, department_name, AVG(salary) as avg_salary
        FROM employees 
        JOIN departments USING (department_id)
        GROUP BY department_id, department_name;
    v_dept_id departments.department_id%TYPE;
    v_dept_name departments.department_name%TYPE;
    v_avg_salary NUMBER;
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_dept_id, v_dept_name, v_avg_salary;
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_dept_id || 
                           ', Nom: ' || v_dept_name || 
                           ', Salaire moyen: ' || ROUND(v_avg_salary, 2));
    END LOOP;
    CLOSE dept_cursor;
END;
/
--b) Nombre d'employés par département
BEGIN
    FOR emp_count IN (SELECT d.department_id, d.department_name, COUNT(e.employee_id) as emp_total
                     FROM departments d
                     LEFT JOIN employees e ON d.department_id = e.department_id
                     GROUP BY d.department_id, d.department_name)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Département: ' || emp_count.department_name || 
                           ' (' || emp_count.department_id || ')' ||
                           ', Nombre employés: ' || emp_count.emp_total);
    END LOOP;
END;
/
--c) Employés des départements avec plus de 20 employés
BEGIN
    FOR emp_rec IN (SELECT e.first_name, e.last_name, d.department_name
                   FROM employees e
                   JOIN departments d ON e.department_id = d.department_id
                   WHERE e.department_id IN (
                       SELECT department_id
                       FROM employees
                       GROUP BY department_id
                       HAVING COUNT(*) > 20))
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employé: ' || emp_rec.first_name || ' ' || 
                           emp_rec.last_name || 
                           ', Département: ' || emp_rec.department_name);
    END LOOP;
END;
/
--d) Managers et leurs employés avec curseur paramétré
DECLARE
    CURSOR emp_cursor(p_mgr_id NUMBER) IS
        SELECT first_name, last_name
        FROM employees
        WHERE manager_id = p_mgr_id;
    v_mgr_fname employees.first_name%TYPE;
    v_mgr_lname employees.last_name%TYPE;
BEGIN
    FOR mgr_rec IN (SELECT employee_id, first_name, last_name
                   FROM employees
                   WHERE employee_id IN (SELECT DISTINCT manager_id 
                                       FROM employees 
                                       WHERE manager_id IS NOT NULL))
    LOOP
        DBMS_OUTPUT.PUT_LINE('Manager: ' || mgr_rec.first_name || ' ' || mgr_rec.last_name);
        FOR emp_rec IN emp_cursor(mgr_rec.employee_id)
        LOOP
            DBMS_OUTPUT.PUT_LINE('  Employé: ' || emp_rec.first_name || ' ' || emp_rec.last_name);
        END LOOP;
    END LOOP;
END;
/
--2 Création de la table PRODUITS
BEGIN
    EXECUTE IMMEDIATE '
        CREATE TABLE PRODUITS (
            idProduit NUMBER PRIMARY KEY,
            nomProduit VARCHAR2(100) NOT NULL,
            categorieP VARCHAR2(50),
            prixProduit NUMBER(10,2) CHECK (prixProduit >= 0)
        )';
    DBMS_OUTPUT.PUT_LINE('Table PRODUITS créée avec succès');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('La table PRODUITS existe déjà');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Erreur lors de la création: ' || SQLERRM);
        END IF;
END;
/