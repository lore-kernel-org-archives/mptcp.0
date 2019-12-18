Content-Type: multipart/mixed; boundary="===============6924809398126580693=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 13:02:51 -0800
Message-ID: <alpine.OSX.2.21.1912181251550.32925@mjmartin-mac01.local>
In-Reply-To: 20191218.124510.1971632024371398726.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 3163

--===============6924809398126580693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 18 Dec 2019, David Miller wrote:

> From: Eric Dumazet <eric.dumazet(a)gmail.com>
> Date: Wed, 18 Dec 2019 11:50:24 -0800
>
>> On 12/17/19 12:38 PM, Mat Martineau wrote:
>>> The MPTCP extension data needs to be preserved as it passes through the
>>> TCP stack. Make sure that these skbs are not appended to others during
>>> coalesce or collapse, so the data remains associated with the payload of
>>> the given skb.
>>
>> This seems a very pessimistic change to me.
>>
>> Are you planing later to refine this limitation ?
>>
>> Surely if a sender sends TSO packet, we allow all the segments
>> being aggregated at receive side either by GRO or TCP coalescing.
>
> This turns off absolutely crucial functional elements of our TCP
> stack, and will avoid all of the machinery that avoids wastage in TCP
> packets sitting in the various queues.  skb->truesize management, etc.
>
> I will not apply these patches with such a non-trivial regression in
> place for MPTCP streams, sorry.
>

Ok, understood. Not every packet has this MPTCP extension data so =

coalescing was not always turned off, but given the importance of avoiding =

this memory waste I'll confirm GRO behavior and work on maintaining =

coalesce/collapse with identical MPTCP extension data.

--
Mat Martineau
Intel
--===============6924809398126580693==--
