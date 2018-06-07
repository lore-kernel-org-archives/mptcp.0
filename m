Content-Type: multipart/mixed; boundary="===============0944392419561561326=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 7th of June 2018
Date: Thu, 07 Jun 2018 19:18:34 +0200
Message-ID: <154ded93-6a53-db83-3138-4c4bc800a244@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 664

--===============0944392419561561326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 13th meeting with Mat, Peter, Ossama (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Progress from last week visible on the ML:
    - Mat and Peter have released the v2 of their patches.
    - Mat, Matth and Christoph: worked on the Netdev's paper



New TCP maintainer (Eric Dumazet):
    - we don't know what it means in practice, will see
    - but sounds very good to have a maintainer for TCP only
    - would be nice if we can talk with him at Netdev Conf (if he goes
there, anyone knows?)



Netconf:
    - slides are available online: http://vger.kernel.org/netconf2018.html
    - there were some presentations about indirections, ULPs, and others
that could be interesting for us.



Netdev conf:
    - we should finish a first draft before the next meeting
    - and already start slides =E2=86=92 easier to use google docs:
https://docs.google.com/presentation/d/1giewlChJKBSgtd6qB32FiFuzW8VbgqqLEsy=
sHUnvK7E/edit?usp=3Dsharing
    - for the slides: we will not use templates from one company as it
is a shared effort.
    - Could be good to talk about people participating to the IETF
after. But they will maybe participating to Netdev. For example, it
could be good to talk about APIs with Lorenzo (@Lorenzo, will you be
there? :) )



Mat and Peter's v2 patches:
    - v2 is available:
https://lists.01.org/pipermail/mptcp/2018-June/000643.html
    - waiting for reviews, feel free to review!
    - not everything is working as mentioned in the cover letter, e.g.
DATA_FIN are not sent (note that when testing with a server suing
MPTCP.org implementation, you will not see any timeout, that's normal), etc.
    - it is also to share the idea of the architecture in more details
    - main changes: last two patches (one is disabling coalescing and
collapsing ; last is the receive path stuff)
    - next step: keep coalescing/collapsing =E2=86=92 we could keep a list =
of
coalesced/collapsed chunks (if we can add an 'if' statement in the core
code base like TLS devs did ; we can also enable these "optimisations"
later)
    - (and of course support multiple subflows, etc. as stated in the
cover letter)
    - Nobody here had time this week to start reviewing them. But that
will come!



Next steps:
    - Netdev conf: slides + finalise paper ; Mat, Christoph and Matth
will try to do that starting from today/tomorrow
    - Mat and Peter's patches: review and discussion on the ML will come.
    - As usual, update the wiki if there are new stuffs to put in!



Next meeting:
    - We propose to exceptionally switch to Wednesday next time: the
13th of June. Usual time 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180613
    - we also propose to have one meeting the 26th of June, 16:00 UTC.



Feel free to comment on these points and propose new ones for the next
meeting!



Talk to you next week,
Matthieu
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

--===============0944392419561561326==--
