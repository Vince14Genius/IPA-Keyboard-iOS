# IPA-Keyboard-iOS

**[NEW]** Update 1.0.1 is available on the App Store

An iOS keyboard for typing symbols in the International Phonetic Alphabet. 

Download on the App Store: https://apps.apple.com/us/app/ipa-phonetic-keyboard/id1440241497

## Purpose

- Most IPA symbols cannot be typed using regular keyboards

- Full Unicode keyboards are too hard to navigate; an IPA-specific keyboard would have demand among linguistics hobbyists

- All IPA Keyboards on the App Store before mine was released were either non-free, full of ads, or poorly designed; this project aims to solve all three problems

- A relatively easily accomplishable project to boost my previously negative self-esteem

## TODO List

All items in the TODO list will be moved to Issues.

## To-Do List: Changes to be made for next release

- [ ] Add system-provided sound effects for the delete key and the symbol keys on the top

## To-Do List: Current Bugs

- [ ] The bottom of "◌̩" is cut off (this is probably a font problem)

- [ ] Haptic feedback is not working

- [ ] If the user switched to this keyboard before tapping on any numeric input text field (e.g. LINE Pay, WeChat Pay), this keyboard replaces the system numerical keyboard, rendering the user unable to enter numbers for said text field

  * **theoretically unfixable**, as there is currently no way of indicating absence of a numerical keyboard through the iOS third-party keyboard API
  
- [ ] Bad support for hardware keyboards, such as Bluetooth keyboards and iPad Smart/Magic Keyboard

  * **theoretically unfixable**, as the iOS third-party keyboard API does not yet support ignoring the hardware keyboard

## To-Do List: Features for future releases

- [ ] Add a drag-scrolling mechanism to the bottom sections bar

- [ ] **(if possible)** Section for recently used keys

- [ ] Section for customized key selection & layout

- [ ] Settings for turning specific sections on & off in the host app

- [ ] Make host app look better using SwiftUI

### Other key sets

_No longer using separate keyboard extensions; integrate everything to the main keyboard extension_

_Some of these features might be charged a price using IAP (or not)_

- [ ] _Obsolete symbols (such as ʧ and ʤ)_

- [ ] _Nonstandard symbols (such as ɿ ʅ ʮ ʯ)_

- [ ] _Custom keyboard (custom keys and custom order)_

### All keyboard extensions

_Some of these features might not be allowed by the keyboard extension API_

- [ ] **(if possible)** Recently used keys

- [ ] Ability to move the cursor using the keyboard

  * will not be able to mimic system keyboard behavior 100%; can only move cursor left and right

- [ ] Hide the switch keyboard button on devices with edge-to-edge displays (e.g. iPhone X)

  * now possible to implement due to the `needsInputModeSwitchKey` property

  * will do after/during the SwiftUI migration

### Host app

- [ ] Donations & Link to Donations 

  * If there are enough donations, some paid features can be made free

