Content-Type: multipart/mixed; boundary="===============7985847370773642919=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6
 support
Date: Mon, 21 Sep 2020 18:07:59 +0200
Message-ID: <905b76a4-c932-2155-02cc-82fa5b5ae86e@tessares.net>
In-Reply-To: 6aeebfa8dca2ee2b7de3e14fee44b5e4c47d9b34.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5968

--===============7985847370773642919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/09/2020 17:42, Paolo Abeni wrote:
> On Mon, 2020-09-21 at 17:29 +0200, Matthieu Baerts wrote:
>> On 21/09/2020 16:02, Paolo Abeni wrote:
>>> On Mon, 2020-09-21 at 13:12 +0200, Florian Westphal wrote:
>>>> Geliang Tang <geliangtang(a)gmail.com> wrote:
>>>>> When ADD_ADDR suboption include an IPv6 address, the size is 28
>>>>> octets.
>>>>> It will not fit when other options are included, e.g. TCP
>>>>> Timestamps. So
>>>>> here we send out a mptcp dedicated packet to carry only mptcp
>>>>> options.
>>>>
>>>> Note that RFC 7323 requires TCP TS to be included for the
>>>> remainder
>>>> of
>>>> the connection.  It even recommends TCP peers to drop segments
>>>> that
>>>> do
>>>> not carry a timestamp option in case the connection has TCP TS
>>>> enabled.
>>>
>>> IIRC, we discussed the above some mtg ago, and mptcp.org is
>>> currently
>>> doing that (dropping the TS option on forged ack packet to allow
>>> for
>>> extra MPTCP-level opts). Still IIRC, the main point was that the TS
>>> option will be dropped on very rare occasion and only on
>>> "duplicate"
>>> ack/ack forged by MPTCP to pass along ADD_ADDR/DELETE_ADDR info or
>>> the
>>> like - relevant timing information should not be lost.
>>>
>>> @Christoph: is the above somewhat correct?
>>
>> Note that mptcp.org already sends ADD_ADDR in dedicated ACK. And the
>> plan is to drop other options when the goal is to signal MPTCP-
>> related
>> notifications.
>>
>> According to MPTCP's RFC, that's the way to go:
>>
>>     During normal MPTCP operation, it is unlikely that there will be
>>     sufficient TCP option space for ADD_ADDR to be included along with
>>     those for data sequence numbering (Section 3.3.1). Therefore, it
>> is
>>     expected that an MPTCP implementation will send the ADD_ADDR
>> option on
>>     separate ACKs. As discussed earlier, however, an MPTCP
>> implementation
>>     MUST NOT treat duplicate ACKs with any MPTCP option, with the
>>     exception of the DSS option, as indications of congestion
>> [RFC5681],
>>     and an MPTCP implementation SHOULD NOT send more than two
>> duplicate
>>     ACKs in a row for signaling purposes.
>>
>>     https://www.rfc-editor.org/rfc/rfc8684.html#section-3.4.1-14
>>
>>
>> If later, packets without TS while enabled are dropped, we can maybe
>> add
>> an exception for MPTCP-related notifications, no?
> =

> It just occurred to me that the ipv6 ADD_ADDR option is 28 bytes when
> the port field is not present, so dropping other MPTCP options would be
> sufficient.
> =

> For IPv6 ADD_ADDR with port anyhow will be necessary to drop the
> TS_OPTION, too.
> =

> Perhaps we can start small and do not look at port support for IPv6?!?

Looks good to me!

>> This ADD_ADDR/REMOVE_ADDR would be in a dedicated ACK but from a TCP
>> (core) point of view, it will be seen as duplicated if you omit
>> MPTCP
>> info. This will be misinterpreted by TCP CC but that's another topic
>> :)
> =

> Hopefully such acks will not be frequent at all, so the CC should not
> be fooled too much...

Indeed, that should not be an issue. Likely these notifications will =

happen at the beginning of the connection, certainly before carrying =

data and then, if I am not mistaken, not impacting the slow start.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7985847370773642919==--
