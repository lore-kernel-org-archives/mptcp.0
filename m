Content-Type: multipart/mixed; boundary="===============1572897572816600504=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] protocol questions
Date: Tue, 24 Sep 2019 15:13:14 +0200
Message-ID: <61f2235a9daec416f4d0b4d270ae9b22434a1bc7.camel@redhat.com>
In-Reply-To: 549866c4-ddd9-6703-90b4-814660e9b0b2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1914

--===============1572897572816600504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-24 at 13:57 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 24/09/2019 09:03, Paolo Abeni wrote:
> > there are a few DSS related corner cases I don't understand well:
> > =

> > * is support for 'delayed DSS' optional? e.g. pkt 1 with no DSS, pkt 2
> > with DSS for pkt 1 and 2. Can we ignore/consider such scenario evil
> > (and ev close the subflow if we hit it)?
> =

> It is possible to have this scenario but we don't have to support it
> now. I think the out-of-tree kernel support[1] it but I am sure some
> smaller stacks don't support it.
> =

> [1]
> https://github.com/multipath-tcp/mptcp/blob/mptcp_trunk/net/mptcp/mptcp_i=
nput.c#L642

good! :)

> > * are out-of-order DSS allowed? I mean pkt 1 contans a DSS for pkt 2
> > and vice-versa? If I read correctly, the RFC does not explicitly forbit
> > them. Can we consider such scenario evil (and ev close the subflow if
> > we hit it)?
> =

> I am not sure to understand how you could get this situation where a
> packet contains a DSS for another one. May you give more details about th=
at?

AFAICS our export branch can't produce that result, but theoretically
it's possible, I think - at least with something like pktdrill.

I'm trying to redesign the recvmsg() path as per last mtg, and I would
like to understand the possible scenarios - and explicitly bails on
anything unsupported.

> > * what if we receive a different DSS before the old one is completed?
> =

> Do you mean:
> - We receive the DSS A covering packets 1, 2, 3 ; then DSS B covering 4,
> 5, 6 but packet 3 is lost. (packets 1 =E2=86=92 6 are following each othe=
r when
> looking at the TCP seq num)
> - Or: we receive the DSS A covering packets 1, 2, 3, 7 ; then DSS B
> covering 4, 5, 6 ; packets 4 follows 3 regarding the TCP seq num, 7 will
> arrive later.
> =

> I guess you are talking about the second one, right?

I think the 2nd scenario is not possible ?!? DSS mapping should be
continuous inside the TCP sequence numbers space, right?

I was wondering something alike:

pkt 1 carries DSS A which covers also pkt 2.
pkt 2 carries DSS B (with B !=3D A, for some field at least).

Can we accept pkt2/DSS B? The current recvmsg() 'export branch' code
just emits a warning in such scenario. Reading the RFC I think it
allows that if the only difference between DSS B and DSS A is
B.data_len > A.data_len

> > If I read the RFC correctly, that should be allowed only if the new DSS
> > don't change the existing mapping - e.g. the DSS lenght grow and
> > anything else is unchanged. How we should handle other scenario? ignore
> > the DSS? close the subflow? as MPTCP processing happens after TCP
> > validation, I suppose TCP reset should fit here.
> =

> Can we not fallback? (and send an MP_FAIL)
> =

> From my point of view, I think the only "tricky" case we should support
> is to have the same DSS for a few packets (due to TSO). I don't think we
> should support now the other corner cases you mentioned.

Easier then what I feared, then ;)

> I think the case where there is no DSS in some packets (but only a
> DATA-ACK?) can happen if the sender is doing some optimisation to reduce
> the size of MPTCP options. For the rest, if it happens, it is more due
> to some middleboxes and we can fallback to TCP.
> =

> Regarding the case where the DSS is "missing" in some packets, my
> colleague Benjamin pointed me to this text from the RFC:
> =

>    A sender MUST include a DSS option with data sequence mapping in
>    every segment *until* one of the sent segments has been acknowledged
>    with a DSS option containing a Data ACK.  Upon reception of the
>    acknowledgment, the sender has the confirmation that the DSS option
>    passes in both directions and *may* choose to send fewer DSS options
>    than once per segment.

Note the the 'export branch' can (and actually does) send data pkts
without DSS due the internal TCP machinery and without tacking in
account any MPTCP related logic.

e.g. we enqueue a pkt with proper DSS mapping, but later it's splitted-
up by tso_fragment() and/or tcp_fragment() on retransmit or even normal
tcp_push(). =


Nor tcp_fragment nor tso_fragment() copy the skb ext to the newly
allocated skb header.

Such packet will be xmitted without mapping.

Thank you,

Paolo


--===============1572897572816600504==--
