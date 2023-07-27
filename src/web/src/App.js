import React, { useState, useEffect, useCallback } from 'react';
import axios from 'axios';

function App() {
  const [todos, setTodos] = useState([]);
  const [newTodo, setNewTodo] = useState('');
  const apiBaseUrl = process.env.REACT_APP_API_BASE_URL || 'http://localhost:5071/api';

  const fetchTodos = useCallback(async () => {
    try {
      const response = await axios.get(`${apiBaseUrl}/todos`);
      setTodos(response.data);
    } catch (error) {
      console.error(`Failed to fetch todos: ${error}`);
    }
  }, [apiBaseUrl]);

  const addTodo = async () => {
    try {
      const response = await axios.post(`${apiBaseUrl}/todos`, { name: newTodo });
      if (response.status === 200) {
        setNewTodo('');
        fetchTodos();
      } else {
        console.error(`Failed to add todo: ${response.statusText}`);
      }
    } catch (error) {
      console.error(`Failed to add todo: ${error}`);
    }
  };

  useEffect(() => {
    fetchTodos();
  }, [fetchTodos]);

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
