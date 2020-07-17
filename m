Content-Type: multipart/mixed; boundary="===============4536533759758819318=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: explicitly zeros msk fields on clone
Date: Fri, 17 Jul 2020 09:11:02 -0700
Message-ID: <20200717161102.GT73500@MacBook-Pro-64.local>
In-Reply-To: 19266193fa938c42a6d304d0bae824a20137e950.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5080

--===============4536533759758819318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/17/20 - 17:30, Paolo Abeni wrote:
> On Fri, 2020-07-17 at 17:12 +0200, Paolo Abeni wrote:
> > sk_clone_lock() does not set the __GFP_ZERO flag on the
> > internal socket allocation, so we must explicitly zero
> > all the relevant msk fields, or we could see inconsitent
> > socket status leading to unexpected fallback or data
> > corruption.
> =

> I noticed only after sending this that sk_clone_lock() calls
> sock_copy() which in turn copies everything up to prot->obj_size - that
> is sizeof(struct mptcp_sock) or sizeof(struct mptcp6_sock) in our
> case).
> =

> Since the listening socket should always have the relevant fields
> cleared this patch is not needed.
> =

> There is a caveat: a socket could go through:
> =

>  connect(); shutdown(); listen(); =


Wouldn't that then go through mptcp_disconnect()? Thus, in the same style as
for TCP (tcp_disconnect()), the zeroing can happen in mptcp_disconnect().


Christoph

> =

> but I think the correct way to handle the above is clearing properly
> the status in listen(), will look at that later
> =

> /P
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4536533759758819318==--
