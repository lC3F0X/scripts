# Created by: Ice Fox
# Date: 2023-10-01
# Description: This script sends 100 GET requests to a specified API endpoint with a Bearer token for authorization.
# Usage: Update the $uri and $bearerToken variables with your API endpoint and token.
# PowerShell script to send 100 GET requests to an API endpoint with a Bearer token

# Define the API endpoint
$uri = ""

# Define the Bearer token (replace with your actual token)
$bearerToken = ""  # Truncated for readability

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