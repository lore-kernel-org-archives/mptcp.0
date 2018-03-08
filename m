Content-Type: multipart/mixed; boundary="===============7099526676306890991=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 8th of March 2018
Date: Thu, 08 Mar 2018 19:39:22 +0100
Message-ID: <b6feaf42-9dea-46c7-a697-286bdaf8cff9@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 354

--===============7099526676306890991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Everyone,

We just had our first meeting with Mat and Ossama (Intel OTC), Christoph =

(Apple) and myself (Tessares). Thank you guys for having participated to =

this first nice meeting, it was very useful!


Here are the minutes of the meeting, AP's are at the end:



Direction: do we all agree that we need a mix between a new fork with =

code from scratch and only adding new code to the current base?

   Mat:
	mptcp.org implementation is clearly not ready for upstream. On the =

other hand, it seems stable and used.
	We should not be afraid to rewrite code to fit with netdev's =

maintainers expectations.
	We need to get feedback from netdev maintainers, not wait to do =

everything before asking for comments.

   Christoph:
	We should work on both sides: modify TCP stack to help for the =

introduction of MPTCP and modify MPTCP to fit with these changes.
	We should also try to do modifications on the current MPTCP code as =

well. Of course if it is possible, sometimes it is better to work =

without it to stay generic.
	It could be good to share code as soon as possible, even if it is not =

ready, more to share the concept. Working as a team.



Could we draw a kind of roadmap? Not really for fixing dates - something =

maybe impossible in our way of working - but to have an overview of the =

work we still need to do.

	Hard to draw something. We have big points (skb' size, API, meta-lock, =

etc.) but we need to get feedback from netdev to know what's next.



Discussion with netdev: it seems it is not clear what netdev maintainer =

and main contributors would like to have. On the other hand, it seems =

clear they would like to see MPTCP coming but not as it is. How can get =

more input from them not to work on something they would not like?  Rao =

proposed to send patches of the design to get comments. Is it the only =

possibility? Is it possible to initiate longer discussions with them =

about how to upstream MPTCP?

	After the first feedback we got from David Miller about the TCP options =

framework, it looks difficult for us to introduce any new extensions. He =

maybe wants to see what would be the implementation without the =

abstraction. Adding new abstractions for nothing will not be accepted.

	For the TCP options framework, MPTCP was also mentioned, maybe not the =

good thing. On the other hand, the framework was already useful (e.g. =

for TCP MD5). Maybe not posted at the best moment, lack of people =

reacting to these patches.
	Ossama proposed to add data: perf are still the same, etc. It can =

indeed help, sometimes difficult to know if they are interested by some =

changes, especially when they are in the core system.
	Would be easier if the modifications where not in the core system, if =

MPTCP was on top of KCM or ULP but not really possible for MPTCP.
	Note that it doesn't look like a clear NO. Maybe more discussions about =

that could help.
	Maybe they don't see MPTCP as something asked by many people. But MPTCP =

is used by many people everyday in the world (iOS, Android in =

South-Korea, Internet Hybrid)



Concrete next steps:

	- Mat's team: working with the PM netlink.
  	- Mat: incoming skb with DSS on them. Having a generic POC to share
	- Christoph: new stable release based on 4.14 upstream release. =

Mid-term goal: working on the meta-socket lock. Can prevent MPTCP to be =

on a completely separated area. It includes: consolidate all areas where =

the subflow receives something and need to interact with the =

meta-socket. Then we would be able to reduce the lock at the subflow level.
	- Matthieu: cleaning MPTCP Netlink PM patches and send it on mptcp-dev.



Meetings:

	- having them each week looks good using the same tools (talky.io =

currently seems to work better with Firefox and Safari, if you have =

issues, reload and/or try with another browser)
	- we didn't have time to go through the whole list of items we had in =

mind. We will continue to do that next time.
	- anybody else is free to join!



Action Points:

	Mat: check with other people from Intel who were more involved in =

netdev community what could help: e.g. creating a workshop at Linux =

plumber conf, meeting netdev maintainer and main contributors as a team, =

not alone this time, show interest in MPTCP from different companies, etc.



Feel free to comment these points and propose new ones for the next meeting!

See you next week,
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

--===============7099526676306890991==--
