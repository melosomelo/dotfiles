# Requirements information types

## Business requirements

Describe why the organization is implementing the system - the business benefits the organization
hopes to achieve. Example: a movie theater wants to reduce personnel costs by 25% and customer queue
waiting time by 30%. This leads to the idea of building a kiosk system that the customers can use to
buy their tickets and snacks.

## User requirements

Describe goals or tasks the users must be able to perform with the product that will provide value
to someone. Represented via use cases or user stories. Example: in a movie theater, a customer uses
the kiosk system to "Select a screening for tickets".

## Functional requirements

Specify the behaviors the product will exhibit under specific conditions. They describe what the
developers must implement to enable users to accomplish their tasks (user requirements), thereby
satisfying the business requirements. Are usually written in the form of the traditional "shall"
statements: "The customer shall be able to choose their preferred payment method".

## Business rules

Include corporate policies, government regulations, industry standards, and ­computational
algorithms. They are NOT themselves software requirements because they have an existence outside of
any software application, but they often dictate that the system must contain functionality to
comply with the pertinent rules. Example: "staff can only overwrite ticket validation failure with
the approval of a manager".

## Quality attributes

Describe the product’s characteristics in various dimensions that are important either to users or
to developers and maintainers, such as performance, safety, availability, and portability.

## External interface requirements

A description of a connection between a software system and a user, another software system, or a
hardware device. Example: the movie management system must interface with an existing tax note
system.

## Constraint

A restriction that is imposed on the choices available to the developer for the design and
construction of a product. Example: the kiosk system must use a specific display equipment that has
already been bought.

## Feature

A feature consists of one or more logically related system capabilities that provide value to a user
and are described by a set of functional requirements. It can encompass multiple user requirements,
each of which implies that certain functional requirements must be implemented. Thus, it is NOT
equivalent to a description of the user's task-related needs.

# Important relationship between business, user and functional requirements

These three types form a dependency chain that flows from organizational intent down to
implementation detail.

Each level exists to serve the one above it. A functional requirement that can't be traced to a user
requirement is a red flag. A user requirement that can't be traced to a business requirement is
equally suspect.

Business rules, constraints, quality attributes, and external interface requirements cut across all
three levels — they don't belong to one layer but shape what's possible at every layer.
