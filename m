Content-Type: multipart/mixed; boundary="===============1651168589029464978=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP falling back to TCP
Date: Tue, 15 Jan 2019 16:53:11 +0100
Message-ID: <CAKuKrBmeeGdG97swHPJxmJV82R+3P43Xii-rjc6iMRSrzuaAxQ@mail.gmail.com>
In-Reply-To: CAG40BEKJhva=JBx6eZHJ7Z5ZinLp_R0007VZe96oqDvd=Lx=rg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 976

--===============1651168589029464978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dejene,

On Mon, Jan 14, 2019 at 11:17 PM Dejene Boru <dejene.boru(a)gmail.com> wrot=
e:
>
> Hi,
>
> While running an experiment in Mininet using MPTCP, MPTCP falls back to T=
CP after three SYN retransmissions. I have enabled MPTCP both on the host n=
ode and Mininet emulated hosts. The problem appears when multiple clients a=
ttempt to connect to the server, i.e., I have a client-server application, =
the servers listen on a given port and the clients connect to the servers a=
t a certain time interval to download some file size (100KB, 30MB). A conne=
ction with a client closes after the desired file size transfer but the ser=
ver continues to listen for new connections.  The problem happens after som=
e number of clients are connected and irrespective of path managers and the=
 number of sub flows used.
>
> I have tried to enable MPTCP to debug flag and the following debug messag=
e is printed.
>
> 'mptcp_do_join_short:mpcb not found'
>
> Host evnironment: Ubuntu 16.04, Linux version 4.14.79, MPTCP (v0.94)

It seems that you are using this version of the kernel:
https://github.com/multipath-tcp/mptcp/
Not the one for upstream and linked to this ML:
https://github.com/multipath-tcp/mptcp_net-next

Could you then report your problem to this ML instead please?
https://listes-2.sipr.ucl.ac.be/sympa/info/mptcp-dev

Also it can be interesting to clearly state what's your problem:
what's you expect and what's you saw instead? I guess it is because
some connections fallback to TCP after 3 SYN retransmissions while it
should not happen in your test env but it is not clear, at least for
me ;-)

Matthieu

>
> Neither CPU nor memory seems to be part of the problem since during the t=
est the CPU usage is less than 10% and memory usage is also negligible.
>
> I would appreciate a suggestion for a workaround for this issue.\
>
>
> Thanks,
>
> Dejene Boru
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp



-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1651168589029464978==--
