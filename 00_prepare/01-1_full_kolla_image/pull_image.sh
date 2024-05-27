output_file=repository_list.txt

# Pulling the images with the specific tag
while IFS= read -r image; do
    echo "Pulling image $image..."
    podman pull "docker.io/$image"
done < "$output_file"

