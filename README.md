# Care4Me

A Flutter-based customer search application built for the Care247 assignment.  
This app demonstrates a clean **MVVM architecture**, dynamic configuration-driven UI generation, and local filtering with remote API integration for fetching customer data.

---

## 1. Overview

Care4Me allows users to search customers based on multiple fields such as first name, last name, date of birth, city, and more.  
The search system is **configuration-driven**, meaning new search fields can be added without modifying any ViewModel or UI logic.

---

## 2. Tech Stack and Packages

**Framework:** Flutter 3.32.8  
**IDE:** Android Studio  
**Architecture Pattern:** MVVM (Model-View-ViewModel)

**Core Packages Used:**
```yaml
cupertino_icons: ^1.0.8
google_fonts: ^6.3.2
flutter_riverpod: ^3.0.3
go_router: ^16.3.0
gap: ^3.0.1
dio: ^5.9.0
intl: ^0.20.2
