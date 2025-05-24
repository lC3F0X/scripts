<#
.SYNOPSIS
    Simulates multiple consecutive requests to an API endpoint to test rate limiting configurations.

.DESCRIPTION
    'RateLimitStressTest.ps1' is a PowerShell script designed to send 100 authenticated GET requests using a Bearer token 
    to a specified API endpoint. It helps verify whether rate limiting mechanisms are correctly implemented by monitoring 
    the returned HTTP status codes (e.g., 429 Too Many Requests or 503 Service Unavailable).

    This script is useful for stress testing rate limiting policies such as ASP.NET rate limiters or IIS Dynamic IP Restrictions.

.NOTES
    Author: Ice Fox
    Version: 1.0
    Created: 2025-05-20
    Last Updated: 2025-05-24
#>

# Loop 100 times
for ($i = 1; $i -le 100; $i++) {
    try {
        # Send a GET request with the Authorization header
        $response = Invoke-WebRequest -Uri $uri `
            -Headers @{ Authorization = "Bearer $bearerToken" } `
            -Method GET -UseBasicParsing

        # Output the status code and status description (e.g., "200 OK")
        Write-Output "$($response.StatusCode) $($response.StatusDescription)"
    }
    catch {
        # If the request fails (e.g., 401, 500), try to get the status code and description from the response
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
            Write-Output "$statusCode $statusDescription"
        }
        else {
            # If no HTTP response is available, show the exception message
            Write-Output "Error: $($_.Exception.Message)"
        }
    }

    # Optional delay between requests (uncomment if needed)
    # Start-Sleep -Seconds 1
}