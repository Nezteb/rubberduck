# Rubberduck

TODO:

- [X] Dockerfile + docker-compose file
- [X] get tests working with commanded
- [ ] justfile?
- [ ] earthly for ci?
- [ ] k8s/k3s yaml (use kind for ci?)
  - [ ] https://github.com/massdriver-cloud/application-templates/tree/main/phoenix-kubernetes
- [ ] Jaeger/Prometheus? (telemetry/tracing/metrics)
- [ ] Read chatgpt conversation (and BoltAI)
- [ ] devcontainer (from ice backend)
- [ ] different container for MIX_ENV=dev, MIX_ENV=test, MIX_ENV=prod
- [ ] have `mix test` automatically start docker compose stack?
- [ ] horde/swarm/libcluster/pogo?
- [ ] MQTT / NATS ? (prob not, need to support web clients)
- [X] credo/dialyzer/sobelow

Some commands for generating boilerplate initially:

```sh
# mix phx.gen.live Game GameState game_states value:integer
mix phx.gen.live Game ServerState server_states value:integer
mix phx.gen.live Game ClientState client_states value:integer # Manually tweak to add predicted state and action buffer
mix phx.gen.channel Game
```

Old readme content below:

---

# Rubberduck

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
