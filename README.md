# Network Cards

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

This app is a flashcard app that contains flashcards for most of the Networking and CyberSecurity Certifications.
This app uses Google Firestore Authentication and Cloud Firestore to handle user authentication and fetching data.
This app also has a feature called General Knowledge Test which uses Trivia API to fetch questions.

### App Evaluation


- **Category:** Education
- **Mobile:** IOS only
- **Story:**  Flashcards
- **Market:** CyberSecurity Enthusiasts
- **Habit:** Daily use for users that are preparing for certifications
- **Scope:** Narrow

  
## Walkthrough
![Unit10Demo](https://github.com/user-attachments/assets/095ea0d2-c711-49d0-abba-89fcaa7f567e)



## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can register a new account
* User can login
* User can view pre-built flashcards list
* User can open a deck
* User can get into fun mode to refresh

**Optional Nice-to-have Stories**

* User can create flashcards
* User can share their flashcards with others.
* User gets to practice with enhanced mode that lets them master unknown flashcards.



### 2. Screen Archetypes


**Login Screen**
* - [X] User can login

**Register Screen**
* - [X] User can register

**Flashcard Library**
* - [X] User can view built-in flashcards

**General Knowledge Screen**
* - [X] User can refresh their mind with fun question.

**Flashcards Screen**
* - [X] User can open and navigate through a deck



### 3. Navigation

#### Tab Navigation (Tab to Screen)
* - [X] Deck Library
* - [X] Flashcard View
* - [X] Import Deck View
* - [X] General Knowledge View


#### Flow Navigation (Screen to Screen)

**Login Screen**
  * - [X] Leads to Deck Library

**Register Screen**
  * - [X] Leads to Deck Library 

**Deck Library Screen**
  * - [X] Leads to Flashcard View
  * - [X] Leads to Import Deck View
  * - [X] Leads to General Knowledge View

**FlashCard View Screen**
  * - [X] Leads to Deck Library

**General Knowledge View Screen**
  * - [X] Leads to Deck Library 



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



