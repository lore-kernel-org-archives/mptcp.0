Content-Type: multipart/mixed; boundary="===============6505059071056655423=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: attempt skb coalescing when moving skbs to
 mptcp rx queue
Date: Mon, 25 May 2020 20:10:29 +0200
Message-ID: <20200525181029.GE2915@breakpoint.cc>
In-Reply-To: f4836de8b7756bd749878450935bc296c193f931.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4500

--===============6505059071056655423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2020-05-25 at 18:02 +0200, Florian Westphal wrote:
> > We can try to coalesce the skbs we take from the subflows rx queue
> > with the tail of the mptcp rx queue.
> > =

> > If successful, the skb head can be discarded early.
> > =

> > We can also free the skb extensions, we do not access them after
> > this so no need to hold on to them.
> > =

> > Only caveat: do not built too fat skbs. They are only free'd once
> > userspace has read all data.
> =

> To share IRC thoughts here:
> =

> It looks like TCP allows skb to grow above GSO_MAX_SIZE and frees them
> only when user-space read all the data. Could we relax this constraint,
> too?

Yes, but I saw skbs of up ~320kb Truesize, which i considered too
much.  I will remove the comment and the contraint in v2.
--===============6505059071056655423==--
