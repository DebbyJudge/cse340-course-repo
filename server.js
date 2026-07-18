import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';

import { testConnection } from './src/models/db.js';
import router from './src/routes.js';

// Environment Configuration
const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Create Express App
const app = express();

// Configure Express

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Set EJS as the view engine
app.set('view engine', 'ejs');

// Tell Express where the views are located
app.set('views', path.join(__dirname, 'src/views'));

// Global Middleware

// Log all requests while in development
app.use((req, res, next) => {
    if (NODE_ENV === 'development') {
        console.log(`${req.method} ${req.url}`);
    }

    next();
});

// Make NODE_ENV available to all EJS templates
app.use((req, res, next) => {
    res.locals.NODE_ENV = NODE_ENV;
    next();
});

// Routes
app.use(router);

// 404 Catch-All
app.use((req, res, next) => {
    const err = new Error('Page Not Found');
    err.status = 404;

    next(err);
});

// Global Error Handler
app.use((err, req, res, next) => {

    console.error('Error occurred:', err.message);
    console.error(err.stack);

    const status = err.status || 500;
    const template = status === 404 ? '404' : '500';

    res.status(status).render(`errors/${template}`, {
        title: status === 404 ? 'Page Not Found' : 'Server Error',
        error: err.message,
        stack: err.stack
    });

});

// Start Server
app.listen(PORT, async () => {
    try {
        await testConnection();

        console.log(`Server is running at http://127.0.0.1:${PORT}`);
        console.log(`Environment: ${NODE_ENV}`);

    } catch (error) {
        console.error('Error connecting to the database:', error);
    }
});