# Pothole Detection API

This is a FastAPI-based API for detecting potholes in images using a trained TensorFlow/Keras model.


## Prerequisites and Setup

Before running the API, you need to have Python 3.7 or later installed. Follow these steps to set up your environment:

1.  **Install Python Dependencies:** Open your terminal and install the required Python packages using pip:

    ```bash
    pip install fastapi uvicorn tensorflow Pillow numpy
    ```

    This command installs FastAPI, uvicorn (for running the server), TensorFlow/Keras, Pillow (for image processing), and NumPy (for numerical operations).

2.  **Place the Model:** Ensure your trained Keras model (`potholemodel.h5`) is located in the `./model/` directory relative to your main Python file (e.g., `main.py`). If your model is in a different location, update the model loading path in your Python code:

    ```python
    model = load_model('./model/potholemodel.h5')  # Adjust path if needed
    ```

3.  **Verify Class Names:** Confirm that the `class_names` list in your Python code matches the classes your model was trained on. Modify it if necessary:

    ```python
    class_names = ['normal', 'potholes']  # Adjust if needed
    ```

## Running the API

1.  **Navigate to the Directory:** Open your terminal and navigate to the directory containing your Python file.

2.  **Start the Server:** Run the following command to start the FastAPI server using uvicorn:

    ```bash
    uvicorn main:app --reload
    ```

    Replace `main:app` with the correct filename and FastAPI app instance if they differ. The `--reload` flag enables automatic server reloading when you make code changes.

3.  **Access the API:** The API will be accessible at `http://127.0.0.1:8000` by default.

## API Endpoint

### `/predict` (POST)

-   **Description:** This endpoint accepts an image file and returns a JSON response indicating whether a pothole was detected.
-   **Method:** POST
-   **Request:**
    -   `file`: The image file to be processed (multipart/form-data).
-   **Response:**
    -   `pothole_detected`: A boolean indicating whether a pothole was detected (`true` or `false`).
    -   `predicted_class`: The predicted class label (`"normal"` or `"potholes"`).
-   **Example Request (using curl):**

    ```bash
    curl -X POST -F "file=@/path/to/your/image.jpg" [http://127.0.0.1:8000/predict](http://127.0.0.1:8000/predict)
    ```

-   **Example Response:**

    ```json
    {"pothole_detected": true, "predicted_class": "potholes"}
    ```

## Error Handling

-   If the model fails to load, the API will raise a `RuntimeError`.
-   If any other error occurs during image processing or prediction, the API will return an `HTTPException` with a status code of 500 and the error details.

## Model Requirements

-   The model should be a TensorFlow/Keras model saved in the `.h5` format.
-   The model should be trained to classify images into the classes specified in `class_names`.
-   The model expects input images of size `180x180` pixels.

## Notes

-   Adjust the `img_size` variable in the code if your model expects a different input size.
-   The code includes print statements for debugging purposes, which you can remove in a production environment.
-   The API handles RGB Images. If your images are in grayscale or another color space, modify the image loading section of the code.
-   This readme is designed to be easily modified for other FastAPI machine learning projects.

## Example Usage

Here's an example of how you might use this API in Python:

```python
import requests

def predict_pothole(image_path):
    url = "[http://127.0.0.1:8000/predict](http://127.0.0.1:8000/predict)"
    files = {"file": open(image_path, "rb")}
    response = requests.post(url, files=files)

    if response.status_code == 200:
        result = response.json()
        return result
    else:
        return {"error": f"Request failed with status code {response.status_code}"}

# Example usage
image_file = "/path/to/your/test_image.jpg" #Replace with your test image path.
prediction = predict_pothole(image_file)
print(prediction)
