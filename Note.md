## Difference between Repository and DAO
The dao basically contains CRUD operations, though repository contains more complex operations (Crud + business logic)
## Pattern
vue - controller(servlet) - service - repository|dao - database
## Manual Dependency Injection
to use the service in the controller we have to create an instance of the service class in the controller class in the init() method, but 
we have to ensure that this instance has synchronized operations(is thread-safe | stateless), because multiple requests can come to the controller at the same time.
-> this so bad because its not scalable, so as a solution we will use a shared instance in the ServletContext object, but how?
    ->we have 2 options for that:
        1.Using a ServletContextListener: create the service in a listener class that implements ServletContextListener interface and override the contextInitialized()(called when the app starts) method to create the instance and set it in the ServletContext object using setAttribute() method.
        2.Using a servlet that runs on startup: create the service in the init() method of the controller class and set it in the ServletContext object using setAttribute() method.
!one important thing is that we are storing just the service instance not the dao, because the dao will be injected in the service constructor.