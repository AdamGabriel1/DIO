@RestController
@RequestMapping("/api/tasks")
public class TaskController {
    @PostMapping
    public Task createTask(@RequestBody Task task) { ... }
}
