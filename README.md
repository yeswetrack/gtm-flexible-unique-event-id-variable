# Flexible Event ID – GTM Community Variable

This repository contains a **Google Tag Manager Community Variable** that generates a **flexible Event ID** for accurate event identification and deduplication across tracking and advertising platforms.

---

## What This Variable Does

The Flexible Event ID allows you to control **how unique an Event ID should be**, depending on your use case:
- Per event
- Per page load
- Per browser tab

This makes it suitable for both **conversion tracking** and **page-level tracking**, including consent flows.

---

## Event ID Uniqueness Options

| Mode | Description | Recommended for |
|----|----|----|
| `event` | Unique Event ID for every event | Purchases, leads, calls |
| `page` | One Event ID per page load | Page views, consent tracking |
| `browser` | One Event ID per browser tab | Debugging, advanced setups |

Default mode: **`event`**

---

## Installation

1. Download the `template.tpl` file.
2. Open **Google Tag Manager**.
3. Go to **Templates** → **Variable Templates**.
4. Click **New** → **Import** and select the template file.

---

## How to Use

### Create the Variable
- Go to **Variables** → **New**
- Select **Flexible Event ID**
- Choose the **Event ID Uniqueness Level**
- Save the variable

---

## Usage Examples

### Conversion Tracking
Use **`event`** mode to ensure strict deduplication for conversions.

### Page Views & Consent
Use **`page`** mode so all events on the same page share the same Event ID.

### Browser-Level (Advanced)
Use **`browser`** mode for debugging or advanced tracking scenarios.

---

## Using the Event ID in Tags

Pass the variable to your tags as:
event_id = {{Flexible Event ID}}

Supported by platforms like Google Ads, Meta, GA4, and server-side GTM setups.

---

## Permissions

This template requires:
- `get_timestamp_millis`
- `generate_random`
- `set_in_window`
- `access_globals`
