<h1 align="center">
  API Challenge - Documentation
</h1>

<h2 align="center">
  Information
</h2>
<p align="center">
    This documentation has been created to guide how to install, use and test this challenge project, which consists of a Flutter-based mobile application (frontend) and a Python FastAPI-based API (backend).
</p>

## 1. Project Overview

This project implements a mobile application with a Flutter frontend that interacts with a Python FastAPI backend. The application allows users to log in, view their user data, and query a hierarchical "tree" structure based on a site ID. The backend acts as an intermediary, handling authentication (token management) and fetching data from an external API.

## 2. Getting Started

To begin, you need to have Git installed on your system to clone the repository.

### 2.1. Install Git

If you don't have Git installed, download and install it from the official website: [Git Downloads](https://git-scm.com/downloads).

### 2.2. Clone the Repository

Once Git is installed, open your terminal or command prompt and run the following command:

```bash
git clone https://github.com/vlenci/desafio-api-python.git
cd desafio-api-python
```
After cloning, navigate into the project directory.

---
## 3. Installation Requirements

To set up and run this project, you need to install the following dependencies for both the frontend and the backend.

### 3.1. Frontend (Flutter)

The Flutter frontend requires the Flutter SDK and a few Dart packages.

* **Flutter SDK**:
    Install Flutter by following the official guide: [Flutter Get Started](https://flutter.dev/docs/get-started)

* **Dart Packages**:
    The following packages are listed in `frontend_flutter/pubspec.yaml`:
    * `http`: Used for making HTTP requests to the backend.
    * `provider`: A state management solution for Flutter.

    These packages will be installed automatically when you run `flutter pub get` in the `frontend_flutter` directory.

### 3.2. Backend (FastAPI)

The FastAPI backend is a Python application.

* **Python**:
    Ensure you have Python 3.8+ installed. You can download it from the official Python website.

* **Python Packages**:
    The following packages are required for the FastAPI backend:
    * `fastapi`: The web framework for building the API.
    * `uvicorn[standard]`: An ASGI server to run the FastAPI application.
    * `requests`: Used for making HTTP requests to the external API.
    * `python-dotenv`: For loading environment variables from a `.env` file.
    * `pydantic`: For data validation and settings management (FastAPI's dependency).

    You can install these dependencies using pip:
    ```bash
    pip install fastapi "uvicorn[standard]" requests python-dotenv pydantic
    ```

---
## 4. How to Use

Follow these steps to get the frontend and backend applications running.

### 4.1. Backend Setup and Run

1.  **Navigate to the project's root directory**:
    Ensure you are in the main `desafio-api-python` directory (the one containing both `app` and `frontend_flutter`).

2.  **Important Note for Testers**:
    To fully test the application, you will need credentials for an external API (`API_EXTERNAL_URL`, `API_USERNAME`, `API_PASSWORD`) which are configured in the `.env` file. Please contact me to obtain these credentials.

3.  **Create a `.env` file**:
    The backend uses `python-dotenv` to load environment variables from a `.env` file. Create a file named `.env` **inside the `app/` directory** with the following content, using the credentials obtained as mentioned above:
    ```
    API_EXTERNAL_URL=<YOUR_EXTERNAL_API_BASE_URL>
    API_USERNAME=<YOUR_EXTERNAL_API_USERNAME>
    API_PASSWORD=<YOUR_EXTERNAL_API_PASSWORD>
    ```
    Replace `<YOUR_EXTERNAL_API_BASE_URL>`, `<YOUR_EXTERNAL_API_USERNAME>`, and `<YOUR_EXTERNAL_API_PASSWORD>` with the actual credentials.

4.  **Run the FastAPI application**:
    From the **root directory** of the project (e.g., `desafio-api-python`), run the following command:
    ```bash
    uvicorn app.main:app --reload
    ```
    This will start the FastAPI server, typically accessible at `http://127.0.0.1:8000` by default. The `--reload` flag enables auto-reloading on code changes.

### 4.2. Frontend Setup and Run

1.  **Navigate to the frontend directory**:
    From the project's root directory, navigate to the frontend:
    ```bash
    cd frontend_flutter
    ```

2.  **Get Flutter packages**:
    ```bash
    flutter pub get
    ```

3.  **Ensure the backend is running**:
    The Flutter app connects to the backend at `http://10.0.2.2:8000` (for Android emulator). Make sure your FastAPI backend is accessible from this address or update the `baseUrl` in `frontend_flutter/lib/services/api_service.dart` if your backend is running on a different IP/port.

4.  **Run the Flutter application**:
    You can run the application on an attached device or emulator:
    ```bash
    flutter run
    ```
    Or, for a specific device:
    ```bash
    flutter run -d <device_id>
    ```

---
## 5. API Call Examples

The FastAPI backend exposes several endpoints. All authenticated endpoints require an `Authorization` header with a Bearer token.

**Base URL**: `http://127.0.0.1:8000` (or wherever your FastAPI app is running)

### 5.1. Authentication Endpoints

#### 5.1.1. Login (Get Token)

* **Endpoint**: `/token`
* **Method**: `POST`
* **Description**: Authenticates a user and returns access and refresh tokens.
* **Request Body**:
    ```json
    {
      "username": "your_username",
      "password": "your_password"
    }
    ```
* **Example `curl` command**:
    ```bash
    curl -X POST "http://127.0.0.1:8000/token" \
         -H "Content-Type: application/json" \
         -d '{ "username": "your_username", "password": "your_password" }'
    ```
* **Example Insomnia response**:
    <img src="./readme_images/token.png" alt="Exemplo no Insomnia do POST /token" width="900" />

#### 5.1.2. Verify Token

* **Endpoint**: `/token/verify`
* **Method**: `POST`
* **Description**: Verifies the validity of an access token.
* **Request Body**:
    ```json
    {
      "token": "your_access_token"
    }
    ```
* **Example `curl` command**:
    ```bash
    curl -X POST "http://127.0.0.1:8000/token/verify" \
         -H "Content-Type: application/json" \
         -d '{ "token": "your_access_token" }'
    ```
* **Example Insomnia response**:
    <img src="./readme_images/verify.png" alt="Exemplo no Insomnia do POST /verify" width="900" />
#### 5.1.3. Refresh Token

* **Endpoint**: `/token/refresh`
* **Method**: `POST`
* **Description**: Uses a refresh token to obtain a new access token.
* **Request Body**:
    ```json
    {
      "token": "your_refresh_token"
    }
    ```
* **Example `curl` command**:
    ```bash
    curl -X POST "http://127.0.0.1:8000/token/refresh" \
         -H "Content-Type: application/json" \
         -d '{ "token": "your_refresh_token" }'
    ```
* **Example Insomnia response**:
    <img src="./readme_images/refresh.png" alt="Exemplo no Insomnia do POST /refresh" width="900" />

### 5.2. Data Endpoints (Requires Authentication)

#### 5.2.1. Get User Data

* **Endpoint**: `/usercorp`
* **Method**: `GET`
* **Description**: Retrieves user-specific data from the external API. Requires a valid access token.
* **Authentication**: Bearer Token in `Authorization` header.
* **Example `curl` command**:
    ```bash
    curl -X GET "http://127.0.0.1:8000/usercorp" \
         -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
    ```
* **Example Insomnia response**:
    <img src="./readme_images/usercorp.png" alt="Exemplo no Insomnia do GET /usercorp" width="900" />

#### 5.2.2. Get Implantation Tree

* **Endpoint**: `/implantation/mobile/tree`
* **Method**: `GET`
* **Description**: Fetches a hierarchical tree structure based on a `site_id` from the external API. Requires a valid access token.
* **Query Parameters**:
    * `site_id`: Integer, the ID of the site to retrieve the tree for.
* **Authentication**: Bearer Token in `Authorization` header.
* **Example `curl` command**:
    ```bash
    curl -X GET "http://127.0.0.1:8000/implantation/mobile/tree?site_id=123" \
         -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
    ```
* **Example Insomnia response**:
    <img src="./readme_images/tree.png" alt="Exemplo no Insomnia do GET /tree" width="900" />