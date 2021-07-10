{ lib
, buildPythonPackage
, fetchFromGitHub
, isPy3k
, beautifulsoup4
, bottle
, chardet
, click
, dateutil
, google-api-python-client
, google-auth-oauthlib
, lxml
, oauth2client
, ply
, pytest
, python_magic
, requests
}:

buildPythonPackage rec {
  version = "2021-06-30";
  pname = "beancount";

  disabled = !isPy3k;

  src = fetchFromGitHub {
    owner = "beancount";
    repo = "beancount";
    rev = "4a489c69a5a751a73151fb8d121d31f8b5f74f6f";
    sha256 = "sha256-w8KPd5dZWd68MTxmb8XwUSoXyU8DPjWt0Yv/NCRPxL4=";
  };

  # Tests require files not included in the PyPI archive.
  doCheck = false;

  propagatedBuildInputs = [
    beautifulsoup4
    bottle
    chardet
    click
    dateutil
    google-api-python-client
    google-auth-oauthlib
    lxml
    oauth2client
    ply
    python_magic
    requests
    # pytest really is a runtime dependency
    # https://github.com/beancount/beancount/blob/v2/setup.py#L81-L82
    pytest
  ];

  meta = with lib; {
    homepage = "http://furius.ca/beancount/";
    description = "Double-entry bookkeeping computer language";
    longDescription = ''
        A double-entry bookkeeping computer language that lets you define
        financial transaction records in a text file, read them in memory,
        generate a variety of reports from them, and provides a web interface.
    '';
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ bhipple ];
  };
}
