# stock-tracker
Simple test app using SwiftUI + SwiftData to display stock data, built using Xcode 16.3. 

<p>
<img width="300" alt="Screenshot 2025-05-20 at 11 58 02 AM" src="https://github.com/user-attachments/assets/f394d04f-8ad8-486b-8ef3-49a3058cf163" />
<img width="300" alt="Screenshot 2025-05-20 at 11 58 17 AM" src="https://github.com/user-attachments/assets/0c98c153-a6d3-4ef3-911f-a991e201c80a" />
<img width="300" alt="Screenshot 2025-05-20 at 11 58 23 AM" src="https://github.com/user-attachments/assets/785d52d1-f02d-4e27-8059-e3cf3e0403bf" />
</p>

## UI
- The app uses SwiftUI views, with a basic TabView as the base for the List/Favorite tabs.
- A ProgressView shows until the initial data loads
- Stocks tab has a horizontal scrolling featured list above the full stock list
- Featured tab has the ability to sort by ticker, price change increasing/decreasing
- Stock list cells were reused between tabs
- Simple SwiftUI animations were used, and support for light/dark mode by default
- There is some room for improvement on the UI for the featured section of the stock list, since I focused more on the data side. Ideally this view would do something like an auto scroll, and potentially pin to the top to always show.

## Data Fetching
Used dependency injection (via the swift package Swinject) for the StockAPI, defaulting to resolve to the LocalStockAPI, which sleeps for 1 second and loads the json. Provided a RemoteStockAPI variant that loads the json from the same file in the Github repo. Some sort of polling would be ideal as a future step here. 

## State Management & Data Persistence
I had never used SwiftData before, so took the opportunity to try it out here. The PersistentStore handles the ModelContainer, which is used through the app as the backing data source via Queries to handle state management. This also handles full persistence between launches. Didn't use @StateObject or @ObservedObject due to the convenience of SwiftData queries handling efficient state updates. Ideally the persistence (and other things) would also use some dependency injection, but didn't spend the time to do that here. The PersistentStore also handles adding new data, making sure duplicates are updated, and new objects are added. One case that still isn't handled is deleting data that no longer exists in the new source. 

## Unit testing
Created simple tests using Swift Testing to verify the persistent store handles adding data, overwriting existing data, and clearing out data. More unit/UI tests could be added around the API responses, lists, etc. 
