# Go-Scholar Final Project

## Rules

- Please try to make use of all knowledge that you have gained throughout this course
- This is an individual project, please do this project by yourself
- All code must be committed to one private repository on bitbucket
- Exercise TDD
- You **must** create more than one separate service. Please create justification by yourself on how you design the multiple services (you are allowed to make assumptions)
- Implement at least one type of sync communication and one type of async communication for communicating between services
- Make sure that you understand and can justify your actions for the design and implementation of your application

## Time limit

- Make sure that the last commit and push is before December 20th, 2018 23:59

## Bonus

- One of the service must be in Go
- Implement design patterns that is not built-in on your choice of framework (provide justification)

## Use-case that must be implemented

1 User
  1.1 User can register
  1.2 User can login/logout
  1.3 User can see their own profile
    1.3.1 User can see their go-pay balance
    1.3.2 User can top-up their go-pay
  1.4 User can edit their own profile
  1.5 User can order go-ride
  1.6 User can order go-car
  1.7 User can pick payment type during confirmation (cash or go-pay)
  1.8 User can see order history

2 Driver
  2.1 Driver can register
  2.2 Driver can login/logout
  2.3 Driver can see their own profile
    2.3.1 Driver can see their go-pay balance
  2.4 Driver can set their current location (to simulate GPS)
  2.5 Driver can bid for job
  2.6 Driver can see job history

## Note

- You are only allowed to ask questions related to the rules, bonus & use-case of this final project.
- Implement & store coordinate for real-world location using google map API or similar services.
- For use-case 2.5, there are two possible approaches that you can take:
  1. Pick the driver automatically based on their current location. Implement an algorithm that distribute the order evenly between drivers (don't let one driver get all the job).
  2. When someone orders go-ride or go-car, notify drivers who are currently located on said location. Driver who accept the order first will get the job. Implementation of the notification system is left to you. (BONUS)
