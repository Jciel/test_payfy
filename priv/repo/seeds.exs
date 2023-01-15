# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TestPayfy.Repo.insert!(%TestPayfy.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

TestPayfy.Repo.delete_all(TestPayfy.RegistersSweepstake.RegisterSweepstake)
TestPayfy.Repo.delete_all(TestPayfy.Sweepstakes.Sweepstake)
TestPayfy.Repo.delete_all(TestPayfy.Users.User)

user_joao =
  TestPayfy.Repo.insert!(%TestPayfy.Users.User{
    id: "6a764634-35a1-4c23-b1a9-6f625281b942",
    name: "João",
    email: "joao@gmail.com"
  })

user_carlos =
  TestPayfy.Repo.insert!(%TestPayfy.Users.User{
    id: "76e28268-e6fc-4a05-bdee-e540a1c0e187",
    name: "Carlos",
    email: "carlos@gmail.com"
  })

user_jose =
  TestPayfy.Repo.insert!(%TestPayfy.Users.User{
    id: "97505604-5b68-40b4-9556-cbca58913d52",
    name: "Jose",
    email: "jose@gmail.com"
  })

sweepstake_ford_mustang =
  TestPayfy.Repo.insert!(%TestPayfy.Sweepstakes.Sweepstake{
    id: "123ed3ae-2a5c-45b0-819d-4e4afde250b0",
    name: "Ford Mustang",
    draw_date: ~U[2023-12-01 00:00:00Z]
  })

sweepstake_casa_praia =
  TestPayfy.Repo.insert!(%TestPayfy.Sweepstakes.Sweepstake{
    id: "22559088-79cc-4fcd-a065-6d4064e2c819",
    name: "Casa Praia",
    draw_date: ~U[2023-11-05 00:00:00Z]
  })

_sweepstake_harley_davidson =
  TestPayfy.Repo.insert!(%TestPayfy.Sweepstakes.Sweepstake{
    id: "3bc57d10-c52b-425e-8c24-69934ba9d4dd",
    name: "Moto Harley-Davidson",
    draw_date: ~U[2023-10-24 00:00:00Z],
    user_id: user_joao.id
  })

_sweepstake_kawasaki =
  TestPayfy.Repo.insert!(%TestPayfy.Sweepstakes.Sweepstake{
    id: "a7d76267-44b0-40a1-8e39-618a74a11d8b",
    name: "Moto Kawasaki",
    draw_date: ~U[2022-07-05 00:00:00Z],
    user_id: user_jose.id
  })

TestPayfy.Repo.insert!(%TestPayfy.RegistersSweepstake.RegisterSweepstake{
  id: "e13031ec-dffa-4960-8ad7-7d6de3cdfbf5",
  user_id: user_carlos.id,
  sweepstake_id: sweepstake_ford_mustang.id
})

TestPayfy.Repo.insert!(%TestPayfy.RegistersSweepstake.RegisterSweepstake{
  id: "e8d15ce2-80d9-40a4-95ea-25f84b17409a",
  user_id: user_joao.id,
  sweepstake_id: sweepstake_ford_mustang.id
})

TestPayfy.Repo.insert!(%TestPayfy.RegistersSweepstake.RegisterSweepstake{
  id: "8215ce4f-3a9b-4615-a012-0bca3f756084",
  user_id: user_joao.id,
  sweepstake_id: sweepstake_casa_praia.id
})
