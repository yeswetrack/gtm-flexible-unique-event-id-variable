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

const copyFromDataLayer = require('copyFromDataLayer');
const setInWindow = require('setInWindow');
const copyFromWindow = require('copyFromWindow');
const getTimestampMillis = require('getTimestampMillis');
const generateRandom = require('generateRandom');

// Fetch the mode from the template input fields (defaults to 'event')
const mode = data.mode || 'event';

/* ========================= */
// Main Execution Logic
/* ========================= */

if (mode === 'browser') {
  return getBrowserId();
}

if (mode === 'page') {
  return getBrowserId() + '_' + getPageLoadId();
}

// Default: 'event' mode
// Returns the concatenated string: BrowserID_PageIDEventID
return getBrowserId() + '_' + getPageLoadId() + getGtmUniqueEventId();

/* ========================= */
// Helper Functions
/* ========================= */

/**
 * Retrieves the unique event ID from the GTM Data Layer.
 * Matches your reference logic for handling '00' fallback.
 */
function getGtmUniqueEventId() {
  let gtmId = copyFromDataLayer('gtm.uniqueEventId') || 0;
  return gtmId >= 0 ? gtmId : '00';
}

/**
 * Generates or retrieves a persistent ID for the browser.
 */
function getBrowserId() {
  let gtmBrowserId = copyFromWindow('gtmBrowserId');

  if (!gtmBrowserId) {
    gtmBrowserId = getTimestampMillis() + generateRandom(100000, 999999);
    setInWindow('gtmBrowserId', gtmBrowserId, false);
  }

  return gtmBrowserId;
}

/**
 * Generates or retrieves a persistent ID for the page load.
 */
function getPageLoadId() {
  let pageLoadId = copyFromWindow('gtmPageLoadId');

  if (!pageLoadId) {
    pageLoadId = getTimestampMillis() + generateRandom(100000, 999999);
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
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "gtm.uniqueEventId"
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

Created on 11/03/2021, 11:05:32


