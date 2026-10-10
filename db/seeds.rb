# frozen_string_literal: true

TicketTransfer.destroy_all
Comment.destroy_all
Ticket.destroy_all
Membership.destroy_all
User.destroy_all
Team.destroy_all

# Teams: Support, Billing, Tech
support = Team.create!(name: "Support")
billing = Team.create!(name: "Billing")
tech    = Team.create!(name: "Tech")

# Internal users
# asha@example.com (Support)
asha = User.create!(
  name: "Asha",
  email: "asha@example.com",
  password: "password",
  password_confirmation: "password",
  role: :internal
)
Membership.create!(user: asha, team: support)

# meera@example.com (Billing)
meera = User.create!(
  name: "Meera",
  email: "meera@example.com",
  password: "password",
  password_confirmation: "password",
  role: :internal
)
Membership.create!(user: meera, team: billing)

# riya@example.com (Billing and Tech)
riya = User.create!(
  name: "Riya",
  email: "riya@example.com",
  password: "password",
  password_confirmation: "password",
  role: :internal
)
Membership.create!(user: riya, team: billing)
Membership.create!(user: riya, team: tech)

# Customers: neha@example.com, pooja@example.com
neha = User.create!(
  name: "Neha",
  email: "neha@example.com",
  password: "password",
  password_confirmation: "password",
  role: :customer
)

pooja = User.create!(
  name: "Pooja",
  email: "pooja@example.com",
  password: "password",
  password_confirmation: "password",
  role: :customer
)

# Six tickets across teams and statuses
ticket1 = Ticket.create!(
  subject: "Cannot login to dashboard",
  description: "Getting a 500 error on login.",
  status: :open,
  priority: :urgent,
  requester: neha,
  team: support,
  assignee: asha
)

ticket2 = Ticket.create!(
  subject: "Invoice discrepancy for March",
  description: "Charged twice for subscription.",
  status: :pending,
  priority: :high,
  requester: neha,
  team: billing,
  assignee: meera
)

ticket3 = Ticket.create!(
  subject: "API rate limit questions",
  description: "Need clarification on rate limit headers.",
  status: :open,
  priority: :normal,
  requester: pooja,
  team: tech,
  assignee: riya
)

ticket4 = Ticket.create!(
  subject: "Update notification preferences",
  description: "Please change my email settings.",
  status: :resolved,
  priority: :low,
  requester: pooja,
  team: support,
  assignee: nil
)

ticket5 = Ticket.create!(
  subject: "Refund processed inquiry",
  description: "Confirming if refund was completed.",
  status: :closed,
  priority: :normal,
  requester: neha,
  team: billing,
  assignee: riya
)

ticket6 = Ticket.create!(
  subject: "Server latency spikes",
  description: "Experiencing high response latency.",
  status: :open,
  priority: :high,
  requester: pooja,
  team: support,
  assignee: asha
)

# One transfer: transfer ticket6 from Support to Tech by asha
ticket6.transfer_to(tech, by: asha, reason: "Requires engineering investigation")

# Comments: a few comments including one internal
Comment.create!(
  ticket: ticket1,
  author: neha,
  body: "Here is a screenshot of the error.",
  internal: false
)

Comment.create!(
  ticket: ticket1,
  author: asha,
  body: "Checked the server logs; auth service had a restart.",
  internal: true
)

Comment.create!(
  ticket: ticket1,
  author: asha,
  body: "We have resolved the underlying issue, please try again.",
  internal: false
)

Comment.create!(
  ticket: ticket2,
  author: meera,
  body: "We are reviewing your invoice history.",
  internal: false
)
