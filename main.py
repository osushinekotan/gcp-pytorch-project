from kaggle import KaggleApi

client = KaggleApi()
client.authenticate()
client.competition_download_files(
    competition="titanic",
    path="./data",
    quiet=False,
)
