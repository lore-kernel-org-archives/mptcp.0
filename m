Content-Type: multipart/mixed; boundary="===============7660913367588680595=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] protocol questions
Date: Wed, 25 Sep 2019 12:06:55 -0700
Message-ID: <alpine.OSX.2.21.1909251128430.26111@leoliu1-mobl.amr.corp.intel.com>
In-Reply-To: 1E3698C5-C685-4977-8F04-D751C94701DB@apple.com
X-Status: 
X-Keywords:                  
X-UID: 1932

--===============7660913367588680595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 24 Sep 2019, Christoph Paasch wrote:

> Hello,
>
>       On Sep 24, 2019, at 4:30 PM, Mat Martineau <mathew.j.martineau(a)li=
nux.intel.com> wrote:
> =

> =

> On Tue, 24 Sep 2019, Matthieu Baerts wrote:
>
>       On 24/09/2019 15:13, Paolo Abeni wrote:
>             On Tue, 2019-09-24 at 13:57 +0200, Matthieu Baerts wrote:
>                   On 24/09/2019 09:03, Paolo Abeni wrote:
> =

>
>       [...]
>
>                         * are out-of-order DSS allowed? I mean pkt 1 cont=
ans a DSS for pkt 2
>                         and vice-versa? If I read correctly, the RFC does=
 not explicitly forbit
>                         them. Can we consider such scenario evil (and ev =
close the subflow if
>                         we hit it)?
> =

>
>                   I am not sure to understand how you could get this situ=
ation where a
>                   packet contains a DSS for another one. May you give mor=
e details about that?
>
>             AFAICS our export branch can't produce that result, but theor=
etically
>             it's possible, I think - at least with something like pktdril=
l.
>             I'm trying to redesign the recvmsg() path as per last mtg, an=
d I would
>             like to understand the possible scenarios - and explicitly ba=
ils on
>             anything unsupported.
> =

>
>       I guess we can then say we don't want to support this case :)
> =

> =

> It's within the MPTCP spec for unmapped packets to arrive and get stored =
for MPTCP-level reassembly when the DSS arrives on a
> later packet. But we are not required to keep unmapped packets, it's opti=
onal to keep them for some period of time. If the
> DSS shows up later, then we can rely on MPTCP-level reinjection by the pe=
er to fill in the data we thought was unmapped and
> we discarded.
> =

> It's also within the MPTCP spec for a DSS to arrive "early", while still =
reassembling data mapped by an earlier DSS.
> =

> =

> Indeed - the spec is unfortunately a bit too permissive here. It allows m=
appings to arrive early, late, or mixed in any imaginable
> way.
> =

> Implementation-wise, out-of-tree Linux MPTCP only supports a DSS-mapping =
that is covering a TCP-sequence space of the packet that
> it is being sent on. If the mapping covers a sequence in the future or in=
 the "past", then we reset the flow.
>
>       While we can discard packets when we don't have a mapping for them,=
 I think we should store "early" DSS mappings.
> =

> =

> Storing early mappings is kind of tricky because we need to limit the amo=
unt of mappings we store (otherwise, an attacker could
> simply fill our memory with mappings :-))
>
>       What I don't know is if any existing MPTCP implementations send the=
se early mappings. If no one is sending them then it
>       does seem kind of pointless.
> =

> =

> In practice, I don't know of an implementation that sends early or late m=
appings. The only thing that happens is a missing mapping
> because of the scenario that Paolo described (aka., tcp_fragment,...). As=
 long as the mapping is on one of the segments, it's fine.

Thanks Christoph. It sounds like handling all those corner cases is =

overkill.

>
>       Seems like these two things could happen on consecutive packets, I =
don't remember a requirement that DSS mappings must
>       be in-order. But I can't think of a reason an MPTCP implementation =
would send them out-of-order.
> =

>
>                               * what if we receive a different DSS before=
 the old one is completed?
> =

>
>                         Do you mean:
>                         - We receive the DSS A covering packets 1, 2, 3 ;=
 then DSS B covering 4,
>                         5, 6 but packet 3 is lost. (packets 1 =E2=86=92 6=
 are following each other when
>                         looking at the TCP seq num)
>                         - Or: we receive the DSS A covering packets 1, 2,=
 3, 7 ; then DSS B
>                         covering 4, 5, 6 ; packets 4 follows 3 regarding =
the TCP seq num, 7 will
>                         arrive later.
>
>                         I guess you are talking about the second one, rig=
ht?
>
>                   I think the 2nd scenario is not possible ?!? DSS mappin=
g should be
>                   continuous inside the TCP sequence numbers space, right?
> =

>
>             I guess indeed it is not possible. Maybe in this case the pkt=
 4 will be
>             associated to DSS A.
> =

>
>       I agree that the second scenario isn't possible.
>
>       What I do think is possible is this:
>
>       Packet 1 (Data, and DSS A that maps packets 1,2,3)
>       Packet 2 (Data)
>       Packet 3 (Data, and DSS B that maps packets 4,5,6)
>       Packet 4 (Data)
>       Packet 5 (Data)
>       Packet 6 (Data)
>
>       This is the "early DSS" situation I describe above.
> =

> =

> I think it is fine to kill the TCP-subflow for early mappings.

Ok.

> =

> =

> One interesting scenario (currently not supported by any known implementa=
tion) is the following though:
> =

> Packet 1, Seq 1:1501 (Data, DSS A MPTCP-seq 1 maps TCP-sequence 1 -> 2001)
> Packet 2, Seq 1501:2001 (Data, DSS A MPTCP-seq 1 maps TCP-sequence 1 -> 2=
001)
> Packet 3, Seq 2001:2501 (Data, DSS B MPTCP-seq 2001 maps TCP-sequence 200=
1 -> 2501)
> =

> Now, let's imagine Packet 2 & 3 are lost.
> =

> Ideally, I would be able to retransmit a single packet:
> =

> Packet 4 (retransmission), Seq 1501:2501 (Data, DSS C MPTCP-seq 1501 maps=
 TCP-sequence 1501:2001)
> =

> Packet 1 should be pushed up to the MPTCP-layer (even though the mapping =
is incomplete) and Packet 4 will also be pushed higher. =

> =

> If that is not supported, the retransmission needs to maintain the Packet=
 2 & Packet 3 mappings and thus actually retransmit 2
> packets instead of 1.
>

Ah, right. I had been thinking in terms of the reassembled TCP-level =

stream that's passed up to MPTCP, but TCP-level retransmissions could lead =

to this kind of situation with the DSS. For our retransmission code, it =

seems safer and simpler to keep the same mappings when retransmitting =

(packets could have been delayed rather than lost?).

--
Mat Martineau
Intel

--===============7660913367588680595==--
