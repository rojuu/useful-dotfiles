# create_pg <db_name>
# Uses a stable container name "dev-postgres" on host port 5432.
# Creates the container if needed, then creates the requested DB if it does not exist.
create_pg() {
  if [[ -z "$1" ]]; then
    echo "Usage: create_pg <db_name>"
    return 1
  fi

  local db_name="$1"
  local container_name="dev-postgres"

  if ! [[ "$db_name" =~ '^[A-Za-z_][A-Za-z0-9_]*$' ]]; then
    echo "Error: db_name must match ^[A-Za-z_][A-Za-z0-9_]*$"
    return 1
  fi

  if ! docker ps -a --format '{{.Names}}' | grep -Fxq "$container_name"; then
    docker run -d \
      --name "$container_name" \
      -e POSTGRES_USER=postgres \
      -e POSTGRES_PASSWORD=postgres \
      -p 5432:5432 \
      postgres >/dev/null || return 1
  elif ! docker ps --format '{{.Names}}' | grep -Fxq "$container_name"; then
    docker start "$container_name" >/dev/null || return 1
  fi

  local i
  for i in {1..30}; do
    if docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
    echo "Error: postgres in $container_name did not become ready in time"
    return 1
  fi

  if docker exec "$container_name" psql -U postgres -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname = '$db_name';" | grep -qx '1'; then
    echo "Database already exists: $db_name"
  else
    docker exec "$container_name" psql -U postgres -d postgres -c \
      "CREATE DATABASE \"$db_name\";" >/dev/null || return 1
    echo "Created database: $db_name"
  fi
}

# drop_pg <db_name>
# Drops a database from the stable "dev-postgres" container if it exists.
drop_pg() {
  if [[ -z "$1" ]]; then
    echo "Usage: drop_pg <db_name>"
    return 1
  fi

  local db_name="$1"
  local container_name="dev-postgres"

  if ! [[ "$db_name" =~ '^[A-Za-z_][A-Za-z0-9_]*$' ]]; then
    echo "Error: db_name must match ^[A-Za-z_][A-Za-z0-9_]*$"
    return 1
  fi

  if ! docker ps -a --format '{{.Names}}' | grep -Fxq "$container_name"; then
    echo "Error: container not found: $container_name"
    return 1
  fi

  if ! docker ps --format '{{.Names}}' | grep -Fxq "$container_name"; then
    docker start "$container_name" >/dev/null || return 1
  fi

  local i
  for i in {1..30}; do
    if docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
    echo "Error: postgres in $container_name did not become ready in time"
    return 1
  fi

  docker exec "$container_name" psql -U postgres -d postgres -v ON_ERROR_STOP=1 -c \
    "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$db_name' AND pid <> pg_backend_pid();" >/dev/null || return 1

  docker exec "$container_name" psql -U postgres -d postgres -v ON_ERROR_STOP=1 -c \
    "DROP DATABASE IF EXISTS \"$db_name\";" >/dev/null || return 1

  echo "Dropped database if it existed: $db_name"
}

# start_pg
# Starts the stable "dev-postgres" container if it exists and is stopped.
start_pg() {
  local container_name="dev-postgres"

  if ! docker ps -a --format '{{.Names}}' | grep -Fxq "$container_name"; then
    echo "Error: container not found: $container_name"
    return 1
  fi

  if docker ps --format '{{.Names}}' | grep -Fxq "$container_name"; then
    echo "Container already running: $container_name"
  else
    docker start "$container_name" >/dev/null || return 1
    echo "Started container: $container_name"
  fi
}

# list_pg
# Lists all databases in the stable "dev-postgres" container.
list_pg() {
  local container_name="dev-postgres"

  if ! docker ps -a --format '{{.Names}}' | grep -Fxq "$container_name"; then
    echo "Error: container not found: $container_name"
    return 1
  fi

  if ! docker ps --format '{{.Names}}' | grep -Fxq "$container_name"; then
    docker start "$container_name" >/dev/null || return 1
  fi

  local i
  for i in {1..30}; do
    if docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
    echo "Error: postgres in $container_name did not become ready in time"
    return 1
  fi

  docker exec "$container_name" psql -U postgres -d postgres -c '\l'
}

# connect_pg <db_name>
# Opens psql inside the stable "dev-postgres" container for a specific database.
connect_pg() {
  if [[ -z "$1" ]]; then
    echo "Usage: connect_pg <db_name>"
    return 1
  fi

  local db_name="$1"
  local container_name="dev-postgres"

  if ! [[ "$db_name" =~ '^[A-Za-z_][A-Za-z0-9_]*$' ]]; then
    echo "Error: db_name must match ^[A-Za-z_][A-Za-z0-9_]*$"
    return 1
  fi

  if ! docker ps -a --format '{{.Names}}' | grep -Fxq "$container_name"; then
    echo "Error: container not found: $container_name"
    return 1
  fi

  if ! docker ps --format '{{.Names}}' | grep -Fxq "$container_name"; then
    docker start "$container_name" >/dev/null || return 1
  fi

  local i
  for i in {1..30}; do
    if docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! docker exec "$container_name" pg_isready -U postgres >/dev/null 2>&1; then
    echo "Error: postgres in $container_name did not become ready in time"
    return 1
  fi

  if ! docker exec "$container_name" psql -U postgres -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname = '$db_name';" | grep -qx '1'; then
    echo "Error: database does not exist: $db_name"
    return 1
  fi

  docker exec -it "$container_name" psql -U postgres -d "$db_name"
}
