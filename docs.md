## GET /books

#### Authentication



Clients must supply the following data


#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- Response body as below.

```javascript
[]
```

## POST /books

#### Authentication



Clients must supply the following data


#### Request:

- Supported content types are:

    - `application/json`

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- No response body

## DELETE /books/:book_id

#### Authentication



Clients must supply the following data


#### Captures:

- *book_id*: Book ID

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- Response body as below.

```javascript
[]
```

## GET /books/:book_id

#### Authentication



Clients must supply the following data


#### Captures:

- *book_id*: Book ID

#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- No response body

## PUT /books/:book_id

#### Authentication



Clients must supply the following data


#### Captures:

- *book_id*: Book ID

#### GET Parameters:

- author
     - **Values**: *John Doe, ...*
     - **Description**: Author name

- title
     - **Values**: *A book I wrote, ...*
     - **Description**: Book title

- year
     - **Values**: *1990, 1735*
     - **Description**: Year published

- in_stock
     - **Values**: *256, 31*
     - **Description**: Number of books in stock


#### Response:

- Status code 200
- Headers: []

- Supported content types are:

    - `application/json`

- No response body

