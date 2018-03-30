Content-Type: multipart/mixed; boundary="===============8150121970014059343=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 29th of March 2018
Date: Fri, 30 Mar 2018 16:55:43 +0200
Message-ID: <1b56b542-453d-d56d-33aa-f5972a727d1d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 477

--===============8150121970014059343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 4th meeting with Mat and Peter (Intel OTC), Christoph =

(Apple) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



- discussion of Rao Shoaib's patches:
     - Christoph posted some comments
     - Peter has comments but mainly similar to the ones of Christoph. =

Will try to post comments the coming days.
     - Rao was not able to join, we hope we will be able to discuss =

about reviews that were done for these patches (or a v2) next week.



- Netlink PM (Matthieu's patches)
     * Discussion on missed events: it is very rare. A bit like loosing =

UDP packets between apps on the same host. We can have a PM with =

Netlink. Could be interesting to get stats of lost events.
     * _CREATED vs. _ESTABLISHED: we would like to have a simple v1, =

with only the minimum required. Not having the _CREATED event could be =

OK, we would not announce ADD_ADDR ASAP but on the other hand, if the =

client receives this while the session is not "ESTABLISHED", it cannot =

create a second subflow.
     * Goal: simple API that can be extended later.
     * (lot of discussions about that but it was difficult to take notes =

at the same points for me).



- lockless subflows (Christoph's patches)
     - one more fix coming
     - waiting for review



- Mat and Peter's patches:
     - first design is there
     - will simplify (a lot) the current implementation, at least on the =

client side. The tricky side is the server side. Work will need to be =

done on this area. Peter is looking at this.
     - Server side: biggest issue: allocate socket for new (coming) =

subflows. Subflows need to be attached to the MPTCP connection. Idea =

(dirty) from Christoph is to pre-allocate resources.
         Current way of doing that =

(https://github.com/multipath-tcp/mptcp): resources are allocated at the =

3rd ACK. Here we would need to do the kernel's accept() in usercontext =

but also allocate and attach resources to the MPTCP connection. What to =

do in the meantime? We cannot drop data. The subflow should be seen as =

fully-functional even if it is not properly accepted/attached.
     - Note about these patches: it is a RFC, we agreed in the past to =

share patches as soon as possible to comment about the idea.
     - waiting for review on the ML



- Mat's summary:
     - clear
     - was added in MPTCP's wiki



- netdevconf:
     - Because David will not be there, maybe a tutorial is more =

interesting. Goad: Why MPTCP is interesting, why netdev community should =

look at, what we are doing in the upstreaming process.
     - Maybe good to have a dedicated topic in the ML (but already a lot =

of other messages there, that can wait)
     - Tutorial: some ideas
         - Android smartphones with MPTCP (but you will need SIM cards, =

etc.)
         - Raspberry PI with MPTCP: they have two ifaces now but maybe =

hard to setup / have something working
         - safer to have a VM?
         - (last time, there were tutorial where people were only =

looking, not acting =E2=86=92 we can also show what's happening with some =

embedded devices)
         - could be good to have new ideas.
     - deadline is May, we still have one month to think about that.



- Next steps:
     - Our ML is not very visible. Wiki: we can use Github.
     - We could move stuff to Github =

(https://github.com/multipath-tcp/mptcp), wiki included.
     - Could be good to have a wiki because there are already a lot of =

discussions in the ML. Mat confirmed he can edit the wiki at =

https://github.com/multipath-tcp/mptcp/wiki
     - most of the next steps concern the continuation of the =

discussions on the different topics already opened on the ML (mostly =

linked to big patch-set)
     - people will try to find time -- among other priorities -- to =

review them.



Next meeting:
     - proposition: the 5th of April at 16:00 UTC (9am PDT, 6pm CEST)
     - open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180405




Feel free to comment these points and propose new ones for the next meeting!



Talk to you next week,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =


------------------------------
DISCLAIMER.
This email and any files transmitted with it are confidential and intended =

solely for the use of the individual or entity to whom they are addressed. =

If you have received this email in error please notify the system manager. =

This message contains confidential information and is intended only for the =

individual named. If you are not the named addressee you should not =

disseminate, distribute or copy this e-mail. Please notify the sender =

immediately by e-mail if you have received this e-mail by mistake and =

delete this e-mail from your system. If you are not the intended recipient =

you are notified that disclosing, copying, distributing or taking any =

action in reliance on the contents of this information is strictly =

prohibited.

--===============8150121970014059343==--
