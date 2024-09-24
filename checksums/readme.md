### Create a new s3 bucket


```
aws s3 mb s3://checksums-examples-0000
```

## Create a file that we will do a checksum on

```
echo "check me my friend." > myfile.txt
```

## Get the checksum of a the file

```
md5sum myfile.txt
```
Output: `b24e483c3d3855c6a019cd2e42650214  myfile.txt`

## Upload file to s3

```
aws s3 cp myfile.txt s3://checksums-examples-0000
```

## Get file information in s3

```
aws s3api head-object --bucket s3://checksums-examples-0000 --key myfile.txt
```

## Upload file with different type of checksum

```
sha256sum myfile.txt
```
output: `6e0c158ef4d10dd9160a393b67259af972787845a1f5b640899af2bdabb2e0f2  myfile.txt`

```
aws s3api put-object --bucket s3://checksums-examples-0000 --key myfile.txt --body myfile.txt \ 
--checksum-algorithm SHA256 --checksum 6e0c158ef4d10dd9160a393b67259af972787845a1f5b640899af2bdabb2e0f2
```

