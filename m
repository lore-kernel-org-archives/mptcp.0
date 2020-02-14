Content-Type: multipart/mixed; boundary="===============7192637920913066864=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 0/5] mptcp: perform mptcp ack update from work queue
Date: Fri, 14 Feb 2020 18:21:01 +0100
Message-ID: <831f4839ee33f80180a337a68503348a7336efb1.camel@redhat.com>
In-Reply-To: 20200213102742.18937-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3659

--===============7192637920913066864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-13 at 11:27 +0100, Florian Westphal wrote:
> This series adds support for async draining of subflow rx queue.
> =

> This allows mptcp to send up-to-data mptcp-level ack sequence
> even if userspace doesn't call recv for some time.

tested with:

// connection initiated by packetdrill
--tolerance_usecs=3D100000
`../common/defaults.sh`


+0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
+0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0

+0    bind(3, ..., ...) =3D 0
+0    listen(3, 1) =3D 0
+0      < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale 7,mpcapabl=
e v1 flags[flag_h] nokey>
+0      > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8,mpcapable v=
1 flags[flag_h] key[skey] >
+0.01   < . 1:1(0) ack 1 win 257 <mpcapable v1 flags[flag_h] key[ckey=3D2,s=
key]>
+0    accept(3, ..., ...) =3D 4

// ack 2 data segments, then read them
+0      < P. 1:101(100) ack 1 win 225 <dss dack8=3D1 dsn8=3D1 ssn=3D1 dll=
=3D100 nocs, nop, nop>
+0.01   > .  1:1(0) ack 101 <dss dack8=3D1 nocs>
+0.1    < P. 101:201(100) ack 1 win 225 <dss dack8=3D1 dsn8=3D101 ssn=3D101=
 dll=3D100 nocs, nop, nop>
+0.01   > .  1:1(0) ack 201 <dss dack8=3D101 nocs>
0.3   read(4, ..., 200) =3D 200
+0    close(4) =3D 0
+0.01   > F. 1:1(0) ack 201 <dss dack8=3D201 dsn8=3D1 ssn=3D0 dll=3D1 nocs =
fin, nop, nop>


-- =

davide

--===============7192637920913066864==--
