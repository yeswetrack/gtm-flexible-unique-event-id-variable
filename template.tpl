___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Unique Event ID by YesWeTrack",
  "description": "Generates a flexible Event ID that can be unique per event, per page load, or per browser session, enabling accurate deduplication across tracking platforms.",
  "categories": [
    "UTILITY"
  ],
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "mode",
    "displayName": "Choose how unique the Event ID should be.",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "event",
        "displayValue": "Event level (default)"
      },
      {
        "value": "page",
        "displayValue": "Page level"
      },
      {
        "value": "browser",
        "displayValue": "Browser level"
      }
    ],
    "simpleValueType": true,
    "help": "Choose how events are grouped for deduplication.\u003cbr\u003e\n  \u003cb\u003ePer Event\u003c/b\u003e creates a new ID for every event.\u003cbr\u003e\n  \u003cb\u003ePer Page\u003c/b\u003e reuses the same ID for all events on one page load.\u003cbr\u003e\n  \u003cb\u003ePer Browser Session\u003c/b\u003e uses one ID per browser tab."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const setInWindow = require('setInWindow');
const copyFromWindow = require('copyFromWindow');
const getTimestampMillis = require('getTimestampMillis');
const generateRandom = require('generateRandom');
const mode = data.mode || 'event';

return getUniqueEventId(mode);

/* ========================= */

function getUniqueEventId(mode) {
  if (mode === 'browser') {
    return getBrowserId();
  }

  if (mode === 'page') {
    return getBrowserId() + '_' + getPageLoadId();
  }

  return (
    getBrowserId() +
    '_' +
    getPageLoadId() +
    '_' +
    getGtmUniqueEventId()
  );
}

function getGtmUniqueEventId() {
  return data.gtmUniqueEventId || 0;
}

function getBrowserId() {
  let gtmBrowserId = copyFromWindow('gtmBrowserId');

  if (!gtmBrowserId) {
    gtmBrowserId =
      getTimestampMillis() + generateRandom(100000, 999999);
    setInWindow('gtmBrowserId', gtmBrowserId, false);
  }

  return gtmBrowserId;
}

function getPageLoadId() {
  let pageLoadId = copyFromWindow('gtmPageLoadId');

  if (!pageLoadId) {
    pageLoadId =
      getTimestampMillis() + generateRandom(100000, 999999);
    setInWindow('gtmPageLoadId', pageLoadId, false);
  }

  return pageLoadId;
}


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmPageLoadId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtmBrowserId"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 28/12/2025, 11:05:32


