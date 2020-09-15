Content-Type: multipart/mixed; boundary="===============6764424774095736731=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Tue, 15 Sep 2020 11:03:36 +0800
Message-ID: <CA+WQbwtQkJrCP6tahHYSVkiS=2L0ry6YR8eh_892kmkcxNVO7g@mail.gmail.com>
In-Reply-To: dde989490e00adfa9f2b56fd51736fd7b1880270.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5866

--===============6764424774095736731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2020-09-14 at 17:34 +0800, Geliang Tang wrote:
> > Hi Paolo,
> >
> > Thanks for your patch. I tested it. It fixed the memory leak problem.
> > But I got this
> > selftest fail output:
> >
> > 11 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - ack[=
 ok ]
> > 12 multiple subflows with syn cookies   syn[fail] got 1 JOIN[s] syn exp=
ected 2
> >  - synack[fail] got 1 JOIN[s] synack expected 2
> >  - ack[fail] got 1 JOIN[s] ack expected 2
> > Server ns stats
> > MPTcpExtMPCapableSYNRX          1                  0.0
> > MPTcpExtMPCapableACKRX          1                  0.0
> > MPTcpExtMPJoinSynRx             1                  0.0
> > MPTcpExtMPJoinAckRx             1                  0.0
> > Client ns stats
> > MPTcpExtMPJoinSynAckRx          1                  0.0
> > 13 subflows limited by server w cookies syn[fail] got 1 JOIN[s] syn exp=
ected 2
> >  - synack[fail] got 1 JOIN[s] synack expected 2
> >  - ack[ ok ]
> > Server ns stats
> > MPTcpExtMPCapableSYNRX          1                  0.0
> > MPTcpExtMPCapableACKRX          1                  0.0
> > MPTcpExtMPJoinSynRx             1                  0.0
> > MPTcpExtMPJoinAckRx             1                  0.0
> > Client ns stats
> > MPTcpExtMPJoinSynAckRx          1                  0.0
> > 14 signal address with syn cookies      syn[ ok ] - synack[ ok ] - ack[=
 ok ]
> > 15 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - ack[=
 ok ]
> > 16 subflows and signal w. cookies       syn[fail] got 1 JOIN[s] syn exp=
ected 3
> >  - synack[fail] got 1 JOIN[s] synack expected 3
> >  - ack[fail] got 1 JOIN[s] ack expected 3
> > Server ns stats
> > MPTcpExtMPCapableSYNRX          1                  0.0
> > MPTcpExtMPCapableACKRX          1                  0.0
> > MPTcpExtMPJoinSynRx             1                  0.0
> > MPTcpExtMPJoinAckRx             1                  0.0
> > Client ns stats
> > MPTcpExtMPJoinSynAckRx          1                  0.0
>
> I sometime see similar errors, but they are quite unfrequent, and looks
> tied to the self-test fragility: we use some hard-coded sleep to allow
> for MPJ/ADD_ADDR handshake. If the VM running the test is my change
> slowed down a bit, self-tests will fail.
>
> Is the above failure reproducible for you?

Yes, I got this self-test failure every time both on -net and linux-next.

-Geliang

>
> Thanks,
>
> Paolo
>
--===============6764424774095736731==--
