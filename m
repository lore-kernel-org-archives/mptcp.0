Content-Type: multipart/mixed; boundary="===============7653462749688019946=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 1st of August 2018
Date: Wed, 01 Aug 2018 18:39:40 +0200
Message-ID: <8467e52e-1c19-dc50-6c08-69c68b59a576@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 693

--===============7653462749688019946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 16th meeting with Mat, Ossama, Peter (Intel OTC),
Christoph (Apple) and myself (Tessares).

Thanks again for this new good meeting!



Here are the minutes of the meeting:



Netdev:
    - we received notes that will be shared somewhere (LWN?)
    - Mat will reply that it is OK, maybe with new comments from Peter
(if we need to share more messages).



Linux Plumbers:
    - any news nor feedback (but deadline is on the 15th of August)



RFC about a design/API:
    - will be about: DSS mapping in/out + ADD_ADDR (and other
asynchronous signaling) in/out =E2=86=92 related to skb
    - note: all signaling options on ACK we have are async, and not
reliable (even Fast close with the latest RFC6824bis)
      @Christoph: even the RST after the Fast close?
    - work in progress by Mat
    - there are still some questions about using an additional queue but
after more thoughts about that, the notes will be shared on the wiki.



testing the latest mptcp_net-next:
    - didn't have chance to do that but in progress for Matth, will
continue this week



Next steps:
    - Mat: new design on the wiki
    - Mat: send reply for Netdev notes
    - Peter: working on MP_JOIN stuff
    - Peter: check the Netdev notes with Mat
    - Christoph: MPTCPv1 + bug fixes
    - Ossama: more debugging on userspace code and sync with latest
changes from Peter/Mat
    - Matth: use recent kernel and maybe mptcp_net-next with our
test-suite. + update netlink code after that.



Next meeting:
    - We propose to have it back on Thursday, the 9th of August then.
Usual time 9am PDT - 16:00 UTC (9am PDT, 6pm CEST)
    - Still open to everyone!
    - https://annuel2.framapad.org/p/mptcp_upstreaming_20180809



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

--===============7653462749688019946==--
