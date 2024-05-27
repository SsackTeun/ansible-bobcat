#!/bin/bash

# Docker Hub API를 사용하여 여러 페이지의 레포지토리 이름을 가져오기 위한 함수
get_repositories() {
    local org=$1
    local max_pages=$2
    local repositories=()

    for page in $(seq 1 $max_pages); do
        response=$(curl -s "https://hub.docker.com/v2/repositories/${org}/?page=${page}&ordering=last_updated&page_size=300")
        echo "Fetching repositories page ${page}..." >&2

        repo_names=$(echo "$response" | jq -r '.results[].name')
        repositories+=($repo_names)
    done

    echo "${repositories[@]}"
}

# Docker Hub API를 사용하여 특정 이미지의 모든 태그를 가져오기 위한 함수
get_tags() {
    local repo=$1
    local page=1
    local tags=()

    while : ; do
        response=$(curl -s "https://hub.docker.com/v2/repositories/${repo}/tags/?page=${page}")
        if echo "$response" | jq -e '.message' >/dev/null; then
            echo "Error: $(echo "$response" | jq -r '.message')" >&2
            break
        fi

        echo "Fetching tags for ${repo}, page ${page}..." >&2

        tag_names=$(echo "$response" | jq -r '.results[].name')
        tags+=($tag_names)
        next=$(echo "$response" | jq -r '.next')
        if [[ "$next" == "null" ]]; then
            break
        fi
        page=$((page + 1))
    done

    echo "${tags[@]}"
}

# Kolla 조직의 모든 레포지토리 목록 가져오기
organization="kolla"
max_pages=133
repositories=$(get_repositories $organization $max_pages)

# 파일명
registry_url="docker.io"
output_file="repository_list.txt"
tag_to_search="2023.2-rocky-9"

# 각 레포지토리에 대해 태그를 확인하고 특정 태그가 있는 경우 파일에 저장
> "$output_file"  # Clear the output file before starting
for repo in ${repositories[@]}; do
    full_repo_name="${organization}/${repo}"
    tags=$(get_tags "$full_repo_name")
    for tag in $tags; do
        if [[ "$tag" == "$tag_to_search" ]]; then
            echo "${full_repo_name}:${tag}" >> "$output_file"
        fi
    done
done

echo "Repository list with specific tag has been saved to $output_file"

# Pulling the images with the specific tag
while IFS= read -r image; do
    echo "Pulling image ${registry_url}/$image..."
    podman pull "$image"
done < "$output_file"

