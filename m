Content-Type: multipart/mixed; boundary="===============3964540038883322708=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 12:45:10 -0800
Message-ID: <20191218.124510.1971632024371398726.davem@davemloft.net>
In-Reply-To: 5fc0d4bd-5172-298d-6bbb-00f75c7c0dc9@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3161

--===============3964540038883322708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Dumazet <eric.dumazet(a)gmail.com>
Date: Wed, 18 Dec 2019 11:50:24 -0800

> On 12/17/19 12:38 PM, Mat Martineau wrote:
>> The MPTCP extension data needs to be preserved as it passes through the
>> TCP stack. Make sure that these skbs are not appended to others during
>> coalesce or collapse, so the data remains associated with the payload of
>> the given skb.
> =

> This seems a very pessimistic change to me.
> =

> Are you planing later to refine this limitation ?
> =

> Surely if a sender sends TSO packet, we allow all the segments
> being aggregated at receive side either by GRO or TCP coalescing.

This turns off absolutely crucial functional elements of our TCP
stack, and will avoid all of the machinery that avoids wastage in TCP
packets sitting in the various queues.  skb->truesize management, etc.

I will not apply these patches with such a non-trivial regression in
place for MPTCP streams, sorry.
--===============3964540038883322708==--
