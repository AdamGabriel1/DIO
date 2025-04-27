using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Azure.Cosmos;
using Azure.Storage.Blobs;
using System.IO;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Collections.Generic;

[Route("api/[controller]")]
[ApiController]
public class CatalogController : ControllerBase
{
    private readonly CosmosClient _cosmosClient;
    private readonly Container _container;
    private readonly BlobServiceClient _blobServiceClient;
    private readonly string _containerName;

    public CatalogController(IConfiguration configuration)
    {
        _cosmosClient = new CosmosClient(configuration["CosmosDb:Account"], configuration["CosmosDb:Key"]);
        _container = _cosmosClient.GetContainer(configuration["CosmosDb:DatabaseName"], configuration["CosmosDb:ContainerName"]);
        _blobServiceClient = new BlobServiceClient(configuration["BlobStorage:ConnectionString"]);
        _containerName = configuration["BlobStorage:ContainerName"];
    }

    [HttpPost("upload")]
    public async Task<IActionResult> UploadFile()
    {
        var file = Request.Form.Files[0];
        var blobContainerClient = _blobServiceClient.GetBlobContainerClient(_containerName);
        await blobContainerClient.CreateIfNotExistsAsync();
        var blobClient = blobContainerClient.GetBlobClient(file.FileName);
        await blobClient.UploadAsync(file.OpenReadStream());

        return Ok();
    }

    [HttpPost("add")]
    public async Task<IActionResult> AddItem([FromBody] CatalogItem item)
    {
        item.Id = Guid.NewGuid().ToString();
        await _container.CreateItemAsync(item);
        return CreatedAtAction(nameof(GetItem), new { id = item.Id }, item);
    }

    [HttpGet("filter/{genre}")]
    public async Task<IActionResult> FilterItems(string genre)
    {
        var query = new QueryDefinition("SELECT * FROM c WHERE c.Genre = @genre")
            .WithParameter("@genre", genre);
        var iterator = _container.GetItemQueryIterator<CatalogItem>(query);
        var results = new List<CatalogItem>();

        while (iterator.HasMoreResults)
        {
            var response = await iterator.ReadNextAsync();
            results.AddRange(response);
        }

        return Ok(results);
    }

    [HttpGet("list")]
    public async Task<IActionResult> ListItems()
    {
        var query = "SELECT * FROM c";
        var iterator = _container.GetItemQueryIterator<CatalogItem>(query);
        var results = new List<CatalogItem>();

        while (iterator.HasMoreResults)
        {
            var response = await iterator.ReadNextAsync();
            results.AddRange(response);
        }

        return Ok(results);
    }
}
