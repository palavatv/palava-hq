# Palava HQ

This Rails-API app is part of the [palava project](https://palava.tv). However, you probably will not need to set this one up, when hosting your own palava, since it only adds the following non-WebRTC features:

- Leave your e-mail address and receive welcome mail
- Leave feedback
- Integration(E2E) tests for the [palava portal](https://github.com/palavatv/portal)

## Running Hints

Use the following ENV vars for configuring:

- `PALAVA_RTC_ADDRESS` Signaling backend to use. Default: "ws:localhost:4233"
- `PALAVA_PORTAL_DIR` Relative path to the [palava portal](https://github.com/palavatv/portal). Only needed for developing. Default: "../portal"

## Credits

MIT License. Part of the [palava project](https://palava.tv).

Copyright 2013 Jan Lelis       jan@signaling.io
Copyright 2013 Marius Melzer   marius@signaling.io
Copyright 2013 Stephan Thamm   thammi@chaossource.net
Copyright 2013 Kilian Ulbrich  kilian@innovailable.eu
