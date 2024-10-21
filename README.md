# spotDL GUI Docker Image

[spotDL](https://github.com/spotDL/spotify-downloader) Docker Image based around support for the GUI.

[![MIT License](https://img.shields.io/github/license/hudsonm62/spotdl-gui-docker?color=44CC11&style=flat-square)](https://github.com/hudsonm62/spotdl-gui-docker/blob/master/LICENSE)
![Contributors](https://img.shields.io/github/contributors/hudsonm62/spotdl-gui-docker?style=flat-square)

## Usage

```bash
docker run -p 8800:8800 -v $(pwd):/music hudsonm62/spotdl-gui
```

### Compose

```yml
services:
  spotdl-gui:
    image: hudsonm62/spotdl-gui
    restart: always
    ports:
      - "8800:8800"
    volumes:
      - C:/Temp/Music:/music
```

## License

This project is Licensed under the [MIT](/LICENSE) License.
