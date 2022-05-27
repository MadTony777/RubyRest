@all
Feature: pet store REST service testing

  @findByStatus
  Scenario Outline: finds pets by status

    Given Send "GET" to the "https://petstore.swagger.io/v2/pet/findByStatus?status=" with "<Param>"
    And Check that response code equals "<Code>"
    And Check that response valid
    And Check that there are no others statuses in response

    Examples:
      | Param     | Code |
      | available | 200  |
      | pending   | 200  |
      | sold      | 200  |
      | wrong     | 200  |


  @petPost
  Scenario Outline: add a new pet to the store

    Given Create "pet" with status "<Param>"
    When Send "POST" to the "https://petstore.swagger.io/v2/pet" with "request"
    Then Check that response code equals "<Code>"
    And Check that response valid
    And Get id from response
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with "id"
    Then Check that response code equals "<Code>"
    Then Compare "pet" request with response

    Examples:
      | Param     | Code |
      | available | 200  |
      | pending   | 200  |
      | sold      | 200  |
      | wrong     | 200  |


  @petPut
  Scenario Outline: update an existing pet

    Given Create "pet" with status "<Param>"
    When Send "POST" to the "https://petstore.swagger.io/v2/pet" with "request"
    Then Check that response code equals "<Code>"
    And Check that response valid
    And Get id from response
    When Update pet by changing status
    Then Check that response code equals "<Code>"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with "id"
    Then Check that response code equals "<Code>"
    And Check that response valid
    And Check that response contains new status

    Examples:
      | Param     | Code |
      | available | 200  |
      | pending   | 200  |
      | sold      | 200  |


  @deletePet
  Scenario Outline: deletes a pet

    Given Create "pet" with status "<Param>"
    When Send "POST" to the "https://petstore.swagger.io/v2/pet/" with "request"
    Then Check that response code equals "<Code>"
    And Check that response valid
    And Get id from response
    When Send "DELETE" to the "https://petstore.swagger.io/v2/pet/" with "id"
    Then Check that response code equals "<Code>"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/pet/" with "id"
    Then Check that response code equals "404"

    Examples:
      | Param     | Code |
      | available | 200  |
      | pending   | 200  |
      | sold      | 200  |


  @order
  Scenario: place an order for a pet

    Given Create "order" with status ""
    When Send "POST" to the "https://petstore.swagger.io/v2/store/order" with "request"
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "GET" to the "https://petstore.swagger.io/v2/store/order/" with "id"
    Then Check that response code equals "200"
    And Check that response valid    
    Then Compare "order" request with response


  @deleteOrder
  Scenario: delete perchase order by id
    Given Create "order" with status ""
    When Send "POST" to the "https://petstore.swagger.io/v2/store/order" with "request"
    Then Check that response code equals "200"
    And Check that response valid
    And Get id from response
    When Send "DELETE" to the "https://petstore.swagger.io/v2/store/order/" with "id"
    Then Check that response code equals "200"
    And Check that response valid
    When Send "GET" to the "https://petstore.swagger.io/v2/store/order/" with "id"
    Then Check that response code equals "404"
