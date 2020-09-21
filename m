Content-Type: multipart/mixed; boundary="===============2551874282045084926=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6
 support
Date: Mon, 21 Sep 2020 17:29:22 +0200
Message-ID: <536cd32e-e283-ecaf-12c3-87e2a9dbd142@tessares.net>
In-Reply-To: be15bba9a03fe0f7153e00041041fd77954beac4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5966

--===============2551874282045084926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 21/09/2020 16:02, Paolo Abeni wrote:
> On Mon, 2020-09-21 at 13:12 +0200, Florian Westphal wrote:
>> Geliang Tang <geliangtang(a)gmail.com> wrote:
>>> When ADD_ADDR suboption include an IPv6 address, the size is 28
>>> octets.
>>> It will not fit when other options are included, e.g. TCP
>>> Timestamps. So
>>> here we send out a mptcp dedicated packet to carry only mptcp
>>> options.
>>
>> Note that RFC 7323 requires TCP TS to be included for the remainder
>> of
>> the connection.  It even recommends TCP peers to drop segments that
>> do
>> not carry a timestamp option in case the connection has TCP TS
>> enabled.
> =

> IIRC, we discussed the above some mtg ago, and mptcp.org is currently
> doing that (dropping the TS option on forged ack packet to allow for
> extra MPTCP-level opts). Still IIRC, the main point was that the TS
> option will be dropped on very rare occasion and only on "duplicate"
> ack/ack forged by MPTCP to pass along ADD_ADDR/DELETE_ADDR info or the
> like - relevant timing information should not be lost.
> =

> @Christoph: is the above somewhat correct?

Note that mptcp.org already sends ADD_ADDR in dedicated ACK. And the =

plan is to drop other options when the goal is to signal MPTCP-related =

notifications.

According to MPTCP's RFC, that's the way to go:

   During normal MPTCP operation, it is unlikely that there will be
   sufficient TCP option space for ADD_ADDR to be included along with
   those for data sequence numbering (Section 3.3.1). Therefore, it is
   expected that an MPTCP implementation will send the ADD_ADDR option on
   separate ACKs. As discussed earlier, however, an MPTCP implementation
   MUST NOT treat duplicate ACKs with any MPTCP option, with the
   exception of the DSS option, as indications of congestion [RFC5681],
   and an MPTCP implementation SHOULD NOT send more than two duplicate
   ACKs in a row for signaling purposes.

   https://www.rfc-editor.org/rfc/rfc8684.html#section-3.4.1-14


If later, packets without TS while enabled are dropped, we can maybe add =

an exception for MPTCP-related notifications, no?


This ADD_ADDR/REMOVE_ADDR would be in a dedicated ACK but from a TCP =

(core) point of view, it will be seen as duplicated if you omit MPTCP =

info. This will be misinterpreted by TCP CC but that's another topic :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2551874282045084926==--
