Content-Type: multipart/mixed; boundary="===============1145238074682474876=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] protocol questions
Date: Tue, 24 Sep 2019 16:30:35 -0700
Message-ID: <alpine.OSX.2.21.1909241602370.16564@leoliu1-mobl.amr.corp.intel.com>
In-Reply-To: d69770b3-8106-a928-9795-8bababd1be72@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1921

--===============1145238074682474876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 24 Sep 2019, Matthieu Baerts wrote:

> On 24/09/2019 15:13, Paolo Abeni wrote:
>> On Tue, 2019-09-24 at 13:57 +0200, Matthieu Baerts wrote:
>>> On 24/09/2019 09:03, Paolo Abeni wrote:
>
> [...]
>
>>>> * are out-of-order DSS allowed? I mean pkt 1 contans a DSS for pkt 2
>>>> and vice-versa? If I read correctly, the RFC does not explicitly forbit
>>>> them. Can we consider such scenario evil (and ev close the subflow if
>>>> we hit it)?
>>>
>>> I am not sure to understand how you could get this situation where a
>>> packet contains a DSS for another one. May you give more details about =
that?
>> =

>> AFAICS our export branch can't produce that result, but theoretically
>> it's possible, I think - at least with something like pktdrill.
>> =

>> I'm trying to redesign the recvmsg() path as per last mtg, and I would
>> like to understand the possible scenarios - and explicitly bails on
>> anything unsupported.
>
> I guess we can then say we don't want to support this case :)
>

It's within the MPTCP spec for unmapped packets to arrive and get stored =

for MPTCP-level reassembly when the DSS arrives on a later packet. But we =

are not required to keep unmapped packets, it's optional to keep them for =

some period of time. If the DSS shows up later, then we can rely on =

MPTCP-level reinjection by the peer to fill in the data we thought was =

unmapped and we discarded.

It's also within the MPTCP spec for a DSS to arrive "early", while still =

reassembling data mapped by an earlier DSS.

While we can discard packets when we don't have a mapping for them, I =

think we should store "early" DSS mappings. What I don't know is if any =

existing MPTCP implementations send these early mappings. If no one is =

sending them then it does seem kind of pointless.

Seems like these two things could happen on consecutive packets, I don't =

remember a requirement that DSS mappings must be in-order. But I can't =

think of a reason an MPTCP implementation would send them out-of-order.


>>>> * what if we receive a different DSS before the old one is completed?
>>>
>>> Do you mean:
>>> - We receive the DSS A covering packets 1, 2, 3 ; then DSS B covering 4,
>>> 5, 6 but packet 3 is lost. (packets 1 =E2=86=92 6 are following each ot=
her when
>>> looking at the TCP seq num)
>>> - Or: we receive the DSS A covering packets 1, 2, 3, 7 ; then DSS B
>>> covering 4, 5, 6 ; packets 4 follows 3 regarding the TCP seq num, 7 will
>>> arrive later.
>>>
>>> I guess you are talking about the second one, right?
>> =

>> I think the 2nd scenario is not possible ?!? DSS mapping should be
>> continuous inside the TCP sequence numbers space, right?
>
> I guess indeed it is not possible. Maybe in this case the pkt 4 will be
> associated to DSS A.

I agree that the second scenario isn't possible.

What I do think is possible is this:

Packet 1 (Data, and DSS A that maps packets 1,2,3)
Packet 2 (Data)
Packet 3 (Data, and DSS B that maps packets 4,5,6)
Packet 4 (Data)
Packet 5 (Data)
Packet 6 (Data)

This is the "early DSS" situation I describe above.


>
>> I was wondering something alike:
>> =

>> pkt 1 carries DSS A which covers also pkt 2.
>> pkt 2 carries DSS B (with B !=3D A, for some field at least).
>> =

>> Can we accept pkt2/DSS B? The current recvmsg() 'export branch' code
>> just emits a warning in such scenario. Reading the RFC I think it
>> allows that if the only difference between DSS B and DSS A is
>> B.data_len > A.data_len
>
> To which section are you referring to? :)
>
> I think that it is an acceptable situation. Not sure we have to support i=
t.
>
>>>> If I read the RFC correctly, that should be allowed only if the new DSS
>>>> don't change the existing mapping - e.g. the DSS lenght grow and
>>>> anything else is unchanged. How we should handle other scenario? ignore
>>>> the DSS? close the subflow? as MPTCP processing happens after TCP
>>>> validation, I suppose TCP reset should fit here.
>>>
>>> Can we not fallback? (and send an MP_FAIL)
>>>
>>> From my point of view, I think the only "tricky" case we should support
>>> is to have the same DSS for a few packets (due to TSO). I don't think we
>>> should support now the other corner cases you mentioned.
>> =

>> Easier then what I feared, then ;)
>
> The other corner cases are there to support multiple kind of
> middleboxes. I don't know if this is common on Internet. Maybe Christoph
> can help us for that :)
>
>>> I think the case where there is no DSS in some packets (but only a
>>> DATA-ACK?) can happen if the sender is doing some optimisation to reduce
>>> the size of MPTCP options. For the rest, if it happens, it is more due
>>> to some middleboxes and we can fallback to TCP.
>>>
>>> Regarding the case where the DSS is "missing" in some packets, my
>>> colleague Benjamin pointed me to this text from the RFC:
>>>
>>>    A sender MUST include a DSS option with data sequence mapping in
>>>    every segment *until* one of the sent segments has been acknowledged
>>>    with a DSS option containing a Data ACK.  Upon reception of the
>>>    acknowledgment, the sender has the confirmation that the DSS option
>>>    passes in both directions and *may* choose to send fewer DSS options
>>>    than once per segment.
>> =

>> Note the the 'export branch' can (and actually does) send data pkts
>> without DSS due the internal TCP machinery and without tacking in
>> account any MPTCP related logic.
>> =

>> e.g. we enqueue a pkt with proper DSS mapping, but later it's splitted-
>> up by tso_fragment() and/or tcp_fragment() on retransmit or even normal
>> tcp_push(). =

>> =

>> Nor tcp_fragment nor tso_fragment() copy the skb ext to the newly
>> allocated skb header.
>> =

>> Such packet will be xmitted without mapping.
>
> Thank you for this note!
>
> I think that in the out-of-tree kernel, the same header is copied in all
> packets to allow the receiver (more the NIC) to aggregate packets (GRO).
> But that's clearly an optimisation!
>

I have been assuming people would want to omit the mapping where possible =

to reduce the header overhead, but hadn't thought of the aggregation =

benefits for identical headers. Depends on whether someone wants to favor =

wire speed or CPU load, I guess. I added a note in the wiki for future =

work.

--
Mat Martineau
Intel

--===============1145238074682474876==--
