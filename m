Content-Type: multipart/mixed; boundary="===============3204669991428012086=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Separating MPTCP packet processing from TCP
Date: Tue, 16 May 2017 15:34:12 -0700
Message-ID: <720c7741-dc9e-6705-bead-632615aca045@oracle.com>
In-Reply-To: d23542e3-86d5-b8a6-b80f-f330e9c45722@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 36

--===============3204669991428012086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 05/16/2017 03:22 PM, Rao Shoaib wrote:
>
>
> On 05/16/2017 02:57 PM, Mat Martineau wrote:
>>
>> On Tue, 16 May 2017, Rao Shoaib wrote:
>>
>>>
>>>
>>> On 05/15/2017 09:59 PM, Christoph Paasch wrote:
>>>> Hello Rao,
>>>>
>>>> On 15/05/17 - 18:16:36, Rao Shoaib wrote:
>>>>> I am thinking the cleanest implementation would be to separate MPTCP
>>>>> processing from TCP. On the receive side, when a packet arrives =

>>>>> TCP only
>>>>> does TCP processing (That leaves the code untouched), the packet =

>>>>> is than
>>>>> passed upto MPTCP which does MPTCP processing and can either =

>>>>> process the
>>>>> packet, drop it or send a reset.
>>>>>
>>>>> The current implementation is doing receive processing in TCP =

>>>>> because it
>>>>> wants to validate the packet and accept it in TCP  or not -- but =

>>>>> why ? that
>>>>> seems to be an implementation choice.
>>>> you can look at mptcp_handle_options for the conditions upon which =

>>>> we stop processing the segment, when coming from =

>>>> tcp_validate_incoming. For example, when a MP_FASTCLOSE is =

>>>> received, the subflow gets killed with a TCP-RST.
>>>>
>>>> The same holds when receiving a DSS-option without DSS-checksum =

>>>> although the DSS-checksum has been negotiated.
>>>>
>>>>
>>>> The question would be, whether we can delay the killing of the =

>>>> subflow &
>>>> sending of the RST until later. This would mean that the packet gets
>>>> completely handled (acks processed, incoming data acknowledged,...)
>>>> by the TCP-stack and later on the subflow gets killed.
>>>> This *might* be ok from a protocol-perspective, but I'm not sure.
>>> Hi Christoph,
>>>
>>> That is exactly what I am suggesting. I know this is fine from the =

>>> protocol perspective and I don't see why it can not be implemented. =

>>> That will leave the TCP code untouched on the receive side and make =

>>> the upstream guys happy because that is the fast path. Last night I =

>>> was looking at the control path, that needs to be cleaned up also =

>>> but that is the slow path.
>>
>> This looks like a good direction to me, with the disclaimer that I =

>> don't have the depth of MPTCP protocol expertise that Christoph does. =

>> I searched through the RFC for all of the "MUSTs", and didn't turn up =

>> anything that would require earlier processing of the received MPTCP =

>> options. Maybe the TCP layer will acknowledge the packet, but that =

>> should be fine for the MPTCP layer.
>>
>> The cost of parsing the TCP options twice seems pretty low, since the =

>> first pass would skip over MPTCP and the second pass would skip over =

>> "regular" options.
> I did confirm my suggestion by posting on the IETF list.
Christoph if you see any potential issues than please speak up. I rather =

discuss the issues now instead of later.
>
>>
>>>>
>>>>> In the case where the receiver drops the packet in MPTCP, no data =

>>>>> ack will
>>>>> be sent and MPTCP will re-transmit, It can retransmit even on the =

>>>>> same flow.
>>>>> To achieve this the code requires some change as the DSS option =

>>>>> has to be
>>>>> saved. I think this is doable and is a much cleaner solution.
>>>> For incoming data, that's already how it is handled. We pass the =

>>>> segment to
>>>> the MPTCP-stack through the sk_data_ready callback, where we go =

>>>> over the
>>>> segments, check whether their DSS-checksum is correct, check if it is
>>>> in-window,... And if all is good, queue it at the MPTCP-level and =

>>>> send a
>>>> DATA_ACK.
>>> Yes. However the MPTCP options are parsed and mptcp_flags and dss =

>>> offset are extracted, no need to do that. Let MPTCP handle it. It's =

>>> not a lot of overhead and leaves the TCP code clean. This also =

>>> removes the requirement of trying to find space in tcp_skb_cb to =

>>> pass any information to MPTCP.
>>>
>>>>
>>>>> Similarly we need to think about the Tx side -- That is not so =

>>>>> straight
>>>>> forward but we need to think harder.
>>
>> Agreed. One thing I'm thinking over is whether we can pre-populate =

>> some of the TCP header. We could set a bit in the control block to =

>> indicate that there is option data there already, and when the rest =

>> of the header is written the information could be read, moved, or =

>> replaced. =

> This is exactly what I was thinking of doing. There is nothing that =

> says that TCP options have to be in front. MPTCP can fill in the =

> options and update the data offset. TCP can work with it.
Actually MPTCP options would have to be at the bottom. So that will just =

work out.
There would be some issues to deal with re-transmission and coalescing =

and fragmentation.

Rao.

>> One tricky part of this is making sure everything works right with =

>> TSO/GSO, etc.
> I have not looked into that.
>
> This approach will not require TCP fiddling with any options except =

> what it knows about right now and we can leave the TCP code mostly =

> untouched.
>>
>>>>> I can work on making the Rx changes but want to discuss it in case =

>>>>> I am
>>>>> missing potential issues and if this is not a got option.
>>
>> Are you approaching this as a refactor of the multipath-tcp.org =

>> kernel, or by building up from net-next?
> I have been working with the code from multipath-tcp.org kernel. I am =

> about to finish a prototype for allocating external memory to pass the =

> options. That is when this idea came to me.  I will post that may be =

> today or tomorrow.
>
> Rao.
>
>>
>> Thanks,
>>
>> -- =

>> Mat Martineau
>> Intel OTC
>


--===============3204669991428012086==--
