# 1 
actuando como un experto DBA asi como en arquitectura de software, quiero que conviertas el siguiente entidad relacion en un script sql para la creacion de tablas,
es importante tener en cuenta lo siguiente:
- normalizacion de las tablas
- indices para posibles consultas frecuentes

erDiagram
     COMPANY {
         int id PK
         string name
     }
     EMPLOYEE {
         int id PK
         int company_id FK
         string name
         string email
         string role
         boolean is_active
     }
     POSITION {
         int id PK
         int company_id FK
         int interview_flow_id FK
         string title
         text description
         string status
         boolean is_visible
         string location
         text job_description
         text requirements
         text responsibilities
         numeric salary_min
         numeric salary_max
         string employment_type
         text benefits
         text company_description
         date application_deadline
         string contact_info
     }
     INTERVIEW_FLOW {
         int id PK
         string description
     }
     INTERVIEW_STEP {
         int id PK
         int interview_flow_id FK
         int interview_type_id FK
         string name
         int order_index
     }
     INTERVIEW_TYPE {
         int id PK
         string name
         text description
     }
     CANDIDATE {
         int id PK
         string firstName
         string lastName
         string email
         string phone
         string address
     }
     APPLICATION {
         int id PK
         int position_id FK
         int candidate_id FK
         date application_date
         string status
         text notes
     }
     INTERVIEW {
         int id PK
         int application_id FK
         int interview_step_id FK
         int employee_id FK
         date interview_date
         string result
         int score
         text notes
     }

     COMPANY ||--o{ EMPLOYEE : employs
     COMPANY ||--o{ POSITION : offers
     POSITION ||--|| INTERVIEW_FLOW : assigns
     INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
     INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
     POSITION ||--o{ APPLICATION : receives
     CANDIDATE ||--o{ APPLICATION : submits
     APPLICATION ||--o{ INTERVIEW : has
     INTERVIEW ||--|| INTERVIEW_STEP : consists_of
     EMPLOYEE ||--o{ INTERVIEW : conducts



     teniendo en cuenta el script generado, es necesario actualizar el script con el fin de 
     crear nuevas entidades para gestionar el flujo completo de la aplicacion de posiciones,
     teniendo en cuenta las migraciones de prisma y los indices necesarios.


----- la respuesta no contenia el archivo prisma

# 2  
te falto generar el archivo schema.prisma para expansion de la estructura de datos usando las migraciones de Prisma.

respuesta 
He generado el archivo schema.prisma con la estructura de datos optimizada para Prisma, incluyendo todas las entidades necesarias y sus relaciones. Ahora puedes usar Prisma Migrate para aplicar los cambios en tu base de datos. ¿Necesitas algún ajuste adicional?