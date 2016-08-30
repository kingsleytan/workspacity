# Workspacity

This is a marketplace for creative industry, a new class of professional.

==========================================================================

Model:

Users
- username:string
- email:string
- password_digest:string
- image:string
- role:integer
- password_reset_token:string
- password_reset_at:datetime

Services
- type:string

Package
- title:string
- description:string
- price:float
- location:string
- image:string
- service_id:integer
- user_id:integer

Review
- body:string
- image:string
- user_id:integer
- package_id:integer
