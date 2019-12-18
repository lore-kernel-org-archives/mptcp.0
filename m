Content-Type: multipart/mixed; boundary="===============7273976649600073078=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 07/11] tcp: Prevent coalesce/collapse
 when skb has MPTCP extensions
Date: Wed, 18 Dec 2019 11:50:24 -0800
Message-ID: <5fc0d4bd-5172-298d-6bbb-00f75c7c0dc9@gmail.com>
In-Reply-To: 20191217203807.12579-8-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3143

--===============7273976649600073078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/17/19 12:38 PM, Mat Martineau wrote:
> The MPTCP extension data needs to be preserved as it passes through the
> TCP stack. Make sure that these skbs are not appended to others during
> coalesce or collapse, so the data remains associated with the payload of
> the given skb.
>


This seems a very pessimistic change to me.

Are you planing later to refine this limitation ?

Surely if a sender sends TSO packet, we allow all the segments
being aggregated at receive side either by GRO or TCP coalescing.

--===============7273976649600073078==--
