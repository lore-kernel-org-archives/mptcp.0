Content-Type: multipart/mixed; boundary="===============4042253459766901104=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 15th of March 2018
Date: Thu, 15 Mar 2018 18:16:48 +0100
Message-ID: <4272b1c9-042f-15b2-350d-9f923d214b48@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 376

--===============4042253459766901104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Everyone,

We just had our second meeting with Mat, Ossama and Peter (Intel OTC), =

Christoph (Apple), Stephen Brennan and myself (Tessares).

Thanks again for this good meeting!

Here are the minutes of the meeting:



Feedback about the "Concrete next steps" from last time:

     - Christoph: lock-less: first attempt which seems working but saw =

issues with subflow establishment on server-side. @Christoph: feel free =

to add more details if needed, It was difficult for me to write the =

details :-)

     - Mat: Peter is rebasing/cleaning patches. We hope he will be able =

to comment that.

     - Mat and Ossama will continue to get more advices from colleagues =

about upstreaming stuff: create a workshop at Linux plumber conf? meet =

these people not alone? presentation at netdevconf?



MPTCP subflow establishment on server-side from Christoph. But:

     1. Need to parse TCP-options to demultiplex to the meta-socket;
     2. MPTCP-code deep in tcp_check_req,... explore kernel_accept()



Netlink API:

     - about the proposition sent by Ossama on the ML: one question =

about the SYN+ACK only sent after having asked the userspace if it can =

establish the subflow:
         can be costly, maybe not good for a first version (we can still =

reject the new subflow later with a reset). Maybe better to do that with =

bpf, it is quite advanced and more about policing.

     - Matthieu: I will continue to clean/rebase patches but I was very =

busy this week. Will try to work more on that next week. It will help =

for the next discussions.



Rao's patches and feedback from upstream:
     - please read the dedicated topic on the ML



Scheduler mailing list thread:
     - we can simplify versions: send a first version without =

"smart/complex" stuffs (in the scheduler, pm, etc.). That will ease the =

job of the reviewers.



https://www.mail-archive.com/netdev(a)vger.kernel.org/msg221741.html =E2=86=
=92 =

indirect function calls are expensive:
     - It seems difficult to avoid them
     - instead of indirect functions calls, we can have static branches. =

Idea: we could also "reduce the jump" =E2=86=92 not having an indirect func=
tion =

call but jump "closer", not trivial, even just to explain :)
     - upstream devs didn't propose alternatives. It also means they are =

not forbidden!
     - no measurement on the cost has been done, we don't know what's =

the impact exactly. But we don't have better "solutions". It is a =

generic issue in TCP. We guess more ideas will also come from upstream =

devs or proposed on netdev.
     - even if they are allowed, we will certainly needs not to abuse them.



Next concrete steps:
     - Christoph will continue to work on the lock-less part, bugs fixing.
     - Peter continues the rebasing stuff, getting closer
     - Mat is still working on the receive part of the SKB not to avoid =

cache misses every time (goal: process the DSS option and generate the =

correct ACK)
     - Matthieu will continue to rebase patches and publish them ASAP.
     - Mat will try to write an email on the ML to summary the next =

steps, what need to be done (from what has already been discussed =

previously). Note that it is still difficult to have a roadmap because =

we don't know exactly what the maintainers want, the list can change a =

lot depending on their feedback. Note that it seems the next occasion to =

meet them would be at the next netdevconf, still no date about that, =

maybe in June?



Next meeting:
     a proposition to have it next Thursday, same time. Christoph will =

be at the IETF in London. He will certainly not be able to join.



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

--===============4042253459766901104==--
