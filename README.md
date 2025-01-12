# Network Cards

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app is a flashcard app that contains flashcards for most of the Networking and CyberSecurity Certifications.

### App Evaluation


- **Category:** Education
- **Mobile:** IOS only
- **Story:**  Flashcards
- **Market:** CyberSecurity Enthusiasts
- **Habit:** Daily use for users that are preparing for certifications
- **Scope:** Narrow

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can register a new account
* User can login
* User can view pre-built flashcards list
* User can open a deck
* User can import ANKI(.apkg) decks

**Optional Nice-to-have Stories**

* User can create flashcards
* User can share their flashcards with others.
* User gets to practice with enhanced mode that lets them master unknown flashcards.



### 2. Screen Archetypes


**Login Screen**
* User can login

**Register Screen**
* User can register

**Flashcard Library**
* User can view built-in flashcards

**Import Cards Screen**
* User can Import Flashcards

**Flashcards Screen**
* User can open and navigate through a deck



### 3. Navigation

#### Tab Navigation (Tab to Screen)
* Deck Library
* Flashcard View
* Import Deck View


#### Flow Navigation (Screen to Screen)

**Login Screen**
  * Leads to Deck Library

**Register Screen**
  * Leads to Deck Library 

**Deck Library Screen**
  * Leads to Flashcard View
  * Leads to Import Deck View

**FlashCard View Screen**
  * Leads to Deck Library 


## Wireframes
![Handmade Wireframe (1)](https://github.com/user-attachments/assets/619a60f2-ff17-4f73-8498-ed89d64110d2)



### Digital Wireframes & Mockups
<img width="1092" alt="Screenshot 2024-12-03 at 9 17 21 PM" src="https://github.com/user-attachments/assets/2affa2c4-6483-433a-b48a-6a9097c71fe3">




## Schema 


### Models

#### User
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| email    | String | unique id for the user's authentication post |
| password | String | user's password for login authentication     |
| Full Name| String | user's name   |

#### Card
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| Question    | String | Questions |
| Answer | String | Answers     |


#### Deck
| Property | Type   | Description                                  |
|----------|--------|----------------------------------------------|
| Name    | String | Name for Deck |
| Cards[] | Array of Cards | Arrays of all the cards |



