Content-Type: multipart/mixed; boundary="===============0716049244863107794=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/2] Fix bug processing options
Date: Wed, 23 Oct 2019 13:35:07 -0700
Message-ID: <c84a21d8e4cdf74c30f463cd65dfe836b2308128.camel@linux.intel.com>
In-Reply-To: 23966238-7748-ea49-391d-5613418391b7@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2295

--===============0716049244863107794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-23 at 14:19 +0200, Matthieu Baerts wrote:
> Hi Peter,
> =

> On 23/10/2019 00:54, Peter Krystad wrote:
> > Observed crash when running against out-of-tree kernel with
> > mis-matched checksum options.
> =

> Thank you for doing this kind of tests!

It was an accident, I forgot to disable checksum on the out-of-tree side...

> =

>  > Do not process incoming options if the subflow is not MPTCP.
> =

> Are we not supposed not to deal with MPTCP options after a fallback to TC=
P?
> =

> If we fallback to TCP, should we not always set 'tp->is_mptcp' to false?

Currently for fallback we set is_mptcp=3D0 after the connection negotiation=
 is
complete [in mptcp_accept()] and presumeably everything is fine after that
point. In this specific situation (we don't send MP_CAPABLE in the third ack
because we don't support checksum) the out-of-tree kernel resends the syn-a=
ck
with DSS options, and these packets are processed before is_mptcp is cleare=
d.
I think we are in uncharted territory here because of how we reject the oth=
er
sides request for checksums, but this check can't hurt.

Peter.

 =

> =

> Cheers,
> Matt

--===============0716049244863107794==--
