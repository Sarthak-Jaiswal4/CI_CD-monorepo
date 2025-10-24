import express, { Request, Response } from 'express'
import {prisma} from '@DB'

const app=express()

app.use(express.json())

app.post('/register', async (req, res) => {
    console.log(req.body)
    const { username, password } = req.body;

    try {
        const user = await prisma.user.create({
            data: { username, password }
        });
        res.status(201).json({ message: 'User registered successfully', user });
    } catch (error) {
        res.status(400).json({ message: 'Registration failed', error });
    }
});

app.post('/login', async (req: Request, res: Response) => {
    const { username, password } = req.body;

    try {
        const user = await prisma.user.findUnique({
            where: { username }
        });
        if (!user || user.password !== password) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        res.json({ message: 'Login successful', user });
    } catch (error) {
        res.status(500).json({ message: 'Login failed', error });
    }
});

app.listen(3001,()=>{
    console.log('Connected to port 3001')
})