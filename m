Content-Type: multipart/mixed; boundary="===============8786858460130175876=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Mon, 14 Sep 2020 15:54:14 +0200
Message-ID: <dde989490e00adfa9f2b56fd51736fd7b1880270.camel@redhat.com>
In-Reply-To: CA+WQbwuNsAFfnu2nnGPdmrU42_xJkA+GsbbV64kjkCMNKVXyAA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5848

--===============8786858460130175876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-14 at 17:34 +0800, Geliang Tang wrote:
> Hi Paolo,
> =

> Thanks for your patch. I tested it. It fixed the memory leak problem.
> But I got this
> selftest fail output:
> =

> 11 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - ack[ o=
k ]
> 12 multiple subflows with syn cookies   syn[fail] got 1 JOIN[s] syn expec=
ted 2
>  - synack[fail] got 1 JOIN[s] synack expected 2
>  - ack[fail] got 1 JOIN[s] ack expected 2
> Server ns stats
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtMPJoinSynRx             1                  0.0
> MPTcpExtMPJoinAckRx             1                  0.0
> Client ns stats
> MPTcpExtMPJoinSynAckRx          1                  0.0
> 13 subflows limited by server w cookies syn[fail] got 1 JOIN[s] syn expec=
ted 2
>  - synack[fail] got 1 JOIN[s] synack expected 2
>  - ack[ ok ]
> Server ns stats
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtMPJoinSynRx             1                  0.0
> MPTcpExtMPJoinAckRx             1                  0.0
> Client ns stats
> MPTcpExtMPJoinSynAckRx          1                  0.0
> 14 signal address with syn cookies      syn[ ok ] - synack[ ok ] - ack[ o=
k ]
> 15 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - ack[ o=
k ]
> 16 subflows and signal w. cookies       syn[fail] got 1 JOIN[s] syn expec=
ted 3
>  - synack[fail] got 1 JOIN[s] synack expected 3
>  - ack[fail] got 1 JOIN[s] ack expected 3
> Server ns stats
> MPTcpExtMPCapableSYNRX          1                  0.0
> MPTcpExtMPCapableACKRX          1                  0.0
> MPTcpExtMPJoinSynRx             1                  0.0
> MPTcpExtMPJoinAckRx             1                  0.0
> Client ns stats
> MPTcpExtMPJoinSynAckRx          1                  0.0

I sometime see similar errors, but they are quite unfrequent, and looks
tied to the self-test fragility: we use some hard-coded sleep to allow
for MPJ/ADD_ADDR handshake. If the VM running the test is my change
slowed down a bit, self-tests will fail.

Is the above failure reproducible for you?

Thanks,

Paolo

--===============8786858460130175876==--
