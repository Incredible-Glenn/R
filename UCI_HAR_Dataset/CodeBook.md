# CodeBook for Tidy HAR Dataset

## Data Source

This dataset is derived from the Human Activity Recognition Using Smartphones Dataset,
available from the UCI Machine Learning Repository:

https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original experiment description:
- 30 volunteers (subjects)
- 6 activities
- Samsung Galaxy S II smartphone sensor data

---

## Study Design and Data Processing

The raw data were processed according to the following steps:

1. Training and test datasets were merged into a single dataset.
2. Only measurements related to mean and standard deviation were retained.
3. Activity IDs were replaced with descriptive activity names.
4. Variable names were cleaned and made descriptive.
5. A final tidy dataset was created containing the average value
   of each variable for each subject and each activity.

---

## Variables

### Identifiers

| Variable | Description |
|--------|-------------|
| subject_id | Identifier of the subject (integer, 1–30) |
| activity_name | Descriptive name of the activity (factor) |

Possible values of `activity_name`:
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

---

### Measurement Variables

All measurement variables are numeric and represent the **average**
of the original measurements, grouped by subject and activity.

Naming convention:

- `time_` : time domain signals
- `freq_` : frequency domain signals
- `body` / `gravity` : signal source
- `acceleration` / `gyro` : accelerometer or gyroscope
- `jerk` : jerk signal
- `magnitude` : magnitude of the signal
- `mean` / `std` : mean or standard deviation
- `_x`, `_y`, `_z` : spatial axes

Example variables include:

- time_body_acceleration_mean_x
- time_body_acceleration_std_y
- freq_body_gyro_mean_z
- freq_body_acceleration_jerk_magnitude_std

For a complete list, see the column names of `tidydata_mean.txt`.

---

## Units

- Acceleration values are normalized to [-1, 1]
- No physical units are provided after normalization

---

## Notes

- This dataset is tidy:
  - Each variable forms a column
  - Each observation forms a row
  - All values are averages per subject and activity