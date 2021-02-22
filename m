Content-Type: multipart/mixed; boundary="===============1521864624071195545=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: reset 'first' and ack_hint on subflow close
Date: Mon, 22 Feb 2021 16:58:33 +0100
Message-ID: <da04d45124f68d7e5518d05cb31055b88781581f.camel@redhat.com>
In-Reply-To: 20210222082859.GJ22944@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7891

--===============1521864624071195545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-02-22 at 09:28 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Thu, 2021-02-18 at 16:59 +0100, Florian Westphal wrote:
> > > Just like with last_snd, we have to NULL 'first' on subflow close.
> > > =

> > > ack_hint isn't strictly required (its never dereferenced), but better=
 to
> > > clear this as well.
> > > =

> > > msk->first is dereferenced unconditionally at accept time, but
> > > at that point the ssk is not on the conn_list yet -- this means
> > > worker can't see it when iterating the conn_list.
> > =

> > There is a __mptcp_flush_join_list() before __mptcp_close_subflow(),
> > could that matter? IIRC even the PM can move the subflow from join_list
> > to conn_list to take some actions.
> =

> AFAICS msk->first gets set/used to avoid use of join_list.
> The latter is only used for incoming mp_join, not mp_capable.

Sharing here private conversation.

If msk->first is closed before accept, accept will still return an
established msk socket, with msk->first still valid and pointing to the
original subflow, in TCP_CLOSE status (and still with a valid refcnt
[=3D=3D1])

TL;DR: the patch looks safe, no need for a complex codying to remove
msk->first field.

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============1521864624071195545==--
