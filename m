Content-Type: multipart/mixed; boundary="===============5728479501002981706=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Mon, 04 May 2020 09:38:13 -0700
Message-ID: <20200504163813.GB33923@MacBook-Pro-64.local>
In-Reply-To: cb40fed4ef20511272146b2ce8710671b79079e8.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4309

--===============5728479501002981706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/05/20 - 09:33:25, Paolo Abeni wrote:
> On Fri, 2020-05-01 at 11:09 -0700, Christoph Paasch wrote:
> > while testing forked MPTCP as client and upstream MPTCP as server and o=
ne
> > forgets to set the max_subflow limit with iproute, I end up having a
> > scenario where SYN+MP_JOIN is followed by SYN/ACK+MP_JOIN followed by t=
he
> > ACK+MP_JOIN, which then gets RST by the server.
> > =

> > This makes for a weird packet-trace:
> > 16:48:01.626118 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [S], seq 32677=
01968, win 42340, options [mss 1460,sackOK,TS val 1457348237 ecr 0,nop,wsca=
le 7,mptcp join id 4 token 0x8e133996 nonce 0xee4ce80a], length 0
> > 16:48:01.626163 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [S.], seq 2603=
10350, ack 3267701969, win 43440, options [mss 1460,sackOK,TS val 391670343=
7 ecr 1457348237,nop,wscale 7,mptcp join id 0 hmac 0x30e5a618ce852835 nonce=
 0x3238ac63], length 0
> > 16:48:01.626411 IP 10.1.3.1.35561 > 10.2.1.1.5001: Flags [.], ack 1, wi=
n 991, options [nop,nop,TS val 1457348238 ecr 3916703437,mptcp join hmac 0x=
5c9f67595a7c0f15e72b8d45d2abe73de3a86bf8], length 0
> > 16:48:01.626427 IP 10.2.1.1.5001 > 10.1.3.1.35561: Flags [R.], seq 1, a=
ck 1, win 340, options [nop,nop,TS val 3916703438 ecr 1457348238,mptcp dss =
ack 7475064947213107918], length 0
> =

> [...]
> =

> =

> Almost forgot! does the above mean that with a correct configuration
> the two implementations interoperate nicely ?

Depends on the definition of "nicely" ;-)


MP_CAPABLE & MP_JOIN exchanges work now.

ADD_ADDR still has the old format in out-of-tree MPTCP, so that doesn't work
yet.

When there is a single subflow, data-exchange works fine. Once there are two
subflows, things become weird. Out-of-tree is retransmitting a lot... I need
to look into this.


Christoph

--===============5728479501002981706==--
