# The REST API has the following features :
- Categorization of Products
- Indexing and searching of Products
- User authentication and management
- Order processing
- Invoice generation 
- Payment integration using Razorpay
- Coupon and discount support
- Automated order receipt to email

# Paths
| URL                | Description                               |
|--------------------|-------------------------------------------|
| /                  | Home page, Launches frontend              |
| /admin             | Django Admin Pannel                       |
| /products          | List all Products                         |
| /profiles/address  | List all User Profiles                    |
| /profiles/cartitem | List all Cart Items                       |
| /profiles/cart     | List all Carts                            |
| /orders/orders     | List all Orders                           |
| /orders/payments   | List all Payment Details                  |
| /orders/coupons    | List all Coupons                          |
| /orders/uc         | List all User Coupons                     |
| /orders/ucl        | List all User Applied Coupons             |
| /owner/delivery    | Delivery Details of  Merchant Home/Office |
| /owner/vieworders  | Download all Orders for Merchant          |


# Getting started

Fork this repository (Click the Fork button in the top right of this page, click your Profile Image)
Clone your fork down to your local machine

    git clone https://github.com/adithyaanilkumar/deliveryt.git

cd into the folder

``` cd deliveryt/server ```

Create a branch

    git checkout -b branch-name

Install Docker and Docker Compose

Create a .env file in this directory with the following details :

```
GOOGLE_APPLICATION_CREDENTIALS=XXXXX-XXXXX-XXXXX-XXXX4.json
RPID=rzp_XXXXXXXXXXXX
RPKEY=XXXXXXXXXXXXXXX
AUD=XXXXXXXXXXX
ISS=https://securetoken.google.com/XXXXXXXXXX
```

Build the docker image

```sudo dokcer-compose build ```

Run the docker container

Build the docker image

```sudo dokcer-compose up ```

Goto ```localhost:8000/admin```
Default credentials are :
username : garden
password : garden

# To contribute
Make your changes
    

Commit and push

    git add .

    git commit -m 'Commit message'

    git push origin branch-name

Create a new pull request from your forked repository (Click the New Pull Request button located at the top of your repo).

Wait for your PR review and merge approval!


PS: Star this repo while you're at it :) ⭐⭐⭐⭐⭐

