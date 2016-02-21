# APIcurious - FitBit Dashboard Reconstruction

## Overview

This project uses the FitBit API to implement a 3rd party app that uses OAuth 2.0 to log users in via FitBit and to consume their data to display a similar looking dashboard. It utilizes the [LazyHighCharts gem](https://github.com/michelson/lazy_high_charts) to create interactive graphs for sleep, activity, and resting heart rate.

![Image of Dashboard](/app/assets/images/APIcurious_dashboard.png)

## Dependencies

The gems used for this project can be found in the Gemfile. Additionally, this application assumes that the user has access to their intraday data, which must be requested from FitBit support. This data is used to display the chart of last night's sleep.

## Testing

The test suite can be run from the main project directory by running the `rspec` command. It uses the [VCR gem](https://github.com/vcr/vcr) to record the API responses that load the main dashboard.
