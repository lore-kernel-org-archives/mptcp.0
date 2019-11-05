Content-Type: multipart/mixed; boundary="===============1207185862307585881=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Tue, 05 Nov 2019 16:13:50 +0100
Message-ID: <2b3914f0ba8ec5c217a9d0b894fe2c8916034350.camel@redhat.com>
In-Reply-To: d07eef2e-66dc-4f0b-8c40-12700fe01cc9@localhost
X-Status: 
X-Keywords:                  
X-UID: 2391

--===============1207185862307585881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-10-26 at 10:52 +0000, Matthieu Baerts wrote:
> Hi Paolo,
>  =

> Sat Oct 26 11:59:07 GMT+02:00 2019 Paolo Abeni :
>  =

> > On Fri, 2019-10-25 at 17:20 +0200, Matthieu Baerts wrote:
> > =

> > > Hi Paolo,
> > > =

> > > On 25/10/2019 09:53, Matthieu Baerts wrote:
>  =

> [...]
>  =

> > > So far, I *think* the establishment of the connection is OK (SYN, =

> > > SYN+ACK, ACK) but not after: it seems the first data packet has bad =

> > > options. I would need to look more to understand why.
> > > =

> > =

> > Do you see connection/test failures, or is just the wireshark dissector
> > output? Note that wireshark can't currently correctly dissect mptcp v1
> > MP_CAPABLE ACK option with data_len and/or checksum - it's a wireshark
> > bug/missing feature
>  =

> The transfer blocks then it fallbacks to TCP but with some errors because=
 it doesn't finish properly.

I finally had time to test the .org implementation, and I also can't
move after MP_CAPABLE, even when mptcp.org kernel is talking with .org
peer. I see TCP reset and/or timeouts, even when both peers use v0
protocol.

I guess the 'ptcp_v0.95_mptcp_v1' branch needs some additional love ;)

Paolo

--===============1207185862307585881==--
