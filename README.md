# Save Sente

## Project Overview

Save Sente is a digital savings application designed to transform Uganda's savings culture and build financial resilience among its 48 million citizens. In Uganda, only 60% of the population manages to save, with 39% saving merely for day-to-day expenses and only 14% preparing for emergencies. This leaves millions vulnerable to financial shocks and unable to recover quickly from unexpected expenses.

Our solution addresses the critical gap in Uganda's financial landscape by providing an accessible, disciplined approach to saving that moves beyond informal saving methods that are often eroded by inflation.

### The Problem We Solve
- **Poor savings culture**: Irregular saving patterns with heavy reliance on informal methods
- **Financial vulnerability**: Lack of emergency funds pushes individuals into debt during crises
- **Business stagnation**: Small businesses struggle to grow without financial buffers
- **Limited accessibility**: Traditional saving methods exclude low-income earners

### Key Features
- **Low barrier to entry**: Start saving with as little as 5,000 UGX
- **Multiple goal-based wallets**: Separate savings for school fees, emergencies, business investments, and more
- **Disciplined saving**: Lock savings for specific timeframes to prevent impulsive spending
- **Global transfers**: Cross-border transactions powered by Bitnob API to boost economic participation
- **Cross-platform mobile application** (iOS & Android)
- **Secure backend** with RESTful API and PostgreSQL database integration

### Impact Vision
Save Sente empowers users like a small retail shop owner in Lugazi who can save 15,000 UGX daily for 30 days, accumulating 450,000 UGX for emergencies or business restocking money that would otherwise be mismanaged but is now available without borrowing.

### Tech Stack
- **Frontend**: Flutter
- **Backend**: Node.js, Express.js
- **Database**: PostgreSQL 15
- **API Documentation**: Postman

## Mobile Application Setup (Flutter)

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Android Studio or Xcode for device simulation
- Git

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/SaveSente/savesente.git
   cd savesente
   ```

2. **Navigate to the Flutter app directory**
   ```bash
   cd frontend  # or your Flutter app directory name
   ```

3. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

4. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

5. **Run the application**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

## Backend Setup (Node.js + Express + PostgreSQL)

### Prerequisites
- Node.js 22+ 
- npm
- PostgreSQL 15
- Git

### Installation Steps

1. **Navigate to the backend directory**
   ```bash
   cd backend
   ```

2. **Install Node.js dependencies**
   ```bash
   npm install
   ```

3. **Configure environment variables**
   Create a `.env` file in the backend directory:
   ```env
   # Database Configuration
   DB_USERNAME=your_username
   DB_PASSWORD=your_password
   DB_NAME=your_database_name
   
   # Bitnob Configuration
   BITNOB_BASE_URL=your_bitnob_base_url
   BITNOB_API_KEY=your_bitnob_api_key
   
   # Server Configuration
   PORT=3000
   NODE_ENV=development
   ```

4. **Run database migrations**
   ```bash
   npm run migrate
   ```

5. **Start the development server**
   ```bash
   npm run dev
   ```

The backend server should now be running on `http://localhost:3000`

### Available Scripts
- `npm run dev` - Start the development server with hot reload
- `npm run migrate` - Run database migrations

## API Documentation

The API is fully documented using Postman. You can access the documentation at:

[SaveSente API Documentation](https://documenter.getpostman.com/view/7079971/2sB34oBcZy)
