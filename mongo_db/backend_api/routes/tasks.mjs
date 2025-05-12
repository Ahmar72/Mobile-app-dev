import { Router } from 'express';
import Task from '../models/task.mjs';

const router = Router();

// Create a new task
// POST /api/tasks
router.post('/', async (req, res, next) => {
  if (!req.body.title) return res.status(400).json({ error: 'Title is required' });
  try {
    const task = new Task(req.body);
    const saved = await task.save();
    res.status(201).json(saved);
  } catch (err) {
    next(err);
  }
});

// Get all tasks
// GET /api/tasks
router.get('/', async (req, res, next) => {
  try {
    const tasks = await Task.find().sort({ dueDate: 1 }); // index on dueDate recommended
    res.json(tasks);
  } catch (err) {
    next(err);
  }
});

// Get a single task by ID
// GET /api/tasks/:id
router.get('/:id', async (req, res, next) => {
  try {
    const task = await Task.findById(req.params.id);
    if (!task) return res.status(404).json({ error: 'Task not found' });
    res.json(task);
  } catch (err) {
    next(err);
  }
});

// Update a task completely
// PUT /api/tasks/:id
router.put('/:id', async (req, res, next) => {
  if (Object.keys(req.body).length === 0) return res.status(400).json({ error: 'Request body cannot be empty' });
  try {
    const updated = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
    if (!updated) return res.status(404).json({ error: 'Task not found' });
    res.json(updated);
  } catch (err) {
    next(err);
  }
});

// Update part of a task
// PATCH /api/tasks/:id
router.patch('/:id', async (req, res, next) => {
  if (Object.keys(req.body).length === 0) return res.status(400).json({ error: 'Request body cannot be empty' });
  try {
    const patched = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true, runValidators: true });
    if (!patched) return res.status(404).json({ error: 'Task not found' });
    res.json(patched);
  } catch (err) {
    next(err);
  }
});

// Delete a task
// DELETE /api/tasks/:id
router.delete('/:id', async (req, res, next) => {
  try {
    const removed = await Task.findByIdAndDelete(req.params.id);
    if (!removed) return res.status(404).json({ error: 'Task not found' });
    res.json({ message: 'Task deleted' });
  } catch (err) {
    next(err);
  }
});

export default router;