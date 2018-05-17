Content-Type: multipart/mixed; boundary="===============2797235850152417641=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 17th of May 2018
Date: Thu, 17 May 2018 19:08:53 +0200
Message-ID: <94a909e9-43d4-43e0-4bdf-1a6c260484ae@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 632

--===============2797235850152417641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Back to normal, we just had our 10th meeting with Mat, Peter, Ossama
(Intel OTC), Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netdev participation:
    * Matthieu got the confirmation this week: he will be there
    * Mat and Peter have to wait
    * (Christoph already said he will be there)



Netdev proposal:
    * at the meeting, we finished the review of the proposal
    * main change: we set a list of challenges to add a tiny bit more
details to prove we are working on something
    * the proposal has been posted just after the meeting



Update of mptcp_trunk (by Christoph):
    - no real issue
    - Christoph will share more changes (bug-fixes)
    - Christoph will look at Mat's comment from
https://lists.01.org/pipermail/mptcp/2018-May/000620.html (should check
with RCU debugging tools?)
         Comment: Is it guaranteed that RCU synchronization happens
between here and when the tcp_sock is freed? Do you need to set
SOCK_RCU_FREE?



Architecture proposal v2 for the receiver part by Peter and Mat:
    - Peter found a bug, Mat is looking at that before sharing a v2.



mptcp_net-next:
    - Peter confirms that creating subflows is still possible (related
to a question raised by Christoph at the last meeting)



Next steps: (almost same as after the last meeting)
    - We hope to get an answer for Netdevconf before the next meeting,
nothing else we can do about that
    - Mat & Peter: looking at the v2 of their patches
    - Christoph: fixing some bugs in mptcp_trunk + check Mat's question
(RCU related)
    - Ossama: looking at a userspace Open-Source code to use the
Open-Source Netlink PM
    - Matthieu: propose a v2 for the PM Netlink, still should not change
the API, useful info for Ossama.
    - As usual, update the wiki if there are new stuffs to put in!



Next meeting:
    - proposition: the 24th of May. Usual time 9am PDT - 16:00 UTC (9am
PDT, 6pm CEST)
    - open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180524



Feel free to comment these points and propose new ones for the next meeting!



Talk to you in two weeks,
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

--===============2797235850152417641==--
