-- Organization Table

CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- Insert Sample Data: Organizations

INSERT INTO organization (
    name,
    description,
    contact_email,
    logo_filename
)
VALUES
(
    'BrightFuture Builders',
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.',
    'info@brightfuturebuilders.org',
    'brightfuture-logo.png'
),
(
    'GreenHarvest Growers',
    'An urban farming collective promoting food sustainability and education in local neighborhoods.',
    'contact@greenharvest.org',
    'greenharvest-logo.png'
),
(
    'UnityServe Volunteers',
    'A volunteer coordination group supporting local charities and service initiatives.',
    'hello@unityserve.org',
    'unityserve-logo.png'
);


-- Project Table

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    project_date DATE NOT NULL,

    CONSTRAINT fk_project_organization
        FOREIGN KEY (organization_id)
        REFERENCES organization(organization_id)
);

-- BrightFuture Builders

INSERT INTO project
(organization_id, title, description, location, project_date)
VALUES
(1,'Community Playground','Build a playground for children','Lagos','2026-08-02'),
(1,'Bridge Repair','Repair damaged pedestrian bridge','Ibadan','2026-08-10'),
(1,'School Renovation','Renovate classrooms','Abuja','2026-08-18'),
(1,'Water Well Construction','Construct clean water wells','Kaduna','2026-08-25'),
(1,'Community Library','Build a local library','Enugu','2026-09-02');

-- GreenHarvest Growers

INSERT INTO project
(organization_id,title,description,location,project_date)
VALUES
(2,'Urban Garden','Create community gardens','Lagos','2026-08-03'),
(2,'Tree Planting','Plant 500 trees','Jos','2026-08-09'),
(2,'School Farm','Develop school vegetable farm','Ilorin','2026-08-15'),
(2,'Food Sustainability Workshop','Teach sustainable farming','Benin','2026-08-22'),
(2,'Community Compost','Build compost systems','Owerri','2026-09-05');

-- UnityServe Volunteers

INSERT INTO project
(organization_id,title,description,location,project_date)
VALUES
(3,'Food Drive','Collect and distribute food','Port Harcourt','2026-08-04'),
(3,'Blood Donation','Organize blood donation','Lagos','2026-08-12'),
(3,'Charity Cleanup','Neighborhood cleanup','Abeokuta','2026-08-20'),
(3,'School Supplies','Donate school materials','Akure','2026-08-28'),
(3,'Senior Care Visit','Volunteer at elderly homes','Calabar','2026-09-06');
