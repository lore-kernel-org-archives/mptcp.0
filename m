Content-Type: multipart/mixed; boundary="===============9037877918197889778=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Separating MPTCP packet processing from TCP
Date: Mon, 15 May 2017 21:59:31 -0700
Message-ID: <20170516045931.GZ6301@da0602a-dhcp133.apple.com>
In-Reply-To: f7203ed5-0457-124f-e649-7069c1bc3354@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 32

--===============9037877918197889778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Rao,

On 15/05/17 - 18:16:36, Rao Shoaib wrote:
> I am thinking the cleanest implementation would be to separate MPTCP
> processing from TCP. On the receive side, when a packet arrives TCP only
> does TCP processing (That leaves the code untouched), the packet is than
> passed upto MPTCP which does MPTCP processing and can either process the
> packet, drop it or send a reset.
> =

> The current implementation is doing receive processing in TCP because it
> wants to validate the packet and accept it in TCP  or not -- but why ? th=
at
> seems to be an implementation choice.

you can look at mptcp_handle_options for the conditions upon which we stop
processing the segment, when coming from tcp_validate_incoming. For example,
when a MP_FASTCLOSE is received, the subflow gets killed with a TCP-RST.

The same holds when receiving a DSS-option without DSS-checksum although the
DSS-checksum has been negotiated.


The question would be, whether we can delay the killing of the subflow &
sending of the RST until later. This would mean that the packet gets
completely handled (acks processed, incoming data acknowledged,...)
by the TCP-stack and later on the subflow gets killed.
This *might* be ok from a protocol-perspective, but I'm not sure.

> In the case where the receiver drops the packet in MPTCP, no data ack will
> be sent and MPTCP will re-transmit, It can retransmit even on the same fl=
ow.
> To achieve this the code requires some change as the DSS option has to be
> saved. I think this is doable and is a much cleaner solution.

For incoming data, that's already how it is handled. We pass the segment to
the MPTCP-stack through the sk_data_ready callback, where we go over the
segments, check whether their DSS-checksum is correct, check if it is
in-window,... And if all is good, queue it at the MPTCP-level and send a
DATA_ACK.


Cheers,
Christoph

> Similarly we need to think about the Tx side -- That is not so straight
> forward but we need to think harder.
> =

> I can work on making the Rx changes but want to discuss it in case I am
> missing potential issues and if this is not a got option.
> =

> Comments  ?
> =

> Rao
> =


> From: Rao Shoaib <rao.shoaib(a)oracle.com>
> To: "multipathtcp(a)ietf.org" <multipathtcp(a)ietf.org>
> Date: Mon, 15 May 2017 17:39:12 -0700
> Subject: [multipathtcp] Question on Data Sequence Mapping
> =

> Hi,
> =

> Section 3.3.1 of RFC 6824 says
> =

> The data sequence mapping specifies a mapping from subflow sequence space=
 to
> data sequence space. This is expressed in terms of starting sequence numb=
ers
> for the subflow and the data level, and a length of bytes for which this
> mapping is valid.
> =

> <...>
> =

> A mapping is fixed, in that the subflow sequence number is bound to the d=
ata
> sequence number after the mapping has been processed. A sender MUST NOT
> change this mapping after it has been declared;
> =

> Does it mean that I can not map the data sequence to another (higher) TCP
> sequence number on the same flow.
> =

> The reason I am asking this is that if this is allowed  TCP and MPTCP
> processing can be separated on the recv side. For example, TCP could acce=
pt
> the packet but MPTCP could reject it. Since data level ack would not be s=
ent
> the peer would retransmit, possibly using the same flow but with a differ=
ent
> mapping so that TCP would accept the packet.
> =

> Is this legal to do and if not than why ?
> =

> Regards,
> =

> Rao
> =

> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org
> https://www.ietf.org/mailman/listinfo/multipathtcp

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============9037877918197889778==--
