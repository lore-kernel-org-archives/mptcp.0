Content-Type: multipart/mixed; boundary="===============6948873577530703566=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Fri, 20 Apr 2018 17:26:50 +0200
Message-ID: <512756bd-89e6-712d-b68f-9fecd3103aea@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 541

--===============6948873577530703566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,


NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th, 2018.


We already talked about this event on this ML and at our weekly meetings =

but here is a summary of the discussions we had:

  - we would like to have a presentation there mainly to get feedback =

and advice from other kernel developers
  - a presentation would clearly indicate that this MPTCP Upstream =

project exists and we could get help from more developers
  - we would like to indicate that having MPTCP upstream is asked by =

different companies, some are even ready to contribute ; it is then =

important to have MPTCP upstream


Also note that:

  - David Miller will not be present in Montr=C3=A9al [1] but other main =

contributors should be there (we don't have a list)
  - A presentation by Octavian Purdila about "MPTCP Upstreaming" has =

already been given in 2015 (NetDev 0.1) [2]
  - 3 types of presentation are available: talks, tutorials and =

workshops [3]
  - Call for Presentation Proposals closes on May 1st, 2018.


The current idea we briefly discussed during our weekly meetings is to =

give a tutorial:

  - It is not useful to give almost the same presentation as the one of =

Octavian
  - It will allow us more flexibility somehow to explain what is MPTCP, =

the different use-cases, why it is important to have it upstream and =

what problems we are currently facing.
  - David Miller and many other kernel developers will go to LPC in =

November: a good place to give a talk this time.


Do you have any ideas on what we could show in this tutorial?


I recently discussed with my colleague Olivier Bonaventure who has a lot =

of experiences in giving different introductions and more about MPTCP =

and here is what he suggests:

  - A first part about a basic introduction of MPTCP
  - Indicate different use-cases -- if possible with a "closed demo" to =

be sure it is working -- asking people to setup something is not easy in =

1h, max 1h30.
  - Then trying to have interactive discussions or explanations about =

how MPTCP is currently implemented or should be implemented if it goes =

upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need to =

support middleboxes, we need to link subflows of the same connection =

together, we need a scheduler, a PM, etc.
  - Of course, we should focus our discussions on the upstreaming =

aspect, e.g. reducing the footprint of MPTCP in the current TCP stack: =

what are we allow to do, what not. It is linked to many previous =

discussions we had on this ML, e.g. why we need more indirect function =

calls and how to reduce the impact, etc.
  - If we have time, we could discuss about how users could interact =

with MPTCP: enable it per connection, control the path manager, maybe =

the scheduler, etc.


What do you think about this? Feel free to comment and even propose =

completely different ideas!


Cheers,
Matthieu

[1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
[2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
[3] https://www.netdevconf.org/0x12/submit-proposal.html
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============6948873577530703566==--
