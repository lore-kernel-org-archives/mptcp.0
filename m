Content-Type: multipart/mixed; boundary="===============4638315573010578915=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Thu, 26 Apr 2018 19:27:39 +0200
Message-ID: <658d8d1f-9b74-9754-26b5-32e06bd3b958@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 554

--===============4638315573010578915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

We just had our 7th meeting with Mat, Peter, Ossama (Intel OTC), =

Christoph (Apple), Rao (Oracle) and myself (Tessares).

Thanks again for this new meeting!



Here are the minutes of the meeting:



Progress from last week:
     - the wiki is ready and need to be kept updated
     - there is an update in the mptcp_net-next branch (sync with net-next)
     - discussions about NetDev tutorial presentations have started.



Netdev:
     From what has been shared on the ML:
     - https://lists.01.org/pipermail/mptcp/2018-April/000540.html

     We cannot only count on discussions: we need a backup plan if =

nobody is expressing something.
     Show different approaches:
       - current implementation where any app can benefit from MPTCP
       - only on demand + API
       (and respecting impact on the TCP code)
     We could get more attention by talking about APIs.
     Who will be there:
         Christoph for sure
         Maybe Mat, Peter and Matthieu, waiting for more details from =

their manager(s)
     Matthieu: write a proposal for the netdev conf on the ML.
     Important: Discussions will continue there. We need to send =

something on Monday!



Wiki:
     The base is there, we need to maintain it.
     It is indexed by Google and others, that's good!



Approach to indirect call optimization by Eric Dumazet:
     that's one example, it is a bit specific to MD5 but the idea is =

there. That's what we had in mind (but the solution is not generic)



Discussion of Oracle's patches:
     - Rao is asking what to do next with these patches
     - (Matthieu: I got disconnected, I maybe missed something =

important, feel free to comment)
     - One main concerning point raised during the call is that we will =

still have a big intrusiveness with a lot of "if(mptcp)" in the code
     - Rao would prefer not to rewrite the current MPTCP implementation =

as much as proposed here during the meetings. Propose this first =

implementation based on a previous mptcp_trunk version.
     - By Christoph: this kind of code should be avoided for =

maintainability reasons:

               struct inet_connection_sock *icsk =3D from_timer(icsk, t, =

icsk_delack_timer);
               struct sock *sk =3D &icsk->icsk_inet.sk;
         +#ifndef CONFIG_MPTCP
         +    struct sock *meta_sk =3D sk;
         +#else
         +    struct sock *meta_sk =3D mptcp(tcp_sk(sk)) ? =

mptcp_meta_sk(sk) : sk;
         +#endif
         -     bh_lock_sock(sk);
         +    bh_lock_sock(meta_sk);

     - Discussions will continue next week.



Next steps:
     - Matthieu: write a proposal for the netdev conf on the ML. =

Discussions will continue there. We need to send something on Monday!
     - As usual, update the wiki if there is new stuff to put in
     - at the meeting next week, continue the discussions about Oracle's =

patches / First implementation.
     - some people will be busy on other topics during the coming days, =

discussions could be "slow" on the ML like the previous days.



Next meeting:
     - proposition: the 3rd of May at 9am PDT - 16:00 UTC (9am PDT, 6pm =

CEST)
     - open to everyone!
     - https://annuel2.framapad.org/p/mptcp_upstreaming_20180503



Feel free to comment these points and propose new ones for the next =

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

--===============4638315573010578915==--
