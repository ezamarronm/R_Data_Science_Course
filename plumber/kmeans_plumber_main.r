library(plumber)
r <- plumb("./vacuums_plumber.r")
r$run(port = 8000)

#"http://localhost:8000/getCluster?opinions=1.0200013&price=-0.5979554&weight=1.3252346batteries.required=0.2212653&length=-0.6337268&width=0.1810840&height=-0.6158319"