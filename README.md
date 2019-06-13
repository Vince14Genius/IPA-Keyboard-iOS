# IPA-Keyboard-iOS

An iOS keyboard for typing symbols in the International Phonetic Alphabet. 

Download on the App Store: https://itunes.apple.com/us/app/ipa-phonetic-keyboard/id1440241497?ls=1&mt=8

<b>I stopped uploading new code to this repository because of a weird GitHub-Xcode bug. The app will still be updated.</b>

## Purpose

* Most IPA symbols cannot be typed using regular keyboards

* Full Unicode keyboards are too hard to navigate; an IPA-specific keyboard would have demand among linguistics hobbyists

* All IPA Keyboards on the App Store right now are either non-free, full of ads, or poorly designed; this project aims to solve all three problems

* A relatively easily accomplishable project to boost my currently negative self-esteem

## To-Do List: Changes to be made for next release

1. Keyboard show/hide in the host app

2. Add ɝ in the main IPA keyboard

3. Add ◌ (dotted circle), in both the top bar of the main IPA keyboard (alongside "\[\]", "//", and "~") and as a display element on keys for diacritics

4. Make buttons on the bottom bar smaller

5. Replace the switch keyboard button with a globe glyph

## To-Do List: Current Bugs

* If the user switched to this keyboard before using WeChat Pay, this keyboard replaces the system numerical keyboard, rendering the user unable to enter numbers for WeChat Pay's numerical field

  * **fix** - tell the system that this keyboard cannot be used as a numerical keyboard

## To-Do List: Features for future releases

### Separate keyboard extensions

_Some of these features might be charged a price using IAP (or not)_

* IPA Extended (extIPA) **(this one will definitely be free)**

* _Obsolete symbols_

* _Nonstandard symbols_

* _Custom keyboard (custom keys and custom order)_

### All keyboard extensions

_Some of these features might not be allowed by the keyboard extension API_

* **(if possible)** Recently used keys

* **(if possible)** Ability to move the cursor using the keyboard

* **(if possible)** Hide the switch keyboard button on devices with edge-to-edge displays (e.g. iPhone X)

* Press and hold on backspace/delete button to rapidly delete

### Host app

* Link to the Wikipedia IPA page

* Link to Bug Report / Feedback

* Link to Donations 

  * If there are enough donations, some paid features can be made free

* “Rate app” (link & in-app alert view)

