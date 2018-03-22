Content-Type: multipart/mixed; boundary="===============8124916907076885607=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 22th of March 2018
Date: Thu, 22 Mar 2018 18:25:33 +0100
Message-ID: <afe2f5d0-b98a-ca29-605d-98d85688946d@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 395

--===============8124916907076885607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our third meeting with Mat, Ossama and Peter (Intel OTC), =

Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!

Here are the minutes of the meeting:



Work from last 7 days:

     - Mat: pretty close to finish his work to get the DSS ACK from the =

SKB. Not fully functional but ready to be tested. We can now parse what =

it coming back. To have something working with MPTCP and not having a =

fallback to TCP, we need to at least read the DSS options from the "3rd" =

ACK. Work was based on net-next. Will first need to have a rebase on =

latest net-next before sharing code. Will be ready to be tested "soon".
     - Christoph is looking at the lock-less part, patches should arrive =

very soon.
     - Matthieu: should send patches for the Netlink PM very soon.



Indirect function calls:

     - we didn't get new input after asking around.
     - message from the maintainer: we cannot simply remove them, =

sometimes needed (e.g. for the drivers)
     - maybe not the best time to introduce new ones (except in RFC).
     - we should certainly reduce their usage to only when it is really =

needed (seems what DaveM said)



Patches that could be sent to netdev:

     - we need to design them for the maintainers: if they are too big =

with not so many explanations, the maintainers may not take the time to =

go over them in detail. These "details" seem very important for them.



Netdevconf:
     - there was a talk in Ottawa (Netdev 0.1)
     - what was presented there is still valid at the end.
     - maybe tutorial (proposed by Jamal): at least to convince other =

devs that there is a very big interest. Then: "we are interested by =

upstreaming that, any recommendations from you guys about (...)?"
     - please propose ideas on ML. We can discuss about them next week.
     - We should propose something and discuss about upstreaming MPTCP =

there and get feedback, advises, ideas, more people interested by that =

or by the issues we have in common with other projects, etc.
     - Deadline: Proposals must be received on or before May 1, 2018
     - Need to check with managers if we can participate to both Netdev =

and Linux Plumbers conf.



kTLS:
     - https://patchwork.ozlabs.org/patch/888002/
     - what they are doing is very similar of what we need to do with =

the DSS.
     - they are maintaining a look-up table not to affect SKB size.
     - callback is used to know when the sent data got acknowledged, so =

that they can then purge elements out of the lookup-table



Next steps:
     - Mat will try to write an email on the ML to summary the next =

steps, what need to be done (from what has already been discussed =

previously). Note that it is still difficult to have a roadmap because =

we don't know exactly what the maintainers want, the list can change a =

lot depending on their feedback. Mat will also testing his new version =

regarding the problem with SKB size.
     - Christoph: will continue to polish patches (lock-less) and share =

them ASAP.
     - Matthieu: publish Netlink PM patches and fix issues.
     - Peter will continue the rebase, share it soon. Will also have a =

look at patches posted on ML.
     - Ossama: will also continue the rebase. Will be off next week. =

Happy holidays!



Next meeting:
     - proposition: the 29th of March at 9am PDT - 16:00 UTC (9am PDT, =

6pm CEST)
     - open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180329



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

--===============8124916907076885607==--
