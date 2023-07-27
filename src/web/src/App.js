import React, { useState, useEffect } from 'react';
import axios from 'axios';

function App() {
  const [todos, setTodos] = useState([]);
  const [newTodo, setNewTodo] = useState('');

  const baseUrl = process.env.REACT_APP_API_BASE_URL || 'http://localhost:5071/api';

  useEffect(() => {
    fetchTodos();
  }, []);

  const fetchTodos = async () => {
    const response = await axios.get(`${baseUrl}/todos`);
    setTodos(response.data);
  };

  const addTodo = async () => {
    await axios.post(`${baseUrl}/todos`, { name: newTodo });
    setNewTodo('');
    fetchTodos();
  };

  return (
    <div className="App">
      <input
        type="text"
        value={newTodo}
        onChange={e => setNewTodo(e.target.value)}
      />
      <button onClick={addTodo}>Add</button>
      <ul>
        {todos.map((todo, index) => (
          <li key={index}>{todo.name}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
