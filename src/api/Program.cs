using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var configuration = builder.Configuration;

var allowedOrigins = configuration["ALLOWED_ORIGINS"];
if (!string.IsNullOrWhiteSpace(allowedOrigins))
{
    builder.Services.AddCors(options =>
    {
        options.AddDefaultPolicy(policy =>
        {
            policy.WithOrigins(allowedOrigins)
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
    });
}

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}

app.MapGet("/api/todos", (Func<List<Todo>>)(() => TodoStore.Todos));

app.MapPost("/api/todos", (Action<Todo>)(todo =>
{
    TodoStore.Todos.Add(todo);
}));
app.UseCors();
app.Run();

public class Todo
{
    public string? Name { get; set; }
}

public static class TodoStore
{
    public static List<Todo> Todos = new List<Todo>();

    static TodoStore()
    {
        Todos.Add(new Todo { Name = "Todo 1" });
        Todos.Add(new Todo { Name = "Todo 2" });
        Todos.Add(new Todo { Name = "Todo 3" });
    }
}
