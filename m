Content-Type: multipart/mixed; boundary="===============5304641221558219065=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Shared control buffer proposal
Date: Fri, 20 Oct 2017 16:06:03 -0700
Message-ID: <alpine.OSX.2.21.1710201605050.33189@mjmartin-mac01.local>
In-Reply-To: 20171020230232.14721-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 132

--===============5304641221558219065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Oct 2017, Mat Martineau wrote:

> Here's an implementation of the "shared control buffer" we recently
> discussed on this list. This uses a SKB_SHINFO_EXT flag for __alloc_skb
> to optionally allocate extra space following skb_shared_info. Regular
> (non-extended) skbs are not changed at all. The new skbs with extended
> shared info can be safely handled by existing code, although low-level
> operations that copy or reallocate skb data and shared info may strip
> the extended information if they are not aware of it.
>
> The second patch allows users of do_tcp_sendpages to provide a skb with
> an extended control buffer to use for the first packet. In MPTCP, this
> would allow a DSS mapping for a large chunk of data to be sent in the
> first packet, with the rest of the mapped data sent in subsequent
> packets. It also conveniently ensures that the beginning of the provided
> data is not coalesced in to an existing skb so the DSS mapping and the
> beginning of the mapped data stay together.
>
> I still need to verify how GSO and TSO handle these skbs. When I tested
> this code by using SKB_ALLOC_SHINFO_EXT with every TCP allocation, the
> extended information was available when TCP headers are written.
>
> Mat Martineau (2):
>  skbuff: Add shared control buffer
>  tcp: Let do_tcp_sendpages accept a pre-allocated initial skb
>
> include/linux/skbuff.h | 24 +++++++++++++++++++++-
> include/net/tcp.h      |  2 +-
> net/core/skbuff.c      | 56 ++++++++++++++++++++++++++++++++++++++-------=
-----
> net/ipv4/tcp.c         | 12 ++++++++---
> net/tls/tls_main.c     |  3 ++-
> 5 files changed, 78 insertions(+), 19 deletions(-)
>
> -- =

> 2.14.2
>
>

I forgot to mention that I've pushed these changes to =

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dsharedcb

They apply to net-next/master.

--
Mat Martineau
Intel OTC

--===============5304641221558219065==--
