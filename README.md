# IPA-Keyboard-iOS

**[NEW]** Update 1.0.1 is available on the App Store

An iOS keyboard for typing symbols in the International Phonetic Alphabet. 

Download on the App Store: https://apps.apple.com/us/app/ipa-phonetic-keyboard/id1440241497

## Purpose

- Most IPA symbols cannot be typed using regular keyboards

- Full Unicode keyboards are too hard to navigate; an IPA-specific keyboard would have demand among linguistics hobbyists

- All IPA Keyboards on the App Store before mine was released were either non-free, full of ads, or poorly designed; this project aims to solve all three problems

- A relatively easily accomplishable project to boost my previously negative self-esteem

## To-Do List: Changes to be made for next release

- [ ] 

- [x] Keyboard show/hide in the host app

- [x] Add ɝ in the main IPA keyboard

- [x] Add ◌ (dotted circle), in both the top bar of the main IPA keyboard (alongside "\[\]", "//", and "~") and as a display element on keys for diacritics

## To-Do List: Current Bugs

- [ ] The bottom of "◌̩" is cut off (this is probably a font problem)

- [ ] If the user switched to this keyboard before using WeChat Pay, this keyboard replaces the system numerical keyboard, rendering the user unable to enter numbers for WeChat Pay's numerical field

  * **theoretically unfixable**, as there is currently no way of indicating absence of a numerical keyboard through the iOS third-party keyboard API
  
- [ ] Bad support for hardware keyboards, such as Bluetooth keyboards and iPad Smart/Magic Keyboard

  * **theoretically unfixable**, as the iOS third-party keyboard API does not yet support ignoring the hardware keyboard

- [x] Section header width contact hitbox bugs

- [x] Delayed refresh of collection view items when scrolling

  * actually a UIButton problem (the .system type button has a default animation)

## To-Do List: Features for future releases

### Other key sets

_No longer using separate keyboard extensions; integrate everything to the main keyboard extension_

_Some of these features might be charged a price using IAP (or not)_

- [ ] _Obsolete symbols (such as ʧ and ʤ)_

- [ ] _Nonstandard symbols (such as ɿ ʅ ʮ ʯ)_

- [ ] _Custom keyboard (custom keys and custom order)_

- [x] IPA Extended (extIPA) **(this one will definitely be free)**

### All keyboard extensions

_Some of these features might not be allowed by the keyboard extension API_

- [ ] **(if possible)** Recently used keys

- [ ] Ability to move the cursor using the keyboard

  * will not be able to mimic system keyboard behavior 100%; can only move cursor left and right

- [x] Hide the switch keyboard button on devices with edge-to-edge displays (e.g. iPhone X)

  * now possible to implement due to the `needsInputModeSwitchKey` property, but I've decided that it's not yet needed

- [x] Press and hold on backspace/delete button to rapidly delete

### Host app

- [ ] Donations & Link to Donations 

  * If there are enough donations, some paid features can be made free

- [ ] “Rate app” (link & in-app alert view)

- [x] Link to the Wikipedia IPA page

- [x] Link to Bug Report / Feedback

