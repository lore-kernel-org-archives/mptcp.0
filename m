Content-Type: multipart/mixed; boundary="===============2972986055368594491=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: attempt skb coalescing when moving skbs to
 mptcp rx queue
Date: Mon, 25 May 2020 19:08:31 +0200
Message-ID: <f4836de8b7756bd749878450935bc296c193f931.camel@redhat.com>
In-Reply-To: 20200525160255.20560-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4493

--===============2972986055368594491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 18:02 +0200, Florian Westphal wrote:
> We can try to coalesce the skbs we take from the subflows rx queue
> with the tail of the mptcp rx queue.
> =

> If successful, the skb head can be discarded early.
> =

> We can also free the skb extensions, we do not access them after
> this so no need to hold on to them.
> =

> Only caveat: do not built too fat skbs. They are only free'd once
> userspace has read all data.

To share IRC thoughts here:

It looks like TCP allows skb to grow above GSO_MAX_SIZE and frees them
only when user-space read all the data. Could we relax this constraint,
too?

skb_try_coalesce() will still somehow bound the skb size to
MAX_SKB_FRAGS * <something [PAGE_SIZE ?!?]>

Cheers,

Paolo

--===============2972986055368594491==--
