Content-Type: multipart/mixed; boundary="===============3839469773067336170=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 18th of July 2019
Date: Fri, 19 Jul 2019 17:23:40 +0200
Message-ID: <345C12D3-796E-46E7-949E-6E6E3FEF0DCA@apple.com>
In-Reply-To: 679a3349-8bde-a2b7-2b96-bb36b6fe99d0@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1539

--===============3839469773067336170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> On Jul 19, 2019, at 5:07 PM, Matthieu Baerts <matthieu.baerts(a)tessares.=
net> wrote:
> =

> =EF=BB=BFHello,
> =

> Yesterday, we had our 58th meeting with Peter and Ossama (Intel OTC),
> Davide (Red Hat) and myself (Tessares).
> =

> Thanks again for this new good meeting!
> =

> =

> =

> Here are the minutes of the meeting:
> =

> =

> =

> Accepted patches:
>    - mptcp: selftests: fix .gitignore for mptcp selftests:
>        - by Davide
>        - Accepted by Matth
>        - "Squashed" in "mptcp: selftests: Add capture option"
> =

> =

> =

> Pending patches:
>    - mptcp: Make MPTCP socket block/wakeup ignore sk_receive_queue :
>        - by Mat
>        - commented by Paolo
>        - Waiting for Mat to be back to comment on Paolo's (crazy???)
> alternative
> =

> =

>    - mptcp: harmonize locking on all socket operations:
>        - by Paolo
>        - RFC and v1 sent
>        - RFC/v1 has been commented by Mat, Peter and Florian
>        - v2 has been shared
>        - waiting for approval
>        - Peter will have a look
> =

> =

>    - mptcp: simplify crypto.c:
>        - by Davide
>        - new version
>        - waiting for approval
>        - Davide: using the random bit has it is now done can be an
> issue if another namespace also create connections at the same time, we
> could get the same info.
>        - maybe we can mention that in a comment (+comment about hash)
> and that might be enough for a v1 (for MPTCP)
>        - *Davide* will send a new version
> =

> =

>    - mptcp: new sysctl to control the activation per NS:
>        - by Matthieu
>        - RFC
>        - commented by Ossama and Peter
>        - some questions are still opened:
>            - see notes:
>                - Is it OK to reserve space per ns via the
> "pernet_operations" structure? Because MPTCP would not be compiled as a
> module, we could directly store stuff in the net structure as other
> parts of the code do but maybe better to keep MPTCP code on the side as
> done here.
> =

>                - In mptcp.org, all sysctls are prepended with 'mptcp_',
> e.g. 'net.mptcp.mptcp_enabled'. Do we need this? Is it better to keep
> the same names if possible or better to differentiate? In this version,
> 'mptcp_' is not prepended.

I vote to keep the names different. It allows for an easy runtime check to =
know which MPTCP API one can use.


Christoph =


> =

>                - This sysctl will only block new sockets to be created.
> Is it enough?
> =

>                - ENOPROTOOPT is returned, maybe something else to
> return? EPERM is maybe too generic? ENOTSUPP is not translated by perror(=
).
> =

>                - Should we start the documentation now for the sysctl?
> =

>                - A simple test has been added, because it is not linked
> to the rest, I put separated as first test.
> =

>                - Of course do not hesitate to comment. Even on the idea
> of having a sysctl for this purpose.
> =

>            - security:
>                - sysctl from net tree can be modified by root or
> CAP_NET_ADMIN. Should we require both?
>                    =E2=86=92 a comment will be added in the code, the same
> behavior will be kept, same as tcp_fastopen and most of the ones from "ne=
t".
> =

>            - new file -- ctrl.c -- to control MPTCP (sysctl, sockopt,
> etc.) =E2=86=92 and also to init the protocol?
> =

> =

>    - mptcp: explicitly retransmit MP_CAPABLE 3whs ack:
>    - mptcp: avoid validating MP_CAPABLE keys on 3way HS handling:
>        - by Paolo
>        - should fix self-tests failures
>        - suggested by Christoph/Peter
>        - 2nd one can be applied, 1st one can be discarded
> =

> =

>    - Implement outgoing MP_JOIN:
>        - patch-set (9 patches) by Peter
>        - commented by Paolo
>        - negotiate the connection fine, found bug on the receiving side
>        - Peter uses the mptcp.org implementation for the other side,
> didn't try to use mptcp upstream on both ends.
>        - one patch will conflict with Davide's changes, that's fine
> =

> =

> =

> roadmap proposal/discussion:
>    - see: https://lists.01.org/pipermail/mptcp/2019-July/001505.html
>    - could be good to talk about the locking issues with Paolo in
> another meeting, maybe next week
>    - seems that Peter is not working on the mentioned topics, maybe Mat is
> =

> =

> =

> Feedback from netdev (RFC patch):
>    - /
> =

> =

> =

> Feedback from LPC:
>    - /
> =

> =

> =

> Next meeting:
>    - We propose to have it next Thursday, the 25th of July.
>    - Usual time: 16:00 UTC (9am PDT, 6pm CEST)
>    - Still open to everyone!
>    - https://annuel2.framapad.org/p/mptcp_upstreaming_20190725
> =

> =

> =

> Feel free to comment on these points and propose new ones for the next
> meeting!
> =

> =

> Talk to you next week,
> Matthieu
> -- =

> Matthieu Baerts | R&D Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============3839469773067336170==--
