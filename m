Content-Type: multipart/mixed; boundary="===============4025297844014363227=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Wed, 28 Jun 2017 13:10:57 -0700
Message-ID: <4c11ab2f-bec3-ebcf-c964-058e2cf2ab8c@oracle.com>
In-Reply-To: 20170628194119.GH2728@da0602a-dhcp200.apple.com
X-Status: 
X-Keywords:                  
X-UID: 63

--===============4025297844014363227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 06/28/2017 12:41 PM, Christoph Paasch wrote:
> On 28/06/17 - 12:13:27, Rao Shoaib wrote:
>> Hi Christoph,
>>
>>
>> On 06/27/2017 09:53 PM, Christoph Paasch wrote:
>>> There are several reasons why such a packet might not make it up to the
>>> receive-queue. For example:
>>>
>>> * tcp_receive_window() returns 0
>>> * the sequence-number of the ack-packet is not the rcv_nxt. Then it goes
>>>     into the ofo-queue. Which is why we had to add tests for mptcp() in
>>>     tcp_data_queue_ofo() to handle DATA_FINs.
>>> * tcp_try_rmem_schedule() returns false
>>>
>>> Such kind of conditions will make that the signal from the peer (DATA_A=
CK,
>>> ADD_ADDR,...) does not reach the MPTCP-stack. But these signals should =
be
>>> delivered to the stack as reliably as possible.
>>>
>>>
>>> What if we rather use the error-queue for these signalling skbs? The
>>> error-queue has already been "abused" for tx-timestamps,... so this mig=
ht be
>>> a good place to put this information. I think that would be cleaner.
>>>
>>>
>>> Christoph
>>>
>> Thanks for elaborating. Now I understand. Your concern is not the zero
>> length but the general constraints with queuing. Yes, the current
>> implementation does not bypass those constraints. It treats pure ack as a
>> zero length data packet. If this is an issue with MPTCP the fix is very
>> straight forward, in fact I want to make that change, In tcp_data_queue()
>> where we check if the packet is a pure ack and make decision to deliver =
it
>> if the socket is an  MPTCP we can just call sk_data_ready . An
>> architecturally correct solution would be to have a another socket speci=
fic
>> function to deal with non data packets and remove checks for mptcp.
> I think the more and more that the error-queue is the right approach for
> such kind of signalling-information.
>
> Because, these signals can even be redundant (aka, if we get twice the sa=
me
> DATA_ACK). Having it in the error-queue would allow us to check for that =
and
> avoid adding another redundant skb into it.
>
> Would you want to explore the error-queue route?

I will definitely look into using the error-queue and any other =

optimizations, I do not want to add any mptcp specific checks though. My =

current focus is mostly just cleaning up TCP code and keep current MPTCP =

working. I am hoping that we can cleanup the TCP code and can present =

the design at the next netdev and get approval from the main stream =

folks. Then we will look into how MPTCP implementation can be improved. =

So right now I rather spend time looking at other main TCP areas and let =

MPTCP  do whatever it does today. This does not mean I will not look =

into using error-queue, just that it might not be my top priority. I =

hope that is OK with you :-).

Rao
>
>> The goal is to (When possible) not do any MPTCP parsing/processing till =
 TCP
>> processing is done and the packet is handed off to MPTCP. This makes the
>> code look cleaner and less intrusive. Which is the biggest complain that=
 the
>> upstream folks have. They are not concerned what we do in the MPTCP code.
> Yes, we all agree on that.
>
>
> Christoph
>


--===============4025297844014363227==--
