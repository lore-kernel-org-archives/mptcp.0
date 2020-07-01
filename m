Content-Type: multipart/mixed; boundary="===============7961612193597946941=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Weekly meeting - 25 June 2020 16:00 UTC (9am PDT,
 6pm CEST)
Date: Wed, 01 Jul 2020 18:17:14 +0200
Message-ID: <eeeb860d-601d-6533-1578-3c997de842f0@tessares.net>
In-Reply-To: CA+WQbwsg7yR-OQge=NtQX2vnb231qxFSV4xsqY9Mg=fq25ziCA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4887

--===============7961612193597946941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 26/06/2020 02:40, Geliang Tang wrote:
> Hi Matt,
> =

> There are several questions I didn't answer clearly in the last meeting. =

> Here I try to write them down:

Thank you for the clarification!

> 1 My name pronunciation
> Geliang Tang sounds like Glenn Town.

Thank you, that's helpful!

> 2 My ideal meeting time
> Every hour from=C2=A011am to 6pm (my location time-zone) at every working=
 day =

> is fine to me to attend the meeting.

I just sent another email now that I am back to work. Did you see it?
I guess you subscribed to the ML but just in case: =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/SHULDCJUWQ=
JX7CWUH6N66MFTRW6TAODS/

The best would be to have a single meeting, once per week where =

everybody can join. But it would always be difficult for people of some =

time zones...
I know it is very late and not in the working hours but do you think =

having the meeting one hour sooner (11pm your time) would be OK for you? =

Maybe not every week of course. Don't be afraid to say no!

An alternative would be to organise other meetings with less people.
But sadly, I don't see other possibilities. Feel free to share if any!

> 3 What would you=C2=A0like to work on?
> I'm interested in the BPF topic in the last meeting. But=C2=A0I don't hav=
e =

> any idea about this at the moment. Can you please give me more detail =

> about it and I'll spend some time to learn it.

At the last meeting, we discussed about BPF because a new dev asked to =

work on this subject. He is for the moment looking at having the =

possibility to set in BPF some socket options per subflow.

Maybe later, he might look at adding BPF_CGROUP_SOCKET to allow =

per-cgroup override of proto in the socket() call. More details in =

https://github.com/multipath-tcp/mptcp_net-next/issues/18

But still in BPF, it would be good to look at other stuffs like =

modifying the behaviour of the Path Manager or the Scheduler with BPF.
Some works were done in a fork of the out-of-tree kernel, maybe it can =

help: https://dial.uclouvain.be/pr/boreal/object/boreal:225610

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7961612193597946941==--
