Content-Type: multipart/mixed; boundary="===============5854815331693594782=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Separating MPTCP packet processing from TCP
Date: Tue, 16 May 2017 14:57:54 -0700
Message-ID: <alpine.OSX.2.21.1705161410080.7093@jspancar-mobl.amr.corp.intel.com>
In-Reply-To: d4946067-efed-a063-639f-b699b86753fc@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 34

--===============5854815331693594782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 16 May 2017, Rao Shoaib wrote:

>
>
> On 05/15/2017 09:59 PM, Christoph Paasch wrote:
>> Hello Rao,
>> =

>> On 15/05/17 - 18:16:36, Rao Shoaib wrote:
>>> I am thinking the cleanest implementation would be to separate MPTCP
>>> processing from TCP. On the receive side, when a packet arrives TCP only
>>> does TCP processing (That leaves the code untouched), the packet is than
>>> passed upto MPTCP which does MPTCP processing and can either process the
>>> packet, drop it or send a reset.
>>> =

>>> The current implementation is doing receive processing in TCP because it
>>> wants to validate the packet and accept it in TCP  or not -- but why ? =

>>> that
>>> seems to be an implementation choice.
>> you can look at mptcp_handle_options for the conditions upon which we =

>> stop processing the segment, when coming from tcp_validate_incoming. =

>> For example, when a MP_FASTCLOSE is received, the subflow gets killed =

>> with a TCP-RST.
>> =

>> The same holds when receiving a DSS-option without DSS-checksum =

>> although the DSS-checksum has been negotiated.
>> =

>> =

>> The question would be, whether we can delay the killing of the subflow &
>> sending of the RST until later. This would mean that the packet gets
>> completely handled (acks processed, incoming data acknowledged,...)
>> by the TCP-stack and later on the subflow gets killed.
>> This *might* be ok from a protocol-perspective, but I'm not sure.
> Hi Christoph,
>
> That is exactly what I am suggesting. I know this is fine from the protoc=
ol =

> perspective and I don't see why it can not be implemented. That will leav=
e =

> the TCP code untouched on the receive side and make the upstream guys hap=
py =

> because that is the fast path. Last night I was looking at the control pa=
th, =

> that needs to be cleaned up also but that is the slow path.

This looks like a good direction to me, with the disclaimer that I don't =

have the depth of MPTCP protocol expertise that Christoph does. I searched =

through the RFC for all of the "MUSTs", and didn't turn up anything that =

would require earlier processing of the received MPTCP options. Maybe the =

TCP layer will acknowledge the packet, but that should be fine for the =

MPTCP layer.

The cost of parsing the TCP options twice seems pretty low, since the =

first pass would skip over MPTCP and the second pass would skip over =

"regular" options.

>> =

>>> In the case where the receiver drops the packet in MPTCP, no data ack w=
ill
>>> be sent and MPTCP will re-transmit, It can retransmit even on the same =

>>> flow.
>>> To achieve this the code requires some change as the DSS option has to =
be
>>> saved. I think this is doable and is a much cleaner solution.
>> For incoming data, that's already how it is handled. We pass the segment=
 to
>> the MPTCP-stack through the sk_data_ready callback, where we go over the
>> segments, check whether their DSS-checksum is correct, check if it is
>> in-window,... And if all is good, queue it at the MPTCP-level and send a
>> DATA_ACK.
> Yes. However the MPTCP options are parsed and mptcp_flags and dss offset =
are =

> extracted, no need to do that. Let MPTCP handle it. It's not a lot of =

> overhead and leaves the TCP code clean. This also removes the requirement=
 of =

> trying to find space in  tcp_skb_cb to pass any information to MPTCP.
>
>> =

>>> Similarly we need to think about the Tx side -- That is not so straight
>>> forward but we need to think harder.

Agreed. One thing I'm thinking over is whether we can pre-populate some of =

the TCP header. We could set a bit in the control block to indicate that =

there is option data there already, and when the rest of the header is =

written the information could be read, moved, or replaced. One tricky part =

of this is making sure everything works right with TSO/GSO, etc.

>>> I can work on making the Rx changes but want to discuss it in case I am
>>> missing potential issues and if this is not a got option.

Are you approaching this as a refactor of the multipath-tcp.org kernel, or =

by building up from net-next?

Thanks,

--
Mat Martineau
Intel OTC

--===============5854815331693594782==--
