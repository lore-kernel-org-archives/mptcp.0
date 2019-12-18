Content-Type: multipart/mixed; boundary="===============2671069619762850718=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 22:52:24 +0100
Message-ID: <518dc6a3c77f51a9d56b66ac80ffb883d80ceedf.camel@redhat.com>
In-Reply-To: 6411d0366a6ec6a30f9dbf4117ea6d1f@codeaurora.org
X-Status: 
X-Keywords:                  
X-UID: 3165

--===============2671069619762850718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 14:36 -0700, subashab(a)codeaurora.org wrote:
> > Ok, understood. Not every packet has this MPTCP extension data so
> > coalescing was not always turned off, but given the importance of
> > avoiding
> > =

> > this memory waste I'll confirm GRO behavior and work on maintaining
> > coalesce/collapse with identical MPTCP extension data.
> > =

> =

> Hi Mat
> =

> Are identical MPTCP extensions a common case?

Yes, they are.

> AFAIK the data sequence number and the subflow sequence number change
> per packet even in a single stream scenario.

What actually change on per packet basis is the TCP sequence number.
The DSS mapping can spawn on multiple packets, and will have constand
(base) sequence number and length.

Cheers,

Paolo

--===============2671069619762850718==--
