@all
Feature: pet store REST service testing

  @findByStatus
  Scenario: finds pets by status

    Given Send "GET" to the "https://petstore.swagger.io/v2/pet/findByStatus?status=" with status "pending"
    And Check that response code equals "200"
    And Check that response valid
    And Check that there are no others statuses in response


  @petPost
  Scenario: add a new pet to the store

    Given Send "POST" to the "https://petstore.swagger.io/v2/pet" with status "available"
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with ID
    Then Check that response code equals "200"


  @order
  Scenario: place an order for a pet

    Given Send create request to the "https://petstore.swagger.io/v2/store/order" url
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "GET" to the "https://petstore.swagger.io/v2/store/order/" with ID
    Then Check that response code equals "200"
    And Check that response valid


  @petPut
  Scenario: update an existing pet

    Given Send create request to the "https://petstore.swagger.io/v2/pet" url
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "PUT" to the "https://petstore.swagger.io/v2/pet" with ID
    Then Check that response code equals "200"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with ID
    Then Check that response code equals "200"
    And Check that response valid
    And Check that response contains new status


  @deletePet
  Scenario: deletes a pet

    Given Send create request to the "https://petstore.swagger.io/v2/pet" url
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "DELETE" to the "https://petstore.swagger.io/v2/pet/" with ID
    Then Check that response code equals "200"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with ID
    Then Check that response code equals "404"



  @deleteOrder
  Scenario: delete perchase order by id
    Given Send create request to the "https://petstore.swagger.io/v2/store/order" url
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "DELETE" to the "https://petstore.swagger.io/v2/store/order/" with ID
    Then Check that response code equals "200"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/store/order/" with ID
    Then Check that response code equals "404"
